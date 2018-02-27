docker_web (Docker image)
=========================

AixViPMaP ownCloud web interface

Configure
---------

1. Set guest ``hostname`` in [docker-compose.yml]() (Default: localhost)

2. Add Apache2 SSL certificate files
  - Copy ``SSLCertificateFile`` to [apache2/cert.pem]()
  - Copy ``SSLCertificateChainFile`` to [apache2/chain.pem]()
  - Copy ``SSLCertificateKeyFile`` to [apache2/key.pem]()

3. Customize ownCloud install in [owncloud.env]()
   - Admin credentials (Default: administrator/administrator)
   - Database name (Default: sqlite)
   - Database credentials (Default: owncloud/owncloud)
   - Database hostname (Default: localhost)

Run
---

```bash
docker-compose up --build
```

> After the initial setup, you may want to set ``skip_owncloud_setup`` to ``true`` in [docker-compose.yml](). This will disable the ownCloud setup script ([owncloud-setup.sh]()) in the Docker entrypoint allowing a container to resume an existing ownCloud configuration.

Docker
------

### Volume

| Mount point | Description |
|-|-|
| ``/occonfig`` | ownCloud config directory |
| ``/ocdata`` | ownCloud data directory (``datadirectory``) |

### Environment

| Variable | Description |
|-|-|-|
| ``skip_owncloud_setup`` | Skip ownCloud setup ([owncloud-setup.sh]()) if ``true``. |
