local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local inv = kap.inventory();

local params = inv.parameters.resource_locker;

local sa = kube.ServiceAccount('delete-operator-deployment') {
  metadata+: {
    annotations+: {
      'argocd.argoproj.io/sync-wave': '-10',
    },
    namespace: params.namespace,
  },
};

local role = kube.Role('delete-operator-deployment') {
  metadata+: {
    annotations+: {
      'argocd.argoproj.io/sync-wave': '-10',
    },
    namespace: params.namespace,
  },
  rules: [
    {
      apiGroups: [ 'apps' ],
      resources: [ 'deployments' ],
      verbs: [ 'get', 'delete' ],
    },
  ],
};

local rolebinding = kube.RoleBinding('delete-operator-deployment') {
  metadata+: {
    annotations+: {
      'argocd.argoproj.io/sync-wave': '-10',
    },
    namespace: params.namespace,
  },
  roleRef_:: role,
  subjects_:: [ sa ],
};

local upgrade_script = importstr 'scripts/upgrade.sh';

local upgrade_job = kube.Job('delete-operator-deployment') {
  metadata+: {
    annotations+: {
      'argocd.argoproj.io/hook': 'Sync',
      'argocd.argoproj.io/hook-delete-policy': 'HookSucceeded',
      'argocd.argoproj.io/sync-wave': '-10',
    },
    namespace: params.namespace,
  },
  spec+: {
    template+: {
      spec+: {
        containers_: {
          delete_deploy: kube.Container('delete-deployment') {
            image: '%(registry)s/%(repository)s:%(tag)s' % params.images.kubectl,
            command: [ 'bash', '-c', upgrade_script ],
            env_: {
              HOME: '/work',
              NAMESPACE: {
                fieldRef: {
                  fieldPath: 'metadata.namespace',
                },
              },
              NEW_VERSION: params.charts['resource-locker-operator'],
            },
            volumeMounts_: {
              work: { mountPath: '/work' },
            },
          },
        },
        serviceAccountName: sa.metadata.name,
        volumes_: {
          work: {
            emptyDir: {},
          },
        },
      },
    },
  },
};

{
  '00_namespace': kube.Namespace(params.namespace),

  '10_upgrade_job': [ sa, role, rolebinding, upgrade_job ],
}
