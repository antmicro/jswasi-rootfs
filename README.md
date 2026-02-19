# jswasi-rootfs

Copyright (c) 2023-2026 [Antmicro](https://www.antmicro.com)

This repository contains a collection of makefiles and patches that allow to build complete [jswasi](https://github.com/antmicro/jswasi) distributions for browser usage.

## Prerequisites

To install prerequisites on Debian, use:
```
apt-get install git wget zip autoconf automake clang libclang-dev make build-essential node-typescript nodejs gettext-base unzip esbuild libtool curl cmake ninja-build pkg-config libssl-dev golang
```

Make sure you have [rustup](https://www.rust-lang.org/tools/install) installed.
You will also need at least version 1.21 of `go`, for installation instructions, see https://go.dev/doc/install.

## Building

To build the rootfs along with the index, run:

```bash
make
```

or

```bash
make build
```

### Selective Builds

If you only want to build specific packages, use the `PACKAGES` variable. For example, to include only `coreutils`, `wasibox`, and `wash`:
```bash
make PACKAGES="coreutils wasibox wash" build
```
> **Note:** If a package has dependencies not listed in `PACKAGES`, those dependencies will still be built to ensure a valid rootfs.

## Cleaning

The project provides granular control over cleaning build artifacts.

### Package Cleanup

You can clean artifacts for specific packages using the same `PACKAGES` variable:

```bash
# Clean only specific packages
make PACKAGES="coreutils wash" clean

# Clean all packages (default behavior)
make clean
```

### Workspace Cleanup

To wipe the entire workspace including the rootfs and dist files:
```
make clean_all
```

### Specific Clean Targets

The following targets allow you to clean specific stages of the build process:

| **Target**        | **Description**                                               |
| ----------------- | ------------------------------------------------------------- |
| `clean_build`     | Removes the `work/build` directory (all package build trees). |
| `clean_rootfs`    | Removes the `work/rootfs` directory.                          |
| `clean_resources` | Removes the `work/dist/resources` directory.                  |
| `clean_dist`      | Removes the entire `work/dist` directory.                     |

## Running

To run the **jswasi** instance, you need to serve the `work/dist` directory over HTTP.

### Using the Make wrapper

The most convenient way is to use the provided wrapper:

```bash
make run_server
```

_By default, this runs on port 8000. You can override it with `make run_server HTTP_PORT=9000`._

### Manual method

Alternatively, you can use any static HTTP server. For example, using Python:

```bash
cd work/dist
python3 -m http.server 8000
```

> **Tips:**
> - To clean old jswasi data use `purge` command in jswasi terminal and refresh the page (`Ctrl+Shift+F5` = hard-reload).
> - To update jswasi service worker, go to: `DevTools > Application > Service workers > Unregister` and refresh the page.

## Using alternate sources

`jswasi-rootfs` supports replacing package source URLs with alternate ones using `ALTERNATE_URL_DEFAULT` environment variable.
If set, the URL pattern in this variable will be used in all packages.
In case it doesn't return a successful response, the default URL is used as a fallback.
In the `ALTERNATE_URL_DEFAULT` variable, the `%VERSION`, `%REPO` and `%OWNER` substrings are replaced with the respective metadata from each package.
