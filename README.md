# Nix Home Manager Setup Guide

This document walks you through setting up Nix and Home Manager with Flakes to manage your system configuration. This is catered towards Azure ML compute instances with its inherent volume configuration challenges. Still WIP


### 1. Fork and Clone this Repo

Clone from your forked repo:

```bash
mkdir -p ~/repos
cd ~/repos
git clone <forked-repo>
cd nix-config
```

### 2. Install Nix Package Manager

If Nix is not installed, run the official installer (yes to all defaults):

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Verify installation:

```bash
nix --version
```

### 3. Enable Experimental Features

Run the following to enable system-wide nix commands:

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

### 4. Update the Configurations

Specify your userName and userEmail in nix-config/modules/git.nix

### 5. Build and Activate Your Configuration

Build and activate your flake-based Home Manager configurations:

```bash
nix run github:nix-community/home-manager -- switch --flake .#azureuser -b backup
```

> [!NOTE]
> At this point, you should now be setup with basic Nix! Read on to learn more about working with Nix. 

### 6. Apply Your Configuration Changes 

To reapply changes after editing your config: 

```bash
nix flake update
nix run .#homeConfigurations.azureuser.activationPackage
```

### 7. Roll Back if Needed

This lists previous generations. You can activate an earlier one using its path.

```bash
nix run github:nix-community/home-manager -- generations
```

### 8. Pruning Garbage 

Prune nix system garbage:

```bash
nix-collect-garbage --delete-older-than 10d
```

## Troubleshooting

- If you encounter permission issues during Nix installation, make sure you have sudo access
- You may have to restart or create a new shell after installations or activations to 
    ensure changes take effect
- For configuration errors, check the syntax in your home.nix file

## Additional Resources

- [Nix Documentation](https://nixos.org/manual/nix/stable/)
- [Home Manager Documentation](https://nix-community.github.io/home-manager/)
- [Home Manager Options](https://nix-community.github.io/home-manager/options.html)
- [Nix Packages](https://search.nixos.org/packages)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
