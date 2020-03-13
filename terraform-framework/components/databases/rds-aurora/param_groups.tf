resource "aws_db_parameter_group" "db_param_group" {
  count       = var.engine == "aurora-postgresql" ? 1 : 0

  name        = "${local.name}-db-instance-pg"
  family      = var.family
  description = "postgres11 parameter group"

  parameter {
    name  = "shared_preload_libraries"
    value = "pg_stat_statements"
  }

  parameter {
    name  = "log_lock_waits"
    value = "on"
  }

  parameter {
    name  = "idle_in_transaction_session_timeout"
    value = "300000"
  }

  parameter {
    name  = "pg_stat_statements.track_utility"
    value = "on"
  }

  parameter {
    name  = "random_page_cost"
    value = "1.0"
  }
}

resource "aws_rds_cluster_parameter_group" "db_cluster_pg" {
  count       = var.engine == "aurora-postgresql" ? 1 : 0

  name        = "${local.name}-cluster-pg"
  family      = var.family
  description = "db cluster postgres11 parameter group"

  parameter {
    name  = "autovacuum_vacuum_cost_delay"
    value = "0"
  }

  parameter {
    name  = "vacuum_cost_limit"
    value = "10000"
  }

  parameter {
    name  = "autovacuum_vacuum_scale_factor"
    value = "0.01"
  }

  parameter {
    name  = "autovacuum_naptime"
    value = "60"
  }

  parameter {
    name  = "client_encoding"
    value = "LATIN1"
  }
}
