select CustomerID, CompanyName, Contactfirst, Contactlast, Country from us_customers where CustomerID = 'SERVM' or CustomerID = 'GOLFK';
select CustomerID, CompanyName, Contactfirst, Contactlast, Country from non_us_customers where CustomerID = 'ABCST' or CustomerID = 'FERAR';
