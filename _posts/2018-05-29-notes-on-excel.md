---
categories: [data analysis]
tags: [excel]
pin: False
---

Random notes on using Excel

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

I know, I know...but sometimes it's just easier.  

Here are some basic things which are handy to know in Excel.  

# Pivot Tables

Select the rows / columns you want, and go to `Insert` > `Pivot Table`. Then logically put the columns in appropriate data categories. For a more detailed description [see this tutorial by Microsoft](https://support.office.com/en-gb/article/create-a-pivottable-to-analyze-worksheet-data-a9a84538-bfe9-40a9-a8e9-f99134456576).  

# Filtering Data

Filter all columns in a sheet? Select the first cell with data and go to `Data` > `Filter`. Seriously, [it's that easy](https://support.office.com/en-us/article/filter-data-in-a-range-or-table-01832226-31b5-4568-8806-38c37dcc180e).  

# Highlight Non-NULL Cells

Example of how to highlight non-blank cells in column A.  

1. Go to `Home > Conditional Formatting > New Rule`.
2. Select "Use a formula to determine which cells to format"`
3. Enter the formula `=NOT(ISBLANK($A1))`
4. Configure your desired formatting (i.e. fill yellow)
5. Click Okay
6. Change "Applies to" to your column `=$A:$A`
6. Click Apply
