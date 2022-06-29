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
                       "sudo apt-get install ca-certificates curl gnupg lsb-release",
                       "sudo mkdir -p /etc/apt/keyrings",
                       "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
                       "echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
                       "sudo apt-get update",
                       "sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin",
                       "sudo docker pull 18273456/covidstat",
                       "sudo docker run -p 80:80 covidstat",
                  ]
  }
}
