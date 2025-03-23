if [ -f ~/.sh_detectshell ]; then
    . ~/.sh_detectshell
fi

tshell=$(detectshell)

if [ "$tshell" == "Bash" ]; then
    echo "This is Bash!"
elif [ "$tshell" == "Zsh" ]; then
    echo "This is Zsh!"
else
    exit 1
fi
