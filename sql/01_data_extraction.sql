
use credit;
DROP TABLE IF EXISTS modeling_pd;
CREATE TABLE modeling_pd AS
SELECT
  id,
  issue_d,
  term,
  loan_amnt,
  funded_amnt,
  int_rate,
  installment,
  grade,
  sub_grade,
  emp_length,
  home_ownership,
  annual_inc,
  verification_status,
  purpose,
  addr_state,
  dti,
  delinq_2yrs,
  earliest_cr_line,
  fico_range_low,
  fico_range_high,
  open_acc,
  total_acc,
  revol_util,
  inq_last_6mths,
  pub_rec,
  application_type,
  loan_status,
  CASE
    WHEN loan_status IN ('Charged Off','Default','Does not meet the credit policy. Status:Charged Off') THEN 1
    WHEN loan_status = 'Fully Paid' THEN 0
    ELSE NULL
  END AS default_flag
FROM raw;

