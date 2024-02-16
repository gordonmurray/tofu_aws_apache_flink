# Open Tofu, AWS, Apache Flink


### Create a base image AMI using Packer

First, add your VPC IP and Subnet in to packer/variables.json

Validate the packer file

```
packer validate --var-file=variables.json flink.json
```

Build the AMI from the packer file

```
packer build --var-file=variables.json flink.json
```


### Flink cluster diagram

A diagram of the resulting Flink cluster created using this Tofu project:

```mermaid
graph TD
    subgraph On-demand EC2 Instance
        JM[Flink Job Manager]
    end
    subgraph EC2 Spot Instance
        TM1[Flink Task Manager 3]
    end
    subgraph EC2 Spot Instance
        TM2[Flink Task Manager 2]
    end
    subgraph EC2 Spot Instance
        TM3[Flink Task Manager 1]
    end

    JM -->|manages| TM1
    JM -->|manages| TM2
    JM -->|manages| TM3
```


### Estimated cost

```
Project: gordonmurray/tofu_aws_apache_flink

 Name                                                  Monthly Qty  Unit     Monthly Cost

 aws_autoscaling_group.flink_taskmanagers_spot
 └─ aws_launch_template.flink_taskmanagers_spot
    ├─ Instance usage (Linux/UNIX, spot, m7g.large)            730  hours          $26.21
    ├─ EC2 detailed monitoring                                   7  metrics         $2.10
    └─ block_device_mapping[0]
       └─ Storage (general purpose SSD, gp2)                    50  GB              $5.00

 aws_instance.flink_job_managers[0]
 ├─ Instance usage (Linux/UNIX, on-demand, m7g.large)          730  hours          $59.57
 └─ root_block_device
    └─ Storage (general purpose SSD, gp3)                       50  GB              $4.00

 OVERALL TOTAL                                                                     $96.88
──────────────────────────────────
10 cloud resources were detected:
∙ 2 were estimated, all of which include usage-based costs, see https://infracost.io/usage-file
∙ 8 were free:
  ∙ 2 x aws_iam_role_policy_attachment
  ∙ 1 x aws_iam_instance_profile
  ∙ 1 x aws_iam_policy
  ∙ 1 x aws_iam_role
  ∙ 1 x aws_key_pair
  ∙ 1 x aws_launch_template
  ∙ 1 x aws_security_group

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━┓
┃ Project                                            ┃ Monthly cost ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━┫
┃ gordonmurray/tofu_aws_apache_flink                 ┃ $97          ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━┛
```