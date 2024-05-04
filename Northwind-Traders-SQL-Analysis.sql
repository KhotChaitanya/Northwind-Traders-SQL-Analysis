




                         --Queries based on 'NORTHWIND' database



--1- Find the number of orders sent by each shipper.
SELECT SH.CompanyName, COUNT(OD.OrderID) NumberOfOrders
FROM Orders OD
JOIN Shippers SH ON OD.ShipVia = SH.ShipperID
GROUP BY SH.CompanyName
ORDER BY 2 DESC

--2- Find the number of orders sent by each shipper, sent by each employee
SELECT SH.CompanyName, EP.FirstName+ ' ' +EP.LastName EmployeeName, COUNT(OD.OrderID) NumberOfOrders
FROM Orders OD
JOIN Shippers SH ON OD.ShipVia = SH.ShipperID
JOIN Employees EP ON OD.EmployeeID = EP.EmployeeID
GROUP BY SH.CompanyName, EP.FirstName+ ' ' +EP.LastName
ORDER BY 3 DESC

--3- Find  name  of  employees who has registered more than 100 orders.
SELECT EP.FirstName+ ' ' +EP.LastName EmployeeName, COUNT(OD.OrderID) NumberOfOrders
FROM Orders OD
JOIN Employees EP ON OD.EmployeeID = EP.EmployeeID
GROUP BY EP.FirstName+ ' ' +EP.LastName
HAVING COUNT(OD.OrderID) > 100
ORDER BY 2 DESC

--4-Find if the employees "Davolio" or "Fuller" have registered more than 25 orders.
SELECT EP.FirstName+ ' ' +EP.LastName EmployeeName, COUNT(OD.OrderID) NumberOfOrders
FROM Orders OD
JOIN Employees EP ON OD.EmployeeID = EP.EmployeeID
WHERE EP.LastName = 'Davolio' OR EP.LastName = 'Fuller'
GROUP BY EP.FirstName+ ' ' +EP.LastName
HAVING COUNT(OD.OrderID) > 25

--5-Find the customer_id and name of customers who had placed orders more than one time and how many times they have placed the order
SELECT CT.CustomerID, CT.CompanyName, COUNT(OD.OrderID) TotalOders
FROM Orders OD
JOIN Customers CT ON OD.CustomerID = CT.CustomerID
GROUP BY  CT.CustomerID, CT.CompanyName
HAVING COUNT(OD.OrderID) > 1

--6-Select all the orders where the employee’s city and order’s ship city are same.
SELECT OD.*
FROM Orders OD
JOIN Employees EP ON OD.EmployeeID = EP.EmployeeID
WHERE EP.City = OD.ShipCity

--7-Create a report that shows the order ids and the associated employee names for orders that shipped after the required date.
SELECT OD.OrderID, EP.FirstName+ ' ' +EP.LastName EmployeeName, OD.ShippedDate, OD.RequiredDate
FROM Orders OD
JOIN Employees EP ON OD.EmployeeID = EP.EmployeeID
WHERE OD.ShippedDate > OD.RequiredDate

--8-Create a report that shows the total quantity of products ordered fewer than 200.
SELECT PD.ProductName, SUM(OD.Quantity) TotalQuantity
FROM Products PD
JOIN [Order Details] OD ON PD.ProductID = OD.ProductID
GROUP BY PD.ProductName
HAVING COUNT(OD.OrderID) < 200
ORDER BY 2 DESC

--9-Create a report that shows the total number of orders by Customer since December 31, 1996 and the NumOfOrders is greater than 15. 
SELECT CT.CompanyName, COUNT(OD.OrderID) TotalOrders
FROM Orders OD
JOIN Customers CT ON OD.CustomerID = CT.CustomerID
WHERE OrderDate >= '1996-12-31 00:00:00.000'
GROUP BY CT.CompanyName
HAVING COUNT(OD.OrderID) > 15

--10-Create a report that shows the company name, order id, and total price of all products of which Northwind
-- has sold more than $10,000 worth.
SELECT CT.CompanyName, OD.OrderID, SUM(ODS.UnitPrice * ODS.Quantity) TotalPrice
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
GROUP BY CT.CompanyName, OD.OrderID
HAVING SUM(ODS.UnitPrice * ODS.Quantity) > 10000
ORDER BY TotalPrice DESC

--11-Create a report showing the Order ID, the name of the company that placed the order,
--and the first and last name of the associated employee. Only show orders placed after January 1, 1998 
--that shipped after they were required. Sort by Company Name.
SELECT OD.OrderID, CT.CompanyName,EP.FirstName+ ' ' +EP.LastName EmployeeName, OD.ShippedDate, OD.RequiredDate
FROM Orders OD
JOIN Customers CT ON OD.CustomerID = CT.CustomerID
JOIN Employees EP ON OD.EmployeeID = EP.EmployeeID
WHERE OD.OrderDate > '1998-01-01 00:00:00.000'
AND OD.ShippedDate > OD.RequiredDate
GROUP BY OD.OrderID, CT.CompanyName,EP.FirstName+ ' ' +EP.LastName, OD.ShippedDate, OD.RequiredDate

