# PHP Docker Compose Template
A pretty simplified docker-compose workflow that sets up a PHP Server network of containers for development and production.

## Stacks
1. Nginx / Apache
2. PHP
3. MySQL / PostgreSQL
4. Adminer
5. Filebrowser
6. Mailpit (development)

## Usage
To get started, make sure you have [Docker installed](https://docs.docker.com/docker-for-mac/install/) on your system, and then clone this repository. Add your PHP project to the `./src` folder, then open a terminal and from this cloned respository's root run:
1. `cp .env.example .env`
2. `docker-compose build && docker-compose up -d`. 

Open up your browser of choice to [http://localhost:8080](http://localhost:8080) and you should see your PHP app running as intended. 

Containers created and their ports are as follows:
- **WEB SERVER** - `:8000`
- **MYSQL** - `:3600`
- **POSTGRESQL** - `:5400`
- **Adminer** - `:8100`
- **Filebrowser** - `:8200`
- **Mailpit UI** - `:8300`

You can change the ports in `.env` file