# otf-kind

Deploys [otf](https://github.com/leg100/otf) onto a [kind](https://kind.sigs.k8s.io/) kubernetes cluster, as well as a stack of dependencies that are either required or help serve and monitor otf:

* [cloudnative-pg](https://cloudnative-pg.io/): postgres operator that takes care of running a postgres cluster on kubernetes
* [cert-manager](https://cert-manager.io/): uses Let's Encrypt to automatically assign SSL certificates
* [ingress-nginx](https://github.com/kubernetes/ingress-nginx): exposes and proxies web services
* [prometheus](https://prometheus.io/): metrics gathering
* [grafana](https://grafana.com/): dashboards for monitoring metrics
* [loki](https://grafana.com/oss/loki/): log aggregation
* [promtail](https://grafana.com/docs/loki/latest/clients/promtail/): log collector
* [squid](https://github.com/leg100/squid): caches terraform providers

## Pre-requisites:

* [kind](https://kind.sigs.k8s.io/)
* [helm](https://helm.sh/)
* [helm-diff](https://github.com/databus23/helm-diff)
* [helmfile](helmfile.readthedocs.io)

## Deploy

Set required environment variables (recommend [direnv](https://direnv.net/)):

```bash
export OTF_HOSTNAME=<otfd ingress hostname>
export OTF_SECRET=<something long and secret>
export EMAIL=<your email for lets encrypt>
export GRAFANA_HOSTNAME=<grafana ingress hostname>
```

Optionally set these environment variables to configure sign-in using Github:

```bash
export OTF_GITHUB_CLIENT_ID=<see otf docs>
export OTF_GITHUB_CLIENT_SECRET=<see otf docs>
```

And for squid, you need to generate a self-signed certificate, which it uses to 'ssl-bump' connections:

```
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout key.pem -out ca.pem -subj "/CN=squid.local"
```

Place the cert and key into a directory named `./certs`:

```
mv ca.pem key.pem ./certs
```

And deploy it into the cluster via a configmap:

```
kubectl create configmap create --file-from=./certs
```

Now run `make deploy` to deploy all the charts. If you run into issues replace `helmfile apply` with `helmfile sync` in the `deploy` make task.
