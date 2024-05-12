variable "ami_id" {
  type    = string
  default = "ami-0735c191cf914754d"
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-058a7514ba8adbb07", "subnet-0dbcd1ac168414927", "subnet-032f5077729435858"]
}
