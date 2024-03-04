CREATE TABLE dataset_kimia_farma.kf_tabel_analisa AS
SELECT ft.transaction_id, ft.date, ft.branch_id, kc.branch_name, kc.kota, kc.provinsi, kc.rating AS rating_cabang, 
      ft.customer_name, ft.product_id, p.product_name, ft.price AS actual_price, ft.discount_percentage,
      CASE
            WHEN ft.price <= 50000 THEN '10%'
            WHEN ft.price > 50000 AND ft.price <= 100000 THEN '15%'
            WHEN ft.price > 100000 AND ft.price <= 300000 THEN '20%'
            WHEN ft.price > 300000 AND ft.price <= 500000 THEN '25%'
            WHEN ft.price > 500000 THEN '30%'
      END AS persentase_gross_laba,
      ft.price - (ft.price * ft.discount_percentage) AS nett_sales,
      
      (ft.price - (ft.price * ft.discount_percentage)) - (ft.price - (ft.price *  (CASE
            WHEN ft.price <= 50000 THEN 0.1
            WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
            WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.2
            WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
            WHEN ft.price > 500000 THEN 0.3
      END))) AS nett_profit,
      ft.rating AS rating_transaksi

FROM dataset_kimia_farma.kf_final_transaction as ft
LEFT JOIN dataset_kimia_farma.kf_kantor_cabang as kc
  on ft.branch_id = kc.branch_id

LEFT JOIN dataset_kimia_farma.kf_product as p
  on ft.product_id = p.product_id


;


