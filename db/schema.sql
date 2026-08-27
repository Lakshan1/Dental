-- Sunrise Dental Clinic - schema + seed data.
-- Runs automatically on first boot of the MySQL container (mounted into
-- /docker-entrypoint-initdb.d/ in docker-compose.yml).

CREATE TABLE IF NOT EXISTS users (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(150)  NOT NULL,
    email         VARCHAR(150)  NOT NULL UNIQUE,
    passwordHash  VARCHAR(255)  NOT NULL,
    role          VARCHAR(20)   NOT NULL,   -- 'staff' | 'admin' | 'doctor'
    status        VARCHAR(20)   NOT NULL DEFAULT 'active'  -- 'active' | 'leave' | 'restricted'
);

CREATE TABLE IF NOT EXISTS dentists (
    user_id           INT PRIMARY KEY,
    phone             VARCHAR(30),
    specialization    VARCHAR(100),
    consultation_fee  DECIMAL(10,2) NOT NULL DEFAULT 0,
    slot_minutes      INT NOT NULL DEFAULT 30,
    mon_start TIME, mon_end TIME,
    tue_start TIME, tue_end TIME,
    wed_start TIME, wed_end TIME,
    thu_start TIME, thu_end TIME,
    fri_start TIME, fri_end TIME,
    sat_start TIME, sat_end TIME,
    sun_start TIME, sun_end TIME,
    CONSTRAINT fk_dentists_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS patients (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nic             VARCHAR(20)   NOT NULL UNIQUE,
    name            VARCHAR(150)  NOT NULL,
    address         VARCHAR(255),
    contact_number  VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS appointments (
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    patient_id         INT NOT NULL,
    dentist_id         INT NOT NULL,
    treatment_type     VARCHAR(100),
    appointment_date   DATE NOT NULL,
    appointment_time   TIME NOT NULL,
    status             VARCHAR(20) NOT NULL DEFAULT 'scheduled', -- scheduled | completed | cancelled
    CONSTRAINT fk_appt_patient FOREIGN KEY (patient_id) REFERENCES patients(id),
    CONSTRAINT fk_appt_dentist FOREIGN KEY (dentist_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS bills (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id      INT NOT NULL UNIQUE,
    consultation_fee    DECIMAL(10,2) NOT NULL DEFAULT 0,
    treatment_amount    DECIMAL(10,2) NOT NULL DEFAULT 0,
    additional_fees     DECIMAL(10,2) NOT NULL DEFAULT 0,
    additional_notes    TEXT,
    total_amount        DECIMAL(10,2) NOT NULL DEFAULT 0,
    generated_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_bill_appt FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

-- Seed admin account so there's a way to log in on a fresh deploy.
-- email: admin@sunrisedental.com | password: admin123
-- CHANGE THIS PASSWORD after first login in any environment beyond local dev.
INSERT INTO users (name, email, passwordHash, role, status)
VALUES (
    'Admin',
    'admin@sunrisedental.com',
    '$2a$10$pZpp5/HdNS/NXGboiOO44uZAeD8aDOo2fMSpUaM3QlUBC6LzBn.xy',
    'admin',
    'active'
);