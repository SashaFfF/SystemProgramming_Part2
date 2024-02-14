#!/bin/bash
awk '{
  name = $1
  quantity = $2
  price = $3
  
  if (quantity !~ /^[0-9]+$/) {
     print "Некорректное количество для товара " name " в строке " NR ". Количество должно быть числом."
     exit 1;
  }
  
  if (price !~ /^[0-9]+$/) {
     print "Некорректная цена для товара " name " в строке " NR ". Цена должна быть числом."
     exit 1;
  }

  total_quantity[name] += quantity
  total_price[name] += price
  count[name]++
} END {
  for(product_name in total_quantity){
    avg_price = total_price[product_name] / count[product_name]
    printf "Товар: %s, Количество: %d, Средняя цена: %.2f, Общая стоимость: %.2f\n", product_name, total_quantity[product_name], avg_price, total_price[product_name] > "product_result.txt";
  }
}' products.txt
