worker_disk_size = 50
worker_ami_type  = "AL2_x86_64"
enable_irsa      = true

node_groups = {
  group1 = {
    desired_capacity = 3
    max_capacity     = 10
    min_capacity     = 1

    instance_type       = "t2.medium"
    ami_release_version = "1.14.7-20190927"
    k8s_labels = {
      Environment = "dev"
    }
  },
  group2 = {
    desired_capacity = 1
    max_capacity     = 10
    min_capacity     = 1

    instance_type       = "t2.medium"
    ami_release_version = "1.14.7-20190927"
    k8s_labels = {
      Environment = "dev"
    }
  }
}
