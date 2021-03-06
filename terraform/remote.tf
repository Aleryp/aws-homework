variable "ssh_access_key" {
  type = string
}


resource "null_resource" "remote"{
connection {
       type = "ssh"
       user = "ubuntu"
       private_key = var.ssh_access_key
       host  = aws_instance.app_server.public_ip
}

provisioner "remote-exec" {
         inline = [
                       "sudo apt-get update",
                       "sudo apt -y install docker.io",
                       "sudo snap install docker",
                       "sudo docker --version",
                       "sudo docker pull 18273456/covidstat:v0.2",
                       "sudo docker run -d -p 80:80 18273456/covidstat:v0.2",
                  ]
  }
}
