{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.dank-greeter.nixosModules.default
  ];

  hardware.graphics = {
    enable = true;

    enable32Bit = true;
  };

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

  hardware.bluetooth = {
    enable = true;
  
    powerOnBoot = true;
  
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  hardware.i2c.enable = true;

  virtualisation.docker.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Daedalus";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  services.xserver.enable = true;
  services.printing.enable = true;
  services.power-profiles-daemon.enable = true;
  services.accounts-daemon.enable = true;
  services.fprintd.enable = true;
  services.pipewire = {
    enable = true;

    pulse.enable = true;
    wireplumber.enable = true;
  };

  users.users.roro = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "i2c"
      "docker"
    ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  environment.sessionVariables = {
    XDG_MENU_PREFIX = "kde-";
  };

  nixpkgs.config.allowUnfree = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs;
    };

    users.roro = import ./home.nix;
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
  programs.steam.enable = true;

  programs.hyprland = {
    enable = true;

    withUWSM = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;

  programs.dms-greeter = {
    enable = true;

    compositor.name = "hyprland";
    configHome = "/home/roro";

    configFiles = [
      "/home/roro/.config/DankMaterialShell/settings.json"
    ];
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;

    enableSSHSupport = true;
  };

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      57621
    ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    
    allowedUDPPorts = [
      5353
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  services.openssh.enable = true;

  system.copySystemConfiguration = false;
  system.stateVersion = "26.05";
}
