# EasyBackend - lightweight backend to exchange messages
> EasyBackend is a backend meant to exchange messages between parties using http-based microservices. It was developed to exchange messages with the software [EasySMPC](https://github.com/prasser/easy-smpc/), but due to its generic nature, it can also be used for other software requiring the exchange of messages. 
>
## Prerequisites
EasySMPC requires [Java](https://adoptopenjdk.net/), at least in version 14, a PostgreSQL database, a [Spring](https://spring.io/) boot-enabled application server and a [Keycloak](https://www.keycloak.org/) installation. To compile the app from source in addition to the Java JDK the [Maven build system](https://maven.apache.org/) is required.

To facilitate the setup, a package based on docker-compose is provided (see (installation)[#installation] for details)

## Build from Source

To build the executable yourself, please clone this repository and build with
maven  (`mvn clean install org.springframework.boot:spring-boot-maven-plugin:repackage`). The assembled executable should be in the target
directory. 

## Installation
TBD

## Contact

If you have questions or encounter any problems, we would like to invite you to
[open an issue on Github](https://github.com/fnwirth/easy-backend/issues/). This allows
other users to collaborate and (hopefully) answer your question in a timely
manner. If your request contains confidential information or is not suited for a
public issue, send us an email.

EasySMPC's core development team consists of:

* [Fabian Prasser](https://github.com/prasser) - [fabian.prasser@charite.de](fabian.prasser@charite.de)
* [Felix Nikolaus Wirth](https://github.com/fnwirth) - [felix-nikolaus.wirth@charite.de](felix-nikolaus.wirth@charite.de)

## License

This software is licensed under the Apache License 2.0. The full text is
accessible in the [LICENSE file](LICENSE).
