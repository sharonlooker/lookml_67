view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

#################### AGE RELATED DIMENSIONS ###############

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: is_adult {
    type: yesno
    sql: ${age} >= 18;;
  }

  dimension: age_tiers {
    type: tier
    tiers: [0,10,20,30,40,60,80]
    style: integer
    sql: ${age} ;;
  }

###########################################################

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week,
      day_of_year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: days_as_user {
    label: "Days as User"
    type: number
    sql: DATEDIFF('day',${created_raw}, ${order_items.created_raw}) ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    label: "Count Users"
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
  }

  measure: average_age {
    type: average
    sql: ${age} ;;
  }
}
