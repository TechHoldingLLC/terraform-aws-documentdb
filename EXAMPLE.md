# DocumentDB
Below is an example of calling this module.

##
```
module "documentdb" {
  source = "git::https://github.com/TechHoldingLLC/terraform-aws-documentdb.git?ref=v1.0.0"

  name                    = "demo-documentdb"
  master_username         = "username"
  master_password         = "password"
  backup_retention_period = 1

  db_port        = 27017
  engine_version = "5.0.0"
  cluster_family = "docdb5.0"
  instance_class = "db.t4g.medium"
  instance_count = 1

  subnet_ids                   = [db_subnet_ids]
  vpc_security_group_ids       = [db_security_group_id]
  preferred_backup_window      = "07:00-09:00"
  preferred_maintenance_window = "sun:22:00-sun:23:00"

  ## performance insight
  enable_performance_insights = true

  deletion_protection = true
  skip_final_snapshot = false

  cluster_parameters = [{
    apply_method = "pending-reboot"
    name         = "name"
    value        = "value"
  }]

  providers = {
    aws = aws
  }
}
```
