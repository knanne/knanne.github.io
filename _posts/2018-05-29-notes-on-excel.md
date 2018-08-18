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

# Highlight Non-NULL Cells

Example of how to highlight non-blank cells in column A.  

1. Go to `Home > Conditional Formatting > New Rule`.
2. Select "Use a formula to determine which cells to format"`
3. Enter the formula `=NOT(ISBLANK($A1))`
4. Configure your desired formatting (i.e. fill yellow)
5. Click Okay
6. Change "Applies to" to your column `=$A:$A`
6. Click Apply
