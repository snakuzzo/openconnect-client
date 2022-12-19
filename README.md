# Openconnect client

This is an openconnect client (latest version) based on Ubuntu 22.04 official image and official openconnect repository
This client works on Linux, but it doesn't on Windows and macOS because it needs `network: host` to change routing
You can create your container using my image or build your own image starting from Dockerfile

## Using image

If you want to use ready image you have to know there are some mandatory environment variables:

- SERVER -> VPN server ip/fqdn
- USERNAME -> your username
- PASSWORD -> your password
- OTP -> your OTP
- PROTOCOL -> (nc/pulse/gp/f5/fortinet/array). In my case I use nc.
- NODTLS -> (yes/no). Disable DTLS and ESP... in my case I always need this when I connect over another VPN connection.
- USESCRIPT -> (yes/no). Use yes if you want use external script (`/data/juniper-script`)* to set your own routing and not the default. View example browsing code.

(*) The script use a `/data/juniroutes` where user can set IP/CIDR to reach using openconnect VPN gateway. Have a look at the file browsing code.

## Docker example

If your OTP is 123456...

```bash
docker run --privileged -t -d -v /home/myuser/data/juniroutes:/data/juniroutes --name openconnect-client -h openconnect-client -e TZ=Europe/Rome -e SERVER=server -e USERNAME=username -e PASSWORD=password -e OTP=123456 -e PROTOCOL=nc -e NODTLS=yes -e USESCRIPT=yes ghcr.io/snakuzzo/openconnect-client:main 
```

## Docker compose example

```yaml
services:

  openconnect-client:
  
    hostname: openconnect-client
    container_name: openconnect-client
    image: ghcr.io/snakuzzo/openconnect-client:main
    privileged: true
    restart: "no"
    tty: true
    environment:
    - "TZ=Europe/Rome"
    - "SERVER=server"
    - "USERNAME=username"
    - "PASSWORD=password"
    - "OTP=${OTP}"
    - "PROTOCOL=nc"
    - "NODTLS=yes"
    - "USESCRIPT=yes"
    network_mode: host
    volumes:
    - "/home/myuser/data/juniroutes:/data/juniroutes"
```

then to start...

```bash
OTP=123456 docker-compose up -d openconnect-client
```

...and to stop...

```bash
docker-compose stop openconnect-client
```
