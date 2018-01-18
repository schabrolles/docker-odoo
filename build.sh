docker pull schabrolles/ubuntu_ppc64le:16.04
docker tag schabrolles/ubuntu_ppc64le:16.04 ubuntu
docker build -t schabrolles/odoo_ppc64le .
