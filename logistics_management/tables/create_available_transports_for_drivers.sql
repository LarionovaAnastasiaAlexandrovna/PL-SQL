CREATE TABLE available_transports_for_drivers (
    transport_type_id NUMBER,
    driver_id NUMBER,
    
    CONSTRAINT fk_driver FOREIGN KEY (driver_id)
    REFERENCES drivers(driver_id),
    
    CONSTRAINT fk_transport_types FOREIGN KEY (transport_type_id)
    REFERENCES transport_types(transport_type_id)
);