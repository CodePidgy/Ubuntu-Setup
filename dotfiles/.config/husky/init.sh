# Ensure npx is on path
if [ -z "$NVM_DIR" ]; then
    export NVM_DIR="$HOME/.config/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi
