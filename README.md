# Vue.js frontend application with RoR backend

This is a test application for learning VueJs.

## Installation

Use [docker](https://www.docker.com) to run application locally.

```bash
docker-compose build
docker-compose run backend rake db:setup
```

## Usage

```bash
docker-compose up
```

Access frontend on http://localhost:8080 and log as the sample user 'admin' with password 'password.'


## Tests

```bash
docker-compose run backend rspec
```

## Known bugs

- User controller test is unstable. It's not passing everytime.
>>>>>>> Stashed changes
