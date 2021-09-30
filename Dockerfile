FROM redis:buster
#Link to the github repo
ARG REPO_URL="https://github.com/nishantc7/ventroom/archive/refs/heads/main.zip" 

#Install python and some more tools
RUN apt-get update;apt-get install -y python3-dev python3-pip wget unzip ;pip3 install -U pip setuptools

#Download and Extract the repo files
RUN mkdir /app;wget --no-check-certificate -O master.zip $REPO_URL;unzip master.zip -d /app;

#Change working directory
WORKDIR /app/ventroom-main

#Install required python modules
RUN pip3 install wheel;\
    pip3 install --verbose -r requirements.txt;
        
#Do migrations
RUN python3 ventroom/manage.py makemigrations;python3 ventroom/manage.py migrate

#Create the entry script
RUN echo "redis-server --daemonize yes;python3 ventroom/manage.py runserver 0.0.0.0:8000">/usr/local/bin/docker-entrypoint2.sh;chmod +x /usr/local/bin/docker-entrypoint2.sh

CMD docker-entrypoint2.sh



