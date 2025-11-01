# DBLP Publication Analytics Pipeline  

## 📄 Project Report
Full presentation and insights can be found in the PDF below:  
👉 https://www.canva.com/design/DAG3aZi6T-I/WAgPNNElLhgKELQO5TnSUQ/edit?utm_content=DAG3aZi6T-I&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton


A full data analytics pipeline built with **PostgreSQL** to analyze global research publication trends using the **DBLP Computer Science Bibliography** dataset.  

## 📘 Overview  
This project demonstrates the complete data analysis workflow — from schema design to querying and visualization.  
It replicates a real-world scenario of processing large-scale semi-structured data (XML), transforming it into a relational model, and extracting insights through SQL analytics.  

## ⚙️ Workflow  
1. **Data Acquisition:** Parsed and imported ~1M publication records from `dblp.xml`.  
2. **Schema Design:** Built an E/R model and implemented 8+ normalized tables with foreign keys and constraints.  
3. **Data Transformation (ETL):** Cleaned and integrated raw XML data into relational tables.  
4. **Analysis:** Executed 20+ SQL queries to uncover trends by authors, venues, and publication types.  

## 📊 Key Insights  
- Top contributing authors include **Philip S. Yu** and **Michael Stonebraker**.  
- Most publications are in *“article”* and *“inproceedings”* formats.  
- Theoretical conferences such as **STOC** and **SOSP** dominate high-volume academic output.  

## 🧠 Tools & Technologies  
- PostgreSQL  
- SQL (DDL, DML, Aggregations, Indexing)  
- Python (XML parsing & ETL)  
- VS Code  

 

