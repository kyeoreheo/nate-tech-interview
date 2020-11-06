# nate.challenge.ios

# Brief
Show us you can create a small native iOS app, from scratch, that uses a provided API.
We'd love for you to present, and explain to us, your finished app =]

## Specification

### Core Deliverables
- Build an iOS app that displays products, and a detail view of each product
- You can use either the GraphQL API or REST API we provide
- You can use any UIKit or SwiftUI components you like
- Third party libraries are allowed, but should be used purposefully
- Keep in mind UX, Performance, and Readability of code and project structure etc.
- One meaningful Unit Test

### Bonus Deliverables
- Ability to add / update / remove products via API, feel free to get creative here!
- Implement seamless pagination with the endpoints provided
- Add some style / design / animations, completely optional but don't feel limited
- More Unit / Automation Test(s)

### Submission Format
Create a git repository on GitHub/BitBucket/GitLab with your project including README file.

## References

### APIs
Graph and Rest Examples are in `Insomnia.json` file
1. Download Insomnia Core at https://insomnia.rest
2. Import into Insomnia Core Workspace https://support.insomnia.rest/article/52-importing-and-exporting-data

##### Access
- GraphQL: http://localhost:4000/graphql
- REST: http://localhost:3000

### API Setup using Docker
To run the APIs locally (REST, GraphQL, and the DB Service) - install Docker and Docker Compose
1. Follow the Docker Compose install guide (including the Docker install Pre-Eq) https://docs.docker.com/compose/install/
2. In the root directory of this project, run command `sudo docker-compose up` to pull and run the prepared Docker images
3. Once the containers are running the APIs will be available

##### Note
Any modifications to the product data will not be persisted if the container is shutdown.
- If you need to reset the DB data when the containers are running 
  - run command `yarn reset`
- If for any reason you'd like to reset both the APIs and DB Service
  - run command `sudo docker-compose rm` to remove all containers and `sudo docker-compose up` again

### Additional Documentation
- Prisma: https://www.prisma.io/docs/reference/tools-and-interfaces/prisma-client/crud
- Nexus: https://nexusjs.org/adoption-guides/prisma-users
- Rest: https://github.com/prisma/prisma-examples/tree/master/typescript/rest-express
- The repository also contains code for building the Docker Images from scratch and running the services locally 
