{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/42f4a716-e8cf-4f51-b4b0-491bb837cbb0";
      fsType = "btrfs";
      options = [
        "subvol=@"
        "noatime"
        "space_cache"
        "compress-force=zstd"
        "discard=async"
        "commit=120"
      ];
    };

    "boot" = {
      device = "/dev/disk/by-uuid/7D11-1CD3";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/42f4a716-e8cf-4f51-b4b0-491bb837cbb0";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "noatime"
        "space_cache"
        "compress-force=zstd"
        "discard=async"
        "commit=120"
      ];
    };

    "/opt" = {
      device = "/dev/disk/by-uuid/42f4a716-e8cf-4f51-b4b0-491bb837cbb0";
      fsType = "btrfs";
      options = [
        "subvol=@opt"
        "noatime"
        "space_cache"
        "compress-force=zstd"
        "discard=async"
        "commit=120"
      ];
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/45c3133d-8e73-4877-a9d5-1e6796eec17e";
    }
  ];
}