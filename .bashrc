#-----------------------------------------------------------------------------
# .bashrc
#-----------------------------------------------------------------------------

# If not running interactively, don't do anything
#
[ -z "$PS1" ] && return

export PS1="\u@\h \w\$ "

stty -ixon -ixoff
umask 0022

export DIFF=diff
export EDITOR=vim
export c=/cygdrive/c/         # For Cygwin. Use $c to refer to /cygdrive/c etc.
export d=/cygdrive/d/
export e=/cygdrive/e/
export z=/cygdrive/z/
unset MAILCHECK       # No mail notifications.
unset SSH_ASKPASS     # For git on RHEL/Centos

alias -- -='cd -'
alias '~'='cd ~'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias ..5='cd ../../../../../'

alias ag='ag -t -i'                         # Ag, the ack replacement.
alias apt-get='sudo apt-get'
alias aptitude='sudo aptitude'
alias bc='bc -l'         # Math support. This does break the modulo op though!
alias cls=clear
alias cp='cp -v'
alias curl='curl -C -'                      # Resume whenever possible
alias eg='env | grep -iE --color=auto'      # grep in environment
alias grep='grep -EI'                       # Extended regex, Skip binary files
alias hg='history | grep -Ei --color=auto'  # grep in history
alias k9='kill -9'
alias less='less -IrFX'   # No clear screen, quit if one screen, case insens.
alias l='\ls -lFGh'
alias ll='\ls -alFGh'
alias ls='echo "                                  USE l" >&2'
alias mc='mc -b'                            # Monochrome mode.
alias mkdir='mkdir -p'                      # Create parent directories.
alias more='less'
alias parallel='parallel --no-notice'       # Silence annoying notice.
alias ps='echo "                                  USE pg" >&2'
alias py='ping www.yahoo.com'
alias tf='tail -f'
alias tf0='tail -f -n 0'                    # 'tail -f' without preceding context.
alias tcpdump='sudo tcpdump'
alias v=vim
alias vb='vim ~/.bashrc && source ~/.bashrc'
alias vi=vim
alias vv='vim ~/.vimrc'
alias wget='wget -c'                        # Resume whenever possible.
alias yum='sudo yum'

[[ $(uname) = "Darwin" ]] && alias v='subl' ; # Prefer sublime text on OS X.


alias gcd='cd $(git rev-parse --show-toplevel)' # Go to the root of git tree.
alias gcl='git clone'
alias t='tig'
alias ts='tig status'
alias tib='tig blame'


shopt -s dotglob      # Make the '*' wildcard include dot files.
shopt -s extglob      # Enable extended globbing.
shopt -s nocaseglob   # Glob pattern matching is case-insensitive.
#shopt -s nullglob     # '*' in empty directories does not expand to '*'
shopt -s histappend   # Avoid losing history when running concurrent sessions.
shopt -s histverify   # Verify recalled commands before execution.
[[ $BASH_VERSION > 4.0 ]] && shopt -s checkjobs # Check for stopped jobs on exit.
[[ $BASH_VERSION > 4.0 ]] && shopt -s autocd    # Change directory withoutusing 'cd'.
[[ $BASH_VERSION > 4.0 ]] && shopt -s globstar  # Recursive globbing e.g. **/myfile.
[[ $BASH_VERSION > 4.2 ]] && shopt -s direxpand # Expansion of variable names.

export HISTSIZE=25000
export HISTFILESIZE=25000
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export HISTCONTROL=$HISTCONTROL:ignorespace


function prefixDirToPath() {
  tempdir=`eval echo "$1"`    # Force ~ expansion if ~ is passed in quotes
  [[ -d "$tempdir" ]] && export PATH="$tempdir":${PATH} ;   # Skip dup check.
}

function appendDirToPath() {
  tempdir=`eval echo "$1"`    # Force ~ expansion if ~ is passed in quotes
  [[ -d "$tempdir" ]] &&
    [[ ! ":$PATH:" == *":$tempdir:"* ]] &&
    export PATH=${PATH}:"$tempdir" ;
}

prefixDirToPath /opt/bin
prefixDirToPath /opt/local/bin
prefixDirToPath /opt/local/sbin
prefixDirToPath /usr/local/bin   # Find local versions in path first.
prefixDirToPath ~/usr/bin
prefixDirToPath ~/usr/local/bin                       # Prefix this last!

appendDirToPath /sbin
appendDirToPath /usr/sbin
appendDirToPath ~/usr/share/maven/bin

[ $(uname) = "Linux" ] && appendDirToPath ~/usr/local/intellij-idea/bin

