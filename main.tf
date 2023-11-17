terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  key_name = "appmovilllave"
  vpc_security_group_ids = [ "sg-01c3da519e0e6a3dc" ]
  associate_public_ip_address = true

  provisioner "file" {
    source = "Pelicula.zip"
    destination = "/home/ubuntu/Pelicula.zip"
  }
  provisioner "local-exec" {
    command = "sudo apt install docker docker-compose -y && unzip -q Pelicula.zip && cd Pelicula && sudo docker-compose up --build
    interpreter = [ "/bin/bash", "-c" ]
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/Documents/Aplicacion/appmovilllave.pem")}"
    host = "${self.public_ip}"
  }

  tags = {
    Name = "EjemploIaCsalon3"
  }
}
