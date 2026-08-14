{ config, pkgs, inputs, ... }:

{
  home.username = "roro";
  home.homeDirectory = "/home/roro";

  home.stateVersion = "26.05";

  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dsearch.homeModules.default
  ];

  home.packages = with pkgs; [
    # Core
    gcc
    kitty
    vim
    git
    playerctl
    brightnessctl
    libsForQt5.qt5ct
    kdePackages.qt6ct
    inputs.dcal.packages.${pkgs.stdenv.hostPlatform.system}.dankcalendar
    kdePackages.breeze
    file
    glib

    # Code
    python3
    docker
    act
    wpilib
    choreo
    opencode
    opencode-desktop

    # Graphics
    ddcutil
    pciutils
    vulkan-tools
    mesa-demos
    nvtopPackages.nvidia

    # Files
    fzf
    p7zip
    yazi
    gdu
    rclone

    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono

    # Tools
    fastfetch
    ffmpeg
    nodejs
    
    # Media
    spotify
    cava
    mpv
    obsidian

    # Browser
    chromium
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Games
    steam
    vesktop
    godot
    blender

    # Windows
    wine
    yabridge
    yabridgectl
    qpwgraph
    helvum
  ];

  services.kdeconnect = {
    enable = true;
  };

  programs.git = {
    enable = true;

    settings.user = {
      name = "Rohan Bharatia";
      email = "rohan.bharatia@outlook.com";
    };
  };

  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };
  };

  programs.dsearch.enable = true;

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      share = true;
      path = "$HOME/.zsh_history";
      ignorePatterns = ["rm *" "pkill *" "cp *"];
    };

    shellAliases = {
      ls = "ls --color=auto";
      la = "ls -A";
      ll = "ls -alF";
      l = "ls -CF";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -I";
      ln = "ln -v";
      disk_usage = "sudo btrfs filesystem usage /";
      df = "df -hT";
      fetch = "fastfetch --file /home/roro/.local/share/fastfetch.txt";
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      ncdu = "gdu";
      edit = "sudo -e";
      mkcd = "mkdir -p \"$1\" && cd \"$1\"";

      "~" = "cd ~";
      ".." = "cd ..";
      "..." = "cd ../..";

      sudo = "/home/roro/.local/share/scripts/sudo.sh";
      yazi = "/home/roro/.local/share/scripts/yazi.sh";
      dgpu-run = "/home/roro/.local/share/scripts/dgpu-run.sh";

      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#NixOS";
      update = "nix flake update /etc/nixos";
    };

    initContent = ''
      export EDITOR="nvim"
      export VISUAL="nvim"
    '';
  };

  programs.starship = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      add_newline = false;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      directory = {
        truncation_length = 3;
      };

      git_branch = {
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
      };
    };
  };

  programs.kitty = {
    enable = true;

    settings = {
      font_size = 14;
      confirm_os_window_close = 0;
    };

    extraConfig = ''
      include dank-theme.conf
      include dank-tabs.conf
    '';
  };

  programs.neovim = {
    enable = true;

    initLua = ''
      require("config.lazy")
      vim.cmd("colorscheme dms")
    '';
  };
}
