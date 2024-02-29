# export PS1='\[\e[36m\]\T\[\e[00m\]:\[\e[32m\]\u\[\e[00m\]@\[\e[32m\]\h\[\e[00m\]:\[\e[34m\]\w\[\e[00m\]\$ '

# Show current git branch name
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# export PS1="\[\033[38;5;40m\][\t]\[$(tty -s && tput sgr0)\]\[\033[38;5;12m\]\u\[$(tty -s && tput sgr0)\]\[\033[38;5;1m\]@\[$(tty -s && tput sgr0)\]\[\033[38;5;209m\]\h\[$(tty -s && tput sgr0)\]\[\033[38;5;11m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tty -s && tput sgr0)\]\[\033[38;5;13m\]\\$\[$(tty -s && tput sgr0)\] \[$(tty -s && tput sgr0)\]"
export PS1="\[\033[38;5;41m\][\[$(tty -s && tput sgr0)\]\[\033[38;5;40m\]\t\[$(tty -s && tput sgr0)\]\[\033[38;5;35m\]]\[$(tty -s && tput sgr0)\]\[\033[38;5;1m\]\h:\[$(tty -s && tput sgr0)\]\[\033[38;5;45m\]\W\[$(tty -s && tput sgr0)\]\[\033[38;5;226m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tty -s && tput sgr0)\] \[$(tty -s && tput sgr0)\]\[\033[38;5;164m\]\\$\[$(tty -s && tput sgr0)\] \[$(tty -s && tput sgr0)\]"

export VNCPORT="80"
export VNCRES="1920x1080"

alias vncstart="vncserver :$VNCPORT -geometry $VNCRES; tail -fn100 ~/.vnc/`hostname`\:$VNCPORT.log"
alias vncstop="vncserver -kill :$VNCPORT"
alias vncrestart="vncstop; vncstart"

# Firmware build aliases
alias roc='bsub_int "make -j24 clean && make -j24 roc"'
alias strix='bsub_int "make -j24 clean && make -j24 strix"'



# Useful Functions
bsub_int() {
    bsub -q superfpgibm-queue -I "kinit -k -t /pool/keytabs/ryan.kunzi.keytab ryan.kunzi@TEXMEMSYS.COM; $1"
}

bsub_intp() {
    bsub -q non-urgent-queue -Ip "kinit -k -t /pool/keytabs/ryan.kunzi.keytab ryan.kunzi@TEXMEMSYS.COM; $1"
}

bsub_xint() {
    bsub -q non-urgent-queue -XF -I "kinit -k -t /pool/keytabs/ryan.kunzi.keytab ryan.kunzi@TEXMEMSYS.COM; $1"
}

bsub_non_int() {
    bsub -o lsf_bsub.log -q non-urgent-queue "kinit -k -t /pool/keytabs/ryan.kunzi.keytab ryan.kunzi@TEXMEMSYS.COM; $1"
}

bsub_flc_test() {
    bsub -q vm-queue -Ip ./run_sim -t tb_flash_lane_cntrl_V2 -c usr/ryan.kunzi/run_sim.config $2 --simargs "+UVM_TESTNAME=$1 -define PROWLER -define VERSAL -define CARD_SIZE_LG -define NUM_OF_PAGES=1 $3" -C
}

bsub_flc_test_default() {
    bsub -q vm-queue -Ip ./run_sim -t tb_flash_lane_cntrl_V2 $2 --simargs "+UVM_TESTNAME=$1 -define PROWLER -define VERSAL -define CARD_SIZE_LG -define NUM_OF_PAGES=1 $3" -C
}

bsub_vivado() {
    bsub -q vm-queue -XF -Ip vivado
}

export SSH_AUTH_SOCK=""
alias sbc='source ~/.bashrc'
alias ls='ls --color=auto'
alias duu='du -h --max-depth=1'
alias cdflc='cd "sim/tb_flash_lane_cntrl_V2"'
alias cdreg='cd "sim/regressions"'
alias cdrf='cd "sim/regressions/flash_lane_cntrl_V2"'
alias cdsm='cd /home/fpgadev/fpgaprog/pegasus/pass1/sm/anvil'
alias gstat='git status'
alias ignoretags='git update-index --assume-unchanged tags'
alias cdp='cd /pool/ryan.kunzi/'
alias cd4='cd /pool/ryan.kunzi/fcm4/'
alias cd5='cd /pool/ryan.kunzi/fcm5e/'
alias cdub='cd /home/fpgadev/unofficial_builds/'
alias runregflc='./run_regression flash_lane_cntrl_V2 --drm lsf'
alias topsanity='./run_regression abstract_gwy_sanity --drm lsf'
alias topfull='./run_regression abstract_gwy --drm lsf'
alias vman='vmanager -server h153-11:8080'
alias simv='simvision -64bit &'
alias p_siren='sudo /home/fpgadev/unofficial_builds/fcm_mquic patch /home/jupiter/ryan.kunzi/siren_unenc.bin'
alias p_siren_enc='sudo /home/fpgadev/unofficial_builds/fcm_mquic patch /home/jupiter/ryan.kunzi/siren.bin'
alias p_harpy='sudo /home/fpgadev/unofficial_builds/fcm_mquic patch /home/jupiter/ryan.kunzi/harpy_unenc.bin'
alias p_harpy_enc='sudo /home/fpgadev/unofficial_builds/fcm_mquic patch /home/jupiter/ryan.kunzi/harpy.bin'
alias test_dt='sudo /opt/ibm/testing/bin/dt'
alias lastlogsort='lastlog | sort -k9n -k5M -k6n'
alias gpull='git pull & git submodule update'
alias gs='git status'
alias gd='git diff'
alias grepp='grep -P --recursive --line-number --binary-files=without-match'
alias fio_write="sudo fio --size=500g --name='write_500g' --rw=write --iodepth=16 --bs=16384 --ba=16384 --ioengine=libaio --filename='/dev/fcm0n1'"
alias fio_read="sudo fio --size=500g --name='reads_only' --rw=read --iodepth=16 --bs=16384 --ba=16384 --loops=100 --ioengine=libaio --filename='/dev/fcm0n1' --readonly"
