# EasyBackend - lightweight backend to exchange messages
> EasyBackend is a backend meant to exchange messages between parties using http-based micro-services. It was developed to exchange messages with the software [EasySMPC](https://github.com/prasser/easy-smpc/), but due to its generic nature, it can also be used for other software requiring the exchange of messages. 
>
## Prerequisites
EasySMPC requires [Java](https://adoptopenjdk.net/), at least in version 14, a PostgreSQL database, a [Spring](https://spring.io/) boot-enabled application server and a [Keycloak](https://www.keycloak.org/) installation. To compile the app from source in addition to the Java JDK the [Maven build system](https://maven.apache.org/) is required.

To facilitate the setup of the software, a package based on docker-compose is provided (see [setup](#setup) for details)

## Build from Source

To build the executable yourself, start the development environment (see [Development](development)), clone this repository and build with
maven  (`mvn clean install org.springframework.boot:spring-boot-maven-plugin:repackage`). The assembled executable should be in the target
directory.

## Development
To develop EasyBackend, a docker-based development environment is provided. Go to the folder docker\dev and start the environment with `docker compose up -d`. A PostgreSQL instance and a Keycloak instance will be started. Afterwards you can start EasyBackend  with `mvn clean compile org.springframework.boot:spring-boot-maven-plugin:run`.
Please note that you need to start at least the PostgreSQL instance for [building](#build-from-source), since EasyBackend makes use of [jOOQ's](https://www.jooq.org/) code generation feature.

## Setup
To run easy-backend productively with the provided docker compose environment do the following:
1. Check out this repository
2. Obtain a private key as well as a certificate and save them in the files docker\prod\key.pem and docker\prod\cert.pem
3. Adapt the domain name in the file docker\prod\Caddyfile
4. Change the passwords of the Keycloak and PostgreSQL administrators set in the environment variables KEYCLOAK_PASSWORD and POSTGRES_PASSWORD in the file docker\prod\docker-compose.yml
5. Adapt the password of the PostgreSQL administrator in the file docker\prod\application.yml
6. Start the environment with `docker compose up -d` when in folder docker\prod\

## Contact

If you have questions or encounter any problems, we would like to invite you to
[open an issue on Github](https://github.com/fnwirth/easy-backend/issues/). This allows
other users to collaborate and (hopefully) answer your question in a timely
manner. If your request contains confidential information or is not suited for a
public issue, send us an email.

EasyBackend's core development team consists of:

* [Felix Nikolaus Wirth](https://github.com/fnwirth) - [felix-nikolaus.wirth@charite.de](felix-nikolaus.wirth@charite.de)

## License

This software is licensed under the Apache License 2.0. The full text is
accessible in the [LICENSE file](LICENSE).

The EasyBackend software uses the following dependencies:

 - [Spring Boot](https://spring.io/projects/spring-boot) - Apache License 2.0
 - [Keycloak](https://keycloak.org/) - Apache License 2.0
 - [Keycloak](https://keycloak.org/) - Apache License 2.0
 - [PostgreSQL](https://www.postgresql.org) - PostgreSQL License
 - [jooq](https://www.jooq.org/l) (Open source version) - Apache License 2.0
