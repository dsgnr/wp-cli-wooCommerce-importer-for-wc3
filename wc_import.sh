#!/bin/bash
echo -e "Grabbing your products now!"

OLDIFS=$IFS
while IFS='|' read -r sku images product_title short_description cats weight regular_price stock_qty manage_stock length height width
do
DIMS=({\"length\":\"${length}\"\,\"width\":\"${width}\"\,\"height\":\"${height}\"})
echo ${DIMS[@]}


IFS=", "
read -a CATEGORIES <<<$cats
#reset IFS
IFS=$OLDIFS
CATS=([{\"id\":${CATEGORIES[0]}},{\"id\":${CATEGORIES[1]}}])
echo ${CATS[@]}

echo SKU = ${sku}
echo Image = ${images}
echo Title = ${product_title}
echo Desc = ${short_description}
echo Weight = ${weight}
echo Price = ${regular_price}
echo Stock Qty = ${stock_qty}
echo Manage Stock = ${manage_stock}


wp media import "${images}" --featured_image  --post_id=$(wp wc product create --sku="${sku}" --name="${product_title}" --short_description="${short_description}" --weight="${weight}" --regular_price="${regular_price}"  --stock_quantity="${stock_qty}" --manage_stock="${manage_stock}" --dimensions=${DIMS[@]} --categories=${CATS[@]} --allow-root --user=siteadmin | awk '{print $4}') --user=siteadmin --allow-root
IFS=$OLDIFS
done < product-new-final.txt
