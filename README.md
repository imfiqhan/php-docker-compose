# PHP Docker Compose Template
A pretty simplified docker-compose workflow that sets up a PHP Server network of containers for development and production.

## Stacks
1. Nginx
2. PHP
3. MySQL / PostgreSQL
4. Adminer (development)
5. Mailpit (development)

## Usage
To get started, make sure you have [Docker installed](https://docs.docker.com/docker-for-mac/install/) on your system, and then clone this repository. Add your PHP project to the `./src` folder, then open a terminal and from this cloned respository's root run:
1. `cp .env.example .env`
2. `docker-compose build && docker-compose up -d`. 

Open up your browser of choice to [http://localhost:8080](http://localhost:8080) and you should see your PHP app running as intended. 

Containers created and their ports are as follows:
- **SERVER** - `:8000`
- **MYSQL** - `:3600`
- **PHP** - `:9000`

You can change the ports in `.env` file