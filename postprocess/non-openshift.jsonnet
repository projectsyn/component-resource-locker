local com = import 'lib/commodore.libjsonnet';

local inv = com.inventory();
local distribution = inv.parameters.facts.distribution;

local chart_output_dir = std.extVar('output_path');

local list_dir(dir, basename=true) =
  std.native('list_dir')(dir, basename);

local chart_files = list_dir(chart_output_dir);
local input_file(elem) = chart_output_dir + '/' + elem;

local stem(elem) =
  local elems = std.split(elem, '.');
  std.join('.', elems[:std.length(elems) - 1]);

local fixup_deploy(obj) =
  obj {
    spec+: {
      template+: {
        spec+: {
          containers: [
            c {
              ports: [
                {
                  containerPort: 8080,
                  name: 'http',
                },
              ],
            }
            for c in super.containers
            if c.name != 'kube-rbac-proxy'
          ],
          volumes: [
            v
            for v in super.volumes
            if v.name != 'tls-cert'
          ],
        },
      },
    },
  };
local fixup_service(obj) =
  obj {
    spec+: {
      ports: [
        {
          name: 'http',
          port: 8080,
          targetPort: 'http',
        },
      ],
    },
  };
local fixup_servicemonitor(obj) =
  obj {
    spec+: {
      endpoints: [
        {
          interval: '30s',
          port: 'http',
          scheme: 'http',
        },
      ],
    },
  };

local fixup_obj(obj) =
  if distribution != 'openshift4' then (
    if obj.kind == 'Deployment' then
      fixup_deploy(obj)
    else if obj.kind == 'Service' then
      fixup_service(obj)
    else if obj.kind == 'ServiceMonitor' then
      fixup_servicemonitor(obj)
    else
      obj
  )
  else
    obj;

local fixup(obj_file) =
  local objs = std.prune(com.yaml_load_all(obj_file));
  // process all objs
  [ fixup_obj(obj) for obj in objs ];

{
  [stem(elem)]: fixup(input_file(elem))
  for elem in chart_files
}
