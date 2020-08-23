# gitops-caas
Example CaaS setup to support progressive delivery following a GitOps approach.

It will add linkerd to the CaaS cluster.

Preparation
-----------

Ensure that the [step](https://smallstep.com/cli/) cli for creating certificates and keys has been installed.

Create the required certificates and keys for linkerd2:

````
./certs/create_certificates_and_values.sh
````

This will create/update a values.yaml file in the helm directory.

Installation
------------

The additional required CaaS components are installed via:

````
helm upgrade -i gitops-caas helm
````

Deinstallation
--------------

The additional components are removed via:

````
helm uninstall gitops-caas
````
