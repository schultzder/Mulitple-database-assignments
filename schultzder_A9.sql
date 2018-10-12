-----------------------------------------------------------------------------
-- Name        : Derek Schultz
--
-- UserName    : schultzder
--
-- Date        : 4/16/2018
--
-- Course      : CS 3630
--               Section 
--
-- Assignment 9: 15+5 points
--               Queries on multiple tables
--
-- Note        : A booking could be longer than a month, 
--               but not longer than a year.
--
-- Due Date    : Friday, April 20, at 5 PM
--               Drop your UserName_A9.sql to the DropBox on the K: drive.
-----------------------------------------------------------------------------

/*

1. List all rooms (all details) of hotel Glasgow, sorted by hotel number and then price.

2. List all double or family rooms (all details) of hotel Glasgow with a price below 50 per night 
   sorted in ascending order of price.

3. For each hotel that has at least 6 bookings, list the hotel name, hotel number and the number of bookings, 
   sorted by the number of bookings in ascending order.

4. For each hotel, list the hotel name, hotel number and the number of bookings during the current month of 
   the current year (bookings that covers at least one day of the current month of the current year). 
   A zero should be displayed for hotels that don't have any bookings during the current month, 
   and the query should work for any month of any year.

5. List all guests (all details) currently staying at hotel Grosvenor in London, sorted on Guest_no. 
   The query should work for any day.

6. For each hotel that does not have any bookings, display the hotel details, sorted on Hotel_No.

7. List the rooms (all details) that are currently unoccupied at hotel Grosvenor in London. 
   The query should produce correct results today and any day in the future.

8. For each hotel in London, list the hotel number, hotel name, and number of Family rooms with a price below 180. 
   Display a zero for hotels in London that do not have specified rooms.

9. List the guest number, guest name and the number of bookings for the current year, sorted by guest_no. 
   Display a zero for guests who don't have any bookings for the current year. 
   Your query should work for any year. Booking could be longer than one year.

10. For each hotel that has at least one booking, list the Hotel number, Hotel name, and the most commonly booked room type for the hotel 
    (the number of bookings is the largest) with the count of bookings for that room type. 
    Notice that multiple types may have the same largest number of bookings, and all such types should be listed. 

*/


Col Guest_Name format a20 heading 'Guest_Name'
Col Address format a20 heading 'Address'
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
Col Name format a10 heading 'Hotel Name'


PROMPT 
PROMPT 1. 
PROMPT List all rooms (all details)
PROMPT of hotel Glasgow, sorted by hotel number and then price.
PROMPT 

Select * 
From Room R
Join Hotel H
  on R.Hotel_No = H.Hotel_No 
  and H.name = 'Glasgow'
Order by R.Hotel_No, price;
pause

PROMPT 
PROMPT 2.
PROMPT List all double or family rooms (all details) of hotel Glasgow
PROMPT with a price below 50 per night sorted in ascending order of price
PROMPT 

Select * 
From Room R
Join Hotel H
  on R.Hotel_No = H.Hotel_No
  and Price < 50
  and H.name = 'Glasgow'
Where RType = 'Family' or RType = 'Double'
Order by Price asc;
pause 

PROMPT 
PROMPT 3.
PROMPT For each hotel that has at least 6 bookings, list the hotel name, hotel number and the number of bookings
PROMPT sorted by the number of bookings in ascending order
PROMPT 

Select H.name, H.Hotel_No, count(B.Hotel_No) as "Number of Bookings"
From Hotel H
left Join Booking B
       on H.Hotel_No = B.Hotel_No
Group by H.Hotel_No, H.name
Having count(B.Hotel_No) >= 6 
Order by count(B.Hotel_No) asc;
pause 

PROMPT 
PROMPT 4. 
PROMPT For each hotel, list the hotel name, hotel number and the number of bookings durring the current month
PROMPT of the current year (bookings that covers at least one day of the current month of the current year).
PROMPT A zero should be displayed for hotels that do not have any bookings durring the current month,
PROMPT and the query should work for any month of any year. 
PROMPT 

Select name, H.Hotel_No, count(B.Hotel_No) as "Number of bookings this month"
From Hotel H
left Join Booking B
       on H.Hotel_No = B.Hotel_No
	   and (To_Char(Date_From, 'yyyy') <= To_Char(sysDate, 'yyyy')
	   and  To_Char(Date_From, 'mm') <= To_char(sysDate, 'mm') 
	   and  To_Char(Date_To, 'mm') >= To_Char(sysDate, 'mm') 
	   and  To_Char(Date_To, 'yyyy') >= To_Char(sysDate, 'yyyy'))
