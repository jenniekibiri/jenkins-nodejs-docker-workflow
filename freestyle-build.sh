npm --version
npm install
npm test
npm run build
docker build -t jennykibiri/freestyle-jenkins-node-app .
docker login -u $USERNAME -p $password
docker push jennykibiri/freestyle-jenkins-node-app
