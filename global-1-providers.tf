terraform {
  backend "gcs" {
    bucket      = "phoenixflameanew08302025"
    prefix      = "terraform/08302025-global-alb"
    credentials = "phoenixflame-470701-03a6424392d4.json"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}
