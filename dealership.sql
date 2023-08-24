
--Salesperson table for employees
CREATE TABLE salesperson (
  salesperson_no SERIAL PRIMARY KEY, 
  first_name VARCHAR(100),
  last_name VARCHAR(100)
);


--Customers table for customers
CREATE TABLE customer (
   customer_no SERIAL PRIMARY KEY ,
   first_name VARCHAR(100),
   last_name VARCHAR(100),
   address VARCHAR(150),
   phone_number VARCHAR(20),
   email VARCHAR(50)
);

--Inventory table for cars
CREATE TABLE inventory (
   car_no SERIAL PRIMARY KEY,
   make VARCHAR(50),
   model VARCHAR(50),
   color VARCHAR(50),
   _year SMALLINT,
   car_for_sale BOOL
);

--Invoice table for car sales
CREATE TABLE invoice (
   invoice_no SERIAL PRIMARY KEY,
   invoice_date DATE,
   amount DECIMAL(8,2),
   salesperson_no INTEGER,
   customer_no INTEGER,
   car_no INTEGER,
   FOREIGN KEY (salesperson_no) REFERENCES salesperson(salesperson_no),
   FOREIGN KEY (customer_no) REFERENCES customer(customer_no),
   FOREIGN KEY (car_no) REFERENCES inventory(car_no)
);

--Sales table for dealership sales department
CREATE TABLE sales (
   customer_no INTEGER,
   car_no INTEGER,
   salesperson_no INTEGER,
   FOREIGN KEY (salesperson_no) REFERENCES salesperson(salesperson_no),
   FOREIGN KEY (customer_no) REFERENCES customer(customer_no),
   FOREIGN KEY (car_no) REFERENCES inventory(car_no)
);

--Mechanic table for mechanics
CREATE TABLE mechanic (
   staff_no SERIAL PRIMARY KEY,
   first_name VARCHAR(100),
   last_name VARCHAR(100),
   car_serial INTEGER,
   FOREIGN KEY (car_serial) REFERENCES service_ticket(car_serial)
);

--Service ticket table for customers
CREATE TABLE service_ticket (
  car_serial SERIAL PRIMARY KEY,
  ticket_id SERIAL,
  need_parts BOOL,
  name_of_service VARCHAR(100),
  customer_no INTEGER,
  FOREIGN KEY (customer_no) REFERENCES customer(customer_no)
);

--Service table for dealership service department
CREATE TABLE service (
   ticket_id INTEGER,
   car_serial INTEGER,
   staff_no INTEGER,
   customer_no INTEGER,
   FOREIGN KEY (staff_no) REFERENCES mechanic(staff_no),
   FOREIGN KEY (customer_no) REFERENCES customer(customer_no),
   FOREIGN KEY (car_serial) REFERENCES service_ticket(car_serial)
);


--Insert into salesperson
INSERT INTO salesperson(salesperson_no, first_name,  last_name)
VALUES
     ('1','Bonnie', 'Samuels'),
     ('2', 'Frank', 'White'),
     ('3', 'Jamie', 'Littles'),
     ('4', 'James', 'Worthington');
 

--Insert into customer
INSERT INTO customer(customer_no, first_name,  last_name, address, phone_number, email)
VALUES
     ('1','Manuel', 'Adams', '833 E. Thorne Drive Port Washington, NY 11050', '(717) 550-1675','andreashenemann@discslot.com'),
     ('2', 'Pluto', 'Ese', '69 Marlborough St. De Pere, WI 54115', '(206) 342-8631)', 'veratelyukova@earthxqe.com'),
     ('3','Sebastian', 'Verona', '82 Westport Avenue Montclair, NJ 07042', '(980) 365-0972', 'doramaneesan@holdrequired.club'),
     ('4', 'Naphtali', 'Candide', '7705 Locust St. Los Angeles, CA 90022', '(209) 342-8631', 'ijarkynai@safeemail.xyz');
	

--Insert into inventory
INSERT INTO inventory(car_no, make, model, color, _year, car_for_sale)
VALUES
	('1', 'Audi', 'R8', 'Yellow', '2023', 'yes'),
	('2', 'BMW', 'X5', 'Gun Metal', '2024', 'n'),
	('3', 'Tesla', 'X', 'White', '2024', 't');


--Insert into invoice
INSERT INTO invoice(invoice_no, invoice_date, amount, salesperson_no, customer_no, car_no)
VALUES
	('33', '2023-08-22', '490.00', '2', '1', '3'),
	('34', '2023-08-22', '600.00', '2', '2', '1');


--Insert into sales
INSERT INTO sales(customer_no, car_no, salesperson_no)
VALUES
	('1','3','2'),
	('2','1','2');


--Insert into service ticket
INSERT INTO service_ticket(car_serial, ticket_id, need_parts, name_of_service, customer_no)
VALUES
	('1049', '1', 'false', 'oil change', '3'),
	('1050', '2', 'true', 'timing belt replacement', '4');


--Insert into mechanic
INSERT INTO mechanic(staff_no, first_name, last_name, car_serial)
VALUES
	('10', 'Fran', 'Veronika', '1049'),
	('11', 'Lleu', 'Yash', '1050');


--Insert into service
INSERT INTO service(ticket_id, car_serial, staff_no, customer_no)
VALUES
	('1', '1049', '10', '3'),
	('2', '1050', '11', '4');


-- Stored Function to insert data into the invoice table
CREATE FUNCTION add_invoice(invoice_no INTEGER, invoice_date DATE, 
amount INTEGER, salesperson_no INTEGER, customer_no INTEGER, car_no INTEGER)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO invoice(invoice_no, invoice_date, amount, salesperson_no, customer_no, car_no)
	VALUES(_invoice_no, _invoice_date, _amount, _salesperson_no, _customer_no, _car_no);
END;
$MAIN$
LANGUAGE plpgsql;


-- Stored Function to insert data into the service ticket table
CREATE FUNCTION add_service_ticket(car_serial INTEGER, ticket_id INTEGER, 
need_parts BOOL, name_of_service VARCHAR, customer_no INTEGER)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO service_ticket(car_serial, ticket_id, need_parts, name_of_service, customer_no)
	VALUES(_car_serial, _ticket_id, _need_parts, _name_of_service, _customer_no);
END;
$MAIN$
LANGUAGE plpgsql;

-- Call function
SELECT add_service_ticket('35', '12', 'yes', 'transmission', '2')
SELECT add_service_ticket('36', '12', 'yes', 'tires', '3');

-- Verify addition
SELECT * FROM service_ticket

--Change column name in mechanic table
ALTER TABLE mechanic
RENAME COLUMN car_id to car_serial;


 