# Running custom Rust installer on Palmetto Cluster

## As non-root user

```
mkdir -p ~/software ~/modulefiles
./rust-custom-installer.bash 1.23.0 ~/software ~/modulefiles
```

## As root
### Command executed on "master" or "util" node

```
./rust-custom-installer.bash 1.23.0 /software /software/modulefiles
```

## Notes:
  - A log file is placed under the home directory of the user that ran the install script.
  - A .rust-archives directory is created under the home directory of the user running the script to save/cache downloaded rust archives.
    - If a particular archive already resides in the .rust-archives directory it won't be downloaded again.
