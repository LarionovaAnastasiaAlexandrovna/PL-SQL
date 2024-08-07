CREATE OR REPLACE FUNCTION get_correct_drivers_v2(l_invoice_id NUMBER)
RETURN SYS_REFCURSOR
IS
    ref_cursor SYS_REFCURSOR;
BEGIN
    OPEN ref_cursor FOR
    SELECT d.driver_id, d.full_name, d.salary_in_dollars
    FROM drivers d
    WHERE d.driver_id IN (
        -- Возврат id водителей, которые могут завершить доставку вовремя
        SELECT i.assigned_driver_id
        FROM invoice_table i
        JOIN shipments sh ON sh.shipment_id = i.shipment_id
        WHERE sh.end_point = (
                SELECT sh.start_point
                FROM shipments sh
                INNER JOIN invoice_table i ON sh.shipment_id = i.shipment_id
                WHERE i.invoice_id = l_invoice_id
            )
        AND i.departure_time + i.delivery_time <= (
                SELECT sh.delivery_deadline
                FROM shipments sh
                INNER JOIN invoice_table i ON sh.shipment_id = i.shipment_id
                WHERE i.invoice_id = l_invoice_id
            ) - (
                SELECT i.delivery_time
                FROM invoice_table i
                WHERE i.invoice_id = l_invoice_id
            )
        AND i.assigned_driver_id IS NOT NULL
    )
    AND d.driver_id IN (
        -- Возврат id водителей, которые могут работать не более 8 часов в день
        SELECT i.assigned_driver_id
        FROM invoice_table i
        WHERE i.departure_time >= TRUNC(SYSDATE)
          AND i.departure_time < TRUNC(SYSDATE) + 1
        GROUP BY i.assigned_driver_id
        HAVING SUM(i.delivery_time) + (
            SELECT i.delivery_time
            FROM invoice_table i
            WHERE i.invoice_id = l_invoice_id
        ) <= INTERVAL '8' HOUR
    )
    AND d.driver_id IN (
        -- Возврат id водителей, которые могут управлять выбранным транспортом
        SELECT d.driver_id
        FROM drivers d
        JOIN available_transports_for_drivers av ON d.driver_id = av.driver_id
        JOIN transport_types trt ON av.transport_type_id = trt.transport_type_id
        WHERE trt.transport_type = (
            SELECT t.class
            FROM transports t
            INNER JOIN invoice_table i ON t.transport_id = i.selected_transport_id
            WHERE i.invoice_id = l_invoice_id
        )
        GROUP BY d.driver_id
    )
    ORDER BY d.salary_in_dollars;

    RETURN ref_cursor;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; -- Обработка отсутствия данных
    WHEN OTHERS THEN
        RAISE; -- Перехват и повторное выбрасывание исключения

END;
/