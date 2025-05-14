# 👋 Introduction

Come dive into e-commerce with me! 

This project aims to identify, understand, and share key patterns and insights of a simulated real-world online shopping platform from 2024, based in the United States. 

Through a series of [SQL queries](/Dashboard_Queries/), I analyzed categories such as **Sales and Revenue**, **Shipments**, **Customer Segmentation**, **Supplier Performance**, as well as **Reviews and Ratings**. The findings are summarized in a concise [OAC dashboard](/assets/Online_shop_2024.png) for a quick overview.

Shout out to **Martha Dimgba** for the amazing Kaggle data set: [🛒 Online Shop 2024](https://www.kaggle.com/datasets/marthadimgba/online-shop-2024?resource=download).

# 🔎 Background
This project stems from my desire to bridge my professional background in international business with the analytical skills I've been developing. Inspired by the dynamics of online retail, my goal was to shed light and inform on strategic decisions within an online shopping environment.

### The categories I wanted to delve into through my SQL queries were:
1. **KPIs**: Regarding E-commerce.
2. **Sales and Revenue**: Per category, product, and volume.
3. **Shipments**: Time and fulfillment analysis.
4. **Customer Segmentation**: Per location, orders, and value.
5. **Supplier Performance**: By volume and revenue. 
6. **Reviews and Ratings**: Average per products and categories.
7. **Dashboard**: Visual executive summary.

# 🛠️ Tools I Used
Here are the tools I used for the execution of this project:

- **SQL**: Once again, the key to my analysis, allowing me to query the database and unearth critical insights.

- **PostgreSQL**: The chosen database management system for this project and many more.

- **Visual Studio Code**: My go-to for database management and executing SQL queries.

- **Oracle Analytics Cloud**: A new favorite for data visualization, enabling me to efficiently treat data and transform complex findings into clear, understandable information.

- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# 📊 The Analysis
Each category of this project aimed at investigating specific aspects of an Online Shopping platform from 2024. Here’s a sneak peek of how I approached each section:

### 1. KPIs
To start, I selected 5 key performance indicators I considered to be extremely relevant for the e-commerce sector: 

![kpis](/assets/1_KPIs.png)

*OAC dashboard showcasing my findings.*

Here's the breakdown of the KPIs for the e-commerce platform:
- **Orders**: In 2024, the platform received a total of 15,000 orders, indicating strong initial demand.

- **Shipments & Potential Lost Orders**: A total of 10,711 shipments were shipped and delivered, this implies a significant difference of approximately 4,289 orders (15,000 - 10,711) that were not fully processed to a delivered shippment status. This discrepancy represents a substantial number of potentially lost sales or orders facing issues.

- **Revenue Opportunity**: The 4,289 unfulfilled orders present a clear revenue growth opportunity. Successfully fulfilling these orders could have significantly increased the total revenue beyond the current $34.02 million. Investigating the reasons behind these unfulfilled orders (e.g., out of stock, payment issues, cancellations) is crucial to capitalize on this potential.

- **Shipping Time & Customer Satisfaction**: The average shipping time of 7.54 days for delivered orders is notably higher than the suggested standard of 4 days for customer satisfaction, as indicated by [SMG](https://smg.com/blog/8-takeaways-on-shipping-expectations-for-online-shopping-experiences/#:~:text=How%20fast%20should%20shipping%20be,the%20majority%20of%20customers%20happy.). This extended shipping time could be negatively impacting customer experience, potentially leading to decreased satisfaction, repeat purchases, and overall performance. Optimizing the fulfillment and delivery process to reduce shipping times should be a priority.

- **Moderate Average Order Value**: The Average Order Value of $2.83K suggests that while the platform experiences a high volume of transactions, the average spending per order is not exceptionally high. This could imply a customer base that primarily purchases more affordable items or that individual orders typically consist of a limited number of products. Further analysis of product sales data would be needed to confirm these potential drivers.

### 2. Sales and Revenue
To understand where the revenue is coming from, I joined the order items with the products, providing insights into which category makes the most revenue:

```sql
SELECT
    products.category,
    SUM(products.price * order_items.quantity) AS total_revenue
FROM
    order_items
LEFT JOIN
    products ON products.product_id = order_items.product_id
GROUP BY
    products.category
ORDER BY
    total_revenue DESC;
```
Here's the breakdown of the revenue of each product category:
- **Electronics leads in revenue**: With $16.67 million, Electronics accounts for 35.3% of total revenue — the largest share among all categories. This could indicate either a strong customer demand and/or high unit prices in this segment. Further analysis regarding product pricing and volume would shed light on this regard.

- **Home & Kitchen and Accessories are close contenders**: Whith Home & Kitchen making $12.50 million (26.5%), and Accessories $11.14 million (23.6%), together, this two categories contribute more than half the total revenue, showing balanced performance across multiple non-electronics segments.

- **Furniture lags behind**: At $6.92 million and just 14.6%, Furniture generates the least revenue out of the four categories. This could suggest lower demand, higher competition, or potential pricing/margin issues in this segment. A key question to consider while further analyzing the data.

- **Revenue distribution is somewhat balanced**: No single category dominates disproportionately — even the smallest (Furniture) contributes a significant portion. This indicates a relatively diverse product portfolio with revenue coming from multiple sources.

    ![S&R](assets\2_sales_and_revenue.png)

*Pie chart visualizing the revenue coming from each product category; ChatGPT generated this graph from my SQL query results.*

### 3. Shipments
This query helped identify the time it takes from an order being placed, to it being shipped. 

```sql
SELECT 
    (shipments.shipment_date - orders.order_date) AS shipment_days,
    COUNT(orders.order_id)
FROM
    shipments
INNER JOIN
    orders
    ON orders.order_id = shipments.order_id
GROUP BY
    shipment_days
ORDER BY
    shipment_days ASC;
```
Here's the breakdown of the order to shipment times:

- **Most shipments are delivered within 2 to 4 days**: Order to shipment times of 2 days (3,713 orders), 3 days (3,751 orders), and 4 days (3,761 orders) have the highest counts, nearly equal. These three categories alone account for ~78% of total shipments, indicating a highly efficient shipment process centered around 2–4 days.

- **One-day shipments are less frequent**: Only 1,876 shipments occurred within 1 day. This may reflect limited availability of express order to shipping.

- **5-day shipments are also relatively low**: With 1,899 orders, 5-day order to shippment time is the second-lowest. This could indicate that delays are not common — a positive sign for logistics performance.

- **Overall distribution suggests consistency**: The peak around 2–4 days, as well as the symmetrical drop-off at 1 and 5 days, implies a controlled and predictable shipping process.

    ![O2ST](assets\3_shipment_analysis.png)

*Bar chart showing the orders processed to shipment by the amount of days the process takes.*

### 4. Customer Segmentation
Exploring the amount of customers per state revealed the location distribution of the platform's buying audience.

```sql
SELECT
    RIGHT(address, 2) AS state_code,
    COUNT(DISTINCT customer_id) AS total_customers
FROM
    customers
GROUP BY
    RIGHT(address, 2)
ORDER BY
    total_customers DESC;
```
Here's a breakdown of the results for customer segmentation by state code:
- **High Uniformity Among Top States**: A total of 24 states have exactly 210 customers, including large markets like CA, TX, NY, FL, and IL. This uniform count suggests the platform may be capping or evenly distributing campaigns, promotions, or onboarding across major regions.

- **Slight Drop in North Carolina**: NC has 200 customers, slightly below the 210 benchmark seen in other top-performing states. This minor dip could signal local market saturation, lower engagement, or a reporting variance.

- **Majority of Other States Have 140 Customers**: The remaining 30+ states and territories are all at 140 customers. This consistent lower count suggests either limited marketing presence, smaller population/market size, or deliberate underrepresentation in outreach.

- **No Extremely High or Low Outliers**: There are no states with dramatically high or low values — the distribution is tightly clustered around two key figures: 210 and 140. This indicates a potentially controlled growth strategy, focusing on uniform expansion.

- **Opportunity for Targeted Growth**: States currently at 140 customers, such as MA, LA, AL, and OK, present clear opportunities for targeted growth campaigns. Boosting these to the 210-customer range could increase platform reach by 5,000 + users if applied broadly.

    | State Code | Number of Customers |
    | ---------- | ------------------- |
    | KS         | 210                 |
    | CA         | 210                 |
    | NJ         | 210                 |
    | GA         | 210                 |
    | NV         | 210                 |
    | NY         | 210                 |
    | OH         | 210                 |
    | MD         | 210                 |
    | OR         | 210                 |
    | PA         | 210                 |
    | CO         | 210                 |
    | CT         | 210                 |
    | MI         | 210                 |
    | SC         | 210                 |
    | MN         | 210                 |
    | AZ         | 210                 |
    | TX         | 210                 |
    | DE         | 210                 |
    | VA         | 210                 |
    | IL         | 210                 |
    | IN         | 210                 |
    | WA         | 210                 |
    | WI         | 210                 |
    | FL         | 210                 |
    | NC         | 200                 |
    | PW         | 140                 |
    | RI         | 140                 |
    | SD         | 140                 |
    | TN         | 140                 |
    | UT         | 140                 |
    | VI         | 140                 |
    | VT         | 140                 |
    | WV         | 140                 |
    | AK         | 140                 |
    | WY         | 140                 |
    | AL         | 140                 |
    | AR         | 140                 |
    | AS         | 140                 |
    | DC         | 140                 |
    | FM         | 140                 |
    | GU         | 140                 |
    | HI         | 140                 |
    | IA         | 140                 |
    | ID         | 140                 |
    | KY         | 140                 |
    | LA         | 140                 |
    | MA         | 140                 |
    | ME         | 140                 |
    | MH         | 140                 |
    | MO         | 140                 |
    | MP         | 140                 |
    | MS         | 140                 |
    | MT         | 140                 |
    | ND         | 140                 |
    | NE         | 140                 |
    | NH         | 140                 |
    | NM         | 140                 |
    | OK         | 140                 |
    | PR         | 140                 |

*Table of the amount of customers per state code.*

### 5. Supplier Performance 
Combining insights from products, categories, and suppliers, this query aimed to pinpoint the suppliers that provide the must products to each category.

```sql
WITH supplier_category_counts AS (
    SELECT
        products.category,
        suppliers.supplier_name,
        COUNT(products.product_id) AS product_count,
        ROW_NUMBER() OVER (
            PARTITION BY products.category
            ORDER BY COUNT(products.product_id) DESC
        ) AS rank
    FROM
        products
    INNER JOIN
        suppliers ON suppliers.supplier_id = products.supplier_id
    GROUP BY
        products.category,
        suppliers.supplier_name
)

SELECT
    category,
    supplier_name,
    product_count
FROM    
    supplier_category_counts
WHERE
    rank = 1;
```
Here's a breakdown of the top suppliers by category and their product volumes for the e-commerce platform in 2024:

- **Each Category Has a Distinct Leading Supplier**: The data shows no supplier overlaps across categories, indicating that supplier specialization is likely — each focuses on a specific product domain rather than spanning multiple categories.

- **Unified Trading Co. Is the Strongest Leader in Volume**: In the Electronics category, Unified Trading Co. leads with 80 products, the highest count among all top suppliers. This may reflect the broader diversity or complexity of the electronics segment, demanding larger catalogs from suppliers.

- **Furniture’s Top Supplier Has the Smallest Share**: Premier Logistics Inc. leads Furniture with just 40 products, compared to 60–80 in other categories. This may suggest lower product diversity, higher logistical complexity, or tighter quality control in the Furniture category.

- **Product Volume Among Leaders Is Relatively Close (Except Furniture)**: Top suppliers in Accessories (60) and Home & Kitchen (60) show identical product counts, suggesting balanced competition or similar demand expectations in these segments.

- **Potential for Category Expansion or Supplier Diversification**: With only one top supplier per category highlighted, it’s unclear how dominant they are over others. This opens up the possibility to further analyze supplier concentration per category — useful for identifying areas of dependency or diversification need.

| Category       | Supplier                | Products they Provide |
| -------------- | ----------------------- | --------------------- |
| Accessories    | Tech Supplies Inc.      | 60                    |
| Electronics    | Unified Trading Co.     | 80                    |
| Furniture      | Premier Logistics Inc.  | 40                    |
| Home & Kitchen | Precision Suppliers LLC | 60                    |

*Table of the top supplier by category regarding product volume.*

### 6. Reviews and Ratings
In order to identify the average rating of the 10 bestseller products, I filtered the top 10 products by ordered quantity. Therefore calculating the average rating of them.   

```sql
WITH product_sales AS (
    SELECT
        products.product_name,
        products.product_id,
        SUM(order_items.quantity) AS total_quantity
    FROM
        order_items
    JOIN
        products
        ON products.product_id = order_items.product_id
    GROUP BY
        products.product_id, products.product_name
),
product_reviews AS (
    SELECT
        products.product_name,
        AVG(reviews.rating) AS average_rating
    FROM
        products
    JOIN
        reviews
        ON reviews.product_id = products.product_id
    GROUP BY
        products.product_name
)

SELECT
    product_sales.product_name,
    SUM(product_sales.total_quantity) AS total_quantity,
    ROUND(product_reviews.average_rating, 0) AS average_rating
FROM
    product_sales
LEFT JOIN
    product_reviews
    ON product_sales.product_name = product_reviews.product_name
GROUP BY
    product_sales.product_name, product_reviews.average_rating
ORDER BY
    total_quantity DESC
LIMIT 10;
```
Here's the breakdown of the top products raitings:

- **High Sales Don't Guarantee High Ratings**: The 4K Monitor is the top-selling product with 2,280 units sold, yet it has the lowest rating (2/5). Similarly, the Standing Desk ranks 4th in sales but also holds a 2-star rating. This suggests a disconnect between purchase drivers and customer satisfaction, potentially due to price, promotion, or limited alternatives.

- **Top-Rated Products Are Not Always the Top Sellers**: Throw Pillows and Storage Shelf both have perfect 5-star ratings and rank 2nd and 7th in sales respectively. These products combine high satisfaction and solid demand, making them ideal candidates for featured promotions or upsell bundles.

- **Mid-Rated Products Dominate the List**: Half of the products (5 out of 10) have a 3-star rating, indicating an average customer experience across a significant portion of the catalog. This may point to opportunities for product improvement or better customer expectation management.

- **Electronics Show Mixed Satisfaction Trends**: Products like 4K Monitor, Bluetooth Headphones, and External SSD are top sellers but vary in ratings from 2 to 3 stars. This suggests electronics may sell based on features or necessity rather than customer delight, which could impact brand loyalty.

- **Opportunity to Promote High-Rated, Underrated Products**: Products like the Storage Shelf (5⭐, rank #7) and Air Purifier (4⭐, rank #3) show strong satisfaction but slightly lower sales than leaders. These could benefit from highlighted visibility or targeted advertising, leveraging their positive reviews to boost conversions.

    | Product              | Quantity | Average Rating |
    | -------------------- | -------- | -------------- |
    | 4K Monitor           | 2280     | 2              |
    | Throw Pillows        | 2072     | 5              |
    | Air Purifier         | 2031     | 4              |
    | Standing Desk        | 2030     | 2              |
    | Kitchen Blender      | 2024     | 3              |
    | Bluetooth Headphones | 2021     | 3              |
    | Storage Shelf        | 2007     | 5              |
    | External SSD         | 2003     | 3              |
    | Microphone           | 2001     | 4              |
    | Monitor Stand        | 1972     | 3              |

*Table showing the average rating of the top selling products regarding volume.*

## 7. Dashboard
To conclude this analysis, I built a dashboard which delivers a clear, visual overview of the most critical business metrics for the Online Shop in 2024, helping stakeholders quickly grasp performance and act with confidence.

![dash](assets\Online_shop_2024.png)

It highlights:

- **Key Operational Metrics at a Glance**: Total Orders (15,000), Revenue ($34.02M), Shipments (10,711), Average Order Value, and Fulfillment Speed are all instantly accessible, allowing for real-time performance monitoring.

- **Decision-Ready Visuals by Business Area**: Each section (Sales and Revenue, Shipments, Customer Segmentation, Supplier Performance, and Reviews and Ratings) focuses on the most relevant KPIs. For example, “Best Sellers” and “Top Products by Rating” support product curation, while “Top Suppliers by Volume/Revenue” informs procurement strategy.

- **Actionable Gaps Are Easy to Spot**: The Order Fulfillment chart shows that only 36% of orders are fulfilled, an issue that immediately draws attention for operational improvements.
Similarly, the average product rating of 2.64 in the Furniture category signals a need for quality or customer experience enhancement.

- **Customer Reach Is Mapped Clearly**: The geographic visualization of customer distribution aids in identifying growth opportunities and regional sales strengths.

- **Visual Clarity Supports Strategic Alignment**: Each widget is easy to interpret, with well-structured layout and color coding, ensuring that both technical and non-technical users can extract value effortlessly.

# 🤓 What I Learned
- **End-to-End Project Execution**: I successfully developed a complete analytics project from scratch, focused on uncovering and visualizing meaningful insights. This helped me understand the full cycle of data-driven storytelling.

- **Industry-Relevant Data Exploration**: By working with e-commerce data, I gained a clearer view of how the sector operates. I organized the data into relevant categories and applied core SQL techniques to extract insights—bridging analytics with my background in international business.

- **Skill Integration in Practice**: This project allowed me to apply and strengthen my analytical thinking, problem-solving abilities, and SQL skills in a practical, business-relevant scenario—proving my ability to turn raw data into strategic information. 

# 💭 Closing Thoughts
This project significantly strengthened both my data visualization and SQL skills, while deepening my understanding of how to extract and interpret insights from an e-commerce platform. The findings presented here serve as a practical guide for analyzing and addressing key components of an online shop's performance. Online sellers can improve their positioning in today’s competitive market by recognizing that the selling process must be carefully managed across distinct areas—yet treated as a unified whole. This exploration reinforces the value of thoughtful data analysis as a foundation for timely and informed decision-making.