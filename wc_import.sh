#!/bin/bash
echo -e "Grabbing your products now!"
while IFS='|' read -r images product_title short_description category weight regular_price stock_qty manage_stock
do
wp media import "${images}" --featured_image  --post_id=$(wp wc product create --name="${product_title}" --short_description='${short_description}' --categories='${category}' --weight="${weight}" --regular_price="${regular_price}"  --stock_quantity="${stock_qty}" --manage_stock="${manage_stock}" --allow-root --user=danielhand | awk '{print $4}') --user=danielhand --allow-root
done < product-new.txt



###### NOTES ######

# Dimensions can be imported by using --dimensions='{"length":"100","height":"100","width":"100"}' however, this causes issues when pulling the values from the CSV as variables need to be enclosed in " ". Need to try and change the way the values are displayed from the CSV.

# STILL NEED TO DO
# Gallery images
# Categories
