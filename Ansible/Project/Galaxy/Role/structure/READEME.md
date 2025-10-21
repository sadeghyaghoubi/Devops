for example:
for download docker on ansible-galaxy , you have to search docker in site and check must download count :
ansible-galaxy role install geerlingguy.docker

if you enter command , you download just role in the /root/.ansible/roles/
and you have to create directory playbooks and crete directory roles in playbooks
and you have to mv your file downloaded to hear
and create file  inventory.ini and playbooks file  



#cd sadegh-ansible/ansible-docker
#tree:

├── inventory.ini
└── playbooks
    ├── docker.yml
    └── roles
        └── geerlingguy.docker
            ├── defaults
            │   └── main.yml
            ├── handlers
            │   └── main.yml
            ├── LICENSE
            ├── meta
            │   └── main.yml
            ├── molecule
            │   └── default
            │       ├── converge.yml
            │       ├── molecule.yml
            │       └── verify.yml
            ├── README.md
            ├── tasks
            │   ├── docker-compose.yml
            │   ├── docker-users.yml
            │   ├── main.yml
            │   ├── setup-Debian.yml
            │   ├── setup-RedHat.yml
            │   └── setup-Suse.yml
            └── vars
                ├── Alpine.yml
                ├── Archlinux.yml
                ├── Debian.yml
                ├── main.yml
                ├── RedHat.yml
                └── Suse.yml
