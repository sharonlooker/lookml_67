view: user_order_facts {
  derived_table: {
    sql:
      SELECT users.id as user_id,
      sum(order_items.sale_price) as lifetime_revenue
      FROM public.users users
      left join public.order_items order_items
      on users.id = order_items.user_id
      group by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  set: detail {
    fields: [user_id, lifetime_revenue]
  }
}
