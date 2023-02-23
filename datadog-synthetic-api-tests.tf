##-----------------------------------------##
##   Create Datadog Synthetics HTTP test   ##
## ----------------------------------------##

# Create a new Datadog Synthetics API/HTTP test on storedog!
resource "datadog_synthetics_test" "storedog_api" {
  depends_on = [
    aws_instance.app_server
  ]
  type    = "api"
  subtype = "http"
  request_definition {
    method = "GET"
    url    = "http://${aws_instance.app_server.public_ip}:3000"
  }
  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }
  locations = ["aws:eu-west-1"]
  options_list {
    #Test Interval in seconds
    tick_every = 120

    retry {
      count    = 2
      interval = 300
    }

    monitor_options {
      renotify_interval = 120
    }
  }
  name    = "An API test on Storedog"
  message = "Notify @aronday"
  tags    = ["owner:aron.day", "env:development", "app:storedog"]

  status = "live"
}