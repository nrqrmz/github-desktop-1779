with product_total as
(SELECT
  customerid,
  productid,
  round(sum(unitprice * quantity),2) as total_value 
FROM OrderDetails
JOIN Orders USING (orderid)
group by 1, 2),

ranked_prod as 
(SELECT
 	customerid,
 	productid,
 	total_value,
 	rank() over (partition by customerid order by total_value DESC) as rnk
 FROM product_total)


SELECT
  customerid,
  productid,
  total_value as OrderedAmount	
FROM ranked_prod
where rnk = 1 -- this line is the one which is filtering the results 