-- Select the Speaker or Headphones UCM profile based on the headphone jack.
--
-- On SOF cards (e.g. ThinkPad P16s), UCM puts Speaker and Headphones on the same
-- PCM, so PipeWire exposes them in two separate "HiFi (...)" profiles. The stock
-- device/find-best-profile hook picks the highest priority available profile
-- (Headphones), and that profile stays "available" as long as any HDMI/DP output
-- is connected, even when no headphones are plugged in: the speakers vanish.

cutils = require ("common-utils")
log = Log.open_topic ("s-device")

-- Last known headphone jack availability, by device id
local headphones_state = {}

-- Availability of the headphones output route ("yes", "no", "unknown"), or nil
local function headphonesAvailable (device)
  for p in device:iterate_params ("EnumRoute") do
    local route = cutils.parseParam (p, "EnumRoute")
    if route and route.direction == "Output" and
        route.name:find ("Headphones", 1, true) then
      return route.available
    end
  end
  return nil
end

SimpleEventHook {
  name = "device/find-jack-profile",
  before = "device/find-stored-profile",
  interests = {
    EventInterest {
      Constraint { "event.type", "=", "select-profile" },
    },
  },
  execute = function (event)
    -- skip hook if profile is already selected
    if event:get_data ("selected-profile") then
      return
    end

    local device = event:get_subject ()
    if device.properties ["device.api"] ~= "alsa" then
      return
    end

    -- Leave a manually selected pro-audio profile alone
    for p in device:iterate_params ("Profile") do
      local active = cutils.parseParam (p, "Profile")
      if active and active.name == "pro-audio" then
        return
      end
    end

    local headphones = headphonesAvailable (device)
    if headphones == nil then
      return
    end

    -- Only acts on devices that expose a matching profile, else falls through
    local wanted = (headphones == "yes") and "Headphones" or "Speaker"
    local best = nil
    for p in device:iterate_params ("EnumProfile") do
      local profile = cutils.parseParam (p, "EnumProfile")
      if profile and profile.available ~= "no" and
          profile.name:find (wanted, 1, true) and
          (best == nil or profile.priority > best.priority) then
        best = profile
      end
    end

    if best then
      log:info (device, string.format ("Headphones %s, selecting profile '%s'",
          headphones, best.name))
      event:set_data ("selected-profile", best)
    end
  end
}:register ()

-- Plugging headphones only changes route availability, not profile
-- availability, so the stock hooks never re-select the profile: do it here.
SimpleEventHook {
  name = "device/jack-profile-trigger",
  interests = {
    EventInterest {
      Constraint { "event.type", "=", "device-params-changed" },
      Constraint { "event.subject.param-id", "c", "EnumRoute" },
    },
  },
  execute = function (event)
    local device = event:get_subject ()
    if device.properties ["device.api"] ~= "alsa" then
      return
    end

    local id = device ["bound-id"]
    local headphones = headphonesAvailable (device)
    if headphones == nil or headphones_state [id] == headphones then
      return
    end

    headphones_state [id] = headphones
    event:get_source ():call ("push-event", "select-profile", device, nil)
  end
}:register ()
