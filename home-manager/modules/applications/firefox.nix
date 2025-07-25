# Firefox module with default settings
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.settings.firefox;
in
{
  options.settings.firefox = {
    # Base options
    system = {
      type = types.str;
      default = "x86_64-linux";
      description = "The system for which firefox extensions are preinstalled";
    };

    gnome = mkEnableOption "Enable gnome integration";

    # Bookmark group options
    bookmarks = {
      google = mkEnableOption "Enable google bookmarks";
      polytechnique = mkEnableOption "Enable polytechnique bookmarks";
      telecom = mkEnableOption "Enable telecom bookmarks";
      nix = mkEnableOption "Enable nix bookmarks";
    };
  };

  config = {

    programs.firefox = {
      profiles.default = {
        id = 0;
        isDefault = true;

        search = {
          force = true;
          default = "google";
        };

        # https://github.com/yokoffing/Betterfox/blob/main/user.js
        settings = {
          # GENERAL
          content.notify.interval = 100000;

          # GFX
          gfx.canvas.accelerated.cache-items = 4096;
          gfx.canvas.accelerated.cache-size = 512;
          gfx.content.skia-font-cache-size = 20;

          # DISK CACHE
          browser.cache.jsbc_compression_level = 3;

          # MEDIA CACHE
          media.memory_cache_max_size = 65536;
          media.cache_readahead_limit = 7200;
          media.cache_resume_threshold = 3600;

          # IMAGE CACHE
          image.mem.decode_bytes_at_a_time = 32768;

          # NETWORK
          network.http.max-connections = 1800;
          network.http.max-persistent-connections-per-server = 10;
          network.http.max-urgent-start-excessive-connections-per-host = 5;
          network.http.pacing.requests.enabled = false;
          network.dnsCacheExpiration = 3600;
          network.ssl_tokens_cache_capacity = 10240;

          # SPECULATIVE LOADING
          network.dns.disablePrefetch = true;
          network.dns.disablePrefetchFromHTTPS = true;
          network.prefetch-next = false;
          network.predictor.enabled = false;
          network.predictor.enable-prefetch = false;

          # EXPERIMENTAL
          layout.css.grid-template-masonry-value.enabled = true;
          dom.enable_web_task_scheduling = true;
          dom.security.sanitizer.enabled = true;

          # SECUREFOX
          # TRACKING PROTECTION
          browser.contentblocking.category = "strict";
          urlclassifier.trackingSkipURLs = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
          urlclassifier.features.socialtracking.skipURLs = "*.instagram.com, *.twitter.com, *.twimg.com";
          network.cookie.sameSite.noneRequiresSecure = true;
          browser.download.start_downloads_in_tmp_dir = true;
          browser.helperApps.deleteTempFileOnExit = true;
          browser.uitour.enabled = false;
          privacy.globalprivacycontrol.enabled = true;

          # OCSP & CERTS / HPKP
          security.OCSP.enabled = 0;
          security.remote_settings.crlite_filters.enabled = true;
          security.pki.crlite_mode = 2;

          # SSL / TLS
          security.ssl.treat_unsafe_negotiation_as_broken = true;
          browser.xul.error_pages.expert_bad_cert = true;
          security.tls.enable_0rtt_data = false;

          # DISK AVOIDANCE
          browser.privatebrowsing.forceMediaMemoryCache = true;
          browser.sessionstore.interval = 60000;

          # SHUTDOWN & SANITIZING
          privacy.history.custom = true;

          # SEARCH / URL BAR
          browser.urlbar.trimHttps = true;
          browser.urlbar.untrimOnUserInteraction.featureGate = true;
          browser.search.separatePrivateDefault.ui.enabled = true;
          browser.urlbar.update2.engineAliasRefresh = true;
          browser.search.suggest.enabled = false;
          browser.urlbar.quicksuggest.enabled = false;
          browser.urlbar.suggest.quicksuggest.sponsored = false;
          browser.urlbar.suggest.quicksuggest.nonsponsored = false;
          browser.urlbar.groupLabels.enabled = false;
          browser.formfill.enable = false;
          security.insecure_connection_text.enabled = true;
          security.insecure_connection_text.pbmode.enabled = true;
          network.IDN_show_punycode = true;

          # HTTPS-FIRST POLICY
          dom.security.https_first = true;

          # PASSWORDS
          signon.formlessCapture.enabled = false;
          signon.privateBrowsingCapture.enabled = false;
          network.auth.subresource-http-auth-allow = 1;
          editor.truncate_user_pastes = false;

          # MIXED CONTENT + CROSS-SITE
          security.mixed_content.block_display_content = true;
          pdfjs.enableScripting = false;
          extensions.postDownloadThirdPartyPrompt = false;

          # HEADERS / REFERERS
          network.http.referer.XOriginTrimmingPolicy = 2;

          # CONTAINERS
          privacy.userContext.ui.enabled = true;

          # WEBRTC
          media.peerconnection.ice.proxy_only_if_behind_proxy = true;
          media.peerconnection.ice.default_address_only = true;

          # SAFE BROWSING
          browser.safebrowsing.downloads.remote.enabled = false;

          # MOZILLA
          permissions.default.desktop-notification = 2;
          permissions.default.geo = 2;
          permissions.manager.defaultsUrl = "";
          webchannel.allowObject.urlWhitelist = "";

          # TELEMETRY
          datareporting.policy.dataSubmissionEnabled = false;
          datareporting.healthreport.uploadEnabled = false;
          toolkit.telemetry.unified = false;
          toolkit.telemetry.enabled = false;
          toolkit.telemetry.server = "data:,";
          toolkit.telemetry.archive.enabled = false;
          toolkit.telemetry.newProfilePing.enabled = false;
          toolkit.telemetry.shutdownPingSender.enabled = false;
          toolkit.telemetry.updatePing.enabled = false;
          toolkit.telemetry.bhrPing.enabled = false;
          toolkit.telemetry.firstShutdownPing.enabled = false;
          toolkit.telemetry.coverage.opt-out = true;
          toolkit.coverage.opt-out = true;
          toolkit.coverage.endpoint.base = "";
          browser.newtabpage.activity-stream.feeds.telemetry = false;
          browser.newtabpage.activity-stream.telemetry = false;

          # EXPERIMENTS
          app.shield.optoutstudies.enabled = false;
          app.normandy.enabled = false;
          app.normandy.api_url = "";

          # CRASH REPORTS
          breakpad.reportURL = "";
          browser.tabs.crashReporting.sendReport = false;
          browser.crashReports.unsubmittedCheck.autoSubmit2 = false;

          # DETECTION
          captivedetect.canonicalURL = "";
          network.captive-portal-service.enabled = false;
          network.connectivity-service.enabled = false;

          # PESKYFOX
          # MOZILLA UI
          browser.privatebrowsing.vpnpromourl = "";
          extensions.getAddons.showPane = false;
          extensions.htmlaboutaddons.recommendations.enabled = false;
          browser.discovery.enabled = false;
          browser.shell.checkDefaultBrowser = false;
          browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons = false;
          browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features = false;
          browser.preferences.moreFromMozilla = false;
          browser.aboutConfig.showWarning = false;
          browser.aboutwelcome.enabled = false;
          browser.tabs.tabmanager.enabled = false;
          browser.profiles.enabled = true;

          # THEME ADJUSTMENTS
          toolkit.legacyUserProfileCustomizations.stylesheets = true;
          browser.compactmode.show = true;
          browser.display.focus_ring_on_anything = true;
          browser.display.focus_ring_style = 0;
          browser.display.focus_ring_width = 0;
          layout.css.prefers-color-scheme.content-override = 2;
          browser.privateWindowSeparation.enabled = false; # WINDOWS
          browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled = true;

          # COOKIE BANNER HANDLING
          cookiebanners.service.mode = 1;

          # FULLSCREEN NOTICE
          full-screen-api.transition-duration.enter = "0 0";
          full-screen-api.transition-duration.leave = "0 0";
          full-screen-api.warning.delay = -1;
          full-screen-api.warning.timeout = 0;

          # URL BAR
          browser.urlbar.suggest.calculator = true;
          browser.urlbar.unitConversion.enabled = true;
          browser.urlbar.trending.featureGate = false;

          # NEW TAB PAGE
          browser.newtabpage.activity-stream.feeds.topsites = false;
          browser.newtabpage.activity-stream.feeds.section.topstories = false;

          # POCKET
          extensions.pocket.enabled = false;

          # DOWNLOADS
          browser.download.manager.addToRecentDocs = false;

          # PDF
          browser.download.open_pdf_attachments_inline = true;

          # TAB BEHAVIOR
          browser.bookmarks.openInTabClosesMenu = false;
          browser.menu.showViewImageInfo = true;
          findbar.highlightAll = true;
          layout.word_select.eat_space_to_next_word = false;
        };

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
          darkreader
          return-youtube-dislikes
          foxyproxy-standard
          languagetool
        ];

        # Useful bookmarks with default priority
        bookmarks = {

          force = true;
          settings = [
            {
              name = "Google";
              toolbar = cfg.bookmarks.google;
              bookmarks = [
                {
                  name = "Gmail";
                  tags = [ "gmail" ];
                  keyword = "gmail";
                  url = "https://mail.google.com/mail";
                }
                {
                  name = "Drive";
                  tags = [ "drive" ];
                  keyword = "drive";
                  url = "https://drive.google.com/drive/my-drive";
                }
                {
                  name = "Agenda";
                  tags = [ "agenda" ];
                  keyword = "agenda";
                  url = "https://calendar.google.com/calendar";
                }
              ];
            }

            {
              name = "Polytechnique";
              toolbar = cfg.bookmarks.polytechnique;
              bookmarks = [
                {
                  name = "Sigma";
                  tags = [ "sigma" ];
                  keyword = "sigma";
                  url = "https://sigma.binets.fr/app/home";
                }
                {
                  name = "Gitlab";
                  tags = [
                    "gitlab"
                    "polytechnique"
                    "br"
                  ];
                  keyword = "gitlab";
                  url = "https://gitlab.binets.fr";
                }
                {
                  name = "Ximbra";
                  tags = [
                    "zimbra"
                    "polytechnique"
                  ];
                  keyword = "zimbra";
                  url = "https://webmail.polytechnique.fr";
                }
              ];
            }
            {
              name = "Télécom";
              toolbar = cfg.bookmarks.telecom;
              bookmarks = [
                {
                  name = "Synapses Télécom";
                  tags = [
                    "synapses"
                    "télécom"
                  ];
                  keyword = "synapses telecom";
                  url = "https://synapses.telecom-paris.fr";
                }
                {
                  name = "Eole";
                  tags = [
                    "eole"
                    "telecom"
                  ];
                  keyword = "eole telecom";
                  url = "https://eole.telecom-paris.fr";
                }
                {
                  name = "Timbra";
                  tags = [
                    "zimbra"
                    "telecom"
                  ];
                  keyword = "zimbra";
                  url = "https://z.imt.fr/zimbra/mail";
                }
                {
                  name = "ECampus";
                  tags = [
                    "ecampus"
                    "telecom"
                  ];
                  keyword = "ecampus telecom";
                  url = "https://ecampus.paris-saclay.fr/course/index.php?categoryid=573";
                }
              ];
            }
            {
              name = "Nix";
              toolbar = cfg.bookmarks.nix;
              bookmarks = [
                {
                  name = "Noogle";
                  tags = [
                    "noogle"
                    "nix"
                  ];
                  keyword = "noogle";
                  url = "https://noogle.dev";
                }
                {
                  name = "Nix Flake Book";
                  tags = [
                    "nix"
                    "flakes"
                    "book"
                  ];
                  keyword = "nix flakes book";
                  url = "https://nixos-and-flakes.thiscute.world";
                }
              ];
            }
          ];
        };
      };

      enableGnomeExtensions = cfg.gnome;
    };
  };
}
