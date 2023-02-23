resource "datadog_synthetics_test" "tfer--synthetics_snd-r5t-i99" {
  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    is_critical          = "true"
    name                 = "Click on link \"Bags\""

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"aside\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@*[local-name()=\\\"arial-\\\"]=\\\"\\\"]/descendant::*[@href=\\\"/t/bags\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" list-group \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" list-group-item \\\")][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" list-group \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"bags\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"bags\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"bags\\\"]]\"},\"targetOuterHTML\":\"<a class=\\\"list-group-item list-group-item-action\\\" href=\\\"/t/bags\\\">Bags</a>\",\"url\":\"http://${aws_instance.app_server.public_ip}:3000/\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "click"
  }
  
  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    is_critical          = "true"
    name                 = "Click on span \"Datadog Tote\""

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"main\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"a\\\"][1]/*[local-name()=\\\"span\\\"][1]\",\"at\":\"/descendant::*[@itemprop=\\\"name\\\" and @title=\\\"Datadog Tote\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" info \\\")][1]\",\"clt\":\"/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"datadog tote\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"datadog tote\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"datadog tote\\\"]]\"},\"targetOuterHTML\":\"<span class=\\\"info mt-3 d-block\\\" itemprop=\\\"name\\\" title=\\\"Datadog Tote\\\">Datadog Tote</span>\",\"url\":\"http://${aws_instance.app_server.public_ip}:3000/t/bags\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "click"
  }


  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    is_critical          = "true"
    name                 = "Click on button #add-to-cart-button"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"main\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"button\\\"][1]\",\"at\":\"/descendant::*[@name=\\\"button\\\" and @type=\\\"submit\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" input-group-append \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn \\\")]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" input-group-append \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn \\\")]\",\"co\":\"[{\\\"text\\\":\\\"add to cart\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[local-name()=\\\"button\\\"]\"},\"targetOuterHTML\":\"<button name=\\\"button\\\" type=\\\"submit\\\" class=\\\"btn btn-success\\\" id=\\\"add-to-cart-button\\\">\\n                  Add To Cart\\n</button>\",\"url\":\"http://${aws_instance.app_server.public_ip}:3000/products/datadog-tote?taxon_id=3\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "click"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    is_critical          = "true"
    name                 = "Click on button #checkout-link"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"main\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"button\\\"][2]\",\"at\":\"/descendant::*[@name=\\\"checkout\\\" and @type=\\\"submit\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn-lg \\\")]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn-lg \\\")]\",\"co\":\"[{\\\"text\\\":\\\"checkout\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[@id=\\\"checkout-link\\\"]\"},\"targetOuterHTML\":\"<button name=\\\"checkout\\\" type=\\\"submit\\\" onclick=\\\"window.DD_RUM \\u0026amp;\\u0026amp; window.DD_RUM.addUserAction(\\u0026quot;checkout\\u0026quot;, {cartAmount: 12})\\\" class=\\\"btn btn-lg btn-success\\\" id=\\\"checkout-link\\\">\\n        ...\",\"url\":\"http://${aws_instance.app_server.public_ip}:3000/cart?variant_id=1\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "click"
  }

  device_ids = ["chrome.laptop_large", "edge.laptop_large", "firefox.laptop_large"]
  locations  = ["aws:eu-west-1", "pl:eks-529f73e6d21700a972d3f18c719648c0"]
  name       = "Storedog Browser Test"

  options_list {
    accept_self_signed              = "false"
    allow_insecure                  = "false"
    check_certificate_revocation    = "false"
    disable_cors                    = "false"
    disable_csp                     = "false"
    follow_redirects                = "false"
    ignore_server_certificate_error = "false"
    initial_navigation_timeout      = "0"
    min_failure_duration            = "0"
    min_location_failed             = "1"

    monitor_options {
      renotify_interval = "0"
    }

    monitor_priority = "1"
    no_screenshot    = "false"

    retry {
      count    = "0"
      interval = "300"
    }

    rum_settings {
      application_id  = "3be866f8-55b1-49a1-a57a-8cf2266b66e7"
      client_token_id = "92975"
      is_enabled      = "true"
    }

    tick_every = "3600"
  }

  request_definition {
    dns_server_port         = "0"
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    port                    = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "http://${aws_instance.app_server.public_ip}:3000"
  }

  status = "live"
  tags   = ["app:storedog", "env:development"]
  type   = "browser"
}
