-- Data Insights with SQL - Pillow Palooza Business Questions:

-- 1. What are the most popular neighborhoods for short-term rentals in New York City?

-- 2. What is the average rental price for short-term rentals in New York City, and how does it vary by neighborhood and property type?

-- 3. What are the most commonly rented property types on Airbnb in New York City, and how does this vary by neighborhood?

-- 4. What is the average length of stay for short-term rentals in New York City, and how does this vary by 
-- neighborhood and property type?

-- 5. How has demand for short-term rentals in New York City changed over time, and are there any seasonal trends that could
-- impact business decisions?



-- The Dataset:

-- Table 1: Prices

-- * listing_id (the listing ID)
-- * price (price in dollar)
-- * borough (Name of the borough)
-- * neighborhood  (Name of the neighborhood)
-- * price_per_mont (price per month in dollars)
-- * latitude (latitude coordinates)
-- * longitude (longitude coordidantes)


-- Table 2: Reviews

-- * listing_id (the listing ID)
-- * host_name (name of the host)
-- * last_review (date of the last review)
-- * number_of_reviews (number of reviews)
-- * reviews_per_month (number of reviews per month)
-- * calculated_host_listings_count (amount of listing per host)
-- * availability_365 (number of days when listing is available for booking in the next 365 days)
-- * booked_days_365 (Amount of booked days in the next 365 days)


-- Table 3: Room Types

-- * listing_id (the listing ID)
-- * description (the description of the listing)
-- * room_type (listing space type)



--  Let's address the questions one by one:

-- 1. What are the most popular neighborhoods for short-term rentals in New York City?
-- This can be answered by analyzing the prices table, specifically the neighborhood and borough columns.

SELECT neighborhood, COUNT(listing_id) as number_of_listings
FROM prices
GROUP BY neighborhood
ORDER BY number_of_listings DESC
LIMIT 10;


-- 2. What is the average rental price for short-term rentals in New York City, and how does it vary by neighborhood and property type?
-- This can be answered by using the prices and room_types tables.

SELECT p.neighborhood, r.room_type, AVG(p.price) as average_price
FROM prices p
JOIN room_types r ON p.listing_id = r.listing_id
GROUP BY p.neighborhood, r.room_type
ORDER BY average_price DESC;


-- 3. What are the most commonly rented property types on Airbnb in New York City, and how does this vary by neighborhood?
-- This can be answered by using the room_types table.

SELECT room_type, COUNT(listing_id) as number_of_listings
FROM room_types
GROUP BY room_type
ORDER BY number_of_listings DESC;


-- The last two questions cannot be answered completely with the given data because the dataset doesn't have any information 
-- regarding the length of stay, and the historical data required to analyze the trends is missing. 

-- However, for qustion #4 we can make an assumption for the average length of stay by taking into account the 
-- availability_365 and booked_days_365 columns from the reviews table.

-- For question #5, we can examine how the number of reviews changes over time since it is reasonable to assume that a change 
-- in the number of reviews reflects a change in demand.

-- 4. SQL Query for average length of stay:

SELECT (booked_days_365 / (booked_days_365 + availability_365)) as average_length_of_stay
FROM reviews;


-- 5. SQL Query for the trend in demand:

SELECT last_review, COUNT(listing_id) as number_of_reviews
FROM reviews
GROUP BY last_review
ORDER BY last_review;








