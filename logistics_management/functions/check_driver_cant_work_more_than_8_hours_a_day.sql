CREATE OR REPLACE FUNCTION check_driver_cant_work_more_than_8_hours_a_day(l_invoice_id NUMBER)
RETURN SYS_REFCURSOR
IS
    ref_cursor SYS_REFCURSOR;
	l_delivery_time INTERVAL DAY TO SECOND;
BEGIN
	-- Получение времени доставки
    SELECT delivery_time
    INTO l_delivery_time
    FROM invoice_table
    WHERE invoice_id = l_invoice_id;
	
	--Получение количества часов по каждому работнику
   	OPEN ref_cursor FOR
	SELECT i.assigned_driver_id
	FROM invoice_table i
	WHERE (departure_time >= TRUNC(SYSDATE) AND departure_time < TRUNC(SYSDATE) + 1)
	GROUP BY i.assigned_driver_id
	HAVING (SUM(i.delivery_time) + l_delivery_time) <= INTERVAL '8' HOUR;

	RETURN ref_cursor;
	
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; -- Обработка отсутствия данных
    WHEN OTHERS THEN
        RAISE; -- Перехват и повторное выбрасывание исключения

END;
/