--12-Get the phone numbers of all shippers, customers, and suppliers
SELECT SS.Phone ShippersPhone, CT.Phone CustomersPhone, SPS.Phone SuppliersPhone
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
JOIN Shippers SS ON OD.ShipVia = SS.ShipperID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
JOIN Products PD ON ODS.ProductID = PD.ProductID
JOIN Suppliers SPS ON PD.SupplierID = SPS.SupplierID

--13-Create a report showing the contact name and phone numbers for all employees,customers, and suppliers.
SELECT EP.FirstName+ ' ' +EP.LastName EmployeeName, EP.HomePhone EmpPhoneNo, CT.ContactName CustomerName, CT.Phone CustomerPhoneNO, 
SS.ContactName SupplierName, SS.Phone SupplierPhoneNO
FROM Employees EP
JOIN Orders OD ON EP.EmployeeID = OD.EmployeeID
JOIN Customers CT ON OD.CustomerID = CT.CustomerID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
JOIN Products PT ON ODS.ProductID = PT.ProductID
JOIN Suppliers SS ON PT.SupplierID = SS.SupplierID

--14-Fetch all the orders for a given customer’s phone number 030-0074321.
SELECT *
FROM Orders OD
JOIN Customers CT ON OD.CustomerID = CT.CustomerID
WHERE CT.Phone = '030-0074321'

--15-Fetch all the products which are available under Category ‘Seafood’.
SELECT *
FROM Products PT
JOIN Categories CA ON PT.CategoryID = CA.CategoryID
WHERE CA.CategoryName = 'Seafood'

--16-Fetch all the products which are supplied by a company called ‘Pavlova, Ltd.’
SELECT *
FROM Products PT
JOIN Suppliers SS ON PT.SupplierID = SS.SupplierID
WHERE SS.CompanyName = 'Pavlova, Ltd.'

--17-All orders placed by the customers belong to London city.
SELECT *
FROM Orders OD
JOIN Customers CT ON OD.CustomerID = CT.CustomerID
WHERE CT.City = 'London'

--18-All orders placed by the customers not belong to London city.
SELECT *
FROM Orders OD
JOIN Customers CT ON OD.CustomerID = CT.CustomerID
WHERE CT.City != 'London'

--19-All the orders placed for the product Chai.
SELECT *
FROM Orders OD
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
JOIN Products PT ON ODS.ProductID = PT.ProductID
WHERE PT.ProductName = 'Chai'

--20-Find the name of the company that placed order 10290.
SELECT CT.CompanyName
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
WHERE OD.OrderID = 10290

--21-Find the Companies that placed orders in 1997
SELECT CT.CompanyName
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
WHERE YEAR(OD.OrderDate) = '1997'

--22-Get the product name , count of orders processed 
SELECT PT.ProductName, COUNT(*) OrderProcessed
FROM Products PT
JOIN [Order Details] ODS ON ODS.ProductID = PT.ProductID
JOIN Orders OD ON OD.OrderID = ODS.OrderID
WHERE OD.ShippedDate IS NOT NULL
GROUP BY PT.ProductName
ORDER BY OrderProcessed DESC

--23-Get the top 3 products which has more orders
SELECT TOP 3 PT.ProductName, COUNT(*) OrderProcessed
FROM Products PT
JOIN [Order Details] ODS ON ODS.ProductID = PT.ProductID
JOIN Orders OD ON OD.OrderID = ODS.OrderID
WHERE OD.ShippedDate IS NOT NULL
GROUP BY PT.ProductName
ORDER BY OrderProcessed DESC

--24-Get the list of employees who processed the order “chai”
SELECT EP.FirstName+ ' ' +EP.LastName EmployeeName
FROM Employees EP
JOIN Orders OD ON EP.EmployeeID = OD.EmployeeID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
JOIN Products PT ON ODS.ProductID = PT.ProductID
WHERE PT.ProductName = 'Chai'

--25-Get the shipper company who processed the order categories “Seafood” 
SELECT SH.CompanyName, CTS.CategoryName
FROM Shippers SH
JOIN Orders OD ON SH.ShipperID = OD.ShipVia
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
JOIN Products PT ON ODS.ProductID = PT.ProductID
JOIN Categories CTS ON PT.CategoryID = CTS.CategoryID
WHERE CTS.CategoryName = 'Seafood'

--26-Get category name , count of orders processed by the USA employees 
SELECT CTS.CategoryName, COUNT(*) OrdersProcessed
FROM Categories CTS
JOIN Products PT ON CTS.CategoryID = PT.CategoryID
JOIN [Order Details] ODS ON PT.ProductID = ODS.ProductID
JOIN Orders OD ON ODS.OrderID = OD.OrderID
JOIN Employees EP ON OD.EmployeeID = EP.EmployeeID
WHERE EP.Country = 'USA'
GROUP BY CTS.CategoryName
ORDER BY OrdersProcessed DESC

--27-Select CategoryName and Description from the Categories table sorted by CategoryName.
SELECT CTS.CategoryName, CTS.Description
FROM Categories CTS
ORDER BY CTS.CategoryName

