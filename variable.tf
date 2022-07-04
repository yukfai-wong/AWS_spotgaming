variable "keypair_name" {
  description = "Key Pairs"
  type        = string
  default     = "macbookpro"
}
variable "keypair_dir" {
  description = "Location"
  type        = string
  default     = "/Users/yukfai-wong/Documents/AWSKey/macbookpro.pem"
}


variable "user_data" {
  description = "file dir for the user data"
  type        = string
  default     = "./userdata.ps1"
}

variable "target_vpc" {
  description = "target vpc id"
  type        = string
  default     = "vpc-f5b31488"
}

variable "target_instance" {
  description = "target instance"
  type        = string
  default     = "g4dn.xlarge"
}