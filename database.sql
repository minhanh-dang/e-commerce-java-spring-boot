DROP DATABASE IF EXISTS `sql_invoicing`;
CREATE DATABASE `sql_invoicing`; 
USE `sql_invoicing`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;
-- Create table
create table ACCOUNTS
(
  USER_NAME VARCHAR(20) not null,
  ACTIVE    BIT not null,
  ENCRYTED_PASSWORD  VARCHAR(128) not null,
  USER_ROLE VARCHAR(20) not null
) ;

alter table ACCOUNTS
  add primary key (USER_NAME) ;
---------------------------------------
create table COUPON
(
  ID        CHAR(20) not null,
  DISCOUNT	INT not null
) ;

alter table COUPON
  add primary key (ID) ;
---------------------------------------
create table PRODUCT
(
  ID        CHAR(20) not null,
  Coupon_Id CHAR(20) not null,
  #IMAGE       longblob,
  NAME        VARCHAR(255) not null,
  DESCRIPTION        VARCHAR(255) not null,
  BRAND        VARCHAR(255) not null,
  PRICE       double precision not null,
  CREATE_DATE datetime not null,
  CONSTRAINT fk_coupon_product FOREIGN KEY (Coupon_Id)  
  REFERENCES coupon(ID)  
) ;

alter table PRODUCT
  add primary key (ID) ;
  
---------------------------------------

create table CARTITEM
(
  ID        CHAR(20) not null,
  Product_Id CHAR(20) not null,
  QUANTITY INT not null,
  CREATE_DATE datetime not null,
  NAME VARCHAR(255) not null,
  DISCOUNT	INT,
  CONSTRAINT fk_coupon_cartitem FOREIGN KEY (Product_Id)  
  REFERENCES Product(ID)  
) ;
  
  alter table CARTITEM
  add primary key (ID) ;
---------------------------------------
create table CATEGORY
(
  ID        CHAR(20) not null,
  Product_Id CHAR(20) not null,
  NAME        VARCHAR(255) not null,
  DISCOUNT	INT,
  CONSTRAINT fk_product_category FOREIGN KEY (Product_Id)  
  REFERENCES product(ID)  
) ;

alter table CATEGORY
  add primary key (ID) ;
---------------------------------------
create table SHOPPINGCART
(
  ID        CHAR(20) not null,
  CartItem_Id CHAR(20) not null,
  NAME        VARCHAR(255) not null,
  DATE	DATETIME NOT NULL,
  TOTALPRICE	DOUBLE,
  ITEMNUMBER	INT,
  CONSTRAINT fk_CartItem_ShoppingCart FOREIGN KEY (CartItem_Id)  
  REFERENCES CARTITEM(ID)  
) ;
alter table SHOPPINGCART
  add primary key (ID) ;
---------------------------------------
create table WISHLIST
(
  ID        CHAR(20) not null,
  CartItem_Id CHAR(20) not null,
  Account_Id CHAR(20) not null,
  DATE	DATETIME NOT NULL,
  CONSTRAINT fk_CartItem_WishList FOREIGN KEY (CartItem_Id)  
  REFERENCES CARTITEM(ID),
  CONSTRAINT fk_Account_WishList FOREIGN KEY (Account_Id)  
  REFERENCES ACCOUNTS(USER_NAME) 
) ;
alter table WISHLIST
  add primary key (ID);
---------------------------------------
create table WISHLISTITEM
(
  ID        CHAR(20) not null,
  CartItem_Id CHAR(20) not null,
  CONSTRAINT fk_CartItem FOREIGN KEY (CartItem_Id)  
  REFERENCES CARTITEM(ID) 
) ;
alter table WISHLISTITEM
  add primary key (ID) ;
---------------------------------------  
insert into Accounts (USER_NAME, ACTIVE, ENCRYTED_PASSWORD, USER_ROLE)
values ('employee1', 1,
'$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', 'ROLE_EMPLOYEE');

insert into Accounts (USER_NAME, ACTIVE, ENCRYTED_PASSWORD, USER_ROLE)
values ('manager1', 1,
'$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', 'ROLE_MANAGER');

----------------
insert into PRODUCT (ID, NAME, DESCRIPTION, BRAND, PRICE, CREATE_DATE)
values ('S001', 'Oreo Cookies', 'Best seller', 'Oreo', 100, sysdate());

insert into PRODUCT (ID, NAME, DESCRIPTION, BRAND, PRICE, CREATE_DATE)
values ('S002', 'Cocacola','Best seller', 'Cocacola', 50, sysdate());

insert into PRODUCT (ID, NAME, DESCRIPTION, BRAND, PRICE, CREATE_DATE)
values ('S003', 'Snickers','Best seller', 'Mars', 120, sysdate());

insert into PRODUCT (ID, NAME, DESCRIPTION, BRAND, PRICE, CREATE_DATE)
values ('S004', 'Kit Kat','Best seller', 'Nestlé', 120, sysdate());

insert into PRODUCT (ID, NAME, DESCRIPTION, BRAND, PRICE, CREATE_DATE)
values ('S005', 'Vinamilk Farm','Best seller', 'Vinamilk', 110, sysdate());
---------------------------------------

