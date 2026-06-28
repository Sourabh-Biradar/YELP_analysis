# Yelp : Reviews & Sentiment Analysis

## Overview

This project analyzes the **Yelp Open Dataset** using **Python, Amazon S3, and Snowflake**. The workflow includes splitting large JSON files, uploading them to Amazon S3, loading the data into Snowflake, unpacking JSON records, performing sentiment analysis, and solving business-oriented SQL problems.

---

## Installation

Install the required dependencies:

```bash
pip install -r requirements.txt
```

---

## Project Workflow

Run the following files in sequence:

1. `notebooks/split_file.ipynb`
2. `notebooks/upload_to_s3.ipynb`
3. `SQL/data_from_s3.sql`
4. `SQL/analyze_sentiment.sql`
5. `SQL/unpack_json.sql`
6. `SQL/business_queries.sql`

---

## Tech Stack

* Python
* Amazon S3
* Snowflake
* SQL
* Jupyter Notebook
* VS Code
* Git
* GitHub

---

## Python Libraries

* pandas
* boto3

---

## Dataset

**Source:** https://business.yelp.com/data/resources/open-dataset/

### Dataset Information

#### Review Dataset

* Format: JSON (JSON Lines)
* Approximately **7 million** reviews
* **9** fields

#### Business Dataset

* **1,50,346** business records
* **14** fields

---

## Business Questions Solved

1. Find the number of businesses in each category.
2. Identify the top 10 users who reviewed restaurants.
3. Find the most popular business categories based on the number of reviews.
4. Retrieve the three most recent reviews for each business.
5. Find the month with the highest number of reviews.
6. Calculate the percentage of 5-star reviews for each business.
7. Find the top five most-reviewed businesses in each city.
8. Calculate the average rating of businesses with at least 100 reviews.
9. List the top 10 reviewers along with the businesses they reviewed.
10. Find the top 10 businesses with the highest number of positive sentiment reviews.

---

## Project Structure

Project structure.png

---

## Note

Detailed implementation, architecture, and query explanations are available in the **Reports** folder.

---

## Author

**Sourabh Biradar**
