#!/bin/bash
spark-sql --driver-memory 8g --conf spark.driver.maxResultSize=12g --queue pingtaijishubu-gonggongpingtai.commonapi -e"
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.auto.convert.join=true;
set hive.exec.max.dynamic.partitions.pernode=1000000;

insert into table service_security.redup_normal_info_bak
PARTITION(year,month,day)
select
order_id,
driver_id,
passenger_id,
city_id,
city_name,
birth_time,
starting_name,
dest_name,
start_dest_distance,
normal_distance,
arrive_time,
finish_time,
call_times,
begin_charge_time,
product_id,
will_pay,
starting_lng,
starting_lat,
dest_lng,
dest_lat,
dynamic,
dynamic_price,
combo_type,
driver_start_distance,
forecast_time,
pre_total_fee,
order_status,
complete_type,
input,
is_new,
date_type,
source_type,
real_time,
total_recerivetime,
driver_wait_time,
passenge_wait_time,
type,
start_catalog,
dest_catalog,
d_age,
d_gender,
d_create_time,
car_level,
d_phone_model,
d_type,
d_car_brand,
d_car_level,
d_channel,
d_work_times,
d_active_degree,
d_complete_app,
d_finish_count,
d_total_passenger_complaint,
d_work_day,
d_active_day,
d_average_level,
d_star_level,
d_service_score,
p_age,
p_gender,
p_phone_model,
p_finish_count,
p_star_level,
p_finish_num1w,
p_one_star_level_num,
p_two_star_level_num,
p_three_star_level_num,
p_four_star_level_num,
p_five_star_level_num,
p_registered_time,
p_complaint_orders,
p_complaint_by_driver,
p_total_cancel_orders,
p_night_peak,
year,
month,
day
from(
select *,row_number() over (partition by order_id order by city_id desc) num from service_security.normal_info_bak
 ) t
where t.num=1
distribute by (year,month,day);"