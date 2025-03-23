# ~/sh_detectshell.sh

detectshell() {
    case $SHELL in
        */bash)
            echo "Bash"
            ;;
        */zsh)
            echo "Zsh"
            ;;
        *)
            echo "Unsupported"
            ;;
    esac
}
