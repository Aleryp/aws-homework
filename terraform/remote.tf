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
                       "sudo apt update",
                       "sudo apt install python --yes",
                       "sudo git copy https://github.com/Aleryp/aws-homework.git",
                       "sudo cd aws-homework/covidfore",
                       "sudo pip install --upgrade pip",
                       "sudo pip install -r requirements.txt",
                       "sudo python run.py"
                  ]
  }
}
