---------------------------------------------------------------------------------
-- Name       : Qi Yang
--
-- UserName   : YangQ
--
-- Course     : CS 3630
--
-- Section    : 9 AM, 10 AM and 2 PM
--
-- Description: Quiz 3
--
-- Date       : April 13, 2018
---------------------------------------------------------------------------------

Prompt
Prompt Quiz 3
Prompt

Prompt
Prompt 1. Drop tables
Prompt    You may get some error messages saying
Prompt    "table or view does not exist"
Prompt

Drop table ContractPayRoll;
Drop table AllStaff;

pause

Prompt
Prompt 2. Create tables
Prompt

Prompt
Prompt Create table AllStaff
prompt

Create table AllStaff(
   NIN           Char(4) Primary Key,
   FirstName     Varchar2(20) not null,
   LastName      Varchar2(20) not null,
   StreetAddress Varchar(20) Not null,
   City          Varchar2(20) not null,
   State         Char(2) not null,
   ZipCode       Char(5),
   DOB           Date,
   Gender        Char Check (Gender in ('M', 'F')) not null);

desc AllStaff
pause

Prompt
Prompt Create table ContractPayRoll
prompt

Create table ContractPayRoll (
   ContractNo Char(3),
   NIN        Char(4) References AllStaff,
   Hours      Number not null,
   HotelNo    Char(5) not null,
   City       Varchar2(15),
   PayDate    Date Not null,
   Primary key (ContractNo, NIN, PayDate));

desc ContractPayRoll
pause


Prompt
Prompt Insert records to table AllStaff
prompt


insert into AllStaff
values('1135', 'Tom', 'Scanlan', '15 Pioneer Dr', 'Platteville', 'WI', '53818', '21-Jun-55', 'M');

insert into AllStaff
values('1057', 'Joe', 'Clifton', 'Grandview St', 'Platteville', 'WI', '53818', '21-Jun-55', 'M');

insert into AllStaff
values('1068', 'Lisa', 'Landgraf', '123 Westhill St', 'Dubuque', 'IA', '52001', '04-Dec-74', 'F');

insert into AllStaff
values('2007', 'Yan', 'Shi', '500 Maple Rd', 'Belmont', 'WI', '53818', Null, 'F');

pause


Prompt
Prompt Insert records to table ContractPayRoll
prompt

insert into ContractPayRoll
values('C01', '1135', 25, 'H1801', 'Platteville', '11-Apr-15');

insert into ContractPayRoll
values('C03', '1135', 20, 'H1807', 'Platteville', '11-Apr-15');

insert into ContractPayRoll
values('C01', '1057', 15, 'H1801', 'Platteville', '11-Apr-15');

insert into ContractPayRoll
values('C14', '1135', 40, 'H6404', 'Dubuque', '11-Apr-15');

insert into ContractPayRoll
values('C55', '1068', 22, 'H7908', 'Madison', '11-Apr-15');

insert into ContractPayRoll
values('C55', '1068', 18, 'H7908', 'Madison', '18-Apr-15');

insert into ContractPayRoll
values('C09', '1135', 39, 'H1801', 'Platteville', '04-Apr-15');

insert into ContractPayRoll
values('C55', '1135', 50, 'H7908', 'Madison', '25-Apr-15');


-- Current month of current year 
insert into ContractPayRoll
values('C01', '1135', 25, 'H1801', 'Platteville', '11-Apr-2018');

insert into ContractPayRoll
values('C03', '1135', 20, 'H1807', 'Platteville', '11-Apr-2018');

insert into ContractPayRoll
values('C01', '1057', 15, 'H1801', 'Platteville', '11-Apr-2018');

insert into ContractPayRoll
values('C14', '1135', 40, 'H6404', 'Dubuque', '11-Apr-2018');

insert into ContractPayRoll
values('C55', '1068', 22, 'H7908', 'Madison', '11-Apr-2018');

insert into ContractPayRoll
values('C55', '1068', 18, 'H7908', 'Madison', '18-Apr-2018');

insert into ContractPayRoll
values('C09', '1135', 39, 'H1801', 'Platteville', '04-Apr-2018');

insert into ContractPayRoll
values('C55', '1135', 50, 'H7908', 'Madison', '25-Apr-2018');

commit;

pause


Select *
From AllStaff;

Pause

Select *
From ContractPayRoll;