--28-Select ContactName, CompanyName, ContactTitle, and Phone from the Customers table sorted byPhone.
SELECT CT.ContactName, CT.CompanyName, CT.ContactTitle, CT.Phone
FROM Customers CT
ORDER BY CT.Phone

--29-Create a report showing employees' first and last names and hire dates sorted from newest to oldest employee
SELECT EP.FirstName, EP.LastName, EP.HireDate
FROM Employees EP
ORDER BY EP.HireDate DESC

--30-Create a report showing Northwind's orders sorted by Freight from most expensive to cheapest. Show OrderID, 
--OrderDate, ShippedDate, CustomerID, and Freight
SELECT OD.OrderID, OD.OrderDate, OD.ShippedDate, OD.CustomerID, OD.Freight
FROM Orders OD
ORDER BY OD.Freight DESC

--31-Select CompanyName, Fax, Phone, HomePage and Country from the Suppliers table sorted by Country in descending 
--order and then by CompanyName in ascending order
SELECT SS.CompanyName, SS.Fax, SS.Phone, SS.HomePage, SS.Country
FROM Suppliers SS
ORDER BY SS.Country DESC, SS.CompanyName ASC

--32-Create a report showing all the company names and contact names of Northwind's customers in Buenos Aires
SELECT CT.CompanyName, CT.ContactName, CT.City
FROM Customers CT
WHERE CT.City = 'Buenos Aires'

--33-Create a report showing the product name, unit price and quantity per unit of all products that are out of stock
SELECT PT.ProductName, PT.UnitPrice, PT.QuantityPerUnit, PT.UnitsInStock
FROM Products PT
WHERE PT.UnitsInStock = 0

--34-Create a report showing the order date, shipped date, customer id, and freight of all orders placed on May 19, 1997
SELECT OD.OrderDate, OD.ShippedDate, OD.CustomerID, OD.Freight
FROM Orders OD
WHERE OD.OrderDate = '1997-05-01 00:00:00.000'

--35-Create a report showing the first name, last name, and country of all employees not in the United States.
SELECT EP.FirstName, EP.LastName, EP.Country
FROM Employees EP
WHERE EP.Country != 'USA'

--36-Create a report that shows the city, company name, and contact name of all customers who are in cities that begin with "A" or "B."
SELECT CT.City, CT.CompanyName, CT.ContactName
FROM Customers CT
WHERE CT.City LIKE 'A%' OR CT.City LIKE 'B%'

--37-Create a report that shows all orders that have a freight cost of more than $500.00.
SELECT *
FROM Orders OD
WHERE OD.Freight > 500

--38-Create a report that shows the product name, units in stock, units on order, and reorder level of all
-- products that are up for reorder
SELECT PT.ProductName, PT.UnitsInStock, PT.UnitsOnOrder, PT.ReorderLevel
FROM Products PT
WHERE PT.UnitsInStock + PT.UnitsOnOrder <= PT.ReorderLevel

--39-Create a report that shows the company name, contact name and fax number of all customers that have a fax number.
SELECT CT.CompanyName, CT.ContactName, CT.Fax
FROM Customers CT
WHERE CT.Fax IS NOT NULL

--40-Create a report that shows the first and last name of all employees who do not report to anybody
SELECT EP.FirstName, EP.LastName, EP.ReportsTo
FROM Employees EP
WHERE EP.ReportsTo IS NULL

--41-Create a report that shows the company name, contact name and fax number of all customers that have a fax number, 
--Sort by company name.
SELECT CT.CompanyName, CT.ContactName, CT.Fax
FROM Customers CT
WHERE CT.Fax IS NOT NULL
ORDER BY CT.CompanyName

--42-Create a report that shows the city, company name, and contact name of all customers who are in cities 
--that begin with "A" or "B." Sort by contact name in descending order 
SELECT CT.City, CT.CompanyName, CT.ContactName
FROM Customers CT
WHERE CT.City LIKE 'A%' OR CT.City LIKE 'B%'
ORDER BY CT.ContactName DESC

--43-Create a report that shows the first and last names and birth date of all employees born in the 1950s
SELECT EP.FirstName, EP.LastName, EP.BirthDate
FROM Employees EP
WHERE YEAR(EP.BirthDate) BETWEEN 1950 AND 1959

--44-Create a report that shows the shipping postal code, order id, and order date for all orders with a ship postal code 
--beginning with "02389".
SELECT OD.ShipPostalCode, OD.OrderID, OD.OrderDate
FROM Orders OD
WHERE OD.ShipPostalCode LIKE '02389%'

--45-Create a report that shows the contact name and title and the company name for all customers whose contact title
-- does not contain the word "Sales".
SELECT CT.ContactName, CT.ContactTitle
FROM Customers CT
WHERE CT.ContactTitle NOT LIKE '%Sales%'

--46-Create a report that shows the first and last names and cities of employees from cities other than Seattle
-- in the state of Washington.
SELECT EP.FirstName, EP.LastName, EP.City
FROM Employees EP
WHERE EP.City != 'Seattle' AND EP.Region = 'WA'

