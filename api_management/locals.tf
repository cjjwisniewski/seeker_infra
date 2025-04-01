locals {
  function_app_functions = data.azapi_resource_list.seeker_function_app_functions.output.value

  http_triggered_functions = flatten([
    for function in local.function_app_functions : [
      for binding in function.properties.config.bindings : {
        function_name = split("/", function.name)[1]
        methods       = binding.type == "httpTrigger" && contains(keys(binding), "methods") ? binding.methods : []
        function      = function
        type          = binding.type
      }
      if binding.type == "httpTrigger"
    ]
  ])

  filtered_http_triggered_functions = flatten([
    for item in local.http_triggered_functions : [
      for method in item.methods : {
        function_name = item.function_name
        method        = upper(method)
        function      = item.function
        type          = item.type
      }
    ]
  ])
}
