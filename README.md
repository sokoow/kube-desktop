# kube-desktop

## WHY?

Couple of reasons:

- firstly, inspired by Jess Frazelle's desktop apps on kube ( @github/jessfraz https://github.com/jessfraz/dockerfiles), I thought to myself 'Why not put this all on Kube also ? How hard might that be ?'

- secondly, being iritated on how heavy minikube on amd64 is, I decided to rely only on a single node kubeadm cluster containers - this environment should give you enough kubernetes to start a cool project on your own

## What's included:

- [x] kubeadm single node cluster on your desktop
- [x] kubernetes dashboard
- [x] canal overlay networking. other ones commented out in script
- [x] working helm
- [x] traefik

## Prerequisites

- Ubuntu Xenial
- sudo password
- docker installed
- no fancy network setup

## How do I start ?

If you're a happy owner of a Xenial derivative of a Linux distro, clone the repo, and just do ```./install-kubeadm.sh```

To launch semi-working version of Firefox on kube, go to apps directory.

## How do I ..

### Launch a kube dashboard ?

Traefik reverse proxy listens on a NodePort 30000/TCP in non-tls fashion, and ingress is being created to it at the script start (see **ingress** directory), so if all installed correctly, you just need to open up: ```http://dashboard.mykube.awesome:30000/```

### Traefik dashboard ?

NodePort 30001/TCP non-tls, so: ```http://localhost:30001/```

### Deploy my own app ?

Look into **deploy* and **ingress** directories for examples, then ```kubectl -f apply ...``` them. Send me a PR if you dockerize a cool app.

## FAQ - aka can I get this ported to X (before you raise an issue) ?

- **Mac OSX** - well you may try, I accept PRs, but probably it'll be easier to just use minikube on Docker Edge channel and strip up extras to be deployed on top of it
- **Windows** - NO
- **Armhf/Arm64 (Raspberry/Odroid/100s others)** - is kubeadm/helm/traefik available there yet ? Let's talk if you need that.

## Wishlist

Next things that would be handy to run on this:

- [ ] self-contained image registry
- [ ] some form of CI/CD : Jenkins or Drone
- [ ] a DB/storage (Postgres/TiDB) ?
- [ ] secrets store
- [ ] ark backups
- [ ] minio endpoint
- [ ] more desktop apps
- [ ] self-signed TLS ?
- [ ] whatever else

### What might be problematic ?

- Running helm charts that use PV/PVCs - I'm using only hostpaths here
- Running services that want loadbalancers

### What's next ?

Well, here's an interesting concept maintaned by https://github.com/leblancd/Kube-in-the-Box
