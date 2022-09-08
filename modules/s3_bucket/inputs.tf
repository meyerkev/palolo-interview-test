variable "bucket_name" {
    type = string
    description = "The name of the bucket"
}

variable "encrypted" {
    type = bool
    description = "Is the bucket encrypted?"
    default = true
    
}

variable  "public" {
    type = bool
    description = "Is the bucket allowed to be public? (Also set bucket_acl=public)"
    default = false
}

variable "bucket_tags" {
    type = map(string)
    description = "How to tag the bucket"
    default = {}
}

variable "kms_key_arn" {
    type = string
    description = "(Ignored if encypted = false) the arn to encrypt the bucket with"
    default = null
}

# TODO: Permit random grants
variable "bucket_acl" {
    type = string
    description = <<EOF
The pre-built acl we want to set the bucket on. 

Valid values are: 
[private public-read public-read-write authenticated-read aws-exec-read log-delivery-write]
EOF
    default = "private"
}

# TODO: It may prove true that bucket policies and policy grants in particular can be standardized enough to make inputs be practical
# For now, I'm going to leave this as a TODO

# TODO: Possibly allow bucket lifecycles