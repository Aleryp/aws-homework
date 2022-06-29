variable "ssh_access_key" {
  type = string
}


resource "null_resource" "remote"{
connection {
       type = "ssh"
       user = "ec2-user"
       private_key = var.ssh_access_key
       host  = aws_instance.app_server.public_ip
}

provisioner "remote-exec" {
         inline = [
                       "apt update",
                       "apt install python --yes",
                       "git copy https://github.com/Aleryp/aws-homework.git",
                       "cd aws-homework/covidfore",
                       "pip install --upgrade pip",
                       "pip install -r requirements.txt",
                       "python run.py"
                  ]
  }
}
