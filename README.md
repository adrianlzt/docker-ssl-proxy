# docker-ssl-proxy

Builds a basic nginx server that proxies incoming SSL calls to a target host
(usually another Docker container).

## Environment variables

The following environment variables configure nginx:

- ``DOMAIN``: domain in the SSL certificate (default value: ``www.example.com``)
- ``TARGET_PORT``: target port for the reverse proxy (default value: ``80``)
- ``TARGET_HOST``: target host for the reverse proxy (default value: ``proxyapp``)
- ``CLIENT_MAX_BODY_SIZE``: maximum size of client uploads (default value: ``20M``)
- ``CUSTOM_CERTS``: if defined, nginx will expect cert and key in /etc/nginx/certs/

## Certificates and CA location

The SSL certificate is generated using a own-ROOT-ca that is available in the
directory ``/etc/nginx/ca``, you may use Docker volumes to share the CAs with
other containers, so they can trust the installed certificate.

## Custom certs
Example using custom certs.
/home/test/certs should have files ``cert.pem`` and ``key.pem``.
```
docker run -d -e "CUSTOM_CERTS=1" -e "TARGET_PORT=6010" -e "TARGET_HOST=172.17.0.1" -v "/home/test/certs/:/etc/nginx/certs/" -p 443:443 adrianlzt/docker-ssl-proxy
```

Be careful with your certs. If you mount the path but don't define CUSTOM_CERTS nginx will overwrite them!

## Docker Hub Image

You can get the publicly available docker image at the following location:
[docker-ssl-proxy](https://registry.hub.docker.com/u/fsouza/docker-ssl-proxy/).
