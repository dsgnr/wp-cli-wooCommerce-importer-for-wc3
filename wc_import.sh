#!/bin/bash
echo -e "Grabbing your products now!"
while IFS='|' read -r images product_title short_description category weight regular_price stock_qty manage_stock
do
wp media import "${images}" --featured_image  --post_id=$(wp wc product create --name="${product_title}" --short_description='${short_description}' --categories='${category}' --weight="${weight}" --regular_price="${regular_price}"  --stock_quantity="${stock_qty}" --manage_stock="${manage_stock}" --allow-root --user=danielhand | awk '{print $4}') --user=danielhand --allow-root
done < product-new.txt
