FROM ubuntu
MAINTAINER s.chabrolles@fr.ibm.com

ENV GOOS=linux

RUN /usr/sbin/adduser --system --home=/opt/odoo --group odoo

RUN apt-get update

RUN apt-get install -y python-dateutil python-decorator python-docutils python-feedparser \
python-gdata python-gevent python-imaging python-jinja2 python-ldap python-libxslt1 python-lxml \
python-mako python-mock python-openid python-passlib python-psutil python-psycopg2 python-pybabel \
python-pychart python-pydot python-pyparsing python-pypdf python-reportlab python-requests \
python-simplejson python-tz python-unittest2 python-vatnumber python-vobject python-werkzeug \
python-xlwt python-yaml wkhtmltopdf git

RUN apt-get install -y postgresql-client

USER odoo 
RUN git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0 --single-branch /opt/odoo 

#USER root
#/bin/bash su - odoo -s git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0 --single-branch .

USER root

#cp /opt/odoo/debian/openerp-server.conf /etc/odoo-server.conf
#chown odoo: /etc/odoo-server.conf
#chmod 640 /etc/odoo-server.conf
ADD ./odoo-server.conf /etc/odoo-server.conf
ADD ./start_all.sh /start_all.sh
ADD ./change.sql /change.sql
RUN chown odoo: /etc/odoo-server.conf &&\
 chmod 640 /etc/odoo-server.conf &&\
 chmod a+x /start_all.sh

# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

# Expose the Odoo port
EXPOSE 8069

# Set the default command to run when starting the container
CMD ["/bin/bash","/start_all.sh"]
