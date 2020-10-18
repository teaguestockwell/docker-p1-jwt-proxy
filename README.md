# Full-Stack Template

A project to help other developers simulate a full-stack P1 deployment on their dev machines.

## Getting Started

These instructions will get you up and running on your machine.

### Prerequisites

* docker
* docker-compose
* pre-built frontend and backend docker containers

### Usage

1. Modify the ```.env``` file to match your software 
2. Make sure you have images built with names matching ```${APP}-frontend``` and ```${APP}-backend``` (ex. ```checkmate-frontend``` and ```checkmate-backend```)
3. Run ```run.sh``` or ```run.cmd``` depending on your OS
4. The frontend will be at http://localhost:8080/ and the backend will be at http://localhost:8080/${APP}-api/
5. The frontend and backend will have an ```Authorization``` header that emulates Keycloaks's. This can be used for authenticating users and creating profiles.

## Why

I set this up in order to make it easier for new developers to understand how the software acts when deployed, as well as make it faster for teams to get into staging.

## Authors

* **Brandon Swenson**- *Initial work* - [brandon.swenson](https://code.il2.dsop.io/brandon.swenson)

## Notes
* ```run.cmd``` has limited testing, please reach out with any issues that arise.
* ```run.cmd``` does not currently support JWT generation. Looking for help with Windows scripting.