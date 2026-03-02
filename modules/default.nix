{... }:
 {
   # You can import other NixOS modules here
  imports = [
     ./disk-boot
     ./drivers
     ./hardware
     ./integration
     ./maintenance
     ./manager
     ./network
     ./rules
     ./security
     ./services
     ./shell
     ./users
    ];
}
