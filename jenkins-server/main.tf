resource "aws_instance" "jenkins-server" {
  ami = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type
  key_name = "terraform_key"
  subnet_id = aws_subnet.jenkins-server-subnet-1.id
  vpc_security_group_ids = [aws_default_security_group.default-sg.id]
  availability_zone = var.availability_zone
  associate_public_ip_address = true
  user_data = file("jenkins-server-setup.sh")
  tags = {
    Name = "${var.env_prefix}-jenkins-server"
  }
}