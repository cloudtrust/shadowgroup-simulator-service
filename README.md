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
sudo docker create --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name shadowgroup -p 7080:7080 cloudtrust-idptestclient

# test
sudo docker start shadowgroup

TODO: add CURL test
```


