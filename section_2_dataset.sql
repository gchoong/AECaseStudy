WITH indiv20 AS (
    SELECT
      *,
      CASE WHEN transaction_amt > 0 THEN 1 ELSE 0 END AS valid_donation,
      ROW_NUMBER() OVER (PARTITION BY tran_id ORDER BY transaction_dt DESC) AS row_num
    FROM {{ ref('base_fec_indiv20') }}
    WHERE entity_tp = 'IND'
),

cn20 AS (
    SELECT *
    FROM {{ ref('base_fec_cn20') }}
    WHERE cand_office = 'S'
),

main AS (
    SELECT
        indiv20.tran_id
        indiv20.transaction_dt as transaction_date,
        indiv20.name as donor_name,
        indiv20.donor_state,
        indiv20.transaction_amt as donation_amount,
        cn20.cand_pty_affiliation,
        cn20.cand_name as candidate_name, 
        cn20.cand_office_st AS cand_office_state,
        cn20.cand_office AS candidate_office
    FROM indiv20
    LEFT JOIN cn20
        ON indiv20.cmte_id = cn20.cand_pcc
    WHERE indiv20.state != cn20.cand_office_st
    and row_num = 1
)

SELECT *
FROM main;
