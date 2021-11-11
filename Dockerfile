FROM kalilinux/kali-rolling

LABEL maintainer "karim@pininvest.com"

SHELL ["/bin/bash", "-c"]

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive


#### PACKAGES# configure apt and install packages
RUN apt update && apt -y full-upgrade                                                                                       \
    && apt install -y --no-install-recommends apt-utils dialog 2>&1                                                         \
    && apt install -y unzip                                                                                                 \
    && apt install -y bash-completion iproute2  iputils-ping   netdiscover                                                  \
    && apt install -y build-essential  wget sudo unzip wget vim procps lsb-release                                          \
    && apt install -y libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxi6 libxtst6   libssl-dev                  \    
    # nethunter meta package > 700MB   
    && apt install -y kali-linux-core  exploitdb                                                           


#### PACKAGES# configure apt and install packages
RUN apt update && apt upgrade -y \
    # apt
    && apt install -y p7zip-full  nano    wordlists                                                                         \
    && apt install -y gobuster dirbuster sslscan nikto  wireshark                                                           \
    && apt install -y enum4linux  iputils-tracepath dnsutils net-tools

                                                                                          
# metasploit   
RUN  apt install -y metasploit-framework    


# install locate & Update a mlocate database.
RUN  apt install -y locate   && \
    updatedb



#### USER SETUP
ARG USERNAME=kali
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN : \
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support for the non-root user
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME


# Switch back to dialog for any ad-hoc use of apt
ENV DEBIAN_FRONTEND=dialog

# [Optional] Set the default user. Omit if you want to keep the default as root.

# USER $USERNAME

COPY ./bashrc /root/.bashrc

