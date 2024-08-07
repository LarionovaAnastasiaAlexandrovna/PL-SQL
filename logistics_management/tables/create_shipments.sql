CREATE TABLE shipments (
    shipment_id NUMBER PRIMARY KEY,
    start_point VARCHAR2(100),
    end_point VARCHAR2(100),
    delivery_deadline TIMESTAMP
);