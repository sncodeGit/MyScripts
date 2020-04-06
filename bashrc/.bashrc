# Source all .bash files
. ~/.bash/.bash*

# Appearance of console user (host@user:~$)
export PS1="\[\e]0;\h@\u: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\t@\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

# <Up> and <down> upgrade to use history

