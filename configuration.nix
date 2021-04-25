# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = { 
        enable = true;
        devices = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };
  };    

  networking = {
    hostName = "nixos"; # Define your hostname.
    wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
    # Set your time zone.
    time.timeZone = "America/Kentucky/Louisville";

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = { 
      enp2s0.useDHCP = true;
      wlp6s0.useDHCP = true;
    };
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };
  };

  # Enable the X11 windowing system.
  services = {
    httpd.enable = true;
    xserver = {
      enable = true;
      # Enable the Plasma 5 Desktop Environment.
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      # Configure keymap in X11
      layout = "us";
      xkbOptions = "eurosign:e";
    };
  };  
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.wpeace = {
  isNormalUser = true;
  home = "/home/wpeace";
  description = "wpeace";
  extraGroups = [ "wheel" "networkmanager" ];
};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget 
    vim
    neovim
    firefox
    alacritty
    nano
    vscodium
    xclip
    xorg.xkbcomp
    glibc
    ffmpeg
    xorg.xmodmap
    mpd
    neofetch
    w3m
    pciutils
    python
    emacsggG
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib-gpl
    qtile
    spectrwm
    pipewire
    awesome
    font-awesome
    nerdfonts
    bspwm
    gtop
    htop
    feh
    nitrogen
    sxiv
    mpv
    qbittorrent
    mono
    tor-browser-bundle-bin
    neomutt
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    bash
    nix-bash-completions
    sxhkd
    flameshot
    ncmpcpp
    musikcube
    polybar
    ranger
    lf
    nnn
    lxappearance
    qt5ct
    xed
    picom
    adwaita-qt
    nordic
    nordic-polar

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

