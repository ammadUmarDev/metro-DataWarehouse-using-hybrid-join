DROP TABLE IF EXISTS fact_table, customer, product, store , supplier , time;

CREATE TABLE customer( 
    CUSTOMER_ID varchar(4) NOT NULL,
    CUSTOMER_NAME varchar(30) ,
    CONSTRAINT CUSTOMER_PK PRIMARY KEY (CUSTOMER_ID)
    );         
  
CREATE TABLE product(
    PRODUCT_ID varchar(6) NOT NULL,
    PRODUCT_NAME varchar(30) ,
    CONSTRAINT PRODUCT_PK PRIMARY KEY (PRODUCT_ID)
    );
  
CREATE TABLE store(
    STORE_ID varchar(4) NOT NULL,
    STORE_NAME varchar(30) ,
    CONSTRAINT STORE_PK PRIMARY KEY (STORE_ID)
    );
  
CREATE TABLE supplier(
    SUPPLIER_ID varchar(5) NOT NULL,
    SUPPLIER_NAME varchar(30) ,
    CONSTRAINT SUPPLIER_PK PRIMARY KEY (SUPPLIER_ID)
    );
  
CREATE TABLE time(
    TIME_ID varchar(15) NOT NULL,
    DATTE int (2),
    DAY varchar(10),
    QUARTER varchar(2),
    MONTH int(9),
    YEAR int(4),
    CONSTRAINT TIME_PK PRIMARY KEY (TIME_ID)
    );

CREATE TABLE fact_table(
    TRANSACTION_ID int(8) NOT NULL,
    CUSTOMER_ID varchar(5),
    PRODUCT_ID varchar(8),
    STORE_ID varchar(4),
    SUPPLIER_ID varchar(5),
    TIME_ID varchar(15),
    QUANTITY SMALLINT(10),
    PRICE decimal(5,2),
    SALE decimal (6,2),
    CONSTRAINT FACT_PK PRIMARY KEY (TRANSACTION_ID),
    CONSTRAINT CUSTOMER_FK FOREIGN KEY(CUSTOMER_ID) REFERENCES customer(CUSTOMER_ID),
    CONSTRAINT PRODUCT_FK FOREIGN KEY(PRODUCT_ID) REFERENCES product(PRODUCT_ID),
    CONSTRAINT STORE_FK FOREIGN KEY(STORE_ID) REFERENCES store(STORE_ID),
    CONSTRAINT SUPPLIER_FK FOREIGN KEY(SUPPLIER_ID) REFERENCES supplier(SUPPLIER_ID),
    CONSTRAINT TIME_FK FOREIGN KEY(TIME_ID) REFERENCES time(TIME_ID)
    );