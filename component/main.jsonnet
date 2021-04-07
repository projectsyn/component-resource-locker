local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local inv = kap.inventory();

local params = inv.parameters.resource_locker;

{
  '00_namespace': kube.Namespace(params.namespace),
}
