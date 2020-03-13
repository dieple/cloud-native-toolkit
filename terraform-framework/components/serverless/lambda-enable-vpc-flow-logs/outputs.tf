output arn {
  description = "AWS lambda arn"
  value       = module.lambda_enable_vpc_flow_logs.arn
}

output qualified_arn {
  description = "AWS lambda qualified_arn"
  value       = module.lambda_enable_vpc_flow_logs.qualified_arn
}

output invoke_arn {
  description = "AWS lambda invoke_arn"
  value       = module.lambda_enable_vpc_flow_logs.invoke_arn
}

output version {
  description = "AWS lambda version"
  value       = module.lambda_enable_vpc_flow_logs.version
}

output last_modified {
  description = "AWS lambda last_modified"
  value       = module.lambda_enable_vpc_flow_logs.last_modified
}

output source_code_hash {
  description = "AWS lambda source_code_hash"
  value       = module.lambda_enable_vpc_flow_logs.source_code_hash
}

output source_code_size {
  description = "AWS lambda source_code_size"
  value       = module.lambda_enable_vpc_flow_logs.source_code_size
}

