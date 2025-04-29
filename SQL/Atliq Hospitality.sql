create database AtliQGrands

Use AtliQGrands;


-- Revenue Analysis

-- 1. Hotel wise Reveneue
WITH revenue AS (
    SELECT 
        property_name,
        SUM(CAST(revenue_realized AS FLOAT)) AS total_revenue
    FROM 
        dim_hotels h
    LEFT JOIN 
        fact_bookings b ON h.property_id = b.property_id
    GROUP BY 
        property_name
)

SELECT 
    property_name,
    ROUND(total_revenue / 1000000.0, 2) AS revenue_millions,
    FORMAT(total_revenue * 100.0 / SUM(total_revenue) OVER (), 'N2') + '%' AS revenue_percentage
FROM 
    revenue
ORDER BY 
    revenue_millions DESC;

--2. Citywise and Hotelwise Revenue

WITH x AS (
    SELECT 
        city,
        property_name,
        ROUND(SUM(CAST(revenue_realized AS FLOAT)) / 1000000.0, 2) AS revenue_millions
    FROM 
        dim_hotels h
    LEFT JOIN 
        fact_bookings b ON h.property_id = b.property_id
    GROUP BY 
        property_name, city
)
SELECT 
    city,
    property_name,
    revenue_millions,
    FORMAT(
        revenue_millions * 100.0 / SUM(revenue_millions) OVER (PARTITION BY city), 'N2'
    ) + '%' AS revenue_contribution
FROM 
    x
ORDER BY 
    city, 
    revenue_millions DESC;

--3.Room wise Revenue

SELECT 
    room_class,
    ROUND(SUM(revenue_realized) / 1000000, 2) AS revenue_millions
FROM 
    dim_rooms r
LEFT JOIN 
    fact_bookings b ON r.room_id = b.room_category
GROUP BY 
    room_class
ORDER BY 
    revenue_millions DESC;

--4.Citywise Revnue
SELECT 
    city,
    ROUND(SUM(revenue_realized) / 1000000, 2) AS revenue_millions
FROM 
    dim_hotels h
LEFT JOIN 
    fact_bookings b ON h.property_id = b.property_id
GROUP BY 
    city;


--5.Revenue Loss Due To Cancellation
WITH x AS (
    SELECT 
        property_name,
        ROUND(SUM(revenue_generated) / 1000000, 2) AS ideal_revenue_millions,
        ROUND(SUM(revenue_realized) / 1000000, 2) AS actual_revenue_millions
    FROM 
        dim_hotels h
    LEFT JOIN 
        fact_bookings b ON h.property_id = b.property_id
    GROUP BY 
        property_name
)
SELECT 
    property_name,
    ideal_revenue_millions,
    actual_revenue_millions,
    (ideal_revenue_millions - actual_revenue_millions) AS revenue_loss
FROM 
    x
ORDER BY 
    revenue_loss DESC;

