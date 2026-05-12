# 📚 Sustainable Reading: Environmental Impact Comparison System

> A recommendation system database that compares the environmental impact of paper books and e-books to help users make eco-friendly reading choices.

## 📌 Project Overview
**Sustainable Reading** is a MySQL-based database system that systematically manages and compares the environmental impacts of paper books and e-books, providing personalized recommendations for sustainable reading formats.

*   **Paper Books:** Tracks environmental costs such as deforestation, water consumption, and carbon emissions.
*   **E-Books:** Tracks environmental costs such as energy consumption and e-waste.
*   **Integration:** Directly compares both formats within an integrated database to provide customized recommendations to users.

## 🛠 Tech Stack
| Category | Details |
| :--- | :--- |
| **Database** | MySQL |
| **Data Format** | Relational DB + JSON fields |
| **Query** | SQL (CRUD, JOIN, CASE WHEN) |

## 🗂 Database Structure
The database consists of a total of 6 tables.

```text
bookenvironmentaleffect
├── Users                 -- User information and environmental preferences
├── Books                 -- Book metadata (Title, Author, ISBN, etc.)
├── Formats               -- Book format info (Paper / E-Book)
├── EnvironmentalImpact   -- Environmental metrics by format (Carbon emissions, energy, water usage, etc.)
├── Comparisons           -- User-specific comparison results and recommendations
└── UserChoices           -- User selection history and feedback
```

### Entity-Relationship (ER)
| Relationship | Type |
| :--- | :--- |
| Users → UserChoices | 1 : N |
| Books → Formats | 1 : N |
| Formats → EnvironmentalImpact | 1 : 1 |
| Books → Comparisons | 1 : N |
| Users → Comparisons | 1 : N |
| Formats → UserChoices | 1 : N |

## 🚀 Getting Started

**1. Create the database and apply the schema**
```bash
CREATE DATABASE bookenvironmentaleffect;
USE bookenvironmentaleffect;
mysql -u root -p bookenvironmentaleffect < schema.sql
```

**2. Insert sample data**
```bash
mysql -u root -p bookenvironmentaleffect < sample_data.sql
```

**3. Execute recommendation queries**
```bash
mysql -u root -p bookenvironmentaleffect < queries.sql
```

## 🔍 Core Features

### ✅ Environmental Impact Comparison & Recommendation Query
Automatically recommends the more eco-friendly format by comparing the carbon emissions of the paper book and e-book versions of a specific title.

```sql
SELECT
  b.Title AS BookTitle,
  f1.Type AS FormatType1,
  f2.Type AS FormatType2,
  ei1.CarbonEmission AS CarbonEmission1,
  ei2.CarbonEmission AS CarbonEmission2,
  CASE
    WHEN ei1.CarbonEmission > ei2.CarbonEmission THEN
      CONCAT('The e-book reduces carbon emissions by ',
        ROUND(((ei1.CarbonEmission - ei2.CarbonEmission) / ei1.CarbonEmission) * 100, 2),
        '% compared to the paper book.')
    ELSE
      CONCAT('The paper book reduces carbon emissions by ',
        ROUND(((ei2.CarbonEmission - ei1.CarbonEmission) / ei2.CarbonEmission) * 100, 2),
        '% compared to the e-book.')
  END AS Recommendation
FROM Books b
JOIN Formats f1 ON b.BookID = f1.BookID
JOIN Formats f2 ON b.BookID = f2.BookID AND f1.Type = 'Paper' AND f2.Type = 'E-Book'
JOIN EnvironmentalImpact ei1 ON f1.FormatID = ei1.FormatID
JOIN EnvironmentalImpact ei2 ON f2.FormatID = ei2.FormatID
WHERE b.Title = 'The Vegetarian';
```

**Output Example**

| BookTitle | FormatType1 | FormatType2 | CarbonEmission1 | CarbonEmission2 | Recommendation |
| :--- | :--- | :--- | :--- | :--- | :--- |
| The Vegetarian | Paper | E-Book | 4.50 | 0.80 | The e-book reduces carbon emissions by 82.22% compared to the paper book. |

## 📊 Performance Evaluation

| Metric | Previous Design | Improved Design |
| :--- | :--- | :--- |
| **Average Env. Data Fetch Time** | 0.78s | 0.34s |
| **Comparison Query Execution Time** | - | 0.25s |
| **Improvement Rate** | - | **Approx. 56% improvement** |

*   **Scalability:** Utilized JSON fields to allow the addition of new attributes without altering the core table structure.
*   **Efficiency:** Reduced data redundancy and significantly improved search efficiency.

## 📁 File Structure
```text
sustainable-reading-db/
├── README.md
├── schema.sql         # DDL for table creation
├── sample_data.sql    # INSERT sample data
└──  queries.sql        # Recommendation and analysis queries

```

## 🌱 Future Plans
*   Develop a mobile app to analyze users' reading and consumption habits.
*   Add a data visualization feature for personalized Environmental Scores.
*   Expand comparison metrics to include a wider variety of environmental factors (e.g., recycling rates, detailed water usage).

## 📚 References
*   Ministry of Culture, Sports and Tourism, *"2023 National Reading Survey"*, 2024.04.18.
