#!/bin/sh

if [ "$SSH_ROOT_PASSWORD" == "" ]; then
    echo "SSH_ROOT_PASSWORD is required"
    exit 1
fi

if [ ! -f /done-sshd ]; then
    echo "Setting root password to ${SSH_ROOT_PASSWORD}..."
    echo "root:${SSH_ROOT_PASSWORD}" |chpasswd
    touch /done-sshd
    echo "Creating SSH keys..."
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
    ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

    if [ "$GOOGLE_AUTHENTICATOR_ENABLE" = "true" ]; then
        cp /sshd /etc/pam.d/sshd
        echo "Creating a new key for Google Authenticator TOTP authentication..."
        echo ">>>>COPY THE LINK BELOW AND PASTE IT TO A BROWSER IN ORDER TO VIEW THE QRCODE (DON'T CLICK ON THE LINK BECAUSE IT WON'T WORK)<<<<"
        google-authenticator -t -d -f -r 5 -R 30 -w 3 -C -Q UTF8 -e 5
    fi

fi

echo "Starting sshd server..."
/usr/sbin/sshd -D -e
