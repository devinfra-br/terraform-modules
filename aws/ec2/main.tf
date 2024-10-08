data "aws_ami" "curso_terraform" {

  most_recent = true

  filter {
    name   = "state"
    values = ["available"]
  }

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }

}

resource "aws_instance" "curso-terraform-data-source" {
  ami           = data.aws_ami.curso_terraform.id
  instance_type = var.instance_type
  subnet_id     = var.subnet
}
