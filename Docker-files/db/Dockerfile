FROM mysql:8.0.33
LABEL key="project"="Vprofile"
LABEL key="author"="luniemma"

ENV MYSQL_ROOT_PASSWORD="vprofiledbpass"
ENV MYSQL_DATABASE="accounts"

ADD db_backup.sql docker-entrypiont-initdb.d/b_backup.sql