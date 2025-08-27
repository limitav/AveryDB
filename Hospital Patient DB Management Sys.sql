-- Create the database for the Patient Management System
-- CREATE DATABASE HospitalPatientDB;

-- CREATE TYPE gender AS ENUM('Male', 'Female');
CREATE TABLE Patients (
	patient_id INT NOT NULL PRIMARY KEY,		-- Unique patient ID
	name VARCHAR(255) NOT NULL,					-- Patient full name
	gender_p gender NOT NULL,					-- Gender of the patient
	dob DATE,									-- Date of birth
	contact_number VARCHAR(15),					-- Contact number
	address VARCHAR(255),						-- Patient's home
	medical_history TEXT						-- Past medical history
);
-- DROP TYPE gender_p;

-- Doctors Table
-- Create the Doctors table
CREATE TABLE Doctors (
	doctor_id SERIAL NOT NULL PRIMARY KEY,		-- Unique ID for Doctors
	name VARCHAR(255) NOT NULL,					-- Doctor's full name
	specialty VARCHAR(100),						-- Doctor's practice
	contact_number VARCHAR(15),					-- Contact number
	email VARCHAR(100)							-- Doctor's email address
); 

-- Appointments table
-- Create the Appointments table
-- CREATE TYPE status AS ENUM('Scheduled', 'Completed', 'Cancelled');
CREATE TABLE Appointments (
	appointment_id SERIAL NOT NULL PRIMARY KEY,				-- Unique appointment ID (Primary Key)
	patient_id INT,											-- Foreign key from Patients (which patient booked the appointment)
	doctor_id INT,											-- Foreign key from Doctors (which doctor is assigned)
	appointment_date DATE,									-- Appointment date
	appointment_time TIME,									-- Appointment time
	appointment_status status DEFAULT 'Scheduled',			-- Appointment status
	FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
	FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
	);

-- Billing Table
-- CREATE TYPE status1 AS ENUM('Paid', 'Pending', 'Cancelled');
-- Create the Billing table
CREATE TABLE Billing (
	bill_id SERIAL NOT NULL PRIMARY KEY,			-- Unique bill ID
	patient_id INT,									-- Foreign key from Patients (patient being billed)
	doctor_id INT,									-- Foreign key from Doctors (doctor providing service)
	bill_date DATE,									-- Date of the bill
	amount DECIMAL(10, 2),							-- Total amount billed
	payment_status status1 DEFAULT 'Pending',		-- Billing status
	FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
	FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
 );

/*ALTER TABLE Billing 
RENAME COLUMN payment_status
TO billing_status; */

SELECT * FROM Billing;

Inserting Data into Patients Table
INSERT INTO Patients (patient_id, name, gender_p, dob, contact_number, address, medical_history)
VALUES
(1, 'Alicia Edwards', 'Female', '1995-08-24', '134356789', '245 Cozine Ave', 'High Blood Pressure, Sickle Cell Anemia'),
(2, 'Lyon Johnson', 'Male', '1976-09-28', '14541235', '155 Van Sicilen Ave', 'Leukemia'),
(3, 'Emma Smith', 'Female', '1980-02-14', '16560987654', '444 Washington Ave', 'Migraines'),
(4, 'Albert Carr', 'Male', '1951-03-15', '19897651234', '145 Delaware Ave', 'None'),
(5, 'Gracie Gwen', 'Female', '1967-04-18', '15431234567', '555 Blake St', 'None'),
(6, 'Gregory Owens', 'Male', '1976-05-27', '19091236789', '155 Freeport Loop', 'Diabetes'); */
(7, 'Grantley Johns', 'Male', '1997-04-24', '16560987654', '578 Maple Dr', 'Brain Cancer');
(8, 'Brianna Stewart', 'Female', '1994-05-14', '19891234567', '777 Lucky St', 'Seizures');
SELECT * FROM Patients;

