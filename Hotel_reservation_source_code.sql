---create database--
create database intership;

---select Table---
SELECT [Booking_ID]
      ,[no_of_adults]
      ,[no_of_children]
      ,[no_of_weekend_nights]
      ,[no_of_week_nights]
      ,[type_of_meal_plan]
      ,[room_type_reserved]
      ,[lead_time]
      ,[arrival_date]
      ,[market_segment_type]
      ,[avg_price_per_room]
      ,[booking_status]
  FROM [intership].[dbo].[Hotel Reservation Dataset]

---change the datatype of avg_price_per_room to FLOAT---
ALTER TABLE [intership].[dbo].[Hotel Reservation Dataset]
ALTER COLUMN avg_price_per_room FLOAT;

---Clean or Correct the Invalid Dates---
UPDATE [intership].[dbo].[Hotel Reservation Dataset]
SET arrival_date = NULL
WHERE TRY_CONVERT(DATE, arrival_date) IS NULL AND arrival_date IS NOT NULL;

---Convert the Column Type---
ALTER TABLE [intership].[dbo].[Hotel Reservation Dataset]
ALTER COLUMN arrival_date DATE;

---Convert the Column Type---
ALTER TABLE [intership].[dbo].[Hotel Reservation Dataset]
ALTER COLUMN no_of_adults INT;

---Convert the Column Type---
ALTER TABLE [intership].[dbo].[Hotel Reservation Dataset]
ALTER COLUMN no_of_children INT

ALTER TABLE [intership].[dbo].[Hotel Reservation Dataset]
ALTER COLUMN no_of_weekend_nights INT;

------------------------------------------------------------------------------------------------------------------------
--------------------------------------------   ANALYSIS   -------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

---Q:1 What is the total number of reservations in the dataset?---
SELECT COUNT([Booking_ID]) AS total_reservations FROM [intership].[dbo].[Hotel Reservation Dataset]

---Q:2 Which meal plan is the most popular among guests?---
SELECT TOP 1 type_of_meal_plan, COUNT(*) AS count FROM [intership].[dbo].[Hotel Reservation Dataset]
GROUP BY type_of_meal_plan
ORDER BY count DESC ;

---Q :3 What is the average price per room for reservations involving children?---
SELECT AVG(avg_price_per_room) AS avg_price_per_room_with_children
FROM [intership].[dbo].[Hotel Reservation Dataset]
WHERE no_of_children > 0;

---Q :4 How many reservations were made for the year 20XX (replace XX with the desired year)?---
SELECT COUNT(*) AS reservations_in_year
FROM [intership].[dbo].[Hotel Reservation Dataset]
WHERE YEAR(arrival_date) = 2024;

---Q :5 What is the most commonly booked room type?---
SELECT TOP 1 room_type_reserved, COUNT(*) AS count
FROM [intership].[dbo].[Hotel Reservation Dataset]
GROUP BY room_type_reserved
ORDER BY count DESC;

---Q :6 How many reservations fall on a weekend (no_of_weekend_nights > 0)?---
SELECT COUNT(*) AS weekend_reservations
FROM [intership].[dbo].[Hotel Reservation Dataset]
WHERE no_of_weekend_nights > 0;


---Q :7 What is the highest and lowest lead time for reservations?---
SELECT MAX(lead_time) AS highest_lead_time, MIN(lead_time) AS lowest_lead_time
FROM [intership].[dbo].[Hotel Reservation Dataset];

---Q :8 What is the most common market segment type for reservations---
SELECT TOP 1 market_segment_type, COUNT(*) AS count
FROM [intership].[dbo].[Hotel Reservation Dataset]
GROUP BY market_segment_type
ORDER BY count DESC;

---Q :9 How many reservations have a booking status of "Confirmed"?---
SELECT COUNT(*) AS confirmed_reservations
FROM [intership].[dbo].[Hotel Reservation Dataset]
WHERE booking_status = 'Confirmed';

---Q :10 What is the total number of adults and children across all reservations?---
SELECT SUM(no_of_adults) AS total_adults, SUM(no_of_children) AS total_children
FROM [intership].[dbo].[Hotel Reservation Dataset];

---Q :11 What is the average number of weekend nights for reservations involving children?---
SELECT AVG(no_of_weekend_nights) AS avg_weekend_nights_with_children
FROM [intership].[dbo].[Hotel Reservation Dataset]
WHERE no_of_children > 0;

---Q :12 How many reservations were made in each month of the year?---
SELECT MONTH(arrival_date) AS month, COUNT(*) AS reservations_count
FROM [intership].[dbo].[Hotel Reservation Dataset]
GROUP BY MONTH(arrival_date)
ORDER BY month;

---Q :13 What is the average number of nights (both weekend and weekday) spent by guests for each room type?---
SELECT room_type_reserved, AVG(no_of_weekend_nights + no_of_week_nights) AS avg_total_nights
FROM [intership].[dbo].[Hotel Reservation Dataset]
GROUP BY room_type_reserved;

---Q : 14 For reservations involving children, what is the most common room type, and what is the average price for that room type?--
WITH CommonRoomType AS (
    SELECT TOP 1 room_type_reserved
    FROM [intership].[dbo].[Hotel Reservation Dataset]
    WHERE no_of_children > 0
    GROUP BY room_type_reserved
    ORDER BY COUNT(*) DESC
)
SELECT room_type_reserved, AVG(avg_price_per_room) AS avg_price_per_room
FROM [intership].[dbo].[Hotel Reservation Dataset]
WHERE room_type_reserved = (SELECT room_type_reserved FROM CommonRoomType) AND no_of_children > 0
GROUP BY room_type_reserved;

---Q :15 Find the market segment type that generates the highest average price per room.---
SELECT TOP 1 market_segment_type, AVG(avg_price_per_room) AS avg_price_per_room
FROM [intership].[dbo].[Hotel Reservation Dataset]
GROUP BY market_segment_type
ORDER BY avg_price_per_room DESC;










