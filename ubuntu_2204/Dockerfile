FROM ubuntu:22.04

# Install supervisor
RUN apt-get update && apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install SSH server
RUN apt-get update && apt-get install -y openssh-server \
    && mkdir /var/run/sshd
    # && echo 'root:root' | chpasswd \
    # && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22

# Install Docker
RUN apt-get update && apt-get install -y ca-certificates curl \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc \
    && echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install Git
RUN apt-get update && apt-get install -y git

# Add user dev
RUN apt-get update && apt-get install -y sudo \
    && useradd -s /bin/bash dev \
    && echo "dev:dev" | chpasswd \
    && adduser dev sudo \
    && echo 'dev ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && usermod -aG docker dev

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
