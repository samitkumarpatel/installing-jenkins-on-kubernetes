# image
This folder is for customize Jenkins Image need to k8s.

**How to build ?**
> Make sure you have docker runtime Installed

```sh
docker build -t samitkumarpatel/jenkins:lts -f image/Dockerfile .
```

Note- So far the above command with only installed versy few plugins `kubernetes` `workflow-aggregator` `git` `configuration-as-code` `blueocean` but If you want to extend and want more plugins , than please update the Dockerfile or Update the plugins.txt and make sure you update Dockerfile afterwards like below :

```
FROM jenkins/jenkins:lts
RUN jenkins-plugin-cli --plugins-file plugins.txt
```