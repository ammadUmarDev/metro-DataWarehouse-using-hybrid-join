#Q1
SELECT fact_table.PRODUCT_ID, fact_table.SUPPLIER_ID,
SUM(case when time.QUARTER = "Q1" then fact_table.sale end) as Sales_Q1,
SUM(case when time.QUARTER = "Q2" then fact_table.sale end) as Sales_Q2,
SUM(case when time.QUARTER = "Q3" then fact_table.sale end) as Sales_Q3,
SUM(case when time.QUARTER = "Q4" then fact_table.sale end) as Sales_Q4
FROM fact_table , time 
GROUP BY fact_table.SUPPLIER_ID
ORDER BY fact_table.PRODUCT_ID ASC;
#Q1 ENDS

#Q3
select sales.PRODUCT_ID, p.PRODUCT_NAME, sum(sales.QUANTITY) as 'SALE(Weekend)'
from fact_table sales 
join product p
on (sales.PRODUCT_ID = p.Product_ID)
join time t
on (sales.TIME_ID = t.TIME_ID and t.DAY = "SATURDAY" or t.DAY = "SUNDAY")
group by sales.PRODUCT_ID
order by sum(sales.QUANTITY) DESC
LIMIT 5;
#Q3 ENDS

#Q4	
select a.PRODUCT_ID, a.PRODUCT_NAME, a.Sale_Q1 AS 'Q1 SALES', b.Sale_Q2 AS 'Q2 SALES', c.Sale_Q3 AS 'Q3 SALES', d.Sale_Q4 AS 'Q4 SALES' 
from (select sales.PRODUCT_ID , p.PRODUCT_NAME, sum(sales.SALE) as 'Sale_Q1'
    from fact_table sales 
    join product p
    on (sales.PRODUCT_ID = p.Product_ID )
    join time t
    on (sales.TIME_ID = t.TIME_ID and t.QUARTER = "Q1" or t.YEAR = "2016")
    group by sales.PRODUCT_ID) a
JOIN (select sales.PRODUCT_ID , p.PRODUCT_NAME, sum(sales.SALE) as 'Sale_Q2'
    from fact_table sales 
    join product p
    on (sales.PRODUCT_ID = p.Product_ID )
    join time t
    on (sales.TIME_ID = t.TIME_ID and t.QUARTER = "Q2" or t.YEAR = "2016")
    group by sales.PRODUCT_ID) b
JOIN (select sales.PRODUCT_ID , p.PRODUCT_NAME, sum(sales.SALE) as 'Sale_Q3'
    from fact_table sales 
    join product p
    on (sales.PRODUCT_ID = p.Product_ID )
    join time t
    on (sales.TIME_ID = t.TIME_ID and t.QUARTER = "Q3" or t.YEAR = "2016")
    group by sales.PRODUCT_ID) c
JOIN (select sales.PRODUCT_ID , p.PRODUCT_NAME, sum(sales.SALE) as 'Sale_Q4'
    from fact_table sales 
    join product p
    on (sales.PRODUCT_ID = p.Product_ID )
    join time t
    on (sales.TIME_ID = t.TIME_ID and t.QUARTER = "Q4" or t.YEAR = "2016")
    group by sales.PRODUCT_ID) d 
on (a.PRODUCT_ID = b.PRODUCT_ID and a.PRODUCT_ID = c.PRODUCT_ID and a.PRODUCT_ID = d.PRODUCT_ID) 
group by a.PRODUCT_ID order by a.PRODUCT_ID asc;
#Q4 ENDS

#Q5
SELECT COUNT(distinct(t.TRANSACTION_ID)) AS 'Transaction Count', COUNT(distinct(f.TRANSACTION_ID)) AS 'Sales Count'  FROM transactions t, fact_table f;
#Transaction Count	    Sales Count
#10000	            	9990
#Sales count is lower due to duplication in dataset
#Q5 ENDS

#Q6
	DELIMITER $$
    DROP PROCEDURE IF EXISTS QueryView;
	CREATE PROCEDURE QueryView()
	BEGIN
        DROP TABLE IF EXISTS sales_mv;
        CREATE TABLE sales_mv (PRODUCT_ID VARCHAR(6) NOT NULL, STORE_ID  VARCHAR(4) NOT NULL, SALES VARCHAR(10) NOT NULL);
        INSERT INTO sales_mv SELECT PRODUCT_ID , STORE_ID, SUM(SALE) FROM fact_table GROUP BY PRODUCT_ID;
	 END;
	 $$
	 DELIMITER ;
	 CALL QueryView();
	 SELECT *  from sales_mv;   
#Q6 ENDS