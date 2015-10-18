## install docker
```
# https://docs.docker.com/linux/started/
wget -qO- https://get.docker.com/ | sh
```

## build container from within repo dir
```
docker build -t cjdns .
```

## run it
```
docker run -p PORT -v VOLUME cjdns
```

## enter the container
```
docker exec -it NAME bash
```
