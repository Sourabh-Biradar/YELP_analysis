-- ----------------------------------- --
-- YELP : Reviews & Sentiment Analysis --
-- ----------------------------------- --

// create DB
create or replace database yelpDB;
use yelpDB;

// create schema
create or replace schema yelp;

// create table
create or replace table yelp_review(
    review VARIANT
);

// copy 'reviews' data from aws-s3 to table
copy into yelp_review
from 's3://bucket/path'
credentials = (
    AWS_KEY_ID = 'your-access-key-id'
    AWS_SECRET_KEY = 'your-secret-key'
)
file_format = (type = JSON);

// records count
select count(*) as count
from yelp_review;

// data preview
select * from yelp_review limit 5;



// create 'business' table
create or replace table yelp_business(
    business VARIANT
);

// copy 'business' data from aws-s3 to 
copy into yelp_business
from 's3://bucket/path'
credentials = (
    AWS_KEY_ID = 'your-access-key-id'
    AWS_SECRET_KEY = 'your-secret-key'
)
file_format = (type = JSON);


// records count
select count(*) as count
from yelp_business;

// data preview
select * from yelp_business limit 5;