# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware), use something like:
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
    # It's strongly recommended you take a look at
    # https://github.com/nixos/nixos-hardware
    # and import modules relevant to your hardware.

    # Import your generated hardware configuration
    ./hardware-configuration.nix

    # Feel free to split up your configuration and import pieces of it here.
  ];

  networking = {
    useDHCP = false;
    hostName = "x571";
    extraHosts = "127.0.1.1 x571";
    networkmanager.enable = true;
      interfaces = {
        enp2s0.useDHCP = true;
      };
  };

    boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sda";
      };
    };
  };

   users.users.lucas = {
     isNormalUser = true;
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ];
    initialPassword = "changeme";
   };
  # This setups SSH for the system (with SSH keys ONLY). Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  programs = {
    light.enable = true;
    nm-applet.enable = true;
  };

  console = {
     font = "Lat2-Terminus16";
     keyMap = "br-abnt2";
  };

  # Remove if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;

  # Enable flakes and new 'nix' command
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    autoOptimiseStore = true;
  };
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };
  # This will make all users activate their home-manager profile upon login, if
  # it exists and is not activated yet. This is useful for setups with opt-in
  # persistance, avoiding having to manually activate every reboot.
  environment.loginShellInit = ''
    [ -d "$HOME/.nix-profile" ] || /nix/var/nix/profiles/per-user/$USER/home-manager/activate &> /dev/null
  '';

  # This will add your inputs as registries, making operations with them
  # consistent with your flake inputs.
  nix.registry = lib.mapAttrs' (n: v:
    lib.nameValuePair (n) ({ flake = v; })
  ) inputs;


environment.systemPackages = with pkgs; 

  [wget curl vim git alacritty ]
  ++ [ flameshot ranger xclip]
    ++ [ firefox ];

  
  time.timeZone = "America/Sao_Paulo";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;


    # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "br";

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;

}
