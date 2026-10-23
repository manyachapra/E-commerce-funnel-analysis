# E-commerce Funnel Analysis

An end-to-end data analytics project exploring e-commerce conversion behavior using **Google BigQuery, SQL, Python, and Tableau Public**.

## Project Overview

This project analyzes the e-commerce customer journey from product discovery to purchase. It examines funnel drop-offs, traffic-source performance, and purchase events across device categories to identify areas for further investigation and optimization.

## Business Questions

- How many sessions progress through each stage of the conversion funnel?
- At which stage is the largest drop-off observed?
- Which traffic sources generate the most purchase events?
- How do purchase-event counts differ across desktop, mobile, and tablet devices?

## Tools & Technologies

- **Google BigQuery** — querying public GA4 sample e-commerce event data
- **SQL** — funnel, channel, and device analysis
- **Python** — data validation and visualization using Pandas, NumPy, and Matplotlib
- **Tableau Public** — interactive dashboard development

## Tableau Public Dashboard

[**View E-commerce Analytics Dashboard**](https://public.tableau.com/app/profile/manya.chapra/viz/Ecommerce_Funnel_Analysis/E-commerceAnalyticsDashboard)

The dashboard includes:

- **Conversion Funnel:** Tracks sessions from product views through purchases.
- **Channel Performance:** Compares purchase-event counts across traffic sources.
- **Device Analysis:** Compares purchase-event counts across desktop, mobile, and tablet devices.

## Dataset

- **Source:** `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
- **Analysis period:** November 1, 2020 – January 31, 2021

The dataset contains sample Google Analytics 4 e-commerce events. It is obfuscated sample data and should not be treated as representative of all e-commerce businesses.

## Analysis & Preliminary Findings

### Conversion Funnel

| Funnel Stage | Sessions |
|---|---:|
| Product view | 77,020 |
| Add to cart after view | 15,146 |
| Checkout after cart | 5,293 |
| Purchase after checkout | 2,751 |

The preliminary view-to-final-stage ratio is approximately **3.57%**. The largest proportional drop-off occurs between product view and add to cart.

### Channel Performance

Among the five displayed source categories, `google` has the highest purchase-event count at **1,620**.

### Device Analysis

| Device | Purchase Events |
|---|---:|
| Desktop | 3,226 |
| Mobile | 2,355 |
| Tablet | 111 |

Desktop has the highest purchase-event count in this analysis.

> **Interpretation note:** Funnel counts represent the current query's session-stage logic. Channel and device metrics count events, not necessarily unique purchasers. Validate query logic and metric definitions before using these results for business decisions.

## Project Structure

```text
ANALYTICS/
├── sql/
│   ├── event_exploration.sql
│   ├── session_event_summary.sql
│   ├── funnel_analysis.sql
│   ├── channel_analysis.sql
│   └── device_analysis.sql
├── python/
│   ├── validate_funnel.py
│   ├── check_funnel_csv.py
│   └── plot_funnel.py
├── funnel_results.csv
├── funnel_chart.png
├── channel_analysis.csv
├── device_analysis.csv
└── README.md
```

## Skills Demonstrated

- SQL querying and aggregation
- Funnel analysis and conversion calculations
- Data validation using Python
- Exploratory data analysis
- Dashboard development and data storytelling
- Translating analytics into business questions

## Future Improvements

- Refine session-level funnel sequencing and validate event definitions.
- Compare conversion rates by channel and device.
- Add date-based trends and additional KPIs.
- Improve dashboard layout and add interactive filters.
- Document reproducible setup and query execution steps.

---

**Author:** Manya Chapra
