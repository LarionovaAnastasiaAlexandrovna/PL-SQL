CREATE TABLE invoice_table (
    invoice_id NUMBER PRIMARY KEY,
    shipment_id NUMBER, 
    assigned_driver_id NUMBER,
    selected_transport_id NUMBER,
    departure_time TIMESTAMP,
    delivery_time INTERVAL DAY TO SECOND,
    CONSTRAINT fk_selected_transport FOREIGN KEY (selected_transport_id)
    REFERENCES transports(transport_id),
    CONSTRAINT fk_shipment FOREIGN KEY (shipment_id)
    REFERENCES shipments(shipment_id),
    CONSTRAINT fk_driver_working FOREIGN KEY (assigned_driver_id)
    REFERENCES drivers(driver_id)
);