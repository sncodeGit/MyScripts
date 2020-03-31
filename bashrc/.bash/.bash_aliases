# some personal aliases

# Permanent service goto
# Main goto
alias goto='~/MyScripts/goto.sh'
alias gotoroot='ssh -l root '
# Other goto

# Own scripts
alias getcl='~/MyScripts/getcl.sh'
alias replace-ssh-key="~/MyScripts/replace-ssh-key.sh"
alias replace-ssh-key-ppk="~/MyScripts/replace-ssh-key-ppk.sh"
alias replace-ssh-key-roll-back="~/MyScripts/replace-ssh-key-roll-back.sh"

# Utils modification
alias wget='wget -O /dev/null'
alias docker='sudo docker'

# Repeat actions
alias bash-reload='cd ~; source .bashrc'
alias bash-nano='nano ~/.bashrc'
alias push='git add -A; git commit -m "Intermediate stage of development"; git push origin'

# cd
alias t='cd ~/tmp; ls'
alias ~='cd ~'
alias b='cd ~/.bash; la'
alias D='cd ~/Downloads; la'
alias MS='cd ~/MyScripts; la'
