select
p.product_id,
product_name,
product_description,
category_id,
weight_class,
supplier_id,
product_status,
list_price,
min_price,
catalog_url,
quantity_on_hand,
warehouse_id
from
product_information p,
inventories i
where
i.product_id = 3001  and
i.product_id = p.product_id


select  /*+ first_rows */
p.product_id,
product_name,
product_description,
category_id,
weight_class,
supplier_id,
product_status,
list_price,
min_price,
catalog_url,
quantity_on_hand,
warehouse_id
from
product_information p,
inventories i
where
category_id = 2  and
i.product_id = p.product_id
