#! /bin/bash
# Usage: deploy.sh <repo url> <tree-ish> <location>

download(){
    # download <repo url> <tree-ish> <download folder>
    mkdir -p $3
    git archive --remote=$1 $2 $3 | tar -xvf -
}

stop_service(){
    # stop_service <location> <backup location>
    local location=$1
    local backup_location=$2
    local cwd=$(pwd)
    if [ -f $location ]; then
        cd $location
        if [ -f "${location}/stop.sh" ]; then
            /bin/bash "${location}/stop.sh"
        fi
        cd $cwd
        mv $location $backup_location
    fi
}

start_service(){
    # start_service <location> <src location>
    local location=$1
    local src_location=$2
    local cwd=$(pwd)
    mkdir -p $location
    cp 
    cd $location
    if [ -f "${location}/start.sh" ]; then
        /bin/bash "${location}/start.sh"
    fi
    cd $cwd
}

exit_with_msg(){
    echo $1 && exit 1
}

repo_url=$1
commit_sha=$2
location=$3
timestamp=$(date "+%Y%m%d%H%M%S")
tmp_download_location="/tmp/${location}/${timestamp}"
backup_location="~/backup/${location}/${timestamp}"

download $repo_url $commit_sha $tmp_download_location || exit_with_msg "Download failed"
stop_service $location $backup_location || exit_with_msg "Stop service failed"
start_service $location $tmp_download_location || exit_with_msg "Start service failed"