--47-Create a report that shows the company name, contact title, city and country of all customers in Mexico 
--or in any city in Spain except Madrid.
SELECT CT.CompanyName, CT.ContactTitle, CT.City, CT.Country
FROM Customers CT
WHERE CT.Country = 'Mexico' OR CT.Country = 'Spain' AND CT.City != 'Madrid'

--48-List of Employees along with the Manager
SELECT EP.FirstName+ ' ' +EP.LastName EmployeeName, MP.FirstName+ ' ' +MP.LastName ManagerName
FROM Employees EP
LEFT JOIN Employees MP ON EP.ReportsTo = MP.EmployeeID

--49-List of Employees along with the Manager and his/her title
SELECT EP.FirstName+ ' ' +EP.LastName EmployeeName, EP.Title, MP.FirstName+ ' ' +MP.LastName ManagerName, MP.Title
FROM Employees EP
LEFT JOIN Employees MP ON EP.ReportsTo = MP.EmployeeID

--50-Provide Agerage Sales per order
SELECT AVG(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) AverageSalesPerOrder
FROM [Order Details] ODS

--51-Employee wise Agerage Freight
SELECT OD.EmployeeID, AVG(OD.Freight) AverageFreight
FROM Orders OD
GROUP BY OD.EmployeeID
ORDER BY AverageFreight DESC

-- OR
--SELECT AVG(OD.Freight) AverageFreight
--FROM Orders OD
--GROUP BY OD.EmployeeID
--ORDER BY AverageFreight DESC

--52-Agerage Freight per employee
SELECT  EP.FirstName+ ' ' +EP.LastName EmployeeName, AVG(OD.Freight) AverageFreight
FROM Orders OD
JOIN Employees EP ON OD.EmployeeID = EP.EmployeeID
GROUP BY EP.EmployeeID, EP.FirstName+ ' ' +EP.LastName
ORDER BY AverageFreight DESC

--53-Average no. of orders per customer
SELECT AVG(CO.ORDERCOUNT) AS AverageOrderPerCustomer
FROM (
	SELECT OD.CustomerID, COUNT(OD.OrderID) AS ORDERCOUNT
	FROM Orders OD
	GROUP BY OD.CustomerID
) AS CO

--54-AverageSales per product within Category
SELECT CTS.CategoryName, AVG(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) AverageSalesPerProduct
FROM [Order Details] ODS
JOIN Products PT ON ODS.ProductID = PT.ProductID
JOIN Categories CTS ON PT.CategoryID = CTS.CategoryID
GROUP BY CTS.CategoryName
ORDER BY AverageSalesPerProduct DESC

--55-PoductName which have more than 100 no.of UnitsinStock
SELECT PT.ProductName
FROM Products PT
WHERE PT.UnitsInStock > 100

--56-Query to Provide Product Name and Sales Amount for Category Beverages
SELECT PT.ProductName, ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount) SalesAmount
FROM Products PT
JOIN [Order Details] ODS ON PT.ProductID = ODS.ProductID
JOIN Categories CTS ON PT.CategoryID = CTS.CategoryID
WHERE CTS.CategoryName = 'Beverages'
ORDER BY SalesAmount DESC

--57-Query That Will Give  CategoryWise Yearwise number of Orders
SELECT CTS.CategoryName, YEAR(OD.OrderDate) OrderYear, COUNT(DISTINCT OD.OrderID) NoOfOrders
FROM Orders OD
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
JOIN Products PT ON ODS.ProductID = PT.ProductID
JOIN Categories CTS ON PT.CategoryID = CTS.CategoryID
GROUP BY CTS.CategoryName, YEAR(OD.OrderDate)

--58-Query to Get ShipperWise employeewise Total Freight for shipped year 1997
SELECT OD.EmployeeID, SUM(OD.Freight) TotalFreight
FROM Orders OD
JOIN Shippers SH ON OD.ShipVia = SH.ShipperID
WHERE YEAR(OD.ShippedDate) = '1997'
GROUP BY SH.ShipperID, OD.EmployeeID
ORDER BY TotalFreight DESC

--59-Query That Gives Employee Full Name, Territory Description and Region Description
SELECT EP.FirstName+ ' ' +EP.LastName EmployeeName, TT.TerritoryDescription, RG.RegionDescription
FROM Employees EP
JOIN EmployeeTerritories EPT ON EP.EmployeeID = EPT.EmployeeID
JOIN Territories TT ON EPT.TerritoryID = TT.TerritoryID
JOIN Region RG ON TT.RegionID = RG.RegionID

--60-Query That Will Give Managerwise Total Sales for each year 
SELECT MP.FirstName+ ' ' +MP.LastName ManagerName, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales, YEAR(OD.OrderDate) EachYear
FROM [Order Details] ODS
JOIN Orders OD ON ODS.OrderID = OD.OrderID
JOIN Employees EP ON OD.EmployeeID = EP.EmployeeID
JOIN Employees MP ON EP.EmployeeID = MP.ReportsTo
GROUP BY MP.EmployeeID, MP.FirstName+ ' ' +MP.LastName, YEAR(OD.OrderDate)
ORDER BY YEAR(OD.OrderDate)

