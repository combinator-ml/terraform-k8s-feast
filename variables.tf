variable "name_prefix" {
  description = "Prefix to be used when naming the different components of Feast"
  default     = "combinator"
}

variable "namespace" {
  description = "(Optional) The namespace to install into. Defaults to feast."
  type        = string
  default     = "feast"
}
