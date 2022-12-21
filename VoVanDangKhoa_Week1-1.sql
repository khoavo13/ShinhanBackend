-- Bai 1: Viet lenh tao bang
---- 1. Tao bang
create table CAMPUS
(
    CampusID varchar2(5) NOT NULL,
    CampusName varchar2(100) NOT NULL,
    Street varchar2(100),
    City varchar2(100),
    State varchar2(100),
    Zip varchar2(100) NOT NULL,
    Phone varchar2(100) NOT NULL,
    CampusDiscount decimal(2, 2),
    CONSTRAINT campus_pk PRIMARY KEY (CampusID)
);

create table POSITION
(
    PositionID varchar2(5) NOT NULL,
    POSITION varchar2(100) NOT NULL,
    YearlyMembershipFee decimal(7, 2),
    CONSTRAINT position_pk PRIMARY KEY (PositionID)
);

create table MEMBERS
(
    MemberID varchar2(5) NOT NULL,
    LastName varchar2(100) NOT NULL,
    FirstName varchar2(100) NOT NULL,
    CampusAddress varchar2(100),
    CampusPhone varchar2(100),
    CampusID varchar2(5) NOT NULL,
    PositionID varchar2(5) NOT NULL,
    ContractDuration integer,
    CONSTRAINT member_pk PRIMARY KEY (MemberID),
    CONSTRAINT CampusMember_fk foreign key (CampusID)
    references CAMPUS(CampusID),
    CONSTRAINT PositionMember_fk foreign key (PositionID)
    references POSITION(PositionID)
);

create table PRICES
(
    FoodItemTypeID number(20) NOT NULL,
    MealType varchar2(100),
    MealPrice decimal(7,2) NOT NULL,
    CONSTRAINT price_pk PRIMARY KEY (FoodItemTypeID)
);

create table Fooditems
(
    FoodItemID varchar2(5) NOT NULL,
    FoodItemName varchar2(100) NOT NULL,
    FoodItemTypeID number(20) NOT NULL,
    CONSTRAINT fooditems_pk PRIMARY KEY (FoodItemID),
    CONSTRAINT TypeItem_fk foreign key (FoodItemTypeID)
    references PRICES(FoodItemTypeID)
);

create table Orders
(
    OrderID varchar2(5) NOT NULL,
    MemberID varchar2(5) NOT NULL,
    OrderDate varchar2(25) NOT NULL,
    CONSTRAINT orders_pk PRIMARY KEY (OrderID),
    CONSTRAINT MemberOrder_fk foreign key (MemberID)
    references MEMBERS(MemberID)
);

create table OrderLine
(
    OrderID varchar2(5) NOT NULL,
    FoodItemsID varchar2(5) NOT NULL,
    Quantity integer NOT NULL,
    CONSTRAINT orderline_pk PRIMARY KEY (OrderID, FoodItemsID),
    CONSTRAINT order01_fk foreign key (OrderID)
    references Orders(OrderID),
    CONSTRAINT order02_fk foreign key (FoodItemsID)
    references Fooditems(FoodItemID)
);

---- 2. Tao sequence
create sequence Prices_FoodItemTypeID_SEQ;

-- Bai 2: Viet lenh chen du lieu
---- 1. Su dung insert
insert into Campus values ('1','IUPUI', '425 University Blvd.', 'Indianapolis', 'IN','46202', '317-274-4591',.08);
insert into Campus values ('2','Indiana University', '107 S. Indiana Ave.', 'Bloomington', 'IN','47405', '812-855 4848',.07);
insert into Campus values ('3','Purdue University', '475 Stadium Mall Drive', 'West Lafayette', 'IN', '47907', '765 494-1776',.06);

insert into Position values ('1','Lecturer', 1050.50);
insert into Position values ('2','Associate Professor', 900.50);
insert into Position values ('3','Assistant Professor', 875.50);
insert into Position values ('4','Professor', 700.75);
insert into Position values ('5', 'Full Professor', 500.50);

