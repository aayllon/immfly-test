# Solution for the Immfly DevOps challenge 
#### Alberto Ayllon

## Run the proposal

- The proposal can be executed directly through the command: `./deployment.sh`
   - This bash script perform the following steps:
     - Download, decompress and configure the VM disk image.
     - Execute the VM using virsh.
     - Wait until the VM has a IP address assigned and retrieve it.
     - Create a Docker image to run ansible
     - Configure Ansible inventory with the VM ip
     - Create a container using docker host network to deploy the Ansible playbook on the VM.
     - Return the address of the VM instance to access the application.

## Proposal breakdown

### Web application
- Frontend
  - To execute the given html file I decided to use Nginx
  - This Nginx runs as a Docker container and all its configuration is on the
    docker/frontend directory.
  - Within the Nginx configuration there is a proxy_pass to access the backend application.
  - The web server is configured to run with different user than root.

- Backend 
  - The backend application has been created using Python Fastapi and to run it I choose uvicorn.
  - There is a configuration file where a new env variables could be added to the project. This file is `docker/backend/config/config.py`

- As frontend and backend run as docker containers I decided to use docker-compose to handle both services at the same time
  - An .env file is added beside the docker-compose configuration, this file will be read by Ansible and its variables shared with running containers.


## Thoughts
I need more time than expected to complete the challenge, sorry about that, but I have to say that I enjoyed a lot doing it.
I'm pretty sure that this solution can be improved in many ways, and one of them is adding test to the backend solution.

Please if there is something that is not right explained let me know, I'll try to do it better.

Thanks!