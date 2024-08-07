CREATE TABLE transports (
    transport_id NUMBER PRIMARY KEY,
    gov_number NUMBER,
    brand VARCHAR2(30),
    year_of_production DATE,
    class VARCHAR2(30)
);