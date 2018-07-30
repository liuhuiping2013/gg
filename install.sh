install_bash_c()
{
  if grep -q "^alias c=" ~/.bashrc; then
    printf "${YELLOW}You already have alias gg setting. ${NORMAL}\n"
    printf "You'll need to remove alias gg if you want to re-install.\n"
    exit
  fi
  
  cp ~/.bashrc ~/.bashrc-ggtemp
  cat >> ~/.bashrc-ggtemp <<EOF
alias c='source ${GG}/bashgg'
EOF
  mv -f ~/.bashrc-ggtemp ~/.bashrc

  printf "${GREEN}"
  echo '                                                 '
  echo '             _______  ______                     '
  echo '            / / / /  / / / /                     '
  echo '           / /_/ /  / /_/ /                      '
  echo '           \__, /  /\__, /                       '
  echo '          /____/   /____/   ....is now installed!'
  echo ''
  echo ''
  echo 'Please look over the ~/.bashrc file to check the alias c.'
  echo ''
  printf "${NORMAL}"
  env bash
  
}

install_zsh_c()
{
  if grep -q "^alias c=" ~/.zshrc; then
    printf "${YELLOW}You already have alias gg setting. ${NORMAL}\n"
    printf "You'll need to remove alias gg if you want to re-install.\n"
    exit
  fi
  
  cp ~/.zshrc ~/.zshrc-ggtemp
  cat >> ~/.zshrc-ggtemp <<EOF
alias c='source ${GG}/zshgg'
EOF
  mv -f ~/.zshrc-ggtemp ~/.zshrc

  printf "${GREEN}"
  echo '                                                 '
  echo '             _______  ______                     '
  echo '            / / / /  / / / /                     '
  echo '           / /_/ /  / /_/ /                      '
  echo '           \__, /  /\__, /                       '
  echo '          /____/   /____/   ....is now installed!'
  echo ''
  echo ''
  echo 'Please look over the ~/.zshrc file to check the alias c.'
  echo ''
  printf "${NORMAL}"
  env zsh
  
}

main()
{
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  # Prevent the cloned repository from having insecure permissions. Failing to do
  # so causes compinit() calls to fail with "command not found: compdef" errors
  # for users with insecure umasks (e.g., "002", allowing group writability). Note
  # that this will be ignored under Cygwin by default, as Windows ACLs take
  # precedence over umasks except for filesystems mounted with option "noacl".
  umask g-w,o-w

  if [ ! -n "$GG" ]; then
    GG=~/.gg
  fi


  printf "${BLUE}Cloning gg...${NORMAL}\n"
  hash git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
  # The Windows (MSYS) Git is not compatible with normal use on cygwin
  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo "Error: Windows/MSYS Git is not supported on Cygwin"
      echo "Error: Make sure the Cygwin git package is installed and is first on the path"
      exit 1
    fi
  fi
  
  env git clone --depth=1 https://github.com/liuhuiping2013/gg.git $GG || {
    printf "Error: git clone of gg repo failed\n"
    exit 1
  }

  # check current user shell
  if [[ "$(uname)" = "Linux" ]]; then
    MY_LOGIN_SHELL=$(getent passwd $LOGNAME | cut -d: -f7)
    MY_LOGIN_SHELL=$(basename ${MY_LOGIN_SHELL})
  else
    MY_LOGIN_SHELL="zsh"
  fi

  echo "${MY_LOGIN_SHELL}"
  
  case ${MY_LOGIN_SHELL} in
    bash ) install_bash_c
      ;;
    zsh ) install_zsh_c
      ;;
    * ) echo "${MY_LOGIN_SHELL} not supported"
      ;;
  esac
}

main
