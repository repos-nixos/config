# Call sudo, smartly: if no argument is given, run a shell

if [ $# -lt 1 ]
then
    exec sudo -s
else
    exec sudo "$@"
fi
