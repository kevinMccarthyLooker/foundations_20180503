include: "*.view" # include all the views
#include: "*.dashboard" # include all the lookml dashboards
#
###### Model Level Settings ######
connection: "events_ecommerce"

datagroup: training_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: training_default_datagroup
#^^^^^^ Model Level Settings ^^^^^#

###### Explore Definitions ######
explore: users {}

explore: order_items {
  #To Do: create a user_summary table (e.g. lifetime orders) and join to this explore
  description: "Information about orders including user information"
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }
}
