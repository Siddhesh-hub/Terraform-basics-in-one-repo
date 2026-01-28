# =============================================================================
# AWS EC2 Infrastructure Configuration
# =============================================================================
# Provisions EC2 instances with networking, security groups, and SSH access.
#
# Resources:
#   - aws_key_pair.deployer: SSH authentication key
#   - aws_default_vpc.default: Default VPC configuration
#   - aws_security_group.my_sec_group: Network access control
#   - aws_instance.my_instance: EC2 compute instances
# =============================================================================

# =============================================================================
# SSH Key Pair for Instance Access
# =============================================================================
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key-${var.env}"
  public_key = file("tf_ec2_key.pub")
  tags = {
    Environment = var.env
  }
}

# aws vpc and security group

resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "my_sec_group" {
  name        = "automate-sg-${var.env}"
  description = "Security group for automated EC2 instance"
  vpc_id      = aws_default_vpc.default.id
  # inbound rules - ingress

  # SSh ingress rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access from anywhere"
  }

  # HTTP ingress rule
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP access from anywhere"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open flask app"
  }

  # outbound rules - egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "automate-sg-${var.env}"
    Environment = var.env
  }
}

# ec2 instance
resource "aws_instance" "my_instance" {
  # TO create multiple instances
  # count = 2
  for_each = tomap({
    "ec2_instance_1" = "t3.micro"
    "ec2_instance_2" = "t3.small"
  })
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.my_sec_group.name]
  # instance_type   = var.ec2_instance_type
  instance_type = each.value
  ami           = var.ec2_ami_id
  user_data     = file("install_nginx.sh")
  root_block_device {
    volume_size           = var.ec2_root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    # Name = "tf_ec2_demo_1"
    Name = each.key
    Environment = var.env
  }

}