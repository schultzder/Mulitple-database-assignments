--grade: 16/25
---------------------------------------------------------------------------------
-- Name       : Derek Schultz
--
-- UserName   : schultzder
--
-- Course     : CS 3630
--              Section 1 (09 AM) 
--              Section 2 (10 AM)
--              Section 3 (02 PM)
--
-- Description: Quiz 4
--              Queries using joins/outer joins, sub-queries, and views
--
-- Date       : April 25, 2018
---------------------------------------------------------------------------------

prompt
prompt 1. Set column format 
Prompt 

Col NIN format a8 heading 'Staff No'
Col FirstName format a11 heading 'First Name'
Col LastName format a10 heading 'Last Name'
Col Name format a15 heading 'Hotel Name'
Col HotelNo format a8 heading 'Hotel No'
Col city format a12 heading 'City'
Col State format a6 heading 'State'
Col hours format 999 heading 'Hours' 
Col Payment format $9,999 heading 'Salary'


set pagesize 20 

-- Column NIN      : string of length 8,  heading: "Staff No"
-- Column FirstName: string of length 11, heading: "First Name"
-- Column LastName : string of length 10, heading "Last Name"
-- Column Name     : string of length 15, heading "Hotel Name"
-- Column HotelNo  : string of length 8,  heading "Hotel No"
-- Column city     : string of length 12, heading "City"
-- Column State    : string of length 6,  heading "State"
-- Column hours    : number of 3 digits,  heading "Hours"
-- Column Payment  : dollar no cents,     heading "Salary"
-- Column "Total Amount of Payments" : dollar no cents


prompt
prompt 2.
prompt For each pay roll record in ContractPayRoll, 
prompt list Hotel No, Hotel Name, payDate and payment,
prompt sorted on Hotel No in descending order,
prompt and then on payDate in ascending order.
prompt PayDate must be in the format Month dd yyyy, 
prompt e.g., April 25 2018 with heading "Pay Date"

Select H1.HotelNo, H1.Name, To_Char(PayDate, 'Mon dd yyyy') as "Pay Date", payment
From ContractPayRoll C
Join AllHotels H1
  on H1.HotelNo = C.HotelNo 
Order by HotelNo desc, PayDate;

incorrect format: -1

pause 

pause
prompt
prompt 3.
prompt For each hotel, 
prompt list Hotel No, Hotel Name, and the total number 
prompt of payments in ContractPayRoll by the hotel 
prompt with heading "Total # of Payments", 
prompt sorted on hotel no.
prompt A zero must be displayed if a hotel has no payments at all.
prompt

Select H1.HotelNo, H1.Name, Count(hours) as "Total # of Payments"
From AllHotels H1
Left Join ContractPayRoll C
       on H1.HotelNo = C.HotelNo 
Group by H1.HotelNo, H1.Name
Order by H1.HotelNo;

pause
prompt
prompt 4.
prompt For each staff who received payments from more than 
prompt one hotel, list first name, last name and the number
prompt of different hotels he/she received payments from
prompt with heading "# Hotels Worked on", 
prompt sorted on NIN.
prompt

incorrect query: -2

Select S.FirstName, S.LastName, Count(unique C.HotelNo) as "# Hotels Worked on"
From AllStaff S
Join ContractPayRoll C
  on S.NIN = C.NIN
Group by S.NIN, S.FirstName, S.LastName
Having count(unique C.HotelNo) > 1
Order by S.NIN;



pause
prompt
prompt 5. 
prompt For each hotel and each staff who received payments from 
prompt the hotel during the last month, list hotel number, hotel 
prompt name, NIN and last name with the total amount of payments 
prompt the staff received last month from the hotel with heading 
prompt "Total Amount of Payments", sorted on NIN and then HotelNo. 
prompt The same query should work for any day.
prompt Ignore the hotels that did not make payments last month 
prompt and the staff who did not receive payments last month.

/*
Sample output

Hotel No Hotel Name      Staff No Last Name  Total Amount of Payments 
-------- --------------- -------- ---------- ------------------------ 
H2801    Country Inn     2135     Rowe                           $350
H3807    Mound View Inn  2135     Rowe                           $250
H2801    Country Inn     5001     Hasker                         $600
*/

Select H.HotelNo, H.Name, S.NIN, S.LastName, Sum(C.Payment)
From AllStaff S
Join ContractPayRoll C
  on S.NIN = C.NIN
Join AllHotels H
  on H.HotelNo = C.HotelNo
Where to_char(PayDate, 'mm yyyy') = to_char(Add_Months(sysDate, -1), 'mm yyyy')
Group by S.NIN, firstname, lastName, H.Name, H.HotelNo;

runtime error: -4


pause
prompt
prompt 6.  
prompt For each staff who did not receive any payments
prompt last month, list NIN, last name, and the total number
prompt of payments the staff has received from all hotels 
prompt with heading "No. of Payments", sorted by NIN. 
prompt A zero should displayed for those staff without any payments.
prompt The same query should work for any day.
prompt 

Select S.NIN, LastName,
	   (Select Count(*)
	    From ContractPayRoll C
		Where S.NIN = C.NIN) "No. of Payments"
From AllStaff S
Where NIN not in 
		(Select C.NIN
		 From ContractPayRoll C
		 Where C.NIN = S.NIN 
		   and to_char(Add_Months(SysDate, -1), 'mm yyyy') = to_char(PayDate, 'mm yyyy'))
Order by S.NIN;


incorrect query: -2
  
prompt 
Prompt 7. Remove all column formatting
prompt 


Clear Col

