#!/bin/bash
source ./nodejs-setup.sh

npm install -g typescript
npm install -g webpack
npm install -g ts-loader # links webpack to complie typescript
npm install -g jquery  # to use jquery in your project
npm install -g http-server # to have a local server run

npm install -g grunt-cli #This will put the grunt command in your system path, allowing it to be run from any directory.
