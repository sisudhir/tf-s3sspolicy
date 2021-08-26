terraform {
  required_providers {
    restapi = {
      source = "KirillMeleshko/restapi"
      version = "1.15.0"
    }
  }
}

provider "restapi" {
  uri                  = "http://192.168.1.93:32560/_slm/policy"
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
  object_id = "sspolicy"
  path = "/daily-snapshots"
  data = "{ \"name\":\"weather-data\", \"snapshotName\":\"weather-data-policy1\", \"schedule\":\"0 0 0 * * ?\", \"repository\":\"eck-ss\",  \"config\":{ \"indices\":[\"weather-data-2016\"] }, \"retention\":{ \"expireAfterUnit\":\"d\" }, \"isManagedPolicy\":\"false\" }" 
}


resource "restapi_object" "exec_policy" {
  depends_on = [restapi_object.create_policy]
  object_id = "sspolicyexec"
  path = "/policy/daily-snapshots/_execute"
  data = ""
}
