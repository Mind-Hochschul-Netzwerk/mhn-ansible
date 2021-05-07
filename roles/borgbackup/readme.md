# Borgbackup Role

This role will install and configure [borgbackup](https://borgbackup.readthedocs.io/en/stable/) and [borgmatic](https://torsion.org/borgmatic/).

## Databases

MySQL/Mariadb and Postgres Databases in Docker containers will be dumped before each backup. See: [dump-databases](./templates/dump-databases.j2)
