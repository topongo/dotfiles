# Created by bodo the almighty

function is_host(){
  for i in $@; do
    [[ "$HOST" = "$i" ]] && return 0
  done
}

function is_android(){
  uname -a | grep Android > /dev/null
}

function bell(){
  echo -e "\07"
}

function ghclone(){
  eval "git clone https://github.com/$1 $2"
}

function topongoclone(){
  [ -z "$1" ] && return 1
  ghclone "topongo/$1" "$2"
}

function dsa(){
  $@ < /dev/null > /dev/null 2>&1 &!
}

function ffduration(){
  for i in "$@"; do
    ffprobe -loglevel quiet -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$i"
  done
}

function use_nvim(){
  echo -n "Use neovim instead? "
  if read -q; then
    nvim $@
  else
    /bin/nano $@
  fi
}

function rm(){
  if [[ "$@" == *-r* ]]; then
    echo "Wait 5 seconds before executing \`rm $@\`..."
    sleep 5
  fi
  /usr/bin/rm $@
}

function fsize(){
  stat --printf=%s $1
}

export PATH=$GOPATH:$GOPATH/bin:$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:/opt/riscv/bin
if is_android; then
  export OMZSH=$HOME/.oh-my-zsh
fi
source ~/.omzshrc

alias stocazzo='echo "Non dire parulacce"'
alias stocasso=stocazzo
alias urldecode="url_en-de-code.py decode"
alias urlencode="url_en-de-code.py encode"
alias szshrc="source ~/.zshrc"
alias opendns="echo 208.67.222.222,208.67.220.220"
alias openssl-enc="openssl enc -aes-256-cbc -pbkdf2 -in - -out -"
alias openssl-dec="openssl enc -d -aes-256-cbc -pbkdf2 -in - -out -"
alias al=sl
alias ks=sl
alias ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo="echo cazzo vuoi\?"
alias ipaddr="ip addr | grep 'inet[^6]' | awk '{ print \$2 }'"
alias nano=use_nvim
alias hstop="HISTFILE=/dev/null"
alias pipi=pip
# rust fanboy
alias ua=update-all
alias chmox="chmod +x"
alias cago=cargo
alias zj=zellij
alias bdc=bodoConnect
alias sugo=sudo
alias this-is-mine-now="sudo chown -R $USER:$USER"
alias shitdown="shutdown"

export GOPATH=$HOME/gopath
export EDITOR=nvim
export NTFY_WARNING=""
export NTFY_ERROR=""
export NTFY_CRITICAL=""
export NTFY_INFO=""
export COLORTERM=truecolor
export LC_LANG="en_US.UTF8"

if [[ -z $DISPLAY ]]; then
  export SSH_ASKPASS=/usr/lib/ssh/gnome-ssh-askpass3
else
  export SSH_ASKPASS=
fi

# if ! is_android; then
  export LC_ALL="en_US.UTF-8"

  if pidof -q ssh-agent; then
    eval "$(keychain --eval --quiet)"
  else
    echo -n "Start keychain service? (y/N) "
    if read -q; then
      echo
      eval "$(keychain --eval --ignore-missing ~/.ssh/id_ed25519)"
    fi
  fi
# fi

function cmdlineof(){
  procs=$(pidof $1)
  if [[ ! -z $procs ]]; then
    echo $procs | xargs ps -o "pid=" -o "command="
  else
    echo No such process 1>&2
  fi
}

if is_host topongoPC dell PathFinder raspserver raspserver2; then
  if is_host topongoPC PathFinder; then
    # computers with X server
    alias 2screens="autorandr --change 2screens"
    alias 1screen="autorands --change 1screen"
    alias xcopy="xclip -selection clipboard"
    alias xpaste="xclip -o -selection clipboard"
    alias wine32="WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine"
    alias ffhide="ffplay -nodisp -autoexit"
    export NOTIFY=/usr/share/sounds/freedesktop/stereo/bell.oga
    if [[ $(nproc) -gt 8 ]]; then
      export MAKEFLAGS="-j8"
    else
      export MAKEFLAGS="-j${nproc}"
    fi
    alias blink="ffhide \"$NOTIFY\" > /dev/null 2>&1"


    function pdf-extract(){
      if [ -z "$3" ]; then
        out="./"
      else
        out="$3"
      fi
      pdftk "$1" cat "$2" output "$out/${1/.pdf/.$2.pdf}"
    }

    if is_host topongoPC; then
      export LFS="/mnt/data/disk_images/lfs/mount"
    fi

    if is_host PathFinder; then
      alias rmwifi="sudo rmmod rtw88_8821ce; sudo modprobe rtw88_8821ce"
    fi

    if is_host dell; then
      alias spawn-private="screen -S private sudo /mnt/data/nas/private/space/mount.sh"
    fi
  fi

  # systemctl aliases
  alias  ssc="sudo systemctl"
  alias sscr="ssc restart"
  alias sscu="ssc status"
  alias ssca="ssc start"
  alias ssco="ssc stop"
  alias ssce="ssc enable"
  alias sscd="ssc disable"
  alias sscm="ssc mask"
  alias sscum="ssc unmask"

  alias usc="systemctl --user"
  alias uscr="usc restart"
  alias uscu="usc status"
  alias usca="usc start"
  alias usco="usc stop"
  alias usce="usc enable"
  alias uscd="usc disable"
  alias uscm="usc mask"
  alias uscum="usc unmask"

  alias sjc="sudo journalctl -u"
  alias sjcf="sudo journalctl --follow -u"

  alias ujc="journalctl --user -u"
  alias ujcf="journalctl --user --follow -u"

  alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"

  function mkdircd(){
    mkdir "$1"
    cd "$1"
  }

  function wg-reload(){
    conf="$(ip addr | grep POINTOPOINT | awk '{ print $2 }' | sed 's/://')"
    sudo wg-quick down $conf
    sudo wg-quick up $conf
  }

  if is_host topongopc PathFinder dell; then
    export OHMYZSH=/usr/share/oh-my-zsh/zshrc
    export ZSH=/usr/share/oh-my-zsh/
  fi

elif uname -a | grep Android > /dev/null; then
  alias xcopy="termux-clipboard-set"
  alias xpaste="termux-clipboard-get"

  function adbtcp(){
    sudo setprop service.adb.tcp.port 6666
    sudo stop adbd
    sudo start adbd
  }

  if [[ ! -d ~/tmp ]]; then
    mkdir $PREFIX/tmp/$USER
    ln -s $PREFIX/tmp/$USER ~/tmp
  fi

  # check if looper is running
  #if (( $(date +%s) - $(cat ~/data/looper/restarter_poll) > 120 )); then
  #  colorize yellow "Looper stopped!"
  #fi
fi

if [ -f /usr/share/zsh-antidote/antidote.zsh ]; then
  source /usr/share/zsh-antidote/antidote.zsh
  antidote load
fi

(setopt NO_NOTIFY NO_MONITOR; zsh ~/bin/check-updates &)


