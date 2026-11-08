USE AdventureWorksDW2025;
GO

/****************************************************************************************
  UNIVERSIDAD DON BOSCO - FACULTAD DE INGENIERÍA
  MATERIA: DATAWAREHOUSE Y MINERÍA DE DATOS (DMD941)
  DESAFÍO PRÁCTICO 2 - FASE DE EXPLORACIÓN Y CONSULTAS SQL
  ESTUDIANTE: JENNIFER SARAÍ GÓMEZ BONILLA - CARNET: GB241467
****************************************************************************************/

-- 1. CONSULTA DE EXPLORACIÓN DE LA ARQUITECTURA DEL CUBO (RELACIONES Y LLAVES)
SELECT 
    fk.name AS Relacion_FK,
    tp.name AS Tabla_Hechos,
    cp.name AS Clave_Foranea,
    tr.name AS Tabla_Dimension,
    cr.name AS Clave_Primaria
FROM sys.foreign_keys AS fk
INNER JOIN sys.tables AS tp ON fk.parent_object_id = tp.object_id
INNER JOIN sys.tables AS tr ON fk.referenced_object_id = tr.object_id
INNER JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.columns AS cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
INNER JOIN sys.columns AS cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
WHERE tp.name = 'FactInternetSales'
ORDER BY tr.name;
GO

-- 2. ANÁLISIS MULTIDIMENSIONAL DE VENTAS, COSTOS Y GANANCIAS POR CATEGORÍA Y TERRITORIO
SELECT 
    pc.EnglishProductCategoryName AS Categoria,
    st.SalesTerritoryGroup AS Territorio,
    COUNT(fis.SalesOrderNumber) AS CantidadOrdenes,
    CAST(SUM(fis.SalesAmount) AS DECIMAL(18,2)) AS TotalVentas,
    CAST(SUM(fis.TotalProductCost) AS DECIMAL(18,2)) AS CostoTotal,
    CAST(SUM(fis.SalesAmount - fis.TotalProductCost) AS DECIMAL(18,2)) AS GananciaNeta,
    ROUND((SUM(fis.SalesAmount - fis.TotalProductCost) / SUM(fis.SalesAmount)) * 100, 2) AS MargenPct
FROM FactInternetSales fis
JOIN DimProduct p ON fis.ProductKey = p.ProductKey
JOIN DimProductSubcategory ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN DimProductCategory pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
JOIN DimSalesTerritory st ON fis.SalesTerritoryKey = st.SalesTerritoryKey
GROUP BY pc.EnglishProductCategoryName, st.SalesTerritoryGroup
ORDER BY TotalVentas DESC;
GO

-- 3. ANÁLISIS TEMPORAL MENSUAL Y EVOLUCIÓN HISTÓRICA DE INGRESOS
SELECT 
    d.CalendarYear AS Anio,
    d.EnglishMonthName AS Mes,
    COUNT(fis.SalesOrderNumber) AS TotalTransacciones,
    CAST(SUM(fis.SalesAmount) AS DECIMAL(18,2)) AS VentasTotales,
    CAST(SUM(fis.TotalProductCost) AS DECIMAL(18,2)) AS CostosTotales,
    CAST(SUM(fis.SalesAmount - fis.TotalProductCost) AS DECIMAL(18,2)) AS GananciaNeta
FROM FactInternetSales fis
JOIN DimDate d ON fis.OrderDateKey = d.DateKey
WHERE d.CalendarYear IN (2012, 2013)
GROUP BY d.CalendarYear, d.EnglishMonthName, d.MonthNumberOfYear
ORDER BY d.CalendarYear, d.MonthNumberOfYear;
GO

-- 4. RENDIMIENTO POR CLIENTE Y VOLUMETRÍA TRANSACCIONAL
SELECT TOP 15
    c.CustomerKey,
    c.FirstName + ' ' + c.LastName AS NombreCliente,
    g.City AS Ciudad,
    g.EnglishCountryRegionName AS Pais,
    COUNT(fis.SalesOrderNumber) AS TotalCompras,
    CAST(SUM(fis.SalesAmount) AS DECIMAL(18,2)) AS MontoTotalComprado
FROM FactInternetSales fis
JOIN DimCustomer c ON fis.CustomerKey = c.CustomerKey
JOIN DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY c.CustomerKey, c.FirstName, c.LastName, g.City, g.EnglishCountryRegionName
ORDER BY MontoTotalComprado DESC;
GO
