CREATE TABLE public.hospital_visits (
    id VARCHAR(250) PRIMARY KEY,
    patient_id VARCHAR(250) NOT NULL,
    doctor_id VARCHAR(250) NOT NULL,
    created_at VARCHAR(250),
    type VARCHAR(250)
);



CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);  



CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);  


SELECT DATE(created_at) AS visit_date,
 COUNT(*) AS number_of_visits FROM hospital_visits
  GROUP BY DATE(created_at) ORDER BY visit_date; 



 SELECT d.doctor_name, DATE_TRUNC('month', v.created_at) AS month,
  COUNT(DISTINCT v.patient_id) AS number_of_patients FROM hospital_visits v
   JOIN doctors d ON v.doctor_id = d.doctor_id 
   GROUP BY d.doctor_name, DATE_TRUNC('month', v.created_at)
    ORDER BY d.doctor_name, month; 



    SELECT TO_CHAR(hv.visit_date, 'YYYY-MM') AS month,
     COUNT(CASE WHEN p.gender = 'Female' THEN 1 END) AS female_visits,
      COUNT(CASE WHEN p.gender = 'Male' THEN 1 END) AS male_visits, 
      ROUND( COUNT(CASE WHEN p.gender = 'Female' THEN 1 END)::numeric / NULLIF
      (COUNT(CASE WHEN p.gender = 'Male' THEN 1 END), 0), 2 ) AS female_to_male_ratio FROM hospital_visits hv 
      JOIN patients p ON hv.patient_id = p.patient_id GROUP BY TO_CHAR(hv.visit_date, 'YYYY-MM') ORDER BY month;                               


