# aws key pair
resource "aws_key_pair" "infra-app-key" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("infra_app_key.pub")
  tags = {
    Environment = var.env
  }
}

# aws vpc and security group

resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "my_sec_group" {
  name        = "${var.env}-infra-app-sg"
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
    Name = "${var.env}-infra-app-sg"
    Environment = var.env
  }
}

# ec2 instance
resource "aws_instance" "my_instance" {
  # TO create multiple instances
  count = var.instance_count
  depends_on = [ aws_security_group.my_sec_group, aws_key_pair.infra-app-key ]
  key_name        = aws_key_pair.infra-app-key.key_name
  security_groups = [aws_security_group.my_sec_group.name]
  # instance_type   = var.ec2_instance_type
  instance_type = var.instance_type
  ami           = var.ec2_ami_id

  root_block_device {
    volume_size           = var.ec2_root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    # Name = "tf_ec2_demo_1"
    Name = "${var.env}-infra-app-ec2"
    Environment = var.env
  }

}