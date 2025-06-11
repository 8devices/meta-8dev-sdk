# 8devices SDK Layers Container

The 8devices Yocto SDK is a collection of layers containing configuration files
and recipes to build the 8devices reference DISTRO for supported MACHINES.

## Dependencies

- [Poky](https://git.yoctoproject.org/poky)
- [Meta OpenEmbedded](https://git.openembedded.org/meta-openembedded)
- [Meta SWUpdate](https://github.com/sbabic/meta-swupdate)
- [Meta 8dev](https://github.com/8devices/meta-8dev)

## Host Preparation

1. Ensure your host system meets the [Yocto Project requirements](https://docs.yoctoproject.org/5.0.6/ref-manual/system-requirements.html)
2. Initialize and update the git submodules:
   ```
   git submodule update --init --recursive
   ```

## Build Initialization

### Interactive Setup

To set up the build interactively with guided menus:

   ```
   ./8dev-setup-build
   ```

This method will guide you through menus to select your build configuration.

### Manual Setup

Alternatively, you can set up the build manually:

List available build configurations:

   ```
   ./8dev-setup-build -l
   ```

Set up a specific build configuration:

   ```
   ./8dev-setup-build <config-name> [build-directory]
   ```

  - `<config-name>` (required): Choose from the available build configurations
  - `[build-directory]` (optional): Specify a custom build directory

Optionally when setting up initialising build MACHINE and/or DISTRO may be
specified by passing MACHINE and DISTRO environment variables:

   ```
   MACHINE=machine-name DISTRO=distro-name ./8dev-setup-build <config-name> [build-directory]
   ```

Alternatively force disable dialog windows and use CLI prompts for interactive
build configuration:

   ```
   NO_DIALOG=1 ./8dev-setup-build <config-name> [build-directory]
   ```

> **Note:** Build configuration is initialized once and persists until changed.
> Build environment reinitialization is described in the sections below. When
> initializing build using `8dev-setup-build`, a new shell session is started
> automatically.

## Environment Initialization

### Basic Environment Setup

Initialize the build environment for a previously configured build:

   ```
   . 8dev-init-build-env
   ```

### Configuration Update

Update MACHINE and DISTRO configuration default preferences:

   ```
   . 8dev-init-build-conf
   ```

This can be done either:
- Through an interactive menu (requires `whiptail` or `dialog` installed on your host system)
- Through interactive command line prompts
- By passing MACHINE/DISTRO values through environment variables

## Building Images

Start a build in your configured environment:

   ```
   bitbake <target>
   ```

To override MACHINE and/or DISTRO parameters for a specific build:

   ```
   MACHINE=machine-name DISTRO=distro-name bitbake <image-name>
   ```

## Upgrading Software

Built images are located in the `[build-dir]/tmp/deploy/images/[MACHINE]` directory.

To upgrade your device using the deployed `fastboot_flash.py` utility:

   ```
   ./fastboot_flash.py --boot aImage.gz-[MACHINE].bin --system [IMAGE]-[MACHINE].rootfs.ext4-sparse
   ```
