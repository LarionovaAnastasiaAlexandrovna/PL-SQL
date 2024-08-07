CREATE OR REPLACE PROCEDURE get_correct_drivers_v1(
    l_invoice_id NUMBER,
    p_ref_cursor OUT SYS_REFCURSOR
)
IS
    v_driver_id NUMBER;
    ref_cursor_1 SYS_REFCURSOR;
    ref_cursor_2 SYS_REFCURSOR;
    ref_cursor_3 SYS_REFCURSOR;
BEGIN
    EXECUTE IMMEDIATE 'CREATE GLOBAL TEMPORARY TABLE temp_drivers (driver_id NUMBER)';
    
    ref_cursor_1 := get_drivers_and_cars_that_will_arrive_on_time(l_invoice_id);
    
    LOOP
        FETCH ref_cursor_1 INTO v_driver_id;
        EXIT WHEN ref_cursor_1%NOTFOUND;
        INSERT INTO temp_drivers (driver_id) VALUES (v_driver_id);
    END LOOP;
    CLOSE ref_cursor_1;
    
    ref_cursor_2 := check_driver_cant_work_more_than_8_hours_a_day(l_invoice_id);
    
    DELETE FROM temp_drivers WHERE driver_id NOT IN (
        SELECT driver_id
        FROM (
            FETCH ref_cursor_2 INTO v_driver_id;
            EXIT WHEN ref_cursor_2%NOTFOUND;
            INSERT INTO temp_drivers (driver_id) VALUES (v_driver_id);
        )
    );
    CLOSE ref_cursor_2;
    
    ref_cursor_3 := get_drivers_who_can_drive_fix_types_of_transport(l_invoice_id);
    
    DELETE FROM temp_drivers WHERE driver_id NOT IN (
        SELECT driver_id
        FROM (
            FETCH ref_cursor_3 INTO v_driver_id;
            EXIT WHEN ref_cursor_3%NOTFOUND;
            INSERT INTO temp_drivers (driver_id) VALUES (v_driver_id);
        )
    );
    CLOSE ref_cursor_3;
    
    OPEN p_ref_cursor FOR
    SELECT d.driver_id, d.full_name, d.salary_in_dollars
    FROM drivers d
    WHERE d.driver_id IN (SELECT driver_id FROM temp_drivers)
    ORDER BY d.salary_in_dollars;
    
    EXECUTE IMMEDIATE 'DROP TABLE temp_drivers';

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; -- Обработка отсутствия данных
    WHEN OTHERS THEN
        RAISE; -- Перехват и повторное выбрасывание исключения

END;
/