--6.Hotels that produce 70% of total revenue
WITH x AS (
    SELECT 
        property_name,
        ROUND(SUM(revenue_realized) / 1000000, 2) AS revenue_millions
    FROM 
        dim_hotels h
    LEFT JOIN 
        fact_bookings b ON h.property_id = b.property_id
    GROUP BY 
        property_name
),
y AS (
    SELECT 
        property_name,
        revenue_millions,
        SUM(revenue_millions) OVER (ORDER BY revenue_millions DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cummulative_revenue,
        SUM(revenue_millions) OVER () AS total_revenue
    FROM 
        x
)
SELECT 
    property_name,
    revenue_millions,
    cummulative_revenue,
    total_revenue
FROM 
    y
WHERE 
    cummulative_revenue <= 0.7 * total_revenue;

--7. Revenue Trend week over week

SELECT 
    week_no,
    property_name,
    ROUND(SUM(revenue_realized) / 1000000, 2) AS revenue_millions
FROM 
    dim_date d 
LEFT JOIN 
    fact_bookings b ON d.date = b.check_in_date
RIGHT JOIN 
    dim_hotels h ON h.property_id = b.property_id
GROUP BY 
    week_no, property_name;

--8.Revenue change week over week 
WITH x AS (
    SELECT 
        week_no,
        CAST(SUM(revenue_realized) / 1000000.0 AS DECIMAL(10, 2)) AS revenue_millions
    FROM 
        dim_date d
    LEFT JOIN 
        fact_bookings b ON d.date = b.check_in_date
    GROUP BY 
        week_no
),
y AS (
    SELECT 
        week_no,
        revenue_millions,
        LAG(revenue_millions, 1, 0) OVER (ORDER BY week_no ASC) AS prev_week_revenue
    FROM 
        x
)

SELECT 
    week_no,
    CAST(revenue_millions AS DECIMAL(10, 2)) AS current_week_revenue,  -- Ensure 2 decimal places
    CAST(prev_week_revenue AS DECIMAL(10, 2)) AS prev_week_revenue,    -- Ensure 2 decimal places
    FORMAT(
        CASE 
            WHEN prev_week_revenue = 0 THEN 0
            ELSE ((revenue_millions - prev_week_revenue) / prev_week_revenue) * 100.0
        END, 
    'N2') AS revenue_change_percentage  -- Format as string with 2 decimal places
FROM 
    y;

--9.Hotelwise occupancy

SELECT 
    property_name,
    ROUND(SUM(successful_bookings) * 100 / SUM(capacity), 2) AS occupancy_percentage
FROM 
    dim_hotels h 
LEFT JOIN 
    fact_aggregated_bookings a ON h.property_id = a.property_id
GROUP BY 
    property_name
ORDER BY 
    occupancy_percentage DESC;

--10. Room Categorywise Occupancy

SELECT 
    room_class,
    ROUND(SUM(successful_bookings) * 100 / SUM(capacity), 2) AS occupancy
FROM 
    dim_rooms r 
LEFT JOIN 
    fact_aggregated_bookings a ON r.room_id = a.room_category
GROUP BY 
    room_class
ORDER BY 
    occupancy DESC;

--11.Daywise Occupancy
SELECT 
    day_type,
    ROUND(SUM(successful_bookings) * 100 / SUM(capacity), 2) AS occupancy
FROM 
    dim_date d 
LEFT JOIN 
    fact_aggregated_bookings a ON d.date = a.check_in_date
GROUP BY 
    day_type;

--12.Daywise occupancy
SELECT 
    DATENAME(WEEKDAY, d.date) AS day_name,
    FORMAT(SUM(a.successful_bookings) * 100.0 / SUM(a.capacity), 'N2') AS occupancy
FROM 
    dim_date d
LEFT JOIN 
    fact_aggregated_bookings a ON d.date = a.check_in_date
GROUP BY 
    DATENAME(WEEKDAY, d.date)
ORDER BY 
    CASE DATENAME(WEEKDAY, d.date)
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END;

--13.Week over week occupancy

SELECT 
    week_no,
    property_name,
    ROUND(SUM(successful_bookings) * 100 / SUM(capacity), 2) AS occupancy
FROM 
    dim_date d 
LEFT JOIN 
    fact_aggregated_bookings a ON d.date = a.check_in_date
RIGHT JOIN 
    dim_hotels h ON a.property_id = h.property_id
GROUP BY 
    week_no, property_name;

--15. Hotel wise Check out, Cancellation,No Show Percentage
WITH bookings AS (
    SELECT 
        property_name,
        COUNT(DISTINCT(booking_id)) AS total_bookings,
        COUNT(DISTINCT(CASE WHEN booking_status = 'Cancelled' THEN booking_id ELSE NULL END)) AS cancelled_bookings,
        COUNT(DISTINCT(CASE WHEN booking_status = 'No Show' THEN booking_id ELSE NULL END)) AS noshow_bookings,
        COUNT(DISTINCT(CASE WHEN booking_status = 'Checked Out' THEN booking_id ELSE NULL END)) AS checkout_bookings
    FROM 
        dim_hotels h 
    LEFT JOIN 
        fact_bookings b ON h.property_id = b.property_id
    GROUP BY 
        property_name
)
SELECT 
    property_name,
    total_bookings,
    ROUND(cancelled_bookings * 100 / total_bookings, 2) AS cancellation_percentage,
    ROUND(noshow_bookings * 100 / total_bookings, 2) AS noshow_percentage,
    ROUND(checkout_bookings * 100 / total_bookings, 2) AS checkout_percentage
FROM 
    bookings
ORDER BY 
    total_bookings DESC;

--16. Platform wise bookings

SELECT 
    booking_platform,
    COUNT(DISTINCT(booking_id)) AS total_bookings,
    COUNT(DISTINCT(CASE WHEN booking_status = 'Cancelled' THEN booking_id ELSE NULL END)) * 100 / COUNT(DISTINCT(booking_id)) AS cancelled_percentage,
    COUNT(DISTINCT(CASE WHEN booking_status = 'No Show' THEN booking_id ELSE NULL END)) * 100 / COUNT(DISTINCT(booking_id)) AS noshow_percentage,
    COUNT(DISTINCT(CASE WHEN booking_status = 'Checked Out' THEN booking_id ELSE NULL END)) * 100 / COUNT(DISTINCT(booking_id)) AS checkout_percentage
FROM 
    fact_bookings
GROUP BY 
    booking_platform;

--17 Hotelwise top and bottom booking platforms
WITH x AS (
    SELECT 
        property_name, 
        booking_platform, 
        COUNT(DISTINCT(booking_id)) AS bookings
    FROM 
        dim_hotels h 
    LEFT JOIN 
        fact_bookings b 
        ON h.property_id = b.property_id
    GROUP BY 
        property_name, booking_platform
),
y AS (
    SELECT 
        property_name, 
        booking_platform, 
        bookings,
        RANK() OVER(PARTITION BY property_name ORDER BY bookings DESC) AS max_bookings_rnk,
        RANK() OVER(PARTITION BY property_name ORDER BY bookings ASC) AS min_bookings_rnk
    FROM 
        x
)
SELECT 
    property_name,
    MAX(CASE WHEN max_bookings_rnk = 1 THEN booking_platform ELSE NULL END) AS most_booking_platform,
    MAX(CASE WHEN min_bookings_rnk = 1 THEN booking_platform ELSE NULL END) AS least_booking_platform
FROM 
    y
GROUP BY 
    property_name
ORDER BY 
    property_name;

--18.Hotelwise booking trend
SELECT 
    property_name, 
    week_no, 
    COUNT(DISTINCT(booking_id)) AS bookings
FROM 
    dim_date d 
LEFT JOIN 
    fact_bookings b 
    ON d.date = b.check_in_date
JOIN 
    dim_hotels h 
    ON h.property_id = b.property_id
GROUP BY 
    property_name, week_no;


--19.Booking trend
WITH x AS (
    SELECT 
        week_no,
        COUNT(DISTINCT booking_id) AS bookings
    FROM 
        dim_date d
    LEFT JOIN 
        fact_bookings b ON d.date = b.check_in_date
    GROUP BY 
        week_no
),
y AS (
    SELECT 
        week_no,
        bookings AS current_week_bookings,
        LAG(bookings, 1, 0) OVER (ORDER BY week_no ASC) AS prev_week_bookings
    FROM 
        x
)
SELECT 
    week_no,
    current_week_bookings,
    prev_week_bookings,
    FORMAT(
        CASE 
            WHEN prev_week_bookings = 0 THEN 0
            ELSE ROUND(((current_week_bookings * 1.0 / prev_week_bookings) - 1) * 100.0, 2)
        END, 'N2'
    ) AS percentage_change
FROM 
    y;

--20. Hotelwise DBRN, DURN,DSRN
WITH x AS (
    SELECT 
        property_name,
        city,
        FORMAT(
            COUNT(DISTINCT booking_id) * 1.0 / (SELECT DATEDIFF(DAY, MIN(date), MAX(date)) FROM dim_date),
            'N2'
        ) AS DBRN,
        FORMAT(
            SUM(CASE WHEN booking_status = 'Checked Out' THEN 1 ELSE 0 END) * 1.0 / (SELECT DATEDIFF(DAY, MIN(date), MAX(date)) FROM dim_date),
            'N2'
        ) AS DURN
    FROM 
        dim_hotels h
    LEFT JOIN 
        fact_bookings b ON h.property_id = b.property_id
    GROUP BY 
        property_name, city
),
y AS (
    SELECT 
        property_name,
        city,
        FORMAT(
            SUM(capacity) * 1.0 / (SELECT DATEDIFF(DAY, MIN(date), MAX(date)) FROM dim_date),
            'N2'
        ) AS DSRN
    FROM 
        dim_hotels h
    LEFT JOIN 
        fact_aggregated_bookings a ON h.property_id = a.property_id
    GROUP BY 
        property_name, city
)
SELECT 
    x.property_name,x.city,y.DSRN, x.DBRN,x.DURN
FROM 
    x
INNER JOIN 
    y ON x.property_name = y.property_name AND x.city = y.city;

-- 21.Hotelwise ADR(Average Daily Revenue)
SELECT 
    property_name, 
    city, 
    COUNT(DISTINCT(booking_id)) AS total_bookings, 
    SUM(revenue_realized) AS revenue,
    ROUND(SUM(revenue_realized) / COUNT(DISTINCT(booking_id)), 2) AS ADR
FROM 
    dim_hotels h 
LEFT JOIN 
    fact_bookings b 
    ON h.property_id = b.property_id
GROUP BY 
    property_name, city
ORDER BY 
    ADR DESC;

-- 22. Hotelwise REVPAR
SELECT 
    property_name, 
    city, 
    SUM(CAST(revenue_realized AS DECIMAL(18, 2))) AS revenue, 
    SUM(CAST(capacity AS DECIMAL(18, 2))) AS capacity
FROM 
    dim_hotels h
JOIN 
    fact_bookings b 
    ON h.property_id = b.property_id
JOIN 
    fact_aggregated_bookings a 
    ON h.property_id = a.property_id
GROUP BY 
    property_name, city;