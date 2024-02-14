custom.rc
=========

all my personal .rc files.

- use oh-my-zsh: 
    `apt-get install -y zsh git curl zsh-syntax-highlighting && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
- use theme agnoster
- use plugins : git debian docker systemd python common-aliases dirhistory pip npm django
- set custom aliases : 

  * workon. : enable a virtualenv matching current dir
  * generepasswd : use apg to create a 8 char long secure/spellable password

- custom vim config with powerline and many small features


easy unpack : 

    curl -L  https://api.github.com/repos/ornoone/custom.rc/tarball | tar  xvz --strip-components=1  --exclude='LICENSE' --exclude='README.md'

further customisation for servers 
---------------------------------

instal requirements:
    
    pip3 install powerline-status
    apt-get install linuxlogo lolcat figlet 
    
    cat << 'EOF' > /etc/rc.local 
    #!/bin/sh
    linuxlogo > /etc/motd

    printShinySeeded() {
    
      local seed=$( echo $1 | python3 -c 'import sys, functools; print(functools.reduce(lambda a, b: a+b, (ord(l) for l in sys.stdin.read())))')
      figlet -w 119 $1 | /usr/games/lolcat -f -S ${seed}
    }
    printShinySeeded $(hostname) >>  /etc/motd
    exit 0
    EOF
    
snipets
-------

sudoers: to keep your home when you do `sudo -s`, so multiple user can keep their history and rc's while root

    Defaults        env_keep= "HOME EDITOR"

add ZSH_DISABLE_COMPFIX=true to .zshrc
