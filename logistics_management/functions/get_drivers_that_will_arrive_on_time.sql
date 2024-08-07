CREATE OR REPLACE FUNCTION get_drivers_that_will_arrive_on_time(l_invoice_id NUMBER)
RETURN SYS_REFCURSOR
IS
    l_shipment_id NUMBER;
    l_delivery_time INTERVAL DAY TO SECOND;
    l_start_point VARCHAR2(100);
    l_delivery_deadline TIMESTAMP;
    ref_cursor SYS_REFCURSOR;

BEGIN
    -- Получение идентификатора поставки и времени доставки
    SELECT shipment_id, delivery_time
    INTO l_shipment_id, l_delivery_time
    FROM invoice_table
    WHERE invoice_id = l_invoice_id;
    
    -- Получение начальной точки и крайнего срока доставки
    SELECT start_point, delivery_deadline
    INTO l_start_point, l_delivery_deadline
    FROM shipments
    WHERE shipment_id = l_shipment_id;
    
    -- Открытие курсора для возврата id водителей, которые могут завершить доставку вовремя
    OPEN ref_cursor FOR
    SELECT i.assigned_driver_id
    FROM invoice_table i
    JOIN shipments sh ON sh.shipment_id = i.shipment_id
    WHERE sh.end_point = l_start_point
      AND i.departure_time + i.delivery_time <= l_delivery_deadline - l_delivery_time
      AND i.assigned_driver_id IS NOT NULL;

    RETURN ref_cursor;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; -- Можно обработать как-то иначе, если нужно
    WHEN OTHERS THEN
        RAISE; -- Перехват и повторное выбрасывание исключения

END;
/