--grade: 52/60
-----------------------------------------------------------------------------
-- Name    : Derek Schultz
--
-- UserName: schultzder
--
-- Date    : May-04-2018
--
-- Course  : CS 3630
--           Test 2 (60 points)
--
-- Section : 1 (09 AM)
--           2 (10 AM)
--           3 (02 PM)
--         
-----------------------------------------------------------------------------

Prompt 
prompt 1. Make sure the file name is correct. 
prompt    (2 points) 
Prompt 

pause 
prompt
prompt 2. Enter your name and username in the comment block 
prompt    (2 points) 
Prompt 

pause 
Prompt
prompt 3. Formatting columns
Prompt

set pagesize 20


-- Column NIN      : string of length 8,  heading "Staff No"
-- Column FirstName: string of length 11, heading "First Name"
-- Column LastName : string of length 10, heading "Last Name"
-- Column HotelNo  : string of length 8,  heading "Hotel No"
-- Column DOB      : string of length 12, heading "Birth Day"
-- Column Payment  : USA currency without cents, e.g., $1,234
-- Column Average  : USA currency with cents, e.g., $1,234.08

Col NIN format a8 heading 'Staff No'
Col FirstName format a11 heading 'First Name'
Col LastName format a10 heading 'Last Name'
Col DOB format a12 heading 'Birth Day'
Col HotelNo format a8 heading 'Hotel No' 
Col Payment format $9,999 heading 'Salary'
Col Average format $9,999.00 heading 'Average'

pause 
Prompt
Prompt 4. List NIN, FirstName, LastName and DOB of all staff whose birth day
Prompt    is between June 21 1955 and June 26 1965, inclusive, sorted on DOB
Prompt    in ascending order and then on LastName in descending order
Prompt

Select NIN, FirstName, LastName, DOB 
From AllStaff
Where DOB >= '21-Jun-55' and 
	  DOB <= '26-Jun-65'
Order by DOB asc, LastName desc;



pause
Prompt
Prompt 5. For each hotel that has made more than three payments, 
Prompt    list the HotelNo, total number of payments by the hotel
Prompt    and the average payment of all payments by the Hotel,
Prompt    sorted by hotel number. 
Prompt    The heading must be "Count" and "Average".
Prompt

Select C.HotelNo, count(*) as "Count", Avg(Payment) Average
From ContractPayRoll C
Group by HotelNo
Having count(*) > 3
Order by HotelNo;

incorrect formatting: -1

pause
prompt
prompt 6. For each pay roll record in ContractPayRoll, 
prompt    list the FirstName, LastName, payDate and payment,
prompt    sorted on NIN in descending order,
prompt    and then on payDate in ascending order.
prompt    PayDate must be in the format Month dd yyyy, 
prompt    e.g., May 01 2015 with heading "Pay Date"

Select Firstname, LastName, to_char(payDate, 'Mon dd yyyy'), Payment
From ContractPayRoll C
Join AllStaff S
  on S.NIN = C.NIN
Order by C.NIN desc, C.payDate asc;


pause
Prompt
Prompt 7. List NIN, FirstName and LastName of all staff 
Prompt    who have not received any payments in the current 
Prompt    month of the current year, sorted by NIN.
prompt    The same query should work at any time.
prompt 

Select S.NIN, FirstName, LastName 
From AllStaff S
Where S.NIN NOT IN 
		(Select NIN
		 From ContractPayRoll C
		 Where  to_char(PayDate, 'mm yyyy') = to_char(sysDate, 'mm yyyy')) 
Order by S.NIN;

incorrect query: -5

pause
Prompt
Prompt 8. For each staff, list FirstName, LastName and the number of 
Prompt    payments the staff has received from all hotels with heading 
Prompt    "Number of Payments", sorted by NIN.
Prompt    For a staff member without payments, a zero should be displayed. 
Prompt

Select FirstName, LastName, count(C.NIN) as "Number of Payment"
From AllStaff S
Left Join ContractPayRoll C
       on S.NIN = C.NIN
Group by S.NIN, FirstName, LastName
Order by S.NIN;


incorrect sorting: -2

pause 
Prompt 
Prompt 9. Remove column formatting
Prompt 

Clear Col

