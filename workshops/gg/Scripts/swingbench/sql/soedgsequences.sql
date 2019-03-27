drop sequence customer_seq;

drop sequence orders_seq;

begin
	declare
		cust_count	number :=0;
		order_count	number :=0;
	begin
		select nvl(count(*),0) into cust_count from customers;
		select nvl(count(*),0) into order_count from orders;
		cust_count := cust_count + 1;
		order_count := order_count + 1;	
		execute immediate 'create sequence customer_seq start with '||cust_count||'  cache 100000'; 
		execute immediate 'create sequence orders_seq start with '||order_count||' increment by &instancecount cache 100000';
	end;
end;
/

