SQL Note — Modeling Table Construction

A dedicated analytical base table (modeling_pd) was constructed from the raw LendingClub dataset containing 2.2 million loan records. Only variables observable at loan origination — borrower demographics, credit bureau attributes, loan terms, and application characteristics — were retained for PD model development.

All post-origination fields were deliberately excluded: repayment history, recovery amounts, collection activity, servicing behavior, and platform operational metadata. This boundary enforces point-in-time feature availability, ensuring the model cannot access information that would only exist after a credit decision has been made. Violating this boundary constitutes target leakage — one of the most common and consequential errors in credit model development — and would produce inflated in-sample performance that collapses entirely at deployment.
Target Variable Construction

The target variable (default_flag) was derived from loan status. The following statuses were mapped to default = 1:

- Charged Off
- Default
- Does not meet the credit policy. Status: Charged Off

These statuses represent realized borrower credit failure and economic loss events. Loans with status Fully Paid were mapped to default = 0, while ongoing loans (e.g., Current) were left as NULL and excluded from baseline supervised PD training due to unresolved outcomes.

Why ambiguous statuses were excluded rather than labeled zero:
Assigning default_flag = 0 to loans with unresolved outcomes would treat uncertain repayment as confirmed repayment, systematically understating the true default rate and contaminating the negative class. This would bias the model toward optimism and degrade calibration — the model would underestimate PD precisely in the segments where risk is still materializing. This exclusion approach is consistent with Basel II IRB model development standards and IFRS 9 point-in-time PD estimation requirements, both of which recommend training on resolved observations only.

This SQL extraction stage produced a structured analytical base table for downstream cleaning, feature engineering, and PD modeling in Python.
