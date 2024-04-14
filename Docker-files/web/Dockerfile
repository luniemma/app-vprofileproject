FROM tomcat:8-jre11
LABEL key="project"="Vprofile"
LABEL key="author"="luniemma"

RUN rm -rf /etc/nginx/conf.d/default.conf
COPY nginvproapp.conf /etc/nginx/conf.d/vproapp.conf