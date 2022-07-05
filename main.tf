data "aws_ami" "AMI_NICE_DCV_G4" {
  name_regex  = "NVIDIA-gaming"
  most_recent = true
  filter {
    name   = "owner-id"
    values = ["877902723034"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "platform"
    values = ["windows"]
  }
}

resource "aws_spot_fleet_request" "cheap_computer" {
  iam_fleet_role                      = "arn:aws:iam::227612489064:role/aws-ec2-spot-fleet-tagging-role"
  wait_for_fulfillment                = true
  terminate_instances_with_expiration = true
  fleet_type                          = "request"
  allocation_strategy                 = "lowestPrice"
  target_capacity                     = 1

  dynamic "launch_specification" {
    for_each = [for s in data.aws_subnets.target_vpc_subnets.ids : {
      subnet_id = s
    }]
    content {
      key_name      = var.keypair_name
      ami           = data.aws_ami.AMI_NICE_DCV_G4.image_id
      instance_type = var.target_instance


      associate_public_ip_address = true
      vpc_security_group_ids      = ["${aws_security_group.CloudGaming.id}"]
      subnet_id                   = launch_specification.value.subnet_id

      user_data = file("${var.user_data}")

      root_block_device {
        volume_size = 30
        volume_type = "gp3"
        iops        = 3000
        throughput  = 125

        encrypted             = false
        delete_on_termination = true
      }

      tags = {
        Name = "SpotGaming"
      }
    }
  }
}


data "aws_instance" "spot_retrieve" {
  filter {
    name   = "tag:Name"
    values = ["SpotGaming"]
  }
  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
  get_password_data = true

  depends_on = [resource.aws_spot_fleet_request.cheap_computer]
}

output "Administrator_Password" {
  value = rsadecrypt(data.aws_instance.spot_retrieve.
  password_data, file("${var.keypair_dir}"))
}
output "spot-ips" {
  value = data.aws_instance.spot_retrieve.public_ip
}
output "ami_using" {
  value = data.aws_ami.AMI_NICE_DCV_G4.image_location
}
