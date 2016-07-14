docker build -t demo/docker-node-app .
docker run -p 8080:8080 -d demo/docker-node-app
docker run -d -p 4444:4444 selenium/standalone-chrome:2.53.0
nightwatch