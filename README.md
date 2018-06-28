# shadowgroup-simulator service

This is a service (docker container) for running the [shadowgroup-simulator](https://github.com/cloudtrust/shadowgroup-simulator).

## Installing the shadowgroup-simulator service

```
# prepare the environment
git clone git@github.com:cloudtrust/shadowgroup-simulator-service.git
cd shadowgroup-simulator-service/dockerfiles/

# build the docker file
sudo docker build -t cloudtrust-shadowgroupsimulator -f cloudtrust-shadowgroupSimulator.dockerfile .

#create container 1
sudo docker create --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name shadowgroup -p 7080:7080 cloudtrust-shadowgroupsimulator

# test
sudo docker start shadowgroup

curl -H "referer:testReferer" -H "User-Agent:testAgent" localhost:7080/shadowgroups/usg/user
```
The test should return the following json: `{"$id":1,"$values":["alpha","bravo","charlie","delta","user"]}`

