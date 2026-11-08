# Desafío Práctico 2 - Datawarehouse y Minería de Datos (DMD941)

**Universidad Don Bosco - Facultad de Ingeniería**  
* **Materia:** Datawarehouse y Minería de Datos (DMD941)  
* **Docente:** Ing. David Enrique Moya Aguilar  
* **Estudiante:** Jennifer Saraí Gómez Bonilla  
* **Carnet:** GB241467  
* **Repositorio Oficial:** [https://github.com/jennifer2400/DMD941-Desafio-Practico-2](https://github.com/jennifer2400/DMD941-Desafio-Practico-2)

---

## 📌 Descripción del Proyecto
Este repositorio contiene la entrega formal del **Desafío Práctico 2 (20%)**, centrado en la restauración y explotación analítica de la base de datos dimensional **AdventureWorksDW2025**, el diseño de la arquitectura para un **Cubo OLAP** (dimensiones, hechos, medidas y jerarquías) y la visualización de indicadores clave de desempeño (KPIs) mediante **Microsoft Power BI Desktop**.

---

## 📁 Archivos Entregables en este Repositorio
* **`DMD941_Desafio2_GB241467.pdf`**: Documento final consolidado con portada institucional, marco conceptual, arquitectura dimensional del Cubo OLAP, consultas Transact-SQL analíticas, capturas de pantalla de evidencia paso a paso y conclusiones gerenciales.
* **`Diagrama.pbix`**: Archivo original de Microsoft Power BI Desktop con la conexión activa a AdventureWorksDW2025, el modelo relacional importado y el tablero analítico de ventas por territorio comercial (`SalesTerritoryGroup` y `SalesAmount`).
* **`Consultas_AdventureWorksDW.sql`**: Script Transact-SQL documentado con las consultas analíticas de exploración, análisis multidimensional de margen por categoría y territorio, y volumetría transaccional.
* **`README.md`**: Ficha técnica y documentación general del proyecto.

---

## 🛠️ Entorno y Tecnologías Utilizadas
* **Motor de Base de Datos:** Microsoft SQL Server 2022 / 2025
* **Gestor de Administración:** SQL Server Management Studio (SSMS 20)
* **Plataforma de Business Intelligence:** Microsoft Power BI Desktop
* **Modelo Dimensional:** Esquema de Estrella (`FactInternetSales`, `DimProductCategory`, `DimSalesTerritory`, `DimDate`, `DimCustomer`)
* **Control de Versiones y Entrega:** Git y GitHub

---

## 📊 Principales Hallazgos Analíticos
1. **Liderazgo Comercial por Territorio:** El territorio de **North America** concentra el mayor volumen transaccional global, superando los **$11.36M** en ventas totales, seguido de **Pacific** ($9.06M) y **Europe** ($8.93M), sumando una facturación global analizada de **$29,358,677.22**.
2. **Alta Rentabilidad en Accesorios:** Aunque la categoría de Bicicletas (*Bikes*) aporta el mayor monto monetario bruto, la categoría de Accesorios (*Accessories*) ostenta el margen de utilidad porcentual más alto de todo el catálogo (**62.59%**), convirtiéndose en un motor estratégico de rentabilidad unitaria.
3. **Eficiencia del Esquema de Estrella:** La pre-agregación en tablas de hechos y dimensiones reduce drásticamente el costo de cómputo en consultas complejas frente a modelos normalizados tradicionales.
