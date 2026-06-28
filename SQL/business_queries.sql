-- ----------------------------------- --
-- YELP : Reviews & Sentiment Analysis --
-- ----------------------------------- --

-- BUSINESS QUERIES --

use yelpDB;
use schema yelp;

-- 1. find number of businesses in each category

// split 'categories' list to single records
with cte as(
select 
    business_id,
    trim(A.value) as category
from tbl_yelp_biz,
LATERAL split_to_table(categories,',') A
)
select 
    category,
    count(category) as n_business
from cte
group by category
order by n_business desc;


// 2. top 10 users who have reviewed "Restaurants"
select
 r.user_id,
 count(DISTINCT r.business_id)
from tbl_review r
join tbl_yelp_biz b 
on r.business_id = b.business_id
where b.categories ilike '%restaurants'
group by 1
order by 2 desc
limit 10;


// 3. find the most popular categories of business based on number of reviews
with cte as(
select 
    business_id,
    trim(A.value) as category
from tbl_yelp_biz,
LATERAL split_to_table(categories,',') A
)
select 
    category,
    count(*) as n_reviews
from cte
join tbl_review r 
on cte.business_id = r.business_id
group by 1
order by 2 desc;


// 4. find the 3 most recent reviews for each busniess
with biz_rank as(
select 
    *,
    row_number() over (partition by business_id order by review_date desc) rn
from tbl_review
)
select business_id,review_date 
from biz_rank
where rn <=3;


// 5. find the month with highest number of reviews
select 
    month(review_date) as review_month,
    count(*) as n_reviews
from tbl_review
group by 1
order by 2 desc;

// 6. find percent of 5-star rating for each business
with rating as(
    select
        business_id,
        sum(case when stars = 5 then 1 else 0 end) as star5_ratings,
        count(*) as total_ratings
    from tbl_review
    group by 1
)
select 
    business_id,
    star5_ratings,
    total_ratings,
    (100.0 * star5_ratings / total_ratings) as star5_pct
from rating;


// 7. find top 5 most reviewed business in each city
with cte as (
select
    business_id,
    review_count,
    city
from tbl_yelp_biz
)
select *
from cte
qualify dense_rank() over (partition by city order by review_count desc) <= 5;


// 8. find avg. rating of businesses that have at least 100 reviews
select
    r.business_id,
    count(*) as total_reviews,
    round(avg(r.stars),2) as avr_rating
from tbl_review r
join tbl_yelp_biz b
on r.business_id = b.business_id
group by 1
having total_reviews >=100;


// 9. list of top 10 reviewers ,along with businesses they reviewed
with user_cte as(
    select 
        user_id,
        count(*) as total_reviews
    from tbl_review
    group by 1
    order by 2 desc
    limit 10
)
select 
    distinct user_id,
    business_id
from tbl_review
where user_id in (select user_id from user_cte)
order by 1;


// 10. find top 10 businesses with highest 'Positive' sentiment reviews
select 
    business_id,
    count(*) as total_positive_reviews
from tbl_review
where sentiments = 'Positive'
group by 1
order by 2 desc
limit 10;