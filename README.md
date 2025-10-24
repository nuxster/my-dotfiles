# Neo VIM

**Install latest stable release of Neo VIM**
```shell
mkdir -p ~/.local/bin/ && \
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -O ~/.local/bin/vim
```

**Install requirenments**
```shell
sudo apt install python3-venv
```

**Plugins**
```text
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

```text
:PackerInstall
q
```

**Language servers**
```text
:LspInstall lua_ls marksman pylsp terraformls lemminx
```

**Spelling**
```text
mkdir ~/.config/nvim/spell/
wget https://ftp.uni-bayreuth.de/packages/editors/vim/runtime/spell/ru.utf-8.spl -O ~/.config/nvim/spell/ru.utf-8.spl
wget https://ftp.uni-bayreuth.de/packages/editors/vim/runtime/spell/en.utf-8.spl -O ~/.config/nvim/spell/en.utf-8.spl
wget https://ftp.uni-bayreuth.de/packages/editors/vim/runtime/spell/en.ascii.spl -O ~/.config/nvim/spell/en.ascii.spl
```
