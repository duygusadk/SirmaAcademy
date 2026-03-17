-------3----------------------------------------------
---3.1----
SELECT name,contact_email FROM Clients

-----3.2----
SELECT distinct name,status 
FROM Clients C
JOIN Invoices I ON I.client_id=C.client_id
WHERE status='Overdue'

----3.3------
SELECT* FROM Payments
WHERE payment_method='Bank Transfer'

-----3.4------
Select sum(amount) as 'total revenue received from paid invoices'
from Payments

----3.5-------
SELECT status,COUNT(Invoice_id) as'invoices per status'
FROM Invoices
GROUP BY status

---------------------4-----------------------------------------------
-------------4.1-----
SELECT*
FROM Transactions T
JOIN Suppliers S ON S.supplier_id=T.supplier_id
WHERE S.supplier_id=3

----------4.2-----------
SELECT TOP 5 name,salary
FROM Employees
order by salary desc

--------------4.3----------
SELECT name,hire_date
FROM Employees
where year(getdate())-year(hire_date)<=3

-----------------------4.4------------
SELECT SUM(amount) FROM TRANSACTIONS

--------4.5------
SELECT MAX(amount) as 'max',MIN(amount) as 'min' FROM Invoices

--------------5------------------------------------------------------------


----------5.3----------
SELECT name,sum(P.amount ) as 'total paid amount'
FROM Clients C
JOIN Invoices I ON I.client_id=C.client_id
JOIN Payments P ON P.invoice_id=I.invoice_id
group by name

------------5.4-----------
select invoice_id,amount+vat
from Invoices

--------------5.5--------------
select payment_method,sum(amount) as 'total payments'
from Payments
group by payment_method

------------------5.6----------
CREATE PROC dbo.invoicesByID(@ID INT)
as
SELECT *
FROM Invoices
WHERE invoice_id=@ID

EXEC invoicesByID @ID=5

-------------------5.8----------------
SELECT TOP 3 name,sum(P.amount) as 'total payment'
FROM Clients C
JOIN Invoices I ON I.client_id=C.client_id
JOIN Payments P ON P.invoice_id=I.invoice_id
group by name
order by 2 desc

