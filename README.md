# resource-locker

A Commodore component to install the
[resource-locker](https://github.com/redhat-cop/resource-locker-operator)
operator via Helm chart.

The resource locker operator allows you to specify a set of configurations
that the operator will "keep in place" (lock) preventing any drifts.

The component provides a jsonnet library `resource-locker.libjsonnet`, which
other components can use to provide configurations for the operator.

A brief usage example which creates a configuration for the operator which
enforces the presence of a resource quota object in namespace `default`:

```
local kube = 'import lib/kube.libjsonnet';
local rl = 'import lib/resource-locker.libjsonnet';

local quota = kube._Object('v1', 'ResourceQuota', 'test-quota') {
  metadata+: {
    namespace: 'default',
  },
  spec: {
    hard: {
      'requests.cpu': '4',
      'requests.memory': '4Gi',
    },
  },
};

{
  '10_default_resourcequota': rl.Resource(quota),
}
```

An example which patches the version of the `kube-proxy` DaemonSet in the
`kube-system` namespace for AWS EKS clusters:

This example assumes that the inventory contains a key `eks` which holds the
EKS cluster version in `eks.version`, a list of AWS/EKS docker registries in
`eks.registry.<cloud-region>` and the kube-proxy version for each supported
EKS version in `eks.addons.kube-proxy.<eks-version>`. For this example, the
format of the `eks.version` field must match the keys in
`eks.addons.kube-proxy`.

```
local kube = import 'lib/kube.libjsonnet';
local rl = import 'lib/resource-locker.libjsonnet';

local target = kube.DaemonSet('kube-proxy') {
  metadata+: {
    namespace: 'kube-system'
  }
};

local registry = '602401143452.dkr.ecr.%s.amazonaws.com" % inv.parameters.cloud.region;
local image = "%s/eks/kube-proxy:%s" %
  [registry, inv.parameters.eks.addons.kube_proxy[inv.parameters.eks.version]];

local patch = {
  spec: {
    template: {
      spec: {
        containers: [{
          name: 'kube-proxy',
          image: image,
        }],
      }
    }
  }
};

{
  '10_default_patch_version': rl.Patch(quota),
}
