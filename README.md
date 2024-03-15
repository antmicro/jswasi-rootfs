# jswasi-rootfs

Copyright (c) 2023-2024 [Antmicro](https://www.antmicro.com)

This repository contains a collection of makefiles and patches that allow to build complete [jswasi](https://github.com/antmicro/jswasi) distributions for browser usage.

## Building

To build a rootfs along with an index with jswasi, use:
```
make all
```

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
