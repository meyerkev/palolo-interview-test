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

# Note: In a perfect world, the resource policy would retroactively include the bucket objects and name
# Since that perfect world doesn't actually exist, the answer is that this policy is scoped to our bucket and objects
# by way of being a resource policy
variable "bucket_policy" {
    type = string
    description = "A json blob of an existing poilcy to attach as a resource policy on the bucket"
    default = null
}

# TODO: Possibly allow bucket lifecycles