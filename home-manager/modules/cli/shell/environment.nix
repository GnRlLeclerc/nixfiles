# Shell environment variables
{
  # Allow for mouse scrolling in git-delta
  DELTA_PAGER = "less --mouse";

  # Remote nvim for synctex
  # NOTE: has to be set for one instance only
  # NVIM_LISTEN_ADDRESS = "/tmp/nvimsocket";

  # Silence Poetry
  PYTHON_KEYRING_BACKEND = "keyring.backends.fail.Keyring";

  # Android emulator (enable starting expo app directly in emulator)
  ANDROID_HOME = "$HOME/Android/Sdk";

  GOPATH = "$HOME/go";

  # Bat & delta color theme
  BAT_THEME = "base16";
}
