// main template for resource-locker
local com = import 'lib/commodore.libjsonnet';
local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.resource_locker;

local namespace = kube.Namespace(params.namespace);

local operatorgroup = com.namespaced(params.namespace, {
  apiVersion: "operators.coreos.com/v1",
  kind: "OperatorGroup",
  metadata: {
    annotations: {
      "olm.providedAPIs": "ResourceLocker.v1alpha1.redhatcop.redhat.io"
    },
    name: "resource-locker-operator",
  },
  spec: {
    "targetNamespaces": [
      "resource-locker-operator"
    ]
  }
});

local subscription = com.namespaced(params.namespace, {
  apiVersion: "operators.coreos.com/v1alpha1",
  kind: "Subscription",
  metadata: {
    name: "resource-locker-operator",
  },
  spec: {
    channel: "alpha",
    installPlanApproval: "Automatic",
    name: "resource-locker-operator",
    source: "community-operators",
    sourceNamespace: "openshift-marketplace"
  }
});

// Define outputs below
{
  '01_namespace': namespace,
  '20_operatorgroup': operatorgroup,
  '30_subscription': subscription,
}
