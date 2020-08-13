# pkg
Run FreeBSD pkg in a docker container so you can sync FreeBSD packages without running a dedicated FreeBSD system.

# Usage
```
docker run --rm -i -v /path/to/repo:/repo quay.io/jmontleon/pkg:latest \
  /bin/bash -c 'pkg -r /freebsd update -f && pkg -r /freebsd fetch -y -a -o /repo'
docker run --rm -i -v /path/to/repo:/repo quay.io/jmontleon/pkg:latest \
  /bin/bash -c 'pkg -r /freebsd repo /repo'
```
