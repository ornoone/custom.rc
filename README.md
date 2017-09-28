custom.rc
=========

all my personal .rc files.

- use oh-my-zsh: 
    `apt-get install -y zsh git curl && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
- use theme agnoster
- use plugins : git debian docker systemd python common-aliases dirhistory pip npm django
- set custom aliases : 

  * workon. : enable a virtualenv matching current dir
  * generepasswd : use apg to create a 8 char long secure/spellable password

- custom vim config with powerline and many small features


easy unpack : 

    curl -L  https://api.github.com/repos/ornoone/custom.rc/tarball | tar  xvz --strip-components=1  --exclude='LICENSE' --exclude='README.md'