[[ -d /usr/share/ant ]] && export ANT_HOME=/usr/share/ant
[[ -d ~/usr/share/ant ]] && export ANT_HOME=~/usr/share/ant
[[ -d /usr/share/maven ]] && export MAVEN_HOME=/usr/share/maven
[[ -d ~/usr/share/maven ]] && export MAVEN_HOME=~/usr/share/maven
export MAVEN_OPTS="-Xms256m -Xmx512m -Djava.awt.headless=true"

[[ -d ~/usr/share/findbugs-3.0.0 ]] && export FINDBUGS_HOME=~/usr/share/findbugs-3.0.0
[[ -d ~/usr/share/apache-forrest ]] && export FORREST_HOME=~/usr/share/apache-forrest
appendDirToPath "$ANT_HOME/bin"
appendDirToPath "$MAVEN_HOME/bin"

if [[ -n "$JAVA_HOME" && -z $OLD_JAVA_HOME ]]
then
  export OLD_JAVA_HOME=$JAVA_HOME
fi

# A few settings for OS X.
#
if [[ $(uname) = "Darwin" ]]
then
  export JAVA_HOME=$(/usr/libexec/java_home)

  # Maven SureFire ForkedBooter ignores MAVEN_OPTS. This changes the
  # option system-wide which may not be a good thing.
  #
  export _JAVA_OPTIONS=-Djava.awt.headless=true

  export COPYFILE_DISABLE=true
  export COPY_EXTENDED_ATTRIBUTES_DISABLE=true

  prefixDirToPath ~/Developer/homebrew/bin

  alias idea='open /Applications/IntelliJ\ IDEA\ 13.app/'

elif [[ -f /etc/redhat-release ]]
then
  export JAVA_HOME=/usr/lib/jvm/java-openjdk/
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/usr/local/lib

  alias idea='nohup idea.sh > ~/tmp/nohup.out &'
else
  export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
fi

function ff() {
  for i in "$@";
  do
    find $PWD -type f -iname "$i";
  done;
}

function tibff() {
  tig blame $(ff1 "$@");
}

function ffcd() {
  cd $(dirname $(find $PWD -type f -iname $1 | head -1))
}

function ffd() {
  if [[ "$2" = "" ]]
  then
    find . -type d -iname "$1" | nl | sort | \less -XF
  else
    local target=$(find . -type d -iname "$1" | sed -n "${2}p");
    if [ -n "$target" ]
    then
      echo "Change directory to ${2}th match"
      cd "$target";
    else
      echo "No match";
    fi
  fi
}

function ff1() {
  find $PWD -type f -iname "$1" -print -quit;
}

function ff1withdir() {
  find $1 -type f -iname "$2" -print -quit;
}

function vff()    { 
  [[ "$1" = "" ]] && return 1 ;
  vim $(ff "$@") ;
}

function rmff()   { ff "$@" | xargs rm -vf ; }
function tigff()  { tig $(ff "$@") ; }

function vff1() { vim $(ff1 "$@") ; }

# A replacement for the useless pgrep.
#
function pg() {
  [ -z "$1" ] && sudo ps aux && return ;
  sudo ps aux | grep -iE --color=auto "$@" ;
}

function ng() {
  if [[ $(uname) = "Darwin" ]]
  then
    [ -z "$1" ] && lsof -i -P && return ;
    sudo lsof -i -P | grep -iE --color=auto "$@";
  else
    [ -z "$1" ] && \netstat -an && return ;
    \netstat -an | grep -iE --color=auto "$@";
  fi
}

function ffdiff() {
  diff $(ff1withdir "$1" "$3") $(ff1withdir "$2" "$3") ;
}

function ffdiffsummary() {
  if ! diff -bBq $(ff1withdir "$1" "$3") $(ff1withdir "$2" "$3") > /dev/null
  then
    echo "$3 differs" ;
  fi
}

function ffcp() {
  if [[ -z "$3" && -d "$2" ]]
  then
    cp -iv $(ff1 "$1") "$2"
  elif [[ -n "$3" && -d "$2" && -d "$3" ]]
  then 
    cp -iv $(ff1withdir "$2" "$1") $(ff1withdir "$3" "$1") ;
  else
    echo "Usage: ffcp <file-name> <Source-parent-dir> <Target-parent-dir>"
    echo "   OR: ffcp <file-name> <Target-dir>"
  fi
}

function cleantmp() { rm -fr /tmp/* 2>/dev/null ; }

function fcd() { cd $(find . -type d -iname "$1" | head -1) ; }

function lw() { ll $(which $1); }

function vw() { vim $(which $1) ; }

