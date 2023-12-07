resource "aws_instance" "server" {
  ami           = "ami-0fa1ca9559f1892ec"
  instance_type = "t2.micro"
  key_name      = "Vir"
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname C8.local
              EOF
  tags = {
    Name = "C8.local"
  }
}
resource "aws_instance" "server-backend" {
  ami           = "ami-06aa3f7caf3a30282"
  instance_type = "t2.micro"
  key_name      = "Vir"
    user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname U21.local
              EOF
  tags = {
    Name = "U21.local"
  }
}
resource "local_file" "inventory" {
  filename = "./inventory.yaml"
  content  = <<EOF
[frontend]
${aws_instance.server.public_ip}
[backend]
${aws_instance.server-backend.public_ip}
EOF
}
output "frontend_public_ip" {
  value = aws_instance.server.public_ip
}
output "backend_public_ip" {
  value = aws_instance.server-backend.public_ip
}