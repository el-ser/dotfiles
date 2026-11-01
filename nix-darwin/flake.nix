{
  description = "el-ser nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      mac-app-util,
      nix-homebrew,
    }:
    let
      username = "macky"; # replace with whoami
      configuration =
        { pkgs, config, ... }:
        {
          nixpkgs.config.allowUnfree = true;

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            # cli
            pkgs.vim
            pkgs.neovim
            pkgs.aerospace
            pkgs.mas
            pkgs.git
            pkgs.brave
            pkgs.git-credential-manager
            pkgs.direnv
            pkgs.fzf
            pkgs.lazygit
            pkgs.watchman
            pkgs.tmux
            pkgs.stow
            pkgs.temporal
            pkgs.zoxide
            pkgs.bat
            pkgs.bun
            pkgs.starship
            pkgs.nodejs_24
            pkgs.spotify
            pkgs.sqitchPg
            pkgs.lsd
            pkgs.ripgrep
            pkgs.fd
            pkgs.tree-sitter
            pkgs.nixfmt
            pkgs.ngrok
            pkgs.python315
            pkgs.devenv
            pkgs.yazi
            pkgs.nh
            pkgs.go

            # applications
            pkgs.kitty
            pkgs.raycast
            pkgs.obsidian
            pkgs.bitwarden-desktop
            pkgs.bitwarden-cli
          ];

          fonts.packages = [
            pkgs.nerd-fonts.fira-mono
          ];

          homebrew = {
            enable = true;
            taps = [
              "sqitchers/sqitch"
              "fluxcd/tap"
            ];
            brews = [
              "kubernetes-cli"
              "zsh-autosuggestions"
              "kubectx"
              "watch"
              "fnm"
              "gh"
              "uv"
              "opencode"
              "kubelogin"
              "fluxcd/tap/flux"
            ];
            casks = [
              "ghostty"
              "1password"
              "1password-cli"
              "notion"
              "notion-calendar"
              "vivaldi"
              "claude"
              "claude-code"
              "codex"
              "discord"
              "postico"
              "stats"
            ];
            onActivation.cleanup = "zap";
            onActivation.upgrade = false;
          };

          # ids.gids.nixbld = 30000; tells nix-darwin "the GID of the nixbld group on this system is 30000, please don't complain about it." It's a configuration value that the activation check compares against the actual GID of the nixbld group on your Mac.
          ids.gids.nixbld = 30000;

          power.sleep.display = "never";
          power.sleep.computer = "never";

          system = {
            # Set Git commit hash for darwin-version.
            configurationRevision = self.rev or self.dirtyRev or null;
            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            stateVersion = 5;
            keyboard = {
              enableKeyMapping = true;
              remapCapsLockToControl = true;
            };
            primaryUser = username;
            defaults = {
              dock = {
                autohide = true; # Dock autohide
                largesize = 24;
                orientation = "left";
              };
              controlcenter = {
                # Always show battery percentage
                BatteryShowPercentage = true;
              };
              # Finder view style
              finder.FXPreferredViewStyle = "clmv";
              # Guest login
              loginwindow = {
                GuestEnabled = false;
                SHOWFULLNAME = false;
                DisableConsoleAccess = true;
              };
              NSGlobalDomain = {
                # Force 12-hour time format
                AppleICUForce24HourTime = false;
                # Interface style
                AppleInterfaceStyle = "Dark";
                # Key repeat
                KeyRepeat = 2;
                # Invert scroll direction (disable "natural" scrolling)
                "com.apple.swipescrolldirection" = false;
              };

              # macOS keyboard shortcut overrides (com.apple.symbolichotkeys plist).
              # Each numeric key is a hotkey ID hardcoded by Apple; setting it overwrites
              # the default binding for that action. Requires logout/login to take effect.
              CustomUserPreferences = {
                "com.apple.symbolichotkeys" = {
                  AppleSymbolicHotKeys = {
                    # Hotkey 60: Select the previous input source (default ⌃Space).
                    # Disabled so Ctrl+Space reaches the terminal (needed for nvim cmp trigger).
                    "60" = {
                      enabled = false;
                    };
                    # Hotkey 61: Select next source in Input menu (default ⌃⌥Space).
                    "61" = {
                      enabled = false;
                    };
                    # Hotkey 64: Show Spotlight search.
                    # Remapped from default ⌘Space to ⌥Space to free ⌘Space for Raycast.
                    # parameters = [ ascii virtualKeyCode modifierFlags ]
                    #   32     = ASCII for space
                    #   49     = virtual key code for spacebar
                    #   524288 = modifier flag bitmask for ⌥ (Option) alone
                    #            (⇧=131072, ⌃=262144, ⌥=524288, ⌘=1048576; sum to combine)
                    "64" = {
                      enabled = true;
                      value = {
                        parameters = [
                          32
                          49
                          524288
                        ];
                        type = "standard";
                      };
                    };
                  };
                };
              };
            };
          };

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;
          # programs.zsh.enableCompletion= true;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          nix.package = pkgs.lix;
          nix.settings = {
            experimental-features = "nix-command flakes";
            trusted-users = [ "root" username ];
          };
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#el-ser
      darwinConfigurations."el-ser" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          # Links packages to Applications folder
          mac-app-util.darwinModules.default
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;
              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = false;
              # User owning the Homebrew prefix (Username in your macbook)
              user = username;
              # Automatically migrate existing Homebrew installations
              autoMigrate = true;
            };
          }
        ];
      };
    };
}
