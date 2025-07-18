function cdSpecial()
{
    if [ -n "$1" ]
    then
        \cd "$1" && clear && ls -ilaths;
    else
        \cd /home/${USER}/ && clear && ls -ilaths;
    fi
}
