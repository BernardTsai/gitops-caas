# gitops-caas
Example CaaS setup to support progressive delivery following a GitOps approach.

It will add linkerd to the CaaS cluster.

Installation
------------

The additional required CaaS components are installed via:

````
helm upgrade -i gitops-caas helm
````

Uninstallation
--------------

The additional components are removed via:

````
helm uninstall gitops-caas
````
