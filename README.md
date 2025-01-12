# PDS

**This is NOT the official Bluesky PDS, for that see
[bluesky/pds](https://github.com/bluesky/pds)**

This repository contains a flavor of the Bluesky PDS. As of this writing
it's largely just more up-to-date than the official. Latest versions of
the reference (`@atproto/pds`) are used over hand-picked versions.

## Usage

Follow the [official PDS documentation](https://github.com/bluesky/pds),
using the installer and resources provided in this repository instead.

### Switching from bluesky/pds

TODO

### Switching the Installer Back

To switch back to the official installer, simply replace the `pdsadmin`
script on your machine to be the official one and run `sudo pdsadmin
update`.

## Supply Chain Security

While not perfect, attestations is used in this project to ensure that
only Github Artifacts built the provided artifacts
(ghcr.io/rgst-io/pds).

### How do I verify the Docker image?

You can use the [Github CLI] to easily verify that it was created
through a Github action at a given commit. For example, to verify the
latest built image:

```bash
docker pull ghcr.io/rgst-io/pds:VERSION

# --deny-self-hosted-runners is optional, but proves that I didn't run
# my own runners to create this image and somehow 'taint' the process.
gh attestation verify oci://ghcr.io/rgst-io/pds \
  --owner jaredallard --deny-self-hosted-runners
```

## License

This project is dual-licensed under MIT and Apache 2.0 terms:

- MIT license ([LICENSE-MIT.txt](./LICENSE-MIT.txt)
- Apache License, Version 2.0, ([LICENSE-APACHE.txt](./LICENSE-APACHE.txt)

Downstream projects and end users may choose either license
individually, or both together, at their discretion. The motivation for
this dual-licensing is the additional software patent assurance provided
by Apache 2.0.

[Github CLI]: https://cli.github.com/