Inserting Data into Doctors Table:
INSERT INTO Doctors (doctor_id, name, specialty, contact_number, email)
VALUES
(1, 'Dr. Royce Lewis', 'Endocrinologist', '14561234567', 'royce.j@hospital.com'),
(2, 'Dr. Prajeet Patel', 'Neurologist', '15941237890', 'prajeet.p@hospital.com'),
(3, 'Dr. Angela Garcia', 'Pathologist', '16567891234', 'angela.g@hospital.com'),
(4, 'Dr. Laura Adams', 'Neuro Surgeon', '19894341245', 'laura.a@hospital.com');

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time , appointment_status)
VALUES 
(1, 1, '2025-09-11', '09:30:00', 'Scheduled'),
(2, 2, '2025-09-12', '12:00:00', 'Scheduled'),
(3, 3, '2025-09-15', '08:00:00', 'Completed'),
(4, 4, '2025-09-16', '11:30:00', 'Scheduled'),
(5, 3, '2025-09-17', '01:00:00', 'Cancelled'),
(6, 2, '2025-09-18', '02:00:00', 'Scheduled')
(7, 3, '2025-03-14', '11:45:00', 'Completed'); 
(8, 1, '2025-02-14', '9:45:00', 'Completed');
ALTER TYPE status ADD VALUE 'Cancelled' AFTER 'Completed';

INSERT INTO Billing (patient_id, doctor_id, bill_date, amount, billing_status)
VALUES
(1, 1, '2025-09-11', 400.00, 'Paid'),
(2, 2, '2025-09-12', 1300.00, 'Pending'),
(3, 3, '2025-09-15', 600.00, 'Pending'),
(4, 4, '2025-09-16', 500.00, 'Paid'),
(5, 3, '2025-09-17', 800.00, 'Cancelled'),
(6, 2, '2025-09-18', 1800.00, 'Paid')
(7, 3, '2025-03-14', 5000.00, 'Pending')
(8, 1, '2025-02-14', 3050.00, 'Paid');

SELECT * FROM Patients;
SELECT medical_history FROM Patients WHERE patient_id = 2;
SELECT * FROM Doctors;
SELECT * FROM Appointments WHERE appointment_status = 'Scheduled';
SELECT * FROM Appointments WHERE patient_id = 2;
SELECT * FROM Appointments WHERE doctor_id = 2;
UPDATE Appointments SET appointment_status = 'Completed' WHERE patient_id = 2; 

SELECT * FROM Appointments;
INSERT INTO Billing (patient_id, doctor_id, bill_date, amount, billing_status)
VALUES (1, 1, '2025-09-30', 500.00, 'Pending'); 
SELECT * FROM Billing;
SELECT * FROM Billing WHERE billing_status = 'Pending';
SELECT SUM(amount) FROM Billing WHERE patient_id = 1;

UPDATE Billing SET billing_status = 'Paid' WHERE bill_id = 1;
SELECT COUNT(*) FROM Patients;
Returns the total number of patients in the database
SELECT Patients.name		-- Selects the name of the patients
FROM Patients				-- From the Patients table
INNER JOIN Appointments ON Patients.patient_id = Appointments.patient_id		-- Joins with Appointments table on patient_id
WHERE Appointments.doctor_id = 4; 		-- Filters results for appointments with a specific doctor */

SELECT * 
FROM Billing
WHERE EXTRACT(MONTH FROM bill_date) = 09
AND EXTRACT(YEAR FROM bill_date) = 2025; 

SELECT p.name, COUNT(DISTINCT a.doctor_id) AS doctor_count 			-- Selects patient name and counts the distinct number of doctors the patient has seen
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id
HAVING doctor_count > 1;

