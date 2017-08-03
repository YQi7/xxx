
-- 各支付宝每月收款汇总
SELECT DATE_FORMAT(finish_date, '%Y-%m'),SUM(price)
FROM `order` 
WHERE tradeno IN (SELECT orderno FROM sheet1$ WHERE ali_account = '长投支付宝')
GROUP BY 1


-- 各支付宝每日收款汇总
SELECT DATE(finish_date),SUM(price)
FROM `order` 
WHERE tradeno IN (SELECT orderno FROM sheet1$ WHERE ali_account = '长投支付宝')
GROUP BY 1


-- 打新分红金额
select date_format(ips.`create_time`,'%Y%m') 卖出时间,sum(ipd.payment) 发钱金额
from `ipo_order_detail` ipd inner join `ipo_stock_list` ips on ipd.`stock_code` = ips.`ipo_order_code`
where ips.`is_sold` = 'Y' and ipd.is_paid = 'Y'  and date(ips.divide_time) BETWEEN '20160901' and '20170331' and ipd.entrust_status <> 'S'
GROUP BY 1


-- 打新保证金
select count(capital_account),sum(`deposit`) from `ipo_user_foundation` where is_valid = 'Y'  and date(start_date) < '2017-04-01'




-- 中签用户缴纳中签收益
select date_format(ips.`create_time`,'%Y%m') 卖出时间,count(ipd.`user_capital_account`) 中签人数,sum(ipd.`deposit`)  中签用户交钱金额
from `ipo_order_detail` ipd inner join `ipo_stock_list` ips on ipd.`stock_code` = ips.`ipo_order_code`
where ips.`is_sold` = 'Y' and ipd.`entrust_status` = 'S'  and ipd.is_paid = 'Y' and date(ips.divide_time) BETWEEN '20160901' and '20170331'
GROUP BY 1



-- 支付宝对账
SELECT *
FROM `order` 
WHERE tradeno IN (SELECT orderno FROM sheet1$ WHERE ali_account = '长投支付宝') AND DATE(finish_date)= '2017-03-02'
ORDER BY finish_date

GROUP BY 1


SELECT * FROM sheet1$ WHERE account LIKE '%易园(18627807566)%'