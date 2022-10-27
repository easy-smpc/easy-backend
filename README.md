# EasyBackend - lightweight backend to exchange messages
> EasyBackend is a backend meant to exchange messages between parties using http-based microservices. It was developed to exchange messages with the software [EasySMPC](https://github.com/prasser/easy-smpc/), but due to its generic nature, it can also be used for other software requiring the exchange of messages. 
>
## Prerequisites
EasySMPC requires [Java](https://adoptopenjdk.net/), at least in version 14, a PostgreSQL database, a [Spring](https://spring.io/) boot-enabled application server and a [Keycloak](https://www.keycloak.org/) installation. To compile the app from source in addition to the Java JDK the [Maven build system](https://maven.apache.org/) is required.

To facilitate the setup, a package based on docker-compose is provided (see (installation)[#installation] for details)
# Installation
TBD
## Steps in keycloak
1. Create realm "easybackend"
1. Create client "easy_client"
1. Create role "easybackend_user"
1. Create user "easysmpc.dev0@insutec.de", add password and role "easybackend_user"
