# Full-Stack Template

A project to help other developers simulate a full-stack P1 deployment on their dev machines.

## Getting Started

These instructions will get you up and running on your machine.

### Prerequisites

* docker
* docker-compose

### Usage

1. Modify the ```.env``` file to match your software 
2. Make sure you have images built with names matching ```${APP}-frontend``` and ```${APP}-backend``` (ex. ```checkmate-frontend``` and ```checkmate-backend```)
3. Run ```bin/run.sh``` or ```call bin/run.cmd``` depending on your OS
4. The frontend will be at http://localhost:8080/ and the backend will be at http://localhost:8080/${APP}-api/

## Notes
The frontend and backend will have an ```Authorization``` header that emulates Keycloaks's. This can be used for authenticating users and creating profiles.

In the *nix version, if you supply folder paths to your frontend and backend code, it will build the images for you before running. You can leave them blank if you wish to build them yourself. In Windows you will have to build them yourself before running.

## Why

I set this up in order to make it easier for new developers to understand how the software acts when deployed, as well as make it faster for teams to get into staging.

## Authors

* **Brandon Swenson**- *Initial work* - [brandon.swenson](https://code.il2.dsop.io/brandon.swenson)

## Notes
* There is a difference between Centos 7's ```sed``` and MacOS's version. This can cause issues. 
* ```run.cmd``` has limited testing, please reach out with any issues that arise.
* ```run.cmd``` does not currently support JWT generation. Looking for help with Windows scripting.