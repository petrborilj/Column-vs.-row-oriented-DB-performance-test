# Column-vs.-row-oriented-DB-performance-test
A simple performance test comparing row (MySQL) vs. column (Clickhouse) oriented DB with analytical queries.

Data: https://www.kaggle.com/ajohrn/bikeshare-usage-in-london-and-taipei-network (csv file 38 milion rows, 5.5 GB)

Performance test on my laptop (with very limited HW) comparing two popular open source dbs. The queries are quite simple, but represent the typical analytical queries from the OLAP systems.

As expected, **Clickhouse executes all the SQL statements that need to process large amount of data in the table much faster**. Surprisingly, a query that finds a specific row in a table (on column with PK / index) has similar run time with MySQL and is definitely fast enough. 
