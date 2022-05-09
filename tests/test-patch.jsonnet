local kube = import 'lib/kube.libjsonnet';
local rl = import 'lib/resource-locker.libjsonnet';


rl.Patch(
  kube.Deployment('test') {
    metadata+: {
      namespace: 'foo',
    },
  },
  {
    spec: {
      replicas: 5,
    },
  }
)