Group by name, H.Hotel_No;

pause

PROMPT 
PROMPT 5. 
PROMPT List all guests (all details) currently staying at hotel Grosvenor in London,
PROMPT sorted on Guest_No. The query should work for any day. 
PROMPT

Select unique G.*
From Guest G, Hotel H, Booking B
Where H.Name = 'Grosvenor'
and H.Hotel_No = B.Hotel_No
and To_Char(Date_From, 'mm dd yyyy') <= To_Char(sysDate, 'mm dd yyyy') 
and To_Char(Date_To, 'mm dd yyyy') >= To_Char(sysDate, 'mm dd yyyy')
and B.Guest_No = G.Guest_No
Order by G.Guest_No;

pause 

PROMPT 
PROMPT 6. 
PROMPT For each hotel that does not have any bookings, display the hotel details,
PROMPT sorted on Hotel_No.
PROMPT 

Select H.Hotel_No, H.Name, Address, Count (*) as "Hotels with no bookings"
From Hotel H
Left Join Booking B
       on H.Hotel_No = B.Hotel_No 
Where B.Hotel_No is null
Group by H.Hotel_No, Name, Address
Order by H.Hotel_No;  

pause


PROMPT 
PROMPT 7.
PROMPT List the rooms (all details) that are currently unoccupied at 
PROMPT hotel Grosvenor in London. The query should produce correct results today and 
PROMPT any day in the future.
PROMPT 

Select R.* 
From Room R
Join Hotel H
  on R.Hotel_No = H.Hotel_No 
  and H.Name = 'Grosvenor'
  and H.Address = 'London'
  and R.Room_No Not In
		(Select Room_No
		 From Booking B
		 Join Hotel H1
		   on B.Hotel_No = H1.Hotel_No 
		   and H1.Name = 'Grosvenor'
		   and H1.Address = 'London'
		   and SysDate between Date_From and Date_To);
	 
PROMPT 
PROMPT 8. 
PROMPT For each hotel in London, list the hotel number, hotel name, and number
PROMPT of family rooms with a price below 180. Display a zero for hotels in London
PROMPT that do not have specified rooms.
PROMPT 

Select H.Hotel_No, H.Name, Count(Unique R.Room_No) as "Family Rooms under $180.00"
From Hotel H
Left Join Room R
	   on H.Hotel_No = R.Hotel_No
	   and R.Rtype = 'Family'
	   and Price < 180
Where Address like '%London%'
Group by H.Hotel_No, H.Name;

pause

PROMPT 
PROMPT 9.
PROMPT List the guest number, guest name and the number of bookings for the current year, sorted by guest_no. 
PROMPT Display a zero for guests who do not have any bookings for the current year. 
PROMPT Your query should work for any year. Booking could be longer than one year.
	  
Select G.Guest_No, G.Guest_Name, Count(B.Guest_No) as "Bookings this year"
From Guest G
Left Join Booking B
       on G.Guest_No = B.Guest_No
       and (To_Char(Date_From, 'yyyy') = To_Char(sysDate, 'yyyy')
	   or To_Char(Date_To, 'yyyy') = To_Char(sysDate, 'yyyy')
	   or to_number(To_char(Date_from, 'yyyy')) < to_number(To_Char(SysDate, 'yyyy'))
       and to_number(To_Char(Date_to, 'yyyy')) > to_number(To_Char(SysDate, 'yyyy')))
Group by G.Guest_No, G.Guest_Name
Order by G.Guest_No;

pause

PROMPT 
PROMPT 10.
PROMPT For each hotel that has at least one booking, list the Hotel number, Hotel name, 
PROMPT and the most commonly booked room type for the hotel 
PROMPT (the number of bookings is the largest) with the count of bookings for that room type. 
PROMPT Notice that multiple types may have the same largest number of bookings, and all such types should be listed. 
PROMPT 

Select H.Hotel_No, H.Name, R.RType, Count(*) as "Number of Bookings"
From Hotel H
Join Room R
  on H.Hotel_No = R.Hotel_No 
Join Booking B 
  on H.Hotel_No = B.Hotel_No 
  and B.Room_No = R.Room_No 
Group by H.Hotel_No, H.Name, R.Rtype
Having Count(*) >= ALL 
		(Select Count(*)
		 From Room R1
		 Join Booking B1
		   on R1.Hotel_No = B1.Hotel_No 
		   and B1.Room_No = R1.Room_No 
		 Where R1.Hotel_No = H.Hotel_No 
		 Group by R1.RType)
Order by H.Hotel_No, RType;


Clear Col



