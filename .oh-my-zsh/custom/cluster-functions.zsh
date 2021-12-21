# cluster management functions

# list what other nodes are in the cluster
function cluster-ls {
  grep "node0" /etc/hosts | awk '{print $2}' | grep -v $(hostname)
}

# execute a command on all nodes in the cluster
function cluster-cmd {
  for node in $(cluster-ls);
  do
    echo $node;
    ssh $node "$@";
  done
  cat /etc/hostname; $@
}

# reboot all nodes in the cluster
function cluster-reboot {
  cluster-cmd sudo reboot now
}

# shutdown all nodes in the cluster
function cluster-shutdown {
  cluster-cmd sudo shutdown now
}

function cluster-scp {
  for node in $(cluster-ls);
  do
    echo "${node} copying...";
    cat $1 | ssh $node "sudo tee $1" > /dev/null 2>&1;
  done
  echo 'all files copied successfully'
}

# start yarn and dfs on cluster
function cluster-start-hadoop {
  start-dfs.sh; start-yarn.sh
}

# stop yarn and dfs on cluster
function cluster-stop-hadoop {
  stop-dfs.sh; stop-yarn.sh
}