--61-Names of customers to whom we are sellinng less than average sales per cusotmer
WITH SalesPerCustomer AS (
SELECT CT.CustomerID, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
GROUP BY CT.CustomerID
), AverageSales AS (
SELECT AVG(SPC.TotalSales) AverageSales
FROM SalesPerCustomer SPC
)
SELECT CT.CompanyName
FROM Customers CT
JOIN SalesPerCustomer SPC ON CT.CustomerID = SPC.CustomerID
CROSS JOIN AverageSales AVS
WHERE SPC.TotalSales < AVS.AverageSales

--62-Query That Gives Average Freight Per Employee and Average Freight Per Customer
WITH AvgEmp AS (
SELECT EP.FirstName+ ' ' +EP.LastName EmployeeName, AVG(OD.Freight) AverageFreightPerEMP
FROM Employees EP
JOIN Orders OD ON EP.EmployeeID = OD.EmployeeID
GROUP BY EP.FirstName+ ' ' +EP.LastName
), AvgCust AS (
SELECT CT.CompanyName, AVG(OD.Freight) AverageFreightPerCust
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
GROUP BY CT.CompanyName
) 
SELECT AE.AverageFreightPerEMP, AC.AverageFreightPerCust
FROM AvgEmp AE, AvgCust AC
ORDER BY AE.AverageFreightPerEMP DESC, AC.AverageFreightPerCust DESC

--63-Query That Gives Category Wise Total Sale Where Category Total Sale < the Average Sale Per Category
WITH ProductList AS (
SELECT CTS.CategoryName ,SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales
FROM [Order Details] ODS
JOIN Products PT ON ODS.ProductID = PT.ProductID
JOIN Categories CTS ON PT.CategoryID = CTS.CategoryID
GROUP BY CTS.CategoryName
), AverageList AS (
SELECT PL.CategoryName, AVG(PL.TotalSales) AverageSales
FROM ProductList PL
GROUP BY PL.CategoryName
)
SELECT PL.CategoryName, PL.TotalSales, AL.AverageSales
FROM ProductList PL, AverageList AL
WHERE PL.TotalSales < AL.AverageSales

--64-Query That Provides Month No and Month OF Total Sales < Average Sale for Month for Year 1997
WITH MonthList AS (
SELECT MONTH(OD.OrderDate) MonthNo, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales
FROM [Order Details] ODS
JOIN Orders OD ON ODS.OrderID = OD.OrderID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY MONTH(OD.OrderDate)
), AverageMonthList AS (
SELECT ML.MonthNo, AVG(ML.TotalSales) AverageSales
FROM MonthList ML
GROUP BY ML.MonthNo
)
SELECT ML.MonthNo, ML.TotalSales, AML.AverageSales
FROM MonthList ML, AverageMonthList AML
WHERE ML.TotalSales < AML.AverageSales

--65-Find out the contribution of each employee towards the total sales done by Northwind for selected year
DECLARE @selectedYear INT = '1997';

WITH SalesList AS (
SELECT SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales
FROM [Order Details] ODS
JOIN Orders OD ON ODS.OrderID = OD.OrderID
WHERE YEAR(OD.OrderDate) = @selectedYear
), EmployeeList AS (
SELECT EP.FirstName+ ' ' +EP.LastName EmployeeName, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) EmployeeSales
FROM Employees EP
JOIN Orders OD ON EP.EmployeeID = OD.EmployeeID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
WHERE YEAR(OD.OrderDate) = @selectedYear
GROUP BY EP.FirstName+ ' ' +EP.LastName
)
SELECT EL.EmployeeName, EL.EmployeeSales, (EL.EmployeeSales / SL.TotalSales) * 100 AS ContributionPercentage
FROM SalesList SL, EmployeeList EL
ORDER BY 3 DESC

--66-Give the Customer names that contribute 80% of the total sale done by Northwind for given year
WITH SalesList AS (
SELECT SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales
FROM [Order Details] ODS
JOIN Orders OD ON ODS.OrderID = OD.OrderID
WHERE YEAR(OD.OrderDate) = '1997'
), CustomerList AS (
SELECT CT.CompanyName, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) AS CustomerSales
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY CT.CompanyName
), CumulativeSales AS(
SELECT CL.CompanyName, CL.CustomerSales, (CL.CustomerSales / SL.TotalSales) AS CumulativeSalesPercentage
FROM CustomerList CL, SalesList SL
GROUP BY CL.CompanyName, CL.CustomerSales, SL.TotalSales
)
SELECT CSL.CompanyName, CSL.CustomerSales, CSL.CumulativeSalesPercentage
FROM CumulativeSales CSL
WHERE CSL.CumulativeSalesPercentage <= 0.8
ORDER BY 3 DESC

--67-Top 3 performing employees by freight cost for given year
SELECT TOP 3 EP.FirstName+ ' ' +EP.LastName EmployeeName, SUM(OD.Freight) TotalFreightCost
FROM Employees EP
JOIN Orders OD ON EP.EmployeeID = OD.EmployeeID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY EP.FirstName+ ' ' +EP.LastName
ORDER BY 2 DESC