insert into MEMBERS values ('1', 'Ellen', 'Monk', '009 Purnell', '812-123-1234', '2', '5', 12);
insert into MEMBERS values ('2', 'Joe', 'Brady', '008 Statford Hall', '765-234-2345', '3', '2', 10);
insert into MEMBERS values ('3','Dave', 'Davidson', '007 Purnell', '812-345-3456', '2', '3', 10);
insert into MEMBERS values ('4','Sebastian', 'Cole', '210 Rutherford Hall', '765-234-2345', '3', '5', 10);
insert into MEMBERS values ('5','Michael', 'Doo', '66C Peobody', '812-548-8956', '2', '1', 10);
insert into MEMBERS values ('6','Jerome', 'Clark', 'SL 220', '317-274-9766', '1', '1', 12);
insert into MEMBERS values ('7', 'Bob', 'House', 'ET 329', '317-278-9098', '1', '4', 10);
insert into MEMBERS values ('8', 'Bridget','Stanley', 'SI 234', '317-274-5678', '1', '1', 12);
insert into MEMBERS values ('9','Bradley', 'Wilson', '334 Statford Hall', '765-258-2567', '3', '2', 10);

insert into PRICES values (Prices_FoodItemTypeID_SEQ.nextVal,'Beer/Wine', 5.50);
insert into PRICES values (Prices_FoodItemTypeID_SEQ.nextVal, 'Dessert', 2.75);
insert into PRICES values (Prices_FoodItemTypeID_SEQ.nextVal,'Dinner', 15.50);
insert into PRICES values (Prices_FoodItemTypeID_SEQ.nextVal,'Soft Drink', 2.50);
insert into PRICES values (Prices_FoodItemTypeID_SEQ.nextVal,'Lunch', 7.25);

insert into Fooditems values ('10001', 'Lager', 1);
insert into Fooditems values ('10002', 'Red Wine', 1);
insert into Fooditems values ('10003', 'White Wine', 1);
insert into Fooditems values ('10004', 'Coke', 4);
insert into Fooditems values ('10005', 'Coffee', 4);
insert into Fooditems values ('10006', 'Chicken a la King', 3);
insert into Fooditems values ('10007', 'Rib Steak', 3);
insert into Fooditems values ('10008', 'Fish and Chips', 3);
insert into Fooditems values ('10009', 'Veggie Delight', 3);
insert into Fooditems values ('10010', 'Chocolate Mousse', 2);
insert into Fooditems values ('10011', 'Carrot Cake', 2);
insert into Fooditems values ('10012', 'Fruit Cup', 2);
insert into Fooditems values ('10013', 'Fish and Chips', 5);
insert into Fooditems values ('10014', 'Angus Beef Burger', 5);
insert into Fooditems values ('10015', 'Cobb Salad', 5);

insert into Orders values ('1', '9', 'March 5, 2005');
insert into Orders values ('2', '8', 'March 5, 2005');
insert into Orders values ('3', '7', 'March 5, 2005');
insert into Orders values ('4', '6', 'March 7, 2005');
insert into Orders values ('5', '5', 'March 7, 2005');
insert into Orders values ('6', '4', 'March 10, 2005');
insert into Orders values ('7', '3', 'March 11, 2005');
insert into Orders values ('8', '2', 'March 12, 2005');
insert into Orders values ('9', '1', 'March 13, 2005');

insert into OrderLine values ('1','10001',1);
insert into OrderLine values ('1','10006',1);
insert into OrderLine values ('1','10012',1);
insert into OrderLine values ('2','10004',2);
insert into OrderLine values ('2','10013',1);
insert into OrderLine values ('2','10014',1);
insert into OrderLine values ('3','10005',1);
insert into OrderLine values ('3','10011',1);
insert into OrderLine values ('4','10005',2);
insert into OrderLine values ('4','10004',2);
insert into OrderLine values ('4','10006',1);
insert into OrderLine values ('4','10007',1);
insert into OrderLine values ('4','10010',2);
insert into OrderLine values ('5','10003',1);
insert into OrderLine values ('6','10002',2);
insert into OrderLine values ('7','10005',2);
insert into OrderLine values ('8','10005',1);
insert into OrderLine values ('8','10011',1);
insert into OrderLine values ('9','10001',1);

-- Bai 3: Viet lenh truy van
---- 1. Liet ke tat ca constrains
select constraint_name, table_name FROM user_constraints;

---- 2. Liet ke tat ca ten bang
select owner, table_name from all_tables;

---- 3. Liet ke tat ca sequence
select sequence_owner, sequence_name from all_sequences;

---- 4. Query 
select m.FirstName, m.LastName, p.Position, c.CampusName, p.YearlyMembershipFee/12 as Monthly_Dues
from members m, POSITION p, CAMPUS c
where m.CampusID = c.CampusID and m.PositionID = p.PositionID
order by c.CampusName desc, m.Lastname asc;