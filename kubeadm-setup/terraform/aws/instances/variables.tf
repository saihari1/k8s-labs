variable "ami_id" {
  type    = string
  default = "ami-04b70fa74e45c3917"
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-0578640ffb3d497fe", "subnet-01483b41d7300ff42", "subnet-096b78110a39a544e"]
}
