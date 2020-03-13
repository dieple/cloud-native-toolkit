output arn {
  description = "AWS lambda arn"
  value       = module.lambda_stopping_ec2_instances_nightly.arn
}

output qualified_arn {
  description = "AWS lambda qualified_arn"
  value       = module.lambda_stopping_ec2_instances_nightly.qualified_arn
}

output invoke_arn {
  description = "AWS lambda invoke_arn"
  value       = module.lambda_stopping_ec2_instances_nightly.invoke_arn
}

output version {
  description = "AWS lambda version"
  value       = module.lambda_stopping_ec2_instances_nightly.version
}

output last_modified {
  description = "AWS lambda last_modified"
  value       = module.lambda_stopping_ec2_instances_nightly.last_modified
}

output source_code_hash {
  description = "AWS lambda source_code_hash"
  value       = module.lambda_stopping_ec2_instances_nightly.source_code_hash
}

output source_code_size {
  description = "AWS lambda source_code_size"
  value       = module.lambda_stopping_ec2_instances_nightly.source_code_size
}



