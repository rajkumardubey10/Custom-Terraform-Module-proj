
## This will provide the AMI id for instance
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

## Key-pair for SSH to EC2 Instance
# resource "aws_key_pair" "my_ssh_key_pair" {
    
#     key_name_prefix =  "${var.key_pair_name_prefix}-key"
#     public_key = file(var.public_key_path)

#     tags = var.tags
# }

## To Create the EC2 Instance
resource "aws_instance" "my_instances" {
  for_each = var.instances

    ami           = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    subnet_id              = each.value.subnet_id
    vpc_security_group_ids = each.value.vpc_security_group_ids

    key_name = var.key_pair_name
    iam_instance_profile = var.iam_instance_profile

    associate_public_ip_address = var.associate_public_ip

    user_data = (
        var.user_data_script != "" ?
        file(var.user_data_script) :
        null
    )

    root_block_device {
        volume_size = var.root_volume_size       # Example: 20 GB
        volume_type = var.root_volume_type       # Example: "gp3"
        encrypted   = var.root_volume_encrypted  # true/false
  }

  tags = merge(
    var.tags,
    try(each.value.tags, {}),
    {
      Name = each.key
    }
  )


  lifecycle {
    create_before_destroy = true
  }
}