SELECT d.name AS doctor_name, COUNT(a.appointment_id) AS total_appointments 					-- Selects the doctor's name and counts the total number of appointments
FROM Doctors d																					-- From the Doctors table (alias 'd')
JOIN Appointments a ON d.doctor_id = a.doctor_id												-- Joins the Appointments table on doctor_id to match each doctor with their appointments
WHERE EXTRACT(MONTH FROM a.appointment_date) = 09 AND EXTRACT(YEAR FROM a.appointment_date) = 2025	-- Filters the appointments to only include those from September 2025	
GROUP BY d.doctor_id
ORDER BY total_appointments DESC;


-- Retrieve Total Income Generated From Appointments for Each Doctor
SELECT d.name AS doctor_name, SUM(b.amount) AS total_income 				-- Selects the doctor's name and sums up the total income from paid bills
FROM Doctors d
JOIN Billing b ON d.doctor_id = b.doctor_id
WHERE b.billing_status = 'Paid'
GROUP BY d.doctor_id;

-- Find Patients Who Have Not Paid Their Bills (Pending Bills)
SELECT p.name, b.amount, b.bill_date
FROM Patients p
JOIN Billing b ON p.patient_id = b.patient_id
WHERE b.billing_status = 'Pending'; 

-- Get a List of Patients Who Have Missed (Cancelled) Appointments
SELECT p.name, a.appointment_date							-- Selects the patient's name and the appointment date
FROM Patients p												-- From the Patients table (alias 'p')
JOIN Appointments a ON p.patient_id = a.patient_id			-- Joins the Appointments table on patient_id to match patients with their appointments
WHERE a.appointment_status = 'Cancelled';					-- Filters the results to include only appointments that have a status of 'Cancelled'


SELECT AVG(amount) AS average_bill_amount				-- Calculates the average of the 'amount' field and assigns it an alias 'average_bill_amount'
FROM Billing;	
-- Retrieves data from the 'Billing' table
-- Find the most Frequent Patients TOP 3
SELECT p.name, COUNT(a.appointment_id) AS total_appointments		-- Selects the patient's name and counts the total number of appointments for each patient
FROM Patients p														-- Retrieves data from the 'Patients' table
JOIN Appointments a ON p.patient_id = a.patient_id					-- Joins the 'Appointments' table on patient_id to match patients with their appointments
GROUP BY p.patient_id												-- Groups the results by patient_id to aggregate the count of appointments per patient
ORDER BY total_appointments DESC									
LIMIT 3;															-- Limits the results to the top 3 patients with the most appointments


-- Retrieve All Patients Who Have Been Assigned to a Specific Doctor
SELECT p.name												-- Selects the patient's name
FROM Patients p 											-- Retrieves data from the 'Patients' table
JOIN Appointments a ON p.patient_id = a.patient_id 			-- Joins the 'Appointments' table with 'Patients' based on matching patient_id
WHERE a.doctor_id = 3; */

-- GET Total Appointments Per Day
SELECT appointment_date,							-- Selects the appointment date
	   COUNT(appointment_id) AS total_appointments	-- Counts the total # of appointments
FROM Appointments 									-- Retrieves data from the 'Appointments' table
GROUP BY appointment_date;						-- Groups the result by each unique appointment date


SELECT p.name
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
AND a.appointment_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
WHERE a.appointment_id IS NULL; 

SELECT p.name AS patient_name, d.name AS doctor_name, b.amount
FROM Billing b
JOIN Patients p ON b.patient_id = p.patient_id
JOIN Doctors d ON b.doctor_id = d.doctor_id
WHERE b.billing_status = 'Paid';

SELECT EXTRACT(MONTH FROM b.bill_date) AS month, EXTRACT(YEAR FROM b.bill_date) AS year, SUM(B.amount) AS total_revenue
FROM Billing b
WHERE b.billing_status = 'Paid'
GROUP BY EXTRACT(YEAR FROM b.bill_date), EXTRACT(MONTH FROM b.bill_date);

SELECT p.name, a.appointment_date, a.appointment_status AS appointment_status, b.billing_status
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
LEFT JOIN Billing b ON p.patient_id = b.patient_id;

	  
