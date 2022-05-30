variable "target_path" {
  type        = string
  default     = "flux/cluster"
  description = "flux install target path"
}

variable "github_owner" {
  type        = string
  default     = "DBAverage"
  description = "github owner"
}

variable "repository_name" {
  type        = string
  default     = "k8s-talos"
  description = "github repository"
}

variable "github_token" {
  type        = string
  description = "github token"
}