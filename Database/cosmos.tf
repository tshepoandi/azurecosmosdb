resource "azurerm_cosmosdb_account" "blog_cosmos" {
  name                = "intern-blog-db"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.main.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableServerless"  # Optional if you're using serverless
  }
}

resource "azurerm_cosmosdb_sql_database" "blog_db" {
  name                = "blog"
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.blog_cosmos.name
}

# resource "azurerm_cosmosdb_sql_container" "posts" {
#   name                = "posts"
#   resource_group_name = azurerm_resource_group.main.name
#   account_name        = azurerm_cosmosdb_account.blog_cosmos.name
#   database_name       = azurerm_cosmosdb_sql_database.blog_db.name
#   partition_key_path  = "/authorId"

#   indexing_policy {
#     indexing_mode = "consistent"
#   }
# }
