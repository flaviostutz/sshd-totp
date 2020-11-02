# sshd-totp

SSH server for port tunneling with TOTP option

If you need to persist Google Authenticator TOTP between instance recriations, mount /root as a volume

## Usage

* Create docker-compose.yml

```yml
version: '3.7'
services:
  sshd-totp:
    build: .
    image: flaviostutz/sshd-totp
    environment:
      - SSH_ROOT_PASSWORD=admin123
      - GOOGLE_AUTHENTICATOR_ENABLE=true
    ports:
      - "2222:2222"
```

* docker-compose up -d

* Get a URL from console output and place into browser to see the TOTP QRCode

* Open Google Authenticator on your mobile and read the QRCode

* Connect with `ssh -p 2222 root@localhost`

* Type password admin123 and the current TOTP on Google Authenticator

