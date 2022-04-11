npm --version
npm install
npm test
npm run build
docker build -t jennykibiri/freestyle-jenkins-node-app .
echo $PASSWORD | docker login  -u $USERNAME --password-stdin 
# docker login -u $USERNAME -p $PASSWORD bad practice
docker push jennykibiri/freestyle-jenkins-node-app
