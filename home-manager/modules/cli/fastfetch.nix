# Fastfetch configuration
{
  programs.fastfetch.settings = {
    logo = {
      padding = {
        top = 3;
      };
    };

    modules = [
      {
        type = "title";
        key = "                    ";
        keyWidth = 22;
        format = builtins.fromJSON ''"-> \u001b[96m{1}\u001b[97m@\u001b[96m{2}"'';
      }
      {
        type = "locale";
        key = "";
        keyWidth = 1;
        format = " ──────────────────────────────────────────────────── ";
      }
      "break"
      {
        type = "os";
        key = "╭──󰣇 ";
        keyWidth = 6;
        keyColor = "green";
        format = "-> {3} {9} {12}";
      }
      {
        type = "kernel";
        key = "├── ";
        keyWidth = 6;
        keyColor = "green";
        format = "-> {2}";
      }
      {
        type = "packages";
        key = "├── ";
        keyWidth = 6;
        keyColor = "green";
        format = "-> {9} (system) {10} (user)";
      }
      {
        type = "uptime";
        key = "├──  ";
        keyWidth = 6;
        keyColor = "green";
        format = "-> {1}d {2}h {3}min";
      }
      {
        type = "shell";
        key = "╰──  ";
        keyWidth = 6;
        keyColor = "green";
        format = "-> {3} {4}";
      }
      "break"
      {
        type = "host";
        key = "╭── ";
        keyWidth = 6;
        keyColor = "cyan";
        format = "-> {1} {2}";
      }
      {
        type = "cpu";
        key = "├── ";
        keyWidth = 6;
        keyColor = "cyan";
        format = "-> {1} ({4}) [{8}]";
        temp = true;
      }
      {
        type = "gpu";
        key = "├── ";
        keyWidth = 6;
        keyColor = "cyan";
        format = "-> {1} {2} [{4}]";
        temp = true;
      }
      {
        type = "loadavg";
        key = "├── ";
        keyWidth = 6;
        keyColor = "cyan";
        format = "-> {1} %";
      }
      {
        type = "monitor";
        key = "├──󰍹 ";
        keyWidth = 6;
        keyColor = "cyan";
        format = "-> {2} x {3}";
      }
      {
        type = "memory";
        key = "├──  ";
        keyWidth = 6;
        keyColor = "cyan";
        format = "-> {1} / {2} ({3})";
      }
      {
        type = "disk";
        key = "╰── ";
        keyWidth = 6;
        keyColor = "cyan";
        format = "-> {1} / {2} ({3}) - {9}";
      }
      "break"
      {
        type = "wm";
        key = "╭── ";
        keyWidth = 6;
        keyColor = "yellow";
        format = "-> {2} ({3})";
      }
      {
        type = "terminal";
        key = "├── ";
        keyWidth = 6;
        keyColor = "yellow";
        format = "-> {5}";
      }
      {
        type = "theme";
        key = "├── ";
        keyWidth = 6;
        keyColor = "yellow";
        format = "-> {2}";
      }
      {
        type = "icons";
        key = "├── ";
        keyWidth = 6;
        keyColor = "yellow";
        format = "-> {2}";
      }
      {
        type = "terminalfont";
        key = "╰── ";
        keyWidth = 6;
        keyColor = "yellow";
        format = "-> {1}";
      }
      "break"
      {
        key = "";
        keyWidth = 1;
        type = "locale";
        format = builtins.fromJSON ''" ──────────────────(\u001b[31m \u001b[32m \u001b[33m \u001b[34m \u001b[35m \u001b[36m \u001b[37m )────────────────── "'';
      }
    ];
  };
}
