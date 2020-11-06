#!/bin/bash

# prisma schema migration and data seeding
# yarn -s prisma migrate save --experimental
yarn -s prisma migrate up --experimental
yarn -s prisma generate
yarn seed
