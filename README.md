# otf-kind

Deploys [otf](https://github.com/leg100/otf) onto a [kind](https://kind.sigs.k8s.io/) kubernetes cluster, as well as a stack of dependencies that are either required or help serve and monitor otf:

* [cloudnative-pg](https://cloudnative-pg.io/): postgres operator that takes care of running a postgres cluster on kubernetes
* [cert-manager](https://cert-manager.io/): uses Let's Encrypt to automatically assign SSL certificates
* [ingress-nginx](https://github.com/kubernetes/ingress-nginx): exposes and proxies web services
* [prometheus](https://prometheus.io/): metrics gathering
* [grafana](https://grafana.com/): dashboards for monitoring metrics

## Pre-requisites:

* [kind](https://kind.sigs.k8s.io/)
* [helm](https://helm.sh/)
* [helm-diff](https://github.com/databus23/helm-diff)
* [helmfile](helmfile.readthedocs.io)

## Deploy

Set required environment variables (recommend [direnv](https://direnv.net/)):

```bash
export OTF_HOSTNAME=<hostname_of_your_system>
export OTF_SECRET=<something_long_and_secret>
```

Optionally set these environment variables to configure sign-in using Github:

```bash
export OTF_GITHUB_CLIENT_ID=<see otf docs>
export OTF_GITHUB_CLIENT_SECRET=<see otf docs>
```

Run `make deploy`.
