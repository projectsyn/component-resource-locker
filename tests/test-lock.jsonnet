local kube = import 'lib/kube.libjsonnet';
local rl = import 'lib/resource-locker.libjsonnet';


rl.Resource(
  kube.Deployment('test') {
    metadata+: {
      namespace: 'foo',
    },
    spec: {
      replicas: 3,
    },
  }
)
