DROP TABLE IF EXISTS reviews;
CREATE TABLE IF NOT EXISTS reviews (
	id SERIAL PRIMARY KEY,
	university_name VARCHAR(255),
	review VARCHAR(255),
	review_date TIMESTAMP
);