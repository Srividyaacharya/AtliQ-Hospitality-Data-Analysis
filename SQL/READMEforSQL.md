# 🏨 Atliq Grands Hospitality Data Analysis - SQL

### Problem Statement 

Atliq Grands owns multiple five-star hotels across India 🇮🇳. They have been in the hospitality industry for the past 20 years. Due to strategic moves from other competitors  соперники and ineffective decision-making in management , Atliq Grands are losing its market share  and revenue in the luxury/business hotels category. As a strategic move, the managing director of Atliq Grands wanted to incorporate “Business and Data Intelligence”  in order to regain their market share and revenue. However, they do not have an in-house data analytics team to provide them with these insights .

Their revenue management team  had decided to hire a 3rd party service provider to provide them insights from their historical data.
![7799f5d5-2442-442f-888b-58cef6a20052](https://github.com/user-attachments/assets/7676cdb1-8a91-4d4b-835b-ee7114935b5d)

#### Hotel Revenue and Booking Analysis

This repository contains SQL queries for analyzing hotel revenue, occupancy, booking trends, and various key performance indicators (KPIs) for hotels. The analysis is based on booking data, hotel information, and aggregated bookings.

## Project Overview

The primary goal of this project is to perform detailed revenue and booking analysis for hotel chains. The queries cover revenue generation, cancellations, occupancy rates, and platform-based booking patterns.

## Database Schema

The database `AtliQGrands` includes the following tables:

- `dim_hotels`
- `dim_rooms`
- `dim_date`
- `fact_bookings`
- `fact_aggregated_bookings`

## SQL Queries

### Revenue Analysis
- **Hotel-wise Revenue**: Revenue per hotel and contribution to total revenue.
- **City-wise and Hotel-wise Revenue**: Revenue breakdown by hotel and city.
- **Room-wise Revenue**: Revenue generated by room categories.
- **City-wise Revenue**: Revenue by city across hotels.
- **Revenue Loss Due to Cancellations**: Ideal vs. actual revenue.

### Key Metrics
- **70% Revenue-Contributing Hotels**: Hotels contributing to 70% of revenue.
- **Revenue Trend Week-over-Week**: Weekly revenue tracking.
- **Revenue Change Week-over-Week**: Week-on-week revenue % change.

### Occupancy Analysis
- **Hotel-wise Occupancy**: Occupancy % per hotel.
- **Room Category-wise Occupancy**: Occupancy % per room type.
- **Day-wise Occupancy**: Weekday vs. weekend occupancy.
- **Day-wise Detailed Occupancy**: Occupancy % by each day.
- **Week-over-Week Occupancy**: Weekly occupancy trend.

### Booking Status Analysis
- **Check-out, Cancellation, No-show %**: Booking outcome percentages.
- **Platform-wise Bookings**: Booking distribution across platforms.
- **Top and Bottom Booking Platforms**: Best and worst-performing platforms.

### Booking Trend Analysis
- **Hotel-wise Booking Trend**: Booking numbers week-by-week.
- **Overall Booking Trend**: Week-over-week booking change.

### Additional Metrics
- **Hotel-wise DBRN, DURN, DSRN**: Daily booking metrics.
- **Hotel-wise ADR (Average Daily Rate)**: Average revenue per booking.
- **Hotel-wise REVPAR (Revenue Per Available Room)**: Revenue per available room.


## Key Insights

- 🏨 **Top Hotels Drive Major Revenue**: A small percentage of hotels (about 30%) contribute nearly 70% of the total revenue, indicating a strong Pareto Principle (80/20 rule) in hotel revenue generation.
  
- 💰 **Significant Revenue Loss from Cancellations**: Cancellations cause a measurable drop in ideal revenue, highlighting the need for better cancellation policies or incentives to reduce no-shows.

- 📈 **Strong Weekday vs Weekend Trends**: Occupancy rates are noticeably higher on weekends compared to weekdays, suggesting opportunities for weekday promotions to balance occupancy.

- 🛌 **Room Categories Matter**: Premium and deluxe room categories generate the highest revenue and have higher occupancy rates compared to standard rooms.

- 🌆 **City-Specific Trends**: Certain cities consistently outperform others in both occupancy and revenue, suggesting that marketing efforts should be focused based on city performance.

- 📊 **Platform Performance Varies**: Bookings from certain platforms (like OTA partners vs direct website) show significant differences in volume and cancellation rates, impacting net revenue.

- 🔄 **Fluctuating Weekly Booking Trends**: Booking and revenue trends vary significantly week-over-week, reflecting seasonality, promotions, and external factors.

- 💹 **Stable ADR and REVPAR**: Despite fluctuations in booking volume, the Average Daily Rate (ADR) and Revenue Per Available Room (REVPAR) remain relatively stable, showing strong revenue management practices.


- 🚀 **Opportunities for Optimization**:
  - Increase direct bookings to reduce platform commissions.
  - Target promotions during low-occupancy weekdays.
  - Implement stricter cancellation policies or flexible booking options to reduce revenue loss.


## Learnings

- 📚 **SQL Mastery**: Strengthened my skills in advanced SQL concepts such as CTEs (Common Table Expressions), window functions (`RANK()`, `SUM() OVER()`), and aggregation techniques.
  
- 🏗️ **Data Modeling Understanding**: Gained deeper insight into designing and querying normalized relational databases, linking fact and dimension tables effectively.

- 📈 **Business Metrics Familiarity**: Learned to calculate and interpret key hotel industry KPIs such as:
  - ADR (Average Daily Rate)
  - REVPAR (Revenue Per Available Room)
  - Occupancy Rate
  - Revenue Loss due to Cancellations

- 🔍 **Revenue and Occupancy Analysis**: Developed the ability to analyze and interpret revenue streams, booking patterns, platform performance, and operational inefficiencies.

- 💡 **Data Storytelling Skills**: Improved the ability to convert raw data into actionable business insights and communicate findings in a clear, structured format.

- 🛠️ **Problem-Solving**: Learned how to handle real-world challenges such as missing data, joining complex tables, and calculating week-over-week performance trends.

- 📊 **Analytical Thinking**: Enhanced ability to look beyond numbers and understand business impact, customer behavior, and operational improvement opportunities.
