FROM ubuntu:18.04

## Varaabili d'ambiente
ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWD="ursim123"

## Porta VNC
EXPOSE 5900
EXPOSE 5901
EXPOSE 5902

## Update - Upgrade - Installa strumenti di bases
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget tar psmisc software-properties-common sudo

## Creazione e attivazione dell'utente
# Creazione dell'utente ursimuser e configurazione sudo senza password
RUN useradd -ms /bin/bash ursimuser && echo "ursimuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ursimuser

## Working directory
RUN mkdir -p /home/ursimuser/ursim_install
RUN mkdir /home/ursimuser/Desktop
WORKDIR /home/ursimuser/ursim_install

## Installa le dipendenze necessarie per il display e VNC

# Setta il fuso orario
RUN sudo ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime 
RUN sudo apt-get install -y xvfb xterm tigervnc-standalone-server tigervnc-common fluxbox

# Configura la password per VNC
RUN mkdir -p ~/.vnc
RUN echo "$VNC_PASSWD" | sudo vncpasswd -f >  ~/.vnc/passwd && chmod 600 ~/.vnc/passwd


## Installa la corretta versione di Java
RUN sudo add-apt-repository ppa:openjdk-r/ppa -y
RUN sudo apt-get update
RUN sudo apt-get install openjdk-8-jdk -y

## Installa le librerie Java 3D necessarie per URSim
RUN sudo apt-get install -y libjava3d-java libjava3d-jni


# Scarica e installa URSim
# RUN wget "$URSIM_URL" -O /home/ursimuser/ursim_install/URSim_Linux-5.22.tar.gz
COPY URSim_Linux-5.22.tar.gz /home/ursimuser/ursim_install/URSim_Linux-5.22.tar.gz
RUN tar xvzf URSim_Linux-5.22.tar.gz --strip-components=2
# Simula un terminale per l'installazione di URSim (visto che l'installazione richiede un terminale)
RUN xvfb-run --server-args="-screen 0 1280x900x24" \
    script -q -c "bash ./install.sh"


COPY start-vnc.sh /home/ursimuser/ursim_install/start-vnc.sh
RUN sudo chmod +x /home/ursimuser/ursim_install/start-vnc.sh
COPY Pally-3.4.1.urcap /home/ursimuser/ursim_install/programs.UR20/Pally-3.4.1.urcap


ENTRYPOINT ["/home/ursimuser/ursim_install/start-vnc.sh", "UR20"]