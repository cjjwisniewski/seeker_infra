resource "azurerm_cdn_profile" "seeker" {
  name                = "seeker-cityoftraitors-com-cdn-1"
  location            = "global"
  resource_group_name = data.azurerm_resource_group.seeker_rg.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "seeker" {
  name                   = "seeker-cityoftraitors-com-cdn-1"
  profile_name           = azurerm_cdn_profile.seeker.name
  resource_group_name    = data.azurerm_resource_group.seeker_rg.name
  location               = azurerm_cdn_profile.seeker.location
  is_compression_enabled = true
  origin_host_header     = "seekercityoftraitorscom.z20.web.core.windows.net"
  content_types_to_compress = [
    "application/eot",
    "application/font",
    "application/font-sfnt",
    "application/javascript",
    "application/json",
    "application/opentype",
    "application/otf",
    "application/pkcs7-mime",
    "application/truetype",
    "application/ttf",
    "application/vnd.ms-fontobject",
    "application/x-font-opentype",
    "application/x-font-truetype",
    "application/x-font-ttf",
    "application/x-httpd-cgi",
    "application/x-javascript",
    "application/x-mpegurl",
    "application/x-opentype",
    "application/x-otf",
    "application/x-perl",
    "application/x-ttf",
    "application/xhtml+xml",
    "application/xml",
    "application/xml+rss",
    "font/eot",
    "font/opentype",
    "font/otf",
    "font/ttf",
    "image/svg+xml",
    "text/css",
    "text/csv",
    "text/html",
    "text/javascript",
    "text/js",
    "text/plain",
    "text/richtext",
    "text/tab-separated-values",
    "text/x-component",
    "text/x-java-source",
    "text/x-script",
    "text/xml",
  ]
  origin {
    name       = "default-origin-4ba283f4" # This is imported, hence the weird name
    http_port  = 80
    https_port = 443
    host_name  = "seekercityoftraitorscom.z20.web.core.windows.net"
  }
}