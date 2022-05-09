local kube = import 'lib/kube.libjsonnet';
local rl = import 'lib/resource-locker.libjsonnet';

rl.Patch(
  kube.ClusterRoleBinding('system:build-strategy-docker-binding'),
  {
    annotations: {
      'rbac.authorization.kubernetes.io/autoupdate': 'false',
    },
  }
)
