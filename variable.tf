variable "security_group" {
    type = list(number)
    default = [ 8000,9000,8080,80,22,23,443,360,300 ]
}
variable "instance_type" {
    type = string
    default = "t2.micro" 
}
variable "ami" {
    type = string
    default = "ami-0533f2ba8a1995cf9" 
}
