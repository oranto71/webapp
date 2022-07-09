
variable "instance_type" {
    type = map(string)
    default = {
      default = "t2.micro"
      dev = "m5.large"
      stage = "t3.medium"
      qa = "t2.large"
      prod = "c5.large"
    }
    
    }
