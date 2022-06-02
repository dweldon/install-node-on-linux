# Install Node on Linux

<img src="https://nodejs.org/static/images/logos/nodejs-new-pantone-black.svg" alt="node.js logo" width="300" height="183.7" style="margin: 2rem 0;">

Installing node on linux shouldn't be a huge pain. Every guide out there will
point you to one of these options:

1. Install the default from your package manager globally
2. Add a PPA and install it globally
3. Use [nvm](https://github.com/nvm-sh/nvm)
4. Build it from source

The first two options have little flexibility and require running things like
`sudo npm install`, which is ridiculous. `nvm` is a legitimate option if you
need to regularly switch between versions with the understanding that you you'll
need to learn another tool. Building node from source just isn't necessary for
most people, and the prebuilt binaries work just fine.

**If you just want a fast way to install and update a single version of node,
use this script.**

## Notes

- This script adds an `export` to the end of your `~/.bashrc`.
- It works on Ubuntu. I haven't tested it on other distributions.
- If you find an issue with your distribution, open an issue or send me a PR.

## Install

This will clone the repository and install the latest version of node:

```sh
git clone git@github.com:dweldon/install-node-on-linux.git
cd install-node-on-linux && ./setup.sh && source ~/.bashrc
```

## Add packages

Your global packages will be removed every time you install a new version of
node. If you have a list of packages you'd like to install every time, add their
names to the list:

```sh
echo "yarn" >> packages
```

## Change version

This will download and install a specific version. In this example: `16.15.0`.

```sh
./change-version.sh '16.15.0'
```

## Uninstall

1. Remove the `~/local`, `~/.npm`, and `~/.node-gyp` directories
2. Remove the node.js export from your `~/.bashrc`
3. Remove the `install-node-on-linux` source
