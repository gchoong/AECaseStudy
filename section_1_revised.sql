-- Find Senate candidates with the most out-of-state donors
WITH individual_donations AS (
  SELECT *
  FROM {{ ref('base_fec_indiv20') }}
  WHERE entity_tp = 'IND'
),

senate_candidates AS (
  SELECT *
  FROM {{ref('base_fec_cnd20')}}
  WHERE cand_office = 'S'
)

SELECT
  can.cand_name,
  can.cand_office_st,
  COUNT(*) AS donation_count,
  SUM(c.transaction_amt) AS total_donated,
  COUNT(DISTINCT CONCAT(c.name, c.zip_code)) AS unique_donors
FROM individual_donations c
INNER JOIN senate_candidates can
  ON c.cmte_id = can.cand_pcc
WHERE c.state != can.cand_office_st
GROUP BY
  can.cand_name,
  can.cand_office_st
ORDER BY unique_donors DESC;