--68-Find the bottom 5 customers per product based on Sales Amount
SELECT TOP 5 CT.CompanyName, PT.ProductName, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
JOIN Products PT ON ODS.ProductID = PT.ProductID
GROUP BY CT.CompanyName, PT.ProductName
ORDER BY 3

--69-Display first and the last row of the table
WITH NumberRows AS (
SELECT *, ROW_NUMBER() OVER (ORDER BY PT.ProductID) AS FirstRow,
ROW_NUMBER() OVER (ORDER BY PT.ProductID DESC) AS LastRow
FROM Products PT
)
SELECT NR.ProductID, NR.ProductName, NR.SupplierID, NR.CategoryID, NR.QuantityPerUnit, NR.UnitPrice,
NR.UnitsInStock, NR.UnitsOnOrder, NR.ReorderLevel, NR.Discontinued
FROM NumberRows NR
WHERE NR.FirstRow = 1 OR NR.LastRow = 1
ORDER BY NR.ProductID

--70-Display employee doing highest sale and lowest sale in each year
WITH EmployeeSales AS (
SELECT EP.FirstName+ ' ' +EP.LastName EmployeeName, YEAR(OD.OrderDate) Year,
SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales
FROM Employees EP
JOIN Orders OD ON EP.EmployeeID = OD.EmployeeID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
GROUP BY EP.FirstName+ ' ' +EP.LastName, YEAR(OD.OrderDate)
), RankedSales AS (
SELECT ES.Year, ES.EmployeeName, ES.TotalSales,
ROW_NUMBER() OVER (PARTITION BY ES.Year ORDER BY ES.TotalSales DESC) AS SalesAsc,
ROW_NUMBER() OVER (PARTITION BY ES.Year ORDER BY ES.TotalSales) AS SalesDesc
FROM EmployeeSales ES
)
SELECT RS.Year,
MAX(CASE WHEN RS.SalesAsc = 1 THEN RS.EmployeeName END) AS EmployeeWithMaxSales,
MAX(CASE WHEN RS.SalesAsc = 1 THEN RS.TotalSales END) AS HighestSales,
MAX(CASE WHEN RS.SalesDesc = 1 THEN RS.EmployeeName END) AS EmployeeWithMinSales,
MAX(CASE WHEN RS.SalesDesc = 1 THEN RS.TotalSales END) AS LowestSales
FROM RankedSales RS
GROUP BY RS.Year
ORDER BY RS.Year

--71-Top 3 products of each employee by sales for given year
WITH ProductList AS (
SELECT EP.FirstName+ ' ' +EP.LastName EmployeeName, PT.ProductName,
SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales
FROM Employees EP
JOIN Orders OD ON EP.EmployeeID = OD.EmployeeID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
JOIN Products PT ON ODS.ProductID = PT.ProductID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY EP.FirstName+ ' ' +EP.LastName, PT.ProductName
), RankedList AS (
SELECT PL.EmployeeName, PL.ProductName, PL.TotalSales,
ROW_NUMBER() OVER (PARTITION BY PL.EmployeeName ORDER BY PL.TotalSales DESC) SalesRank
FROM ProductList PL
)
SELECT RL.EmployeeName, RL.ProductName, RL.TotalSales
FROM RankedList RL
WHERE RL.SalesRank <= 3
ORDER BY RL.EmployeeName, RL.SalesRank

--72-Query That Will Give territorywise number of Orders for given region for given year
SELECT TT.TerritoryDescription, COUNT(OD.OrderID) NumberOfOrders
FROM Orders OD
JOIN Employees EP ON OD.EmployeeID = EP.EmployeeID
JOIN EmployeeTerritories EPT ON EP.EmployeeID = EPT.EmployeeID
JOIN Territories TT ON EPT.TerritoryID = TT.TerritoryID
JOIN Region RG ON TT.RegionID = RG.RegionID
WHERE RG.RegionDescription = 'Eastern' AND YEAR(OD.OrderDate) = '1997'
GROUP BY TT.TerritoryDescription
ORDER BY NumberOfOrders DESC

--73-Display sales amount by category for given year
SELECT CG.CategoryName, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales
FROM [Order Details] ODS
JOIN Orders OD ON ODS.OrderID = OD.OrderID
JOIN Products PT ON ODS.ProductID = PT.ProductID
JOIN Categories CG ON PT.CategoryID = CG.CategoryID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY CG.CategoryName
ORDER BY TotalSales DESC

--74-Find  name  of customers who has registered orders less than 10 times.
SELECT CTS.CompanyName, COUNT(OD.OrderID) NoOfOrders
FROM Customers CTS
JOIN Orders OD ON CTS.CustomerID = OD.CustomerID
GROUP BY CTS.CompanyName
HAVING COUNT(OD.OrderID) < 10
ORDER BY 2 DESC

