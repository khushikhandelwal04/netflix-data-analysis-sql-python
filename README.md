# 🎬 Netflix Data Analysis Using Python & SQL

## 📌 Project Overview
This project delivers a comprehensive, end-to-end data engineering and analytics pipeline for the Netflix dataset. By combining the data manipulation power of **Python** with the robust querying capabilities of **SQL Server**, this project addresses raw data imperfections, builds a clean database schema, and uncovers actionable insights regarding Netflix's global content strategy.

### The pipeline covers:
* **Data Cleaning:** Handling malformed text, inconsistencies, and structural anomalies.
* **Normalization:** Deconstructing complex, multi-valued attributes into transactional relational structures.
* **Exploratory Data Analysis (EDA):** Discovering content trends over time and across regions.
* **SQL Querying:** Executing advanced relational queries and aggregations to extract direct business metrics.
* **Visualization:** Building high-impact visual representations of the underlying data patterns.

---

## 🛠 Tools Used

* **Python:** Core data processing engine.
* **Pandas:** Used for robust data wrangling, cleaning, and preparation.
* **Matplotlib:** Library utilized for generating analytical charts.
* **SQL Server:** Relational database management system hosting the normalized datasets.
* **SQLAlchemy:** The programmatic bridge executing secure connection and storage protocols between Python and SQL.
* **Jupyter Notebook:** Interactive environment used to stitch the Python development workflow together.

---

## 🔄 Workflow

```text
┌─────────────────┐      ┌───────────────┐      ┌───────────────────────┐
│  Excel Dataset  │ ───> │ Python Import │ ───> │ SQL Server Connection │
└─────────────────┘      └───────────────┘      └───────────────────────┘
                                                            │
┌─────────────────┐      ┌───────────────┐      ┌───────────▼───────────┐
│   Visualization │ <─── │  EDA & Insights │ <─── │     Data Cleaning     │
└─────────────────┘      └───────────────┘      └───────────────────────┘
                                 ▲                          │
                                 │      ┌───────────────────▼───┐
                                 └──────│     SQL Analysis      │
                                        └───────────────────────┘
```

---

## 📂 Project Structure

```text
├── dataset/            # Raw Excel/CSV files sourced for the project
├── notebook/           # Jupyter Notebooks containing Python cleaning & EDA scripts
├── sql_queries/        # Production-ready SQL scripts organized by analytical objective
└── README.md           # Project documentation and summary
```

---

## 🔍 Key SQL Operations

To extract precise metrics from the cleaned dataset, the following advanced relational database techniques were implemented:
* **Duplicate Removal:** Deduplication of records utilizing Common Table Expressions (CTEs) and partition indexes.
* **Missing Value Handling:** Structured execution of default values or data elimination based on critical dependencies (e.g., missing release dates).
* **Data Normalization:** Restructuring unnormalized lists (such as concatenated actors or genres) into distinct mapped relational tables.
* **Window Functions:** Computing rolling metrics, cumulative totals, and ranking elements (e.g., dense ranking top actors).
* **Aggregations:** Constructing summary metrics grouped by distinct categorization dimensions.
* **Genre and Country Analysis:** Cross-referencing content volumes against geographical origins and cinematic genres.

---

## 📊 Visualizations

### 1. Content Distribution: Movies vs TV Shows
Analysis comparing the overall split of available product types across the streaming application.
*![Movies vs TV Shows](path/to/Screenshot%202026-05-26%20233203.png)*

### 2. Top Content Producing Countries
Geographical visualization isolating regions responsible for generating the highest volume of items.
*![Top Content Producing Countries](path/to/Screenshot%202026-05-26%20221337.png)*

### 3. Content Added Over the Years
Chronological breakdown showing the historical pattern of timeline growth for platform catalog additions.
*![Content Added Over Years](path/to/image.png)*

---

## 💡 Key Insights

* **Format Dominance:** Feature-length **movies overwhelmingly dominate** the global Netflix catalog compared to multi-episode TV shows.
* **Explosive Scaling:** Library acquisition and production rates **increased rapidly and exponentially after 2015**, marking Netflix's aggressive shift toward streaming market dominance.
* **Relational Complexity:** The initial dataset contained extensive multi-valued columns (e.g., multiple cast members or genres listed in a single cell). **Normalization was mandatory** to run efficient, relational group queries.

---

## ⚠️ Challenges Faced

* **Special Character Handling:** Encountered text encoding issues (e.g., UTF-8 variations) stemming from international actor names, titles, and regional diacritics.
* **SQL vs Python Output Mismatch:** Minor variances occurred during aggregation logic due to differing datetime parsing methods between Pandas and SQL Server data types. This required explicit database type casting.
* **Duration Format Inconsistencies:** Media runtimes were formatted using varying schemas (e.g., mixing "Minutes" for movies with "Seasons" for shows), requiring regex-driven parsing before ingestion.

---

## 🚀 Future Improvements

* [ ] **Power BI Integration:** Connect the hosted SQL Server database to Power BI to create dynamic, automated executive tracking dashboards.
* [ ] **Advanced Visualizations:** Implement interactive web plotting (e.g., Plotly or Seaborn) to allow for deeper visual drill-downs.
* [ ] **Recommendation System:** Build a collaborative or content-based filtering model leveraging the normalized genre and cast metadata.
