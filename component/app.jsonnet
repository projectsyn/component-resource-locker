local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.synsights;
local argocd = import 'lib/argocd.libjsonnet';

local app = argocd.App('resource-locker', params.namespace, secrets=true);

{
  'syn-resource-locker': app,
}