--75-Regions with the Sale in the range of +/- 30% of average sale per Region for year 1997...
WITH RegionSales As (
SELECT RG.RegionDescription, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales
FROM [Order Details] ODS
JOIN Orders OD ON ODS.OrderID = OD.OrderID
JOIN Employees EP ON OD.EmployeeID = EP.EmployeeID
JOIN EmployeeTerritories EPT ON EP.EmployeeID = EPT.EmployeeID
JOIN Territories TT ON EPT.TerritoryID = TT.TerritoryID
JOIN Region RG ON TT.RegionID = RG.RegionID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY RG.RegionDescription
), AverageSales AS (
SELECT AVG(RS.TotalSales) AverageSales
FROM RegionSales RS
)
SELECT RS.RegionDescription, RS.TotalSales
FROM RegionSales RS, AverageSales AVS
WHERE RS.TotalSales BETWEEN AVS.AverageSales * 0.7 AND AVS.AverageSales * 1.3
ORDER BY RS.TotalSales DESC

--76-Top 5 countries based on Order Count for year 1998...
SELECT TOP 5 CT.Country, COUNT(OD.OrderID) OrderCount
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY CT.Country
ORDER BY OrderCount DESC

--77-Category-wise Sale along with deviation % wrt average sale per category for year 1996...
WITH CategorySales AS (
SELECT CTS.CategoryName, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) TotalSales
FROM Orders OD
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
JOIN Products PT ON ODS.ProductID = PT.ProductID
JOIN Categories CTS ON PT.CategoryID = CTS.CategoryID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY CTS.CategoryName
), AverageSales AS (
SELECT AVG(CS.TotalSales) AvgSales
FROM CategorySales CS
)
SELECT CS.CategoryName, CS.TotalSales, ((CS.TotalSales - AVS.AvgSales) / AVS.AvgSales) * 100 AS DeviationPercentage
FROM CategorySales CS, AverageSales AVS
ORDER BY DeviationPercentage DESC

--78-Count of orders by Customers which are shipped in the same month as ordered...
SELECT CT.CompanyName CustomerName, COUNT(OD.OrderID) CountOfOrders
FROM Orders OD
JOIN Customers CT ON OD.CustomerID = CT.CustomerID
WHERE MONTH(OD.OrderDate) = MONTH(OD.ShippedDate) AND YEAR(OD.OrderDate) = YEAR(OD.ShippedDate) 
GROUP BY CT.CompanyName
ORDER BY 2 DESC

--79-Average Demand Days per Order per country for year 1997...
SELECT CT.Country, AVG(DATEDIFF(DAY,OD.OrderDate, OD.ShippedDate)) AS AvgDemandDays
FROM Customers CT
JOIN Orders OD ON OD.CustomerID = CT.CustomerID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY CT.Country
ORDER BY AvgDemandDays DESC

--80-Create the report as Country, Classification, Product Count, Average Sale per Product, Threshold... 
--Classification will be based on Sales and as follows -
--Top if the sale is 1.5 times the average sale per product...
--Excellent if the sale is between 1.2 and 1.5 times the average sale per product...
--Acceptable if the sale is between 0.8 to 1.2 time the average sale per product...
--Need Improvement if the sale is 0.5 to 0.8 times the average sale per product...
--Discontinue for remaining products...
--Produce this report for year 1998..
WITH SalesData AS (
SELECT CT.Country, PT.ProductID, COUNT(PT.ProductID) AS ProductCount, 
SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) AS TotalSales
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
JOIN Products PT ON ODS.ProductID = PT.ProductID
WHERE YEAR(OD.OrderDate) = 1997
GROUP BY CT.Country, PT.ProductID
), OverAllSales As (
SELECT AVG(TotalSales) AS AvgSales
FROM SalesData
), AvgOfAvgSales AS (
SELECT AVG(AvgSales) AS AvgOfAvgSales
FROM OverAllSales
), ClassifiedData AS (
SELECT SD.*, OAS.AvgSales AS OverAllAvgSales,
	CASE
		WHEN SD.TotalSales >= 1.5 * AAS.AvgOfAvgSales THEN 'Top'
        WHEN SD.TotalSales < 1.5 * AAS.AvgOfAvgSales AND SD.TotalSales >= 1.2 * AAS.AvgOfAvgSales THEN 'Excellent'
        WHEN SD.TotalSales < 1.2 * AAS.AvgOfAvgSales AND SD.TotalSales >= 0.8 * AAS.AvgOfAvgSales THEN 'Acceptable'
        WHEN SD.TotalSales < 0.8 * AAS.AvgOfAvgSales AND SD.TotalSales >= 0.5 * AAS.AvgOfAvgSales THEN 'Need Improvement'
        ELSE 'Discontinue'
	END AS Classification
FROM SalesData SD, OverAllSales OAS, AvgOfAvgSales AAS
)
SELECT CD.Country, CD.Classification, CD.ProductCount, CD.TotalSales, CD.Classification AS Threshold
FROM ClassifiedData CD
ORDER BY CD.Country, CD.Classification;

