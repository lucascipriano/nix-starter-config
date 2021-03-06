# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3591af52-8a39-4dc9-a39b-ad4e0b40eddf";
      fsType = "ext4";
    };

    fileSystems."/backup" =
    { device = "/dev/disk/by-uuid/0a2a8df4-2a10-46c3-b6ea-2c86d9b76b02";
      fsType = "ext4";
    };



  swapDevices =
    [ { device = "/dev/disk/by-uuid/be231579-4770-4515-a384-ba61d7b96f3d"; }
    ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
