CREATE OR REPLACE FUNCTION get_drivers_who_can_drive_fix_types_of_transport(l_invoice_id NUMBER)
RETURN SYS_REFCURSOR
IS
	ref_cursor SYS_REFCURSOR;
	l_selected_transport_id NUMBER;
	l_class VARCHAR2(30);
BEGIN
	-- Получение времени доставки
    SELECT selected_transport_id
    INTO l_selected_transport_id
    FROM invoice_table
    WHERE invoice_id = l_invoice_id;
   
   	SELECT class
   	INTO l_class
   	FROM transports
   	WHERE transport_id = l_selected_transport_id;
   
    OPEN ref_cursor FOR
    SELECT d.driver_id
    FROM drivers d
    JOIN available_transports_for_drivers av ON d.driver_id = av.driver_id
    JOIN transport_types trt ON av.transport_type_id = trt.transport_type_id
    WHERE trt.transport_type = :l_class
    GROUP BY d.driver_id;
   
   RETURN ref_cursor;
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
        NULL; -- Обработка отсутствия данных
    WHEN OTHERS THEN
        RAISE; -- Перехват и повторное выбрасывание исключения

END;
/