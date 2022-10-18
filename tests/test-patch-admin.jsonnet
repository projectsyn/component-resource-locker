local kube = import 'lib/kube.libjsonnet';
local rl = import 'lib/resource-locker.libjsonnet';


{
  rolepatch: rl.Patch(
    kube.RoleBinding('test') {
      metadata+: {
        namespace: 'foo',
      },
    },
    {
      metadata: {
        annotations: {
          patched: '',
        },
      },
    },
  ),
  clusterrolepatch: rl.Patch(
    kube.ClusterRoleBinding('test') {
      metadata+: {
        namespace: 'foo',
      },
    },
    {
      metadata: {
        annotations: {
          patched: '',
        },
      },
    },
  ),
}
