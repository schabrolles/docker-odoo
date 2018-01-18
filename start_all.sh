#/bin/bash

test $ADMIN_PASSWD && sed -i -e "s/admin_passwd =.*/admin_passwd = $ADMIN_PASSWD/" /etc/odoo-server.conf
test $DB_HOST && sed -i -e "s/db_host =.*/db_host = $DB_HOST/" /etc/odoo-server.conf
test $DB_PORT && sed -i -e "s/db_port =.*/db_port = $DB_PORT/" /etc/odoo-server.conf
if test $DB_USER ; then
  sed -i -e "s/db_user =.*/db_user = $DB_USER/" /etc/odoo-server.conf
  sed -i -e "s/DB_USER/$DB_USER/" /change.sql
fi

if test $DB_PASSWORD ; then 
  sed -i -e "s/db_password =.*/db_password = $DB_PASSWORD/" /etc/odoo-server.conf
  sed -i -e "s/DB_PASSWORD/$DB_PASSWORD/" /change.sql
fi

export PGPASSWORD=$PGPASSWORD

psql -U postgres -h $DB_HOST -f /change.sql  

#/etc/init.d/postgresql start
su - odoo -s /opt/odoo/openerp-server -c /etc/odoo-server.conf
