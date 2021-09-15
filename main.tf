terraform {
  required_providers {
    restapi = {
      source = "KirillMeleshko/restapi"
      version = "1.15.0"
    }
  }
}

provider "restapi" {
  uri                  = "http://${var.eckmstr_uri}/_slm/policy"
  debug                = true
  headers              = {"Content-Type" = "application/json"}
  write_returns_object = true
  insecure             = true
  id_attribute         = "/"
  create_method        = "PUT"
  update_method        = "PUT"
  destroy_method       = "PUT"
}

resource "restapi_object" "create_policy" {
  triggers = {
    always_run = "${timestamp()}"
  }
  
  object_id = "sspolicy"
  path = "/daily-snapshots"
  data = "{ \"name\":\"var.data_name\", \"snapshotName\":\"weather-data-policy1\", \"schedule\":\"0 0 0 * * ?\", \"repository\":\"${var.base_path}\",  \"config\":{ \"indices\":[\"weather-data-2016\"] }, \"retention\":{ \"expireAfterUnit\":\"d\" }, \"isManagedPolicy\":\"false\" }" 
}

