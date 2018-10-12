-----------------------------------------------------------------------------
-- Name        : Derek Schultz
--
-- UserName    : schultzder
--
-- Date        : 4/6/2018
--
-- Course      : CS 3630
--               Section 
--
-- Assignment 8: 10 points
--               Queries on single tables
--
-- Note        : A booking could be longer than a month, 
--               but not longer than a year.
--
-- Due Date    : Friday, April 6, at 5 PM
--               Drop your UserName_A8.sql to the DropBox on the K: drive.
-----------------------------------------------------------------------------

/*
1.  List the names and addresses of all guests from London 
    (Address contains string "London"),
    sorted by name in ascending order.
	

2.  List all guests whose address is missing.


3.  List all double or family rooms with a price below 40 per night,
    sorted in ascending order of price.

   
4.  For all room types, list the type and the average price, 
    sorted by the average price in descending order.

   
5.  Display the number of different guests (not Guest_No) 
    who have bookings during April 2005
    (bookings that contains at least one day of April 2005).

   
6.  For each guest who has made at least one booking, 
    list the guest number and the total number of bookings 
    the guest has made, sorted by guest number.
   
   
7.  For each hotel that has at least one booking during April 2005
    (bookings that contains at least one day of April 2005),
    list the hotel number, the total number of bookings the hotel 
    has for April 2005 and the latest Date_from for such bookings, 
    sorted by the total number of bookings.

   
8.  List all bookings that start in the current month of the current year.
    The query should work for any month of any year without modification.

   
9.  For each room type of each hotel, list the hotel number, room type, 
    the highest and the lowest room prices for the room type.
    Sort the result by hotel number and then room type.

   
10. For each room type of each hotel with the highest price at least 100 
    or the lowest price at most 30, list the hotel number and room type 
    with the highest and the lowest room prices,
    sorted by hotel_no and the highest price.


Requirements
1.  Your queries should work for any database instances. 
    That is, the results should always be correct after any insertion, 
    deletion, or update.
    You may want to insert more records to test your script. 
    DO NOT include the statements to insert these records in the script file.
   
2.  Select all fields when not specified.

3.  For each query, use the Prompt command to display the query number 
    and the query description.

4.  You must pause between any two queries.
         
5.  Your script file must set the column format at the beginning 
    and clear the column format at the end. 

6.  All column headings should be displayed clearly.

7.  All prices including average, max and min prices should be display 
    in currency format such as $63.20.
   
8.  Unless otherwise specified, all dates should be displayed with format 
    "Month dd yyyy" such as "April 12 2009".

9.  Your script file should have a comment block at the beginning, 
    including your name, date, course, and your UserName.

10. Follow the standard style format. 
    You may lose up to three (3) points on the style.
    
11. No partial credit if a query produces a run time error.

12. Your queries must try to retrieve the requested data. 

*/

Col Guest_Name format a20 heading 'Guest_Name'
Col Address format a40 heading 'Address'
Col Guest_No format a8 heading 'Guest_No'
Col RType format a9 heading 'Room_Type'
Col Price format $999.99 heading 'Price'
Col Hotel_No format a9 heading 'Hotel_No'
Col Room_No format a9 heading 'Room_No'
Col Avg(Price) format $999.99 heading 'Average_Price'
Col Date_From format a16 heading 'Date_From'
Col Date_To format a16 heading 'Date_To'
Col Max(Price) format $999.99 heading 'Max Price'
Col Min(Price) format $999.99 heading 'Min Price'


PROMPT
PROMPT 1.
PROMPT List the names and addresses of all guests from London 
PROMPT (Address contains string "London"),
PROMPT sorted by name in ascending order.
PROMPT

Select Guest_Name, Address
From Guest
Where address like '%London%'
Order by Guest_Name, Guest_Name asc;
pause



PROMPT
PROMPT 2.
PROMPT List all guests whose address is missing.
PROMPT

Select *
From Guest
Where address is null
Order by Guest_Name desc;
pause



PROMPT
PROMPT 3. 
PROMPT List all double or family rooms with a price below 40 per night,
PROMPT sorted in ascending order of price.
PROMPT

Select RType, Price
From Room
Where Price < 40 and (RType = 'Double' or RType = 'Family')
Order by Price asc;
pause



PROMPT
PROMPT 4.  
PROMPT For all room types, list the type and the average price, 
PROMPT sorted by the average price in descending order.
PROMPT

Select RType, Avg(Price)
From Room
Group by RType
Order by Avg(Price) desc;
pause



PROMPT
PROMPT 5.  
PROMPT Display the number of different guests (not Guest_No) 
PROMPT who have bookings during April 2005
PROMPT (bookings that contains at least one day of April 2005).
PROMPT


Select count(unique Guest_No) as "Number of Unique Guests"  
From Booking
Where not Date_From > '30-Apr-05' and not Date_To < '1-Apr-05';
pause



PROMPT
PROMPT 6.
PROMPT For each guest who has made at least one booking, 
PROMPT list the guest number and the total number of bookings 
PROMPT the guest has made, sorted by guest number.
PROMPT

Select Guest_No, count(Date_From) as "No of Bookings"
From Booking
Group by Guest_No
Order by Guest_No;
pause



PROMPT
PROMPT 7.  
PROMPT For each hotel that has at least one booking during April 2005
PROMPT (bookings that contains at least one day of April 2005),
PROMPT list the hotel number, the total number of bookings the hotel 
PROMPT has for April 2005 and the latest Date_from for such bookings, 
PROMPT sorted by the total number of bookings.
PROMPT

Select Hotel_No, count(unique Date_From) as "Total Bookings", To_Char(Max(Date_From), 'Mon dd yyyy') "Latest Date"
From Booking 
Where not Date_From > '30-Apr-05' and not Date_To < '1-Apr-05'
Group by Hotel_No
Order by count(unique Date_From), Max(Date_From);
pause



PROMPT
PROMPT 8.  
PROMPT List all bookings that start in the current month of the current year.
PROMPT The query should work for any month of any year without modification.
PROMPT

Select Hotel_No, Guest_No, To_Char(Date_From, 'Mon dd yyyy') "Date_From", To_Char(Date_To, 'Mon dd yyyy') "Date_To", Room_No 
From Booking
Where Date_From <= Last_Day(SysDate) and  Date_From > Last_Day(Add_Months(SysDate, -1));
pause



PROMPT
PROMPT 9.  
PROMPT For each room type of each hotel, list the hotel number, room type, 
PROMPT the highest and the lowest room prices for the room type.
PROMPT Sort the result by hotel number and then room type.
PROMPT

Select Hotel_No, RType, Max(Price), Min(Price)
From Room
Group by Hotel_No, RType
Order by Hotel_No, RType;
pause



PROMPT
PROMPT 10. 
PROMPT For each room type of each hotel with the highest price at least 100 
PROMPT or the lowest price at most 30, list the hotel number and room type 
PROMPT with the highest and the lowest room prices,
PROMPT sorted by hotel_no and the highest price.
PROMPT

Select Hotel_No, RType, Max(Price), Min(Price)
From Room
Group by Hotel_No, RType
Having Max(Price) >= 100 or Min(Price) <= 30
Order by Hotel_No, Max(Price);
pause 



Clear col





