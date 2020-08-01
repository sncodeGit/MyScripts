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

# Opstkhelp
alias server-start='opstkhelp-manage-server -w start'
alias server-stop='opstkhelp-manage-server -w stop'
alias server-info='for server in `opstkhelp-get-info st-p-3`; do echo "${server} : $(opstkhelp-get-info -s ${server} st-p-3 | grep status= | cut -d '=' -f 2)"; done'

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

# Kubernetes
alias k='kubectl'
