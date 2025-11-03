# ===========================================================
# Security Group for App Server
# ===========================================================
resource "aws_security_group" "app_sg" {
  name        = "app-server-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AppServerSG"
  }
}

# ===========================================================
# EC2 Instance for App Server
# ===========================================================
resource "aws_instance" "app_server" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (us-east-1)
  instance_type          = "t2.micro"
  key_name               = "Security" # Must exist in AWS
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  # Attach IAM instance profile for CodeDeploy
  iam_instance_profile = aws_iam_instance_profile.codedeploy_instance_profile.name

  tags = {
    Name        = "AppServer"
    Environment = "Development" # Must match CodeDeploy EC2 tag filter
  }

  user_data = <<-EOF
              #!/bin/bash
              set -e

              # Update system and install dependencies
              yum update -y
              yum install -y ruby wget awscli

              # Enable and install Docker
              amazon-linux-extras enable docker
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user

              # Configure AWS CLI region globally
              echo "export AWS_DEFAULT_REGION=us-east-1" >> /etc/profile
              export AWS_DEFAULT_REGION=us-east-1

              # Install CodeDeploy agent
              cd /home/ec2-user
              wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
              chmod +x ./install
              sudo ./install auto
              sudo systemctl enable codedeploy-agent
              sudo systemctl start codedeploy-agent

              echo "Setup complete: Docker + CodeDeploy agent running successfully."
              EOF

  provisioner "local-exec" {
    command = "echo \"EC2 instance created, Docker & CodeDeploy agent installed successfully.\""
  }
}
