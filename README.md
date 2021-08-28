# Adventure Game Studio Help Files

[![Build](https://github.com/adventuregamestudio/ags-manual/actions/workflows/build.yml/badge.svg)](https://github.com/adventuregamestudio/ags-manual/actions/workflows/build.yml)

## Reading the help files

For the most recent release of the manual two options are available:

- View the web pages at <https://adventuregamestudio.github.io/ags-manual/>
- Download a [CHM file](https://github.com/adventuregamestudio/ags-manual/releases/latest/download/ags-help.chm)

## Contributing

[![](ags-manual-readme.png)](https://adventuregamestudio.github.io/ags-manual/)

The source files for the help pages are contained within the
[wiki repository](https://github.com/adventuregamestudio/ags-manual/wiki)
of this project and can be edited on the wiki or cloned locally and pushed back.
Please open an [issue](https://github.com/adventuregamestudio/ags-manual/issues) if
something appears to be wrong. For a more in-depth look at contributing see
[`CONTRIBUTING.md`](CONTRIBUTING.md) for further details.

## Downloading a release

Release packages and pre-built release assets are available from the
[latest release](https://github.com/adventuregamestudio/ags-manual/releases/latest).

## Building a release

Building a release requires a POSIX-like shell and build environment,
Pandoc, and optionally a CHM compiler.

Firstly download and extract the latest release archive:

```sh
# Download the release archive for version $VERSION to the current directory
url="https://github.com/adventuregamestudio/ags-manual/releases/download/v$VERSION/ags-manual-$VERSION.tar.gz"
curl -fLOJ "$url"

# Extract the archive to the current directory
tar -xvzf "ags-manual-$VERSION.tar.gz"

# Change into the newly created directory
cd "ags-manual-$VERSION"
```

Next run the `configure` script.

Two CHM compilers are supported. Microsoft's `hhc` is preferred by
default. To instead build with Free Pascal's `chmcmd` use the configure
option `--with-chmcmd`.

The default behaviour is to locate Pandoc and a CHM compiler by
searching in PATH and running feature tests as necessary. To bypass
the search any feature checks the following environment variables can
be set:

variable | defines
--- | ---
PANDOC | path to pandoc
CHMCMD | path to chmcmd
HHC | path to hhc

Failure to locate a usable CHM compiler means that building the CHM
version of the manual pages will be skipped. Failure to locate a
usable version of Pandoc will mean that the build process will not be
able to proceed.

Help is available by running `configure --help`.

```sh
# Configure build with default settings
./configure
```

Once configuration is complete the build can be started by running
`make`.

```sh
# Start the configured build
make
```

Once the build has finished files can be installed with `make
install`. To stage files into a custom directory instead of performing
a regular installation, set the variable `DESTDIR` to the path which
should be used - this is a straightforward way to investigate the
final file and directory structure.

```sh
# Create an installation in a sub-directory named 'destdir'
make DESTDIR=destdir install
```

## License

Source code in this repository is distributed under MIT license. See
[`LICENSE`](LICENSE) for more information. The manual content which is
included from the wiki as a sub-module follows
[Adventure Game Studio's license](https://github.com/adventuregamestudio/ags/blob/master/License.txt).
