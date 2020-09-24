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

## Why

I set this up in order to make it easier for new developers to understand how the software acts when deployed, as well as make it faster for teams to get into staging.

## Authors

* **Brandon Swenson**- *Initial work* - [brandon.swenson](https://code.il2.dsop.io/brandon.swenson)

## Notes
* ```run.cmd``` has limited testing, please reach out with any issues that arise.