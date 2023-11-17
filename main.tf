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

resource "aws_instance" "peliculas_server" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  key_name = "peliculas_llave"
  vpc_security_group_ids = [ "sg-01c3da519e0e6a3dc" ]
  associate_public_ip_address = true

  provisioner "file" {
    source = "Pelicula.zip"
    destination = "/home/ubuntu/Pelicula.zip"
  }
  provisioner "local-exec" {
    command = "sudo ./script.sh"
    interpreter = [ "/bin/bash", "-c" ]
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("C:\Users\danid\OneDrive\Escritorio\PaginaDePeliculas\peliculas_llave.pem")}"
    host = "${self.public_ip}"
  }

  tags = {
    Name = "PaginaDePeliculas"
  }
}
