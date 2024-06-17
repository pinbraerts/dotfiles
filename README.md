# Dotfiles

## Bootstrapping

### Linux
Simply use [stow](https://www.gnu.org/software/stow/)
```bash
cd
git clone --recurse-submodules --remote-submodules https://github.com/pinbraerts/dotfiles.git
cd dotfiles
stow .
```

### Windows
Requires some presize configuration, if everything is ok, rerun `stow` without `-Verbose -Simulate`
```pwsh
cd
git clone --recurse-submodules --remote-submodules https://github.com/pinbraerts/dotfiles.git
cd dotfiles
./bin/stow.ps1 -Verbose -Simulate .vimrc .vsvimrc bin
```

#### nvim config
```pwsh
./bin/stow.ps1 -Verbose -Simulate -Directory .config -Target $env:LOCALAPPDATA nvim
```

#### powershell profile
```pwsh
./bin/stow.ps1 -Verbose -Simulate -Directory .config/powershell -Target $(Get-Item -Path $PROFILE).directory .
```
