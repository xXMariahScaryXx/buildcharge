## file naming scheme:

0. no config
1. `configs/ramfs/<PACKAGE_NAME>/config.<architecture>`
2. `configs/ramfs/<PACKAGE_NAME>/config.cross.<host_arch>-<cross_arch>`
3. dynamic, will automatically choose a config based on whether or not we're cross-compiling. (requires config files be placed in both locations obviously)
For example:
```
configs/ramfs/BUSYBOX/config.aarch64
configs/ramfs/BUSYBOX/config.cross.x86_aarch64
```

Set `config_file` to any of the other schemes above (e.g: `"config_file": "2"` in the manifest). the ramfs builder will automatically copy it to `.config`