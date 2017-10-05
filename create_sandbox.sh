#/bin/bash

#------------------------------------------------------------------------
#
# Script to create a new isolated root folder for use
# with chroot.
#
# This new environment will only have the commands listed in the 
# commands variable.
#
# This assumes that these commands are either builtins or in are in
# /bin/bash. This could fail if symbolic links to libraries have
# been used. Only works with simple commands.
#
# Usage:
#    ./create_sandbox.sh foldername
#
# Then:
#   sudo chroot foldername /bin/bash#
#
# Inspired by: 
#    https://www.cyberciti.biz/faq/unix-linux-chroot-command-examples-usage-syntax/
#
#------------------------------------------------------------------------



folder="$@"
commands="bash ls cd mkdir pwd mount top ps"


# Exit if folder already exists or no folder is specified
if [[ -d "$folder" ]] ; then
    echo 'Folder already exists. Exiting.'
    exit
elif [[ "$folder" == "" ]]; then
    echo 'One arguement required. Exiting.'
    exit
fi


# Create folder structure
mkdir "$folder" "$folder"/{bin,lib,lib64,share,usr}

# Clean path to avoid things like anaconda
PATH=/user/bin:$(getconf PATH)

# Remove all aliases
unalias -a

# Loop over commands
for comm in $commands
do
    # Do nothing if a builtin command
    if [[ "$(type -t $comm)" != "builtin" ]]; then

        # Find the command (some of the commands below may not work if it is not in /bin)
        comm=$(which $comm)

        # Copy command
        cp $comm "$folder"/bin/

        # Add location of needed libraries to libs variable
        libs=$(echo $libs $(ldd $comm | awk '{x=$(NF-1); if(x!="=>") print x}'))
    fi
done


# Remove duplicates
libs=$(echo $libs | sed 's/ /\n/g' | sort | uniq)


# Loop over required libraries and copy into correct folder
for lib in $libs
do
    dir=$(dirname $lib)
    file=$(basename $lib)
    
    mkdir -p "$folder"$dir
    cp $dir/$file "$folder"$dir/

done

