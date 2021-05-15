# Call xdg-open, smartly: if no argument is given, open the current directory.

if [ $# -lt 1 ]
then
    exec xdg-open .
else
    exec xdg-open "$@"
fi
