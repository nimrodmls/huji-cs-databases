SELECT DISTINCT S1.TransactionNo AS TransactionNo, S1.ProductNo AS ProductNo
FROM sales S1, sales S2
WHERE 
    (S1.TransactionNo = S2.TransactionNo AND S1.CustomerNo <> S2.CustomerNo) OR
    (S1.TransactionNo = S2.TransactionNo AND S1.Date <> S2.Date) OR
    (S1.CustomerNo = S2.CustomerNo AND S1.Country <> S2.Country) OR
    (S1.ProductNo = S2.ProductNo AND S1.ProductName <> S2.ProductName)
ORDER BY TransactionNo, ProductNo ASC;