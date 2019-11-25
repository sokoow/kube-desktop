# kube-desktop

An attempt to run full CI-CD stack on a single kube node, on any infrastructure.

Also a good lesson on how to integrate Terraform, Ansible and Helm together into an appliance.

## WHY?

Well, mostly so anybody can start developing and have subdomains

## What's included:

- [x] kubeadm single node cluster
- [x] kubernetes dashboard
- [x] calico overlay networking. other ones commented out in script
- [x] working helm 3.0
- [x] traefik 1.x
- [x] some form of CI/CD : Drone
- [x] a DB/storage (Postgres)
- [x] minio endpoint
- [x] self-contained docker image registry
- [x] rook-ceph setup for PV's to work (helm charts should work out of the box)

## Prerequisites/Requirements

- 4GB of memory
- 3 cores
- 12+ GB of disk space
- Ubuntu Bionic
- sudo password
- no fancy network setup
- (optional) Vagrant installed

## How do I start ?

### Running on localhost

If you're a happy owner of a Xenial derivative of a Linux distro, clone the repo, and just do ```./install-kubeadm.sh``` - this will install basic one-node kubeadm cluster and needed prerequisites.

To install full CI stack, fire up ```./deploy-ci-stack.sh``` afterwards and then do ```cat /etc/hosts``` to see what apps are available. For more details go to each app dir.

#### Running example deployment on localhost (golang demo)

Go to the `examples` directory, have a look around there.
s
### Running on Vagrant

Should be as simple as:
- Running ```vagrant up```, assuming you've latest Vagrant installed

To connect to the VM, run ```vagrant ssh```, there should be kubectl already configured for you. To connect to any app with localhost web browser, check ```/etc/hosts``` file for alias name, and then open ```http://ALIAS:1080``` (as vagrant redirects port 80 VM -> port 1080 localhost for treafik ingress controller)

## How do I ..

### Launch a kube dashboard ?

Traefik reverse proxy listens on a NodePort 30000/TCP in non-tls fashion, and ingress is being created to it at the script start (see **ingress** directory), so if all installed correctly, you just need to open up: ```http://dashboard.mykube.awesome/```

### Deploy my own app ?

Look into included examples dir. Send me a PR if you dockerize a cool app.

## FAQ - aka can I get this ported to X (before you raise an issue) ?

- **Mac OSX** - well you may try, I accept PRs, but probably it'll be easier to just use minikube on Docker Edge channel and strip up extras to be deployed on top of it
- **Windows** - NO
- **Armhf/Arm64 (Raspberry/Odroid/100s others)** - is kubeadm/helm/traefik available there yet ? Let's talk if you need that. Maybe k3sup someone?

## Wishlist

Next things that would be handy to run on this:

- [ ] backups
- [ ] more desktop apps
- [ ] self-signed TLS
- [ ] templatize the whole lot using golang templates (https://github.com/VirtusLab/render, https://medium.com/virtuslab/helm-alternative-d6568aa9d40b)
- [ ] some auth servers for development (ldap + dex, keycloak)
- [ ] more storage support (druid, ES, cockroach, TiDB)
- [ ] bigdata/ML demos?
- [ ] example projects in various languages
- [ ] tracing/logging
- [ ] service mesh
- [ ] whatever else

### What might be problematic ?

- Running helm charts that use PV/PVCs - **fixed** when using rook-ceph
- Running services that want loadbalancers - **not needed** when using traefik

### What's next ?

Well, here's an interesting concept maintaned at https://github.com/leblancd/Kube-in-the-Box

## Big thanks

For all projects that are used in this repo:

- Kubernetes (https://github.com/kubernetes/kubernetes)
- Drone CI (https://github.com/drone/drone)
- Minio (https://github.com/minio/minio)
- Vault (https://github.com/hashicorp/vault)
- Helm (https://github.com/kubernetes/helm)
- Gogs (https://github.com/gogits/gogs)
- Postgres

and many more.
