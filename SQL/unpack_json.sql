-- ----------------------------------- --
-- YELP : Reviews & Sentiment Analysis --
-- ----------------------------------- --

-- UNPACK JSON --

use yelpDB;
use schema yelp;

// record count
select 
    count(business:business_id) as n_records
from yelp_business;

// data preview
select *
from yelp_business
limit 5;

// get fields
select DISTINCT object_keys(business)
from yelp_business
limit 1;

// create table with necessary data : yelp_business
create table tbl_yelp_biz as
select 
    business:business_id::string as business_id,
    business:city::string as city,
    business:state::string as state,
    business:review_count::string as review_count,
    business:stars::number as stars,
    business:categories::string as categories
from yelp_business;

// new table preview
select *
from tbl_yelp_biz
limit 5;


// create M warehouse for yelp_review
create warehouse yelp_M_wh
 warehouse_size = 'MEDIUM'
 warehouse_type = 'STANDARD'
 auto_suspend = 60
 auto_resume = TRUE;

// create table with necessary data : yelp_review
create table tbl_review as
select 
    review:business_id::string as business_id,
    review:date::date as review_date,
    review:user_id::string as user_id,
    review:stars::number as stars,
    review:text::string as review_text,
    analyze_sentiment(review) as sentiments
from yelp_review;


// new table preview
select *
from tbl_review
limit 5;