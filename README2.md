# 🏨 Atliq Grands Hospitality Data Analysis - SQL

### Problem Statement 

Atliq Grands owns multiple five-star hotels across India 🇮🇳. They have been in the hospitality industry for the past 20 years. Due to strategic moves from other competitors  соперники and ineffective decision-making in management , Atliq Grands are losing its market share  and revenue in the luxury/business hotels category. As a strategic move, the managing director of Atliq Grands wanted to incorporate “Business and Data Intelligence”  in order to regain their market share and revenue. However, they do not have an in-house data analytics team to provide them with these insights .

Their revenue management team  had decided to hire a 3rd party service provider to provide them insights from their historical data.

### Task List ✅

- Create the metrics according to the metric list .
- Create a dashboard according to the mock-up provided by stakeholders .
- Create relevant insights that are not provided in the metric list/mock-up dashboard .
  
### 📋 Overview

This project focuses on analyzing historical data for **Atliq Grands**, a five-star hotel chain in India, to provide business and data intelligence that can help them regain market share and revenue. 

As a data analyst, I followed an end-to-end data analytics process using **Power BI** to understand business requirements, design a solution, model data, create dashboards, and generate actionable insights for stakeholders.

## 📊 Dashboard View - [Live Interactive Dashboard](https://app.powerbi.com/view?r=eyJrIjoiOGJlM2YwY2QtOWExOS00OTM1LWE5ODItZTQ3YjAzZGM4ZDBjIiwidCI6IjU2MGY2MzA2LWZiZjItNGJhYy1hZTllLWQyMTQ4YzU5OTNiNyJ9)

![Screenshot 2025-04-28 213425](https://github.com/user-attachments/assets/cf64a9e6-b520-4d65-baa9-562eef199cc2)

### Data Model 

![Screenshot 2025-04-28 224948](https://github.com/user-attachments/assets/a84e6d6d-c901-4447-b5d8-21b2abc362c3)

### 🛠️ Project Steps

1. **Requirement Understanding:**  
   Discussed the business problem with stakeholders to understand the need for data-driven insights due to declining market share and ineffective decision-making.

2. **Mock-ups and Solution Design:**  
   Designed a mock-up dashboard based on domain expertise and stakeholder input. Defined key metrics like RevPAR, Occupancy, ADR, Realization, and structured important data breakdowns and filters.

3. **Data Collection and Modeling:**  
   Utilized Power Query for data cleaning and transformation (e.g., removing unnecessary columns, handling empty cells, promoting headers).  
   Implemented a **Star Schema** in Power BI's Model View to establish relationships between fact and dimension tables.

4. **Dashboarding and Insights Generation:**  
   Built metrics using DAX, including calculated columns for `Week_Number` and `Weekday/Weekend`.  
   Created an interactive dashboard based on the mock-up and generated insights related to pricing strategies, occupancy drivers (like ratings), and channel performance.

5. **Stakeholder Feedback:**  
   Discussed potential levers for revenue improvement, such as dynamic pricing strategies, and highlighted key insights derived from the data trends.

---

### 📊 Key Metrics Analyzed

- **RevPAR (Revenue Per Available Room):**  
  `RevPAR = Total Revenue / Total Available Rooms`
  
- **Revenue:**  
  Total income generated from room bookings.

- **Occupancy %:**  
  `(Number of Rooms Occupied / Total Available Rooms) * 100`

- **ADR (Average Daily Rate):**  
  `ADR = Total Room Revenue / Number of Rooms Sold`

- **DSRN (Daily Sellable Room Nights):**  
  Total Sellable Rooms for the Day.

- **Realization:**  
  `Realization = Utilized Room Nights (URN) / Booked Room Nights (BRN)`

- ** Many More Metrics have been created


### 🧩 Power BI Elements

- **Data Transformation (Power Query):**
  - Removed unnecessary columns like `day_type` from `dim_date`.
  - Handled missing/empty cells.
  - Promoted column headers for clean datasets.

- **Data Modeling:**
  - Implemented a **Star Schema** with Fact and Dimension tables.

- **DAX Measures and Calculated Columns:**
  - `Week_Number = WEEKNUM(Dim_date[date])`
  - `Weekday = VAR WeekD = WEEKDAY(Dim_date[date]) RETURN IF(WeekD > 5, "Weekend", "Weekday")`
  - [Other customized DAX measures based on the metric list]

- **Dashboard Visualizations:**
  - Data tables
  - Bar charts (with data bars for revenue)
  - Slicers and filters for dimensions like Month, City, Room Type
  - KPIs and trendlines for key metrics



### 🔍 Key Insights Generated

- **Pricing Strategy:**  
  Analysis suggests the hotel might be using a flat pricing strategy rather than dynamic or weekday/weekend pricing, presenting an opportunity for revenue optimization.

- **Occupancy and Ratings:**  
  A positive correlation between hotel ratings and occupancy was observed, highlighting the importance of service quality and guest satisfaction.

- **Channel Performance:**  
  Direct bookings via the hotel's own website have room for optimization. Offering slight advantages compared to third-party platforms could drive higher margin sales.


### 📚 Learnings

- **Data Analytics with Power BI:**  
  End-to-end experience from data extraction and transformation to dashboard creation and insights presentation.

- **Hospitality Domain Concepts:**  
  Gained understanding of crucial hospitality metrics and operational KPIs such as RevPAR, ADR, Occupancy Rate, etc.

- **Project Execution:**  
  Adopted a structured and iterative approach involving requirement gathering, solution design, implementation, stakeholder review, and feedback incorporation.

