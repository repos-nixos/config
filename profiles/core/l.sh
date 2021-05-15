# Call less, smartly: if no argument is given and nothing is being piped in, list the current directory.

if [ $# -lt 1 -a -t 0 ]
then
    exec less .
else
    exec less "$@"
fi
