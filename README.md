# dotfiles

My macOS setup, managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [Lix](https://lix.systems). One command installs my apps, CLI tools, fonts, and macOS settings on a new Mac.

```
dotfiles/
├── nix-darwin/
│   ├── flake.nix        # system config: packages, Homebrew apps, macOS settings
│   └── flake.lock       # pinned versions
├── .config/             # app configs, linked into ~/.config with stow
├── .zshrc, .zshenv      # linked into ~ with stow
└── .stow-local-ignore   # what stow skips (nix-darwin, README, .git)
```

- **Nix packages:** CLI tools and some apps (`environment.systemPackages`)
- **Homebrew:** apps not in nixpkgs, installed automatically by nix-homebrew
- **macOS settings:** Dock, Finder, keyboard, shortcuts, sleep
  Requires an Apple Silicon Mac and an admin account.

---

## New Mac setup

### 1. Install Command Line Tools

Provides `git`, which you need to clone this repo (Homebrew needs it too).

```bash
xcode-select --install
```

### 2. Install Lix

Lix is the Nix implementation this config uses. After the first switch, nix-darwin takes over managing it (`nix.package = pkgs.lix` in `flake.nix`).

```bash
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```

Open a new terminal, then check that it worked:

```bash
nix --version   # should mention "Lix"
```

### 3. Clone this repo

```bash
git clone https://github.com/el-ser/dotfiles.git ~/dotfiles
```

If the repo is private, set up an SSH key first and clone with `git@github.com:el-ser/dotfiles.git` instead.

### 4. Set your username

```bash
whoami
```

Make sure the output matches this line in `nix-darwin/flake.nix`:

```nix
username = "macky"; # replace with whoami
```

### 5. First switch

`darwin-rebuild` isn't installed yet, so this command borrows it from nix-darwin's GitHub once. It reads your local `flake.nix` and installs everything. Homebrew is installed automatically, so don't install it yourself.

```bash
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/dotfiles/nix-darwin#el-ser
```

The first run takes a while. If it fails, see [Troubleshooting](#troubleshooting).

### 6. Log out and back in

This is needed for the keyboard shortcuts and the Caps Lock → Control remap to take effect.

### 7. Link app configs

The repo mirrors your home directory, so one command links everything. For example, `.config/nvim/init.lua` becomes `~/.config/nvim/init.lua`. Anything listed in `.stow-local-ignore` (like `nix-darwin` and this README) is skipped.

```bash
mkdir -p ~/.config   # so stow links the folders inside it, not ~/.config itself
cd ~/dotfiles
stow .
```

The repo must sit directly in your home folder, because `stow .` links into the parent of the current folder. Run `stow -n -v .` first for a dry run. If stow reports conflicts, move the existing files aside and run it again. Run `stow -R .` to re-link after adding files, and `stow -D .` to remove all the links.

### 8. Manual steps

These are things Nix doesn't handle:

- [ ] Sign in to 1Password and Bitwarden
- [ ] Set up an SSH key for GitHub
- [ ] Run `gh auth login`
- [ ] Set Raycast's hotkey to ⌘Space (Spotlight is moved to ⌥Space)
- [ ] Give AeroSpace accessibility access in System Settings → Privacy & Security → Accessibility
- [ ] Install tmux plugins: run `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`, start tmux, then press prefix + `I`. The plugins aren't stored in this repo

---

## Everyday use

| Task                          | Command                                                            |
| ----------------------------- | ------------------------------------------------------------------ |
| Test changes without applying | `darwin-rebuild build --flake ~/dotfiles/nix-darwin#el-ser`        |
| Apply changes                 | `sudo darwin-rebuild switch --flake ~/dotfiles/nix-darwin#el-ser`  |
| Update package versions       | `cd ~/dotfiles/nix-darwin && nix flake update`, then apply         |
| Upgrade Homebrew apps         | `brew upgrade` (auto-upgrade is off)                               |
| Undo the last switch          | `sudo darwin-rebuild --rollback`                                   |
| List past versions            | `sudo darwin-rebuild --list-generations`                           |

**Add apps through `flake.nix` only.** Homebrew cleanup is set to `zap`, so anything you install with `brew install` by hand gets removed on the next switch.

After `nix flake update`, commit the new `flake.lock`.

---

## Troubleshooting

**`Unexpected files in /etc, aborting activation`**

The Lix installer created files that nix-darwin wants to manage. Rename each file listed in the error, then run step 5 again:

```bash
sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
```

**Error about the `nixbld` group ID**

Fresh Nix installs may use a different group ID. Set `ids.gids.nixbld` in `flake.nix` to the number shown in the error, then run step 5 again.

**New files are ignored, or the flake says a path doesn't exist**

Flakes only see files tracked by git:

```bash
cd ~/dotfiles && git add .
```

---

## Uninstall

Remove nix-darwin:

```bash
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
```

Remove Lix:

```bash
/nix/lix-installer uninstall
```
