# ERP-Sales-Operations-Analytics
End-to-end SQL Data Warehouse project implementing Bronze, Silver, and Gold layers with ETL automation and Power BI reporting.

## 📌 Project Overview

This project is an end-to-end **ERP Sales & Operations Analytics** data warehouse and reporting project built using **SQL Server and Power BI**.

The project transforms raw ERP and CRM data into a clean, structured analytical model using a **Bronze → Silver → Gold architecture** and a **Star Schema**.

The final Gold layer is designed to support business reporting and dashboard development in Power BI.

---

## 🎯 Business Objective

The objective of this project is to analyze:

- Sales performance
- Customer behavior
- Product performance
- Employee performance
- Supplier activity
- Inventory transactions
- Order and payment status
- Warehouse operations

The project demonstrates how raw operational data can be transformed into business-ready analytical data.

---

## 🏗️ Data Architecture

```text
                Raw CSV Data
                     │
                     ▼
              ┌─────────────┐
              │    BRONZE   │
              │ Raw Data    │
              └──────┬──────┘
                     │
                     ▼
              ┌─────────────┐
              │    SILVER   │
              │ Cleaned &   │
              │ Standardized│
              └──────┬──────┘
                     │
                     ▼
              ┌─────────────┐
              │     GOLD    │
              │ Star Schema │
              └──────┬──────┘
                     │
                     ▼
                Power BI
