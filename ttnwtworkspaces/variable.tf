variable "access_key" {
    type = string
    default = "AKIAQ6OEQFVNRZMCRFBA"
}
variable "secret_key" {
    type = string
    default = "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"
}
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