--81-Top 30% products in each Category by their Sale for year 1997...
WITH SalesData AS (
SELECT CTS.CategoryID, PT.ProductID, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) AS TotalSales
FROM [Order Details] ODS
JOIN Orders OD ON ODS.OrderID = OD.OrderID
JOIN Products PT ON ODS.ProductID = PT.ProductID
JOIN Categories CTS ON PT.CategoryID = CTS.CategoryID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY CTS.CategoryID, PT.ProductID
), RankedData AS (
SELECT SD.CategoryID, SD.ProductID, SD.TotalSales,
ROW_NUMBER() OVER (PARTITION BY SD.CategoryID ORDER BY SD.TotalSales DESC) AS SalesRank,
COUNT(*) OVER(PARTITION BY SD.CategoryID) AS TotalProducts
FROM SalesData SD
)
SELECT RD.CategoryID, CTS.CategoryName, RD.ProductID, PT.ProductName, RD.TotalSales 
FROM RankedData RD
JOIN Products PT ON RD.ProductID = PT.ProductID
JOIN Categories CTS ON RD.CategoryID = CTS.CategoryID
WHERE RD.SalesRank <= RD.TotalProducts * 0.3
ORDER BY RD.CategoryID, RD.TotalSales DESC

--82-Bottom 40% countries by the Freight for year 1997 along with the Freight to Sale ratio in %...
WITH FrieghtData AS (
SELECT CT.Country, SUM(OD.Freight) TotalFreight, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) AS TotalSales
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY CT.Country
), RankedData AS (
SELECT FD.Country, FD.TotalFreight, FD.TotalSales, (FD.TotalFreight / FD.TotalSales) * 100 AS FrieghtToSalesRatio,
NTILE(10) OVER (ORDER BY FD.TotalFreight) AS FreightRank
FROM FrieghtData FD
)
SELECT RD.Country, RD.TotalFreight, RD.TotalSales
FROM RankedData RD
WHERE RD.FreightRank <= 4
ORDER BY RD.TotalFreight

--83-Countries contributing to 50% of the total sale for the year 1997...
WITH SalesData AS (
SELECT CT.Country, SUM(ODS.UnitPrice * ODS.Quantity * (1 - ODS.Discount)) AS TotalSales
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
JOIN [Order Details] ODS ON OD.OrderID = ODS.OrderID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY CT.Country
), CumulativeSalesData AS (
SELECT S1.Country, S1.TotalSales,
(
	SELECT SUM(S2.TotalSales)
	FROM SalesData S2 
	WHERE S2.TotalSales >= S1.TotalSales
) AS CumulativeSales
FROM SalesData S1
), TotalSalesData AS (
SELECT SUM(SD.TotalSales) AS TotalSalesOfAllCountries
FROM SalesData SD
)
SELECT CSD.Country, CSD.TotalSales, CSD.CumulativeSales
FROM CumulativeSalesData CSD, TotalSalesData TSD
WHERE CSD.CumulativeSales <= TSD.TotalSalesOfAllCountries / 2
ORDER BY CSD.TotalSales DESC

--84-Top 5 repeat customers for each country in year 1997...
WITH CustomerData AS (
SELECT CT.CustomerID, CT.CompanyName, CT.Country, COUNT(OD.OrderID) OrderCount
FROM Customers CT
JOIN Orders OD ON CT.CustomerID = OD.CustomerID
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY CT.CustomerID, CT.CompanyName, CT.Country
), RankedCustomers AS (
SELECT CD.CustomerID, CD.CompanyName, CD.Country, CD.OrderCount,
ROW_NUMBER() OVER (PARTITION BY CD.Country ORDER BY CD.OrderCount DESC) AS OrderRank
FROM CustomerData CD
)
SELECT RC.Country, RC.CompanyName AS CustomerName, RC.OrderCount
FROM RankedCustomers RC
WHERE RC.OrderCount <= 5
ORDER BY RC.OrderCount DESC, RC.Country ASC

--85- Week over Week Order Count and change % over previous week for year 1997 as Week Number,
-- Week Start Date, Week End Date, Order Count, Change %
WITH WeeklyOrders AS (
SELECT DATEPART(WK, OD.OrderDate) AS WeekNumber,
MIN(OD.OrderDate) AS WeekStartDate,
MAX(OD.OrderDate) AS WeekEndDate,
COUNT(OD.OrderID) AS OrderCount
FROM Orders OD
WHERE YEAR(OD.OrderDate) = '1997'
GROUP BY DATEPART(WK, OD.OrderDate)
), WeeklyOrderWithChange AS (
SELECT WO.WeekNumber, WO.WeekStartDate, WO.WeekEndDate, WO.OrderCount,
LAG(WO.OrderCount, 1, 0) OVER (ORDER BY WO.WeekNumber) AS PreviousWeekOrderCount
FROM WeeklyOrders WO
)
SELECT WOC.WeekNumber, WOC.WeekStartDate, WOC.WeekEndDate, WOC.OrderCount,
(WOC.OrderCount - WOC.PreviousWeekOrderCount) * 100.0 / NULLIF(WOC.PreviousWeekOrderCount, 0) AS ChangePercent
FROM WeeklyOrderWithChange WOC
ORDER BY WOC.WeekNumber