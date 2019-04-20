alter view products compile;

alter view product_prices compile;

alter package orderentry compile;

alter package orderentry compile body;

alter session force parallel query &parallelclause;

BEGIN
  DECLARE
    max_customer_id NUMBER := 1000000;
    min_customer_id NUMBER := 1;
    max_order_id    NUMBER := 1000000;
    min_order_id    NUMBER := 1;
  begin
    execute immediate 'truncate table orderentry_metadata';
    SELECT MIN(o.order_id), MAX(o.order_id)
    INTO min_order_id     , max_order_id
    from orders o;
    INSERT INTO orderentry_metadata
      (
        metadata_key, metadata_value
      )
      VALUES
      (
        'SOE_MIN_ORDER_ID', to_char(min_order_Id)
      );
    INSERT INTO orderentry_metadata
      (
        metadata_key, metadata_value
      )
      VALUES
      (
        'SOE_MAX_ORDER_ID', to_char(max_order_id)
      );
    commit;
    SELECT MIN(c.customer_id), MAX(c.customer_id)
    INTO min_customer_Id        , max_customer_id
    from customers c;
    INSERT INTO orderentry_metadata
      (
        metadata_key, metadata_value
      )
      VALUES
      (
        'SOE_MIN_CUSTOMER_ID', to_char(min_customer_Id)
      );
    INSERT INTO orderentry_metadata
      (
        metadata_key, metadata_value
      )
      VALUES
      (
        'SOE_MAX_CUSTOMER_ID', to_char(max_customer_id)
      );
      commit;
      END;
END;
/


-- End;

