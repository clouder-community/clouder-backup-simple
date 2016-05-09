FROM clouder/clouder-base
MAINTAINER Yannick Buron yburon@goclouder.net

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y -q install python2.7-dev python-fuse python-pyxattr python-pylibacl python-tornado linux-libc-dev acl attr par2 git make cron ncftp supervisor


RUN mkdir  /home/backup
RUN chown -R backup:backup /home/backup
RUN usermod -d /home/backup -s /bin/bash backup
RUN mkdir /opt/backup
RUN chown -R backup:backup /opt/backup
RUN chmod -R 700 /opt/backup

USER backup
RUN mkdir  /home/backup/.ssh
RUN mkdir  /home/backup/.ssh/keys
RUN ln -s /opt/keys/authorized_keys /home/backup/.ssh/authorized_keys
RUN chmod -R 700 /home/backup/.ssh
RUN touch /home/backup/.hushlogin
RUN mkdir /opt/backup/simple

USER root

RUN echo "" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "[program:cron]" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "command=cron -f" >> /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
