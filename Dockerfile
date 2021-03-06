# 下载 archlinux
FROM archlinux:base-devel
# 设置工作目录,在构建完成后进入镜像的根目录
WORKDIR /tmp
# 设置环境变量，在后续的指令中就可以使用该环境变量
ENV SHELL /bin/bash
# 设置pacman的镜像源
ADD mirrorlist /etc/pacman.d/mirrorlist

# 设置匿名数据卷
VOLUME ["/home/repos", "/root/.vscode-server/extensions"]

# 更新系统
RUN yes | pacman -Syu
# 下载基础工具 gcc which make 是为了在wsl arch 里面安装 ruby 用的
RUN yes| pacman -S git zsh vi vim neovim curl wget tree which gcc make 

# 配置 zsh 
RUN zsh -c 'git clone https://code.aliyun.com/412244196/prezto.git "$HOME/.zprezto"' &&\
    zsh -c 'setopt EXTENDED_GLOB' &&\
    zsh -c 'for rcfile in "$HOME"/.zprezto/runcoms/z*; do ln -s "$rcfile" "$HOME/.${rcfile:t}"; done'
# 配置完了之后将zsh设置为默认shell   或者编辑/etc/passwd文件，修改用户名后面的默认Shell即可。
ENV SHELL /bin/zsh
# 设置默认编辑器为nvim
ENV EDITOR=nvim


# 添加bashrc配置，包括简单的git命令别名
ADD bashrc /root/.bashrc

# node 
RUN yes | pacman -S nodejs npm &&\
    npm config set registry=https://registry.npmmirror.com &&\
    corepack enable

# nvm
ENV NVM_DIR /root/.nvm
ADD nvm-0.39.1 /root/.nvm
RUN sh /root/.nvm/nvm.sh &&\
    echo 'export NVM_DIR="$HOME/.nvm"' >> /root/.zshrc &&\
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /root/.zshrc &&\
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> /root/.zshrc


# Ruby 
ADD rvm-stable.tar.gz /tmp/rvm-stable.tar.gz
ENV PATH="/usr/local/rvm/bin:$PATH"
RUN mv /tmp/rvm-stable.tar.gz/rvm-rvm-6bfc921 /tmp/rvm && cd /tmp/rvm && ./install --auto-dotfiles &&\
    echo "ruby_url=https://cache.ruby-china.com/pub/ruby" > /usr/local/rvm/user/db &&\
    echo 'gem: --no-document --verbose' > "$HOME/.gemrc" &&\
    rvm install ruby-3
# end 
