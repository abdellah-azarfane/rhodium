{ icons }:
[
  "break"

  {
    type = "custom";
    format = icons.sectionUptime;
  }
  {
    type = "title";
    key = icons.sess;
    format = "{user-name}@{host-name}";
    keyColor = "red";
  }
  {
    type = "command";
    key = icons.age;
    keyColor = "red";
    text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
  }
  {
    type = "uptime";
    key = icons.up;
    keyColor = "red";
  }
  {
    type = "datetime";
    key = icons.dt;
    keyColor = "red";
  }
  {
    type = "custom";
    format = icons.footer;
  }

  "break"

  {
    type = "custom";
    format = icons.sectionHardware;
  }
  {
    type = "host";
    key = icons.pc;
    keyColor = "green";
  }
  {
    type = "chassis";
    key = icons.chassis;
    keyColor = "green";
  }
  {
    type = "display";
    key = "${icons.display} ";
    keyColor = "green";
  }
  {
    type = "cpu";
    key = icons.cpu;
    showPeCoreCount = true;
    keyColor = "green";
  }
  {
    type = "gpu";
    key = icons.gpu;
    keyColor = "green";
  }
  {
    type = "vulkan";
    key = icons.vulkan;
    keyColor = "green";
  }
  {
    type = "opengl";
    key = icons.opengl;
    keyColor = "green";
  }
  {
    type = "memory";
    key = icons.mem;
    keyColor = "green";
  }
  {
    type = "disk";
    key = icons.disk;
    keyColor = "green";
  }
  {
    type = "locale";
    key = icons.locale;
    keyColor = "green";
  }
  {
    type = "custom";
    format = icons.footer;
  }

  "break"

  {
    type = "custom";
    format = icons.sectionSoftware;
  }
  {
    type = "os";
    key = icons.os;
    keyColor = "yellow";
  }
  {
    type = "kernel";
    key = icons.kernel;
    keyColor = "yellow";
  }
  {
    type = "bios";
    key = icons.bios;
    keyColor = "yellow";
  }
  {
    type = "bootmgr";
    key = icons.bootmgr;
    keyColor = "yellow";
  }
  {
    type = "initsystem";
    key = icons.init;
    keyColor = "yellow";
  }
  {
    type = "packages";
    key = icons.pkgs;
    keyColor = "yellow";
  }
  {
    type = "terminal";
    key = icons.term;
    keyColor = "yellow";
  }
  {
    type = "shell";
    key = icons.shell;
    keyColor = "yellow";
  }
  {
    type = "editor";
    key = icons.editor;
    keyColor = "yellow";
  }

  "break"

  {
    type = "custom";
    format = icons.sectionEnv;
  }
  {
    type = "de";
    key = "│ ├ ◐";
    keyColor = "blue";
  }
  {
    type = "wm";
    key = "│ ├ ▦";
    keyColor = "blue";
  }
  {
    type = "wmtheme";
    key = "│ ├ ◈";
    keyColor = "blue";
  }
  {
    type = "terminalfont";
    key = "└ └ ≡";
    keyColor = "blue";
  }
]
