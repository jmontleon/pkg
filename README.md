# pkg
Run FreeBSD pkg in a docker container so you can sync FreeBSD packages without running a dedicated FreeBSD system.

# Usage
```
docker run --rm -it -v /path/to/repo:/repo quay.io/jmontleon/pkg:latest -- fetch -y -d -o /repo vim
docker run --rm -it -v /path/to/repo:/repo quay.io/jmontleon/pkg:latest -- repo /repo
```
