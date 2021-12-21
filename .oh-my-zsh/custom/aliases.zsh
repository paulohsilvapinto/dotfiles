#===================================
# Navigation
#===================================

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"


#===================================
# List
#===================================

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, excluding . and ..
alias la="ls -lAF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"


#===================================
# Sys Admin
#===================================

# Enable aliases to be sudo’ed
alias sudo='sudo '

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Reload shell
alias reload='source ~/.zshrc'


#===================================
# Kafka aliases
#===================================

# Services aliases
alias start-zookeeper="nohup zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties >/dev/null 2>&1 &;"
alias start-kafka="nohup kafka-server-start.sh $KAFKA_HOME/config/server.properties >/dev/null 2>&1 &; nohup kafka-server-start.sh $KAFKA_HOME/config/server-2.properties >/dev/null 2>&1 &;"
alias stop-kafka="kafka-server-stop.sh; zookeeper-server-stop.sh;"

#Kafka Console Producer
alias kcp='kafka-console-producer.sh --broker-list localhost:9092 --topic'
#Kafka Console Consumer
alias kcc='kafka-console-consumer.sh --bootstrap-server localhost:9092 --from-beginning --topic'
#Kakfa Topics
alias ktc='kafka-topics.sh --create --replication-factor 1 --partitions 2  --zookeeper localhost:2181 --topic'
alias ktd='kafka-topics.sh --delete --zookeeper localhost:2181 --topic'
alias ktl='kafka-topics.sh --list --zookeeper localhost:2181'
#Kafka Consumer Groups
alias kcgl='kafka-consumer-groups.sh --bootstrap-server localhost:9092 --list'
alias kcgd='kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group'


#==================================
# YARN
#==================================

# Application
alias yak='yarn application --kill' # + Application ID
alias yal='yarn application --list -appStates all'
alias yalr='yarn application --list'

# Logs
alias yl='yarn logs -applicationId' # + Application ID


#==================================
# Python
#= =================================

# Virtual Environment

alias va='. ./venv/bin/activate'
alias vc='pyenv exec python -m venv venv; va;'
alias pypkg='pip install -t dependencies-pkg -r requirements.txt; zip -r dependencies-pkg.zip ./dependencies-pkg;rm -rf dependencies-pkg;'


#==================================
# HADOOP
#==================================
# HDFS
alias hls='hdfs dfs -ls'
alias hrm='hdfs dfs -rm'
alias hcat='hdfs dfs -cat'
