local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.resource_locker;
local argocd = import 'lib/argocd.libjsonnet';

local app = argocd.App('resource-locker', params.namespace, secrets=false);

{
  'resource-locker': app,
}
