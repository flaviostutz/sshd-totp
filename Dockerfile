FROM alpine:3.12.1

RUN apk add openssh openssh-server-pam bash google-authenticator

ENV SSH_ROOT_PASSWORD ''
ENV GOOGLE_AUTHENTICATOR_ENABLE false

ADD startup.sh /
ADD sshd_config /etc/ssh/
ADD /sshd /

ENTRYPOINT [ "/startup.sh" ]
