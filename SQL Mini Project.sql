-- Users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    user_role VARCHAR(20),
    email VARCHAR(100),
    created_at DATE
);

-- Technicans Table
CREATE TABLE technicans (
    tech_id INT PRIMARY KEY,
    tech_name VARCHAR(100),
    department VARCHAR(50)
);

-- Tickets table
CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    user_id INT,
    CONSTRAINT FOREIGN KEY (user_id)
        REFERENCES users (user_id),
    tech_id INT NULL,
    issue_type VARCHAR(50),
    priority VARCHAR(10),
    ticket_status VARCHAR(20),
    created_date DATE,
    resolved_date DATE NULL
);

-- Table check
describe users;
describe tickets;

-- Sample Data for Users table
insert into users
values  ('1', 'Trey', 'Bird', 'Staff', 'TreyB@gmail.com', '2025-11-17'), 
		('2', 'Dylan', 'Reinhard', 'Staff', 'DylanR@gmail.com', '2025-11-17'), 
        ('3', 'Rashid', 'Hamid', 'Faculty', 'RashidH@gmail.com', '2025-12-01'), 
        ('4', 'Karim', 'Hamid', 'Faculty', 'KarimH@gmail.com', '2025-12-12'), 
        ('5', 'Sam', 'Crawford', 'Student', 'SamCrawford@gmail.com', '2025-12-18'), 
        ('6', 'Harrison', 'Smith', 'Student', 'HarrisonSmith@gmail.com', '2026-01-02');
SELECT 
    *
FROM
    users;

-- Sample Data for Technicans Table
insert into technicans
values  (1145, 'KJ Taffa', 'IT'), 
		(1146, 'Abrianna McCurdy', 'IT'), 
        (1147, 'Emiliano Rosas', 'IT');
SELECT 
    *
FROM
    technicans;

-- Sample Data for Tickets Table
insert into tickets
values  (1, 1, 1145, 'Security Incident', 'High', 'Resolved', '2025-11-30', '2025-12-06'), 
		(2, 5, 1147, 'Passowrd Reset', 'Medium', 'Resolved', '2025-12-14', '2026-12-14'), 
        (3, 2, 1146, 'Email System Down' , 'High', 'Resolved', '2025-12-16', '2025-12-19'), 
        (4, 1, 1145, 'Security Incident','High', 'Resolved', '2025-12-17', '2025-12-24'), 
        (5, 1, 1147, 'Slow Computer', 'Medium', 'In Progress', '2025-12-30', null), 
        (6, 2, null, 'Monitor Setup Help', 'Low', 'Open', '2025-12-31', null), 
        (7, 4, null, 'Software Update Request', 'Low', 'Open', '2026-01-01', null), 
        (8, 4, 1146, 'Server Outage', 'High', 'Resolved', '2026-01-02', '2026-01-09'), 
        (9, 6, 1147, 'Network Outage' , 'High', 'In Progress', '2026-01-11', null),
        (10, 1, null, 'Hardware Request', 'Low', 'Open', '2026-01-11', null);
SELECT 
    *
FROM
    tickets;

-- Alter Table
alter table tickets
add column resolution_notes varchar(255);
SELECT 
    *
FROM
    tickets;

describe tickets;

-- Update Tickets table data
UPDATE tickets 
SET 
    resolution_notes = 'Isolated affected system, removed malicious files, and reset compromised credentials.'
WHERE
    ticket_id = 1;

UPDATE tickets 
SET 
    resolution_notes = 'Reset password and confirmed successful login to student portal.'
WHERE
    ticket_id = 2;

UPDATE tickets 
SET 
    resolution_notes = 'Resolved mail server configuration issue and restarted services. Email functionality restored.'
WHERE
    ticket_id = 3;

UPDATE tickets 
SET 
    resolution_notes = 'Reviewed logs and confirmed no further suspicous activity.'
WHERE
    ticket_id = 4;

UPDATE tickets 
SET 
    resolution_notes = 'Restarted VM and restored services. Monitored for stability post-recovery.'
WHERE
    ticket_id = 8;

SELECT 
    *
FROM
    tickets;

-- Join Practice
SELECT 
    t.ticket_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    tech.tech_name,
    t.ticket_status,
    t.priority
FROM
    tickets t
        JOIN
    users u ON t.user_id = u.user_id
        LEFT JOIN
    technicans tech ON t.tech_id = tech.tech_id;

-- Count ticket status
SELECT 
    ticket_status, COUNT(*) AS total
FROM
    tickets
GROUP BY ticket_status;

-- Technicians handling more than 3 tickets
SELECT 
    tech.tech_name, COUNT(t.ticket_id) AS total_tickets
FROM
    technicans tech
        JOIN
    tickets t ON tech.tech_id = t.tech_id
GROUP BY tech.tech_id
HAVING COUNT(t.ticket_id) > 3;

-- Delete Open and low priority tickets
DELETE FROM tickets 
WHERE
    priority = 'Low'
    AND ticket_status = 'Open';
SELECT 
    *
FROM
    tickets
WHERE
    priority = 'Low'
        AND ticket_status = 'Open';


SELECT 
    *
FROM
    tickets;
    