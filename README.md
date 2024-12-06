# jswasi-rootfs

Copyright (c) 2023-2024 [Antmicro](https://www.antmicro.com)

This repository contains a collection of makefiles and patches that allow to build complete [jswasi](https://github.com/antmicro/jswasi) distributions for browser usage.

## Prerequisites

To install prerequisites on Debian, use:
```
apt-get install git wget zip autoconf automake clang libclang-dev make build-essential node-typescript nodejs gettext-base unzip esbuild libtool curl cmake ninja-build pkg-config libssl-dev golang
```

Make sure you have [rustup](https://www.rust-lang.org/tools/install) installed.
You will also need at least version 1.21 of `go`, for installation instructions, see https://go.dev/doc/install.

## Building

To build a rootfs along with an index with jswasi, use:
```
make all
```

If you only want to build some specific packages, you can use the `PACKAGES` environment variable.
For example if you only wish to have `coreutils`, `wasibox` and `wash` included in the rootfs, you can use the following command.
```
make PACKAGES="coreutils wasibox wash" all
```
Keep in mind that if any of these packages have dependencies that are not included in the `PACKAGES` variable, these dependencies will be built as well.

To remove build artifacts, use:
```
make clean
```

To remove all build files and the output, use:
```
make clean_all
```

## Using alternate sources

`jswasi-rootfs` supports replacing pacakge source URLs with alternate ones using `ALTERNATE_URL_DEFAULT` environment variable.
If set, the URL pattern in this variable will be used in all packages.
In case it doesn't return a successful response, the default URL is used as a fallback.
In the `ALTERNATE_URL_DEFAULT` variable, the `%VERSION`, `%REPO` and `%OWNER` substrings are replaced with the respective metadata from each package.
