-- ----------------------------------- --
-- YELP : Reviews & Sentiment Analysis --
-- ----------------------------------- --

use yelpDB;
use schema yelp;

// create Pyhton UDF

create or replace function analyze_sentiment(text STRING)
returns STRING
language PYTHON
runtime_version = '3.10'
packages = ('textblob')
handler = 'sentiment_analyzer'
as $$
from textblob import TextBlob
def sentiment_analyzer(text):
    analysis = TextBlob(text)
    polarity = analysis.sentiment.polarity
  
    if polarity > 0: 
        return 'Positive'
    elif polarity == 0: 
        return 'Neutral'
    else: 
        return 'Negative'
$$;


// get sentiment

select 
    review:text::STRING as review_text,
    analyze_sentiment(review:text::STRING) as sentiment
from yelp_review
limit 5
offset 10000;


// sentiment count
select 
    analyze_sentiment(review:text::STRING) as sentiment_type,
    COUNT(*) as review_count
from yelp_review
group by 1
order by review_count desc;