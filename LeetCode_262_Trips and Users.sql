Create table If Not Exists Trips (Id int, Client_Id int, Driver_Id int, City_Id int, Status ENUM('completed', 'cancelled_by_driver', 'cancelled_by_client'), Request_at varchar(50))
Create table If Not Exists Users (Users_Id int, Banned varchar(50), Role ENUM('client', 'driver', 'partner'))
Truncate table Trips
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03')
Truncate table Users
insert into Users (Users_Id, Banned, Role) values ('1', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('2', 'Yes', 'client')
insert into Users (Users_Id, Banned, Role) values ('3', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('4', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('10', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('11', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('12', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('13', 'No', 'driver')




-- Table: Trips

-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | Id          | int      |
-- | Client_Id   | int      |
-- | Driver_Id   | int      |
-- | City_Id     | int      |
-- | Status      | enum     |
-- | Request_at  | date     |     
-- +-------------+----------+
-- Id is the primary key for this table.
-- The table holds all taxi trips. Each trip has a unique Id, while Client_Id and Driver_Id are foreign keys to the Users_Id at the Users table.
-- Status is an ENUM type of (�completed�, �cancelled_by_driver�, �cancelled_by_client�).
 

-- Table: Users

-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | Users_Id    | int      |
-- | Banned      | enum     |
-- | Role        | enum     |
-- +-------------+----------+
-- Users_Id is the primary key for this table.
-- The table holds all users. Each user has a unique Users_Id, and Role is an ENUM type of (�client�, �driver�, �partner�).
-- Status is an ENUM type of (�Yes�, �No�).
 

-- Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03".

-- The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.

-- Return the result table in any order. Round Cancellation Rate to two decimal points.

-- The query result format is in the following example:

 

-- Trips table:
-- +----+-----------+-----------+---------+---------------------+------------+
-- | Id | Client_Id | Driver_Id | City_Id | Status              | Request_at |
-- +----+-----------+-----------+---------+---------------------+------------+
-- | 1  | 1         | 10        | 1       | completed           | 2013-10-01 |
-- | 2  | 2         | 11        | 1       | cancelled_by_driver | 2013-10-01 |
-- | 3  | 3         | 12        | 6       | completed           | 2013-10-01 |
-- | 4  | 4         | 13        | 6       | cancelled_by_client | 2013-10-01 |
-- | 5  | 1         | 10        | 1       | completed           | 2013-10-02 |
-- | 6  | 2         | 11        | 6       | completed           | 2013-10-02 |
-- | 7  | 3         | 12        | 6       | completed           | 2013-10-02 |
-- | 8  | 2         | 12        | 12      | completed           | 2013-10-03 |
-- | 9  | 3         | 10        | 12      | completed           | 2013-10-03 |
-- | 10 | 4         | 13        | 12      | cancelled_by_driver | 2013-10-03 |
-- +----+-----------+-----------+---------+---------------------+------------+

-- Users table:
-- +----------+--------+--------+
-- | Users_Id | Banned | Role   |
-- +----------+--------+--------+
-- | 1        | No     | client |
-- | 2        | Yes    | client |
-- | 3        | No     | client |
-- | 4        | No     | client |
-- | 10       | No     | driver |
-- | 11       | No     | driver |
-- | 12       | No     | driver |
-- | 13       | No     | driver |
-- +----------+--------+--------+

-- Result table:
-- +------------+-------------------+
-- | Day        | Cancellation Rate |
-- +------------+-------------------+
-- | 2013-10-01 | 0.33              |
-- | 2013-10-02 | 0.00              |
-- | 2013-10-03 | 0.50              |
-- +------------+-------------------+

-- On 2013-10-01:
--  - There were 4 requests in total, 2 of which were canceled.
-- - However, the request with Id=2 was made by a banned client (User_Id=2), so it is ignored in the calculation.
--  - Hence there are 3 unbanned requests in total, 1 of which was canceled.
--  - The Cancellation Rate is (1 / 3) = 0.33
-- On 2013-10-02:
-- - There were 3 requests in total, 0 of which were canceled.
--  - The request with Id=6 was made by a banned client, so it is ignored.
--  - Hence there are 2 unbanned requests in total, 0 of which were canceled.
--  - The Cancellation Rate is (0 / 2) = 0.00
-- On 2013-10-03:
--  - There were 3 requests in total, 1 of which was canceled.
--  - The request with Id=8 was made by a banned client, so it is ignored.
--  - Hence there are 2 unbanned request in total, 1 of which were canceled.
--  - The Cancellation Rate is (1 / 2) = 0.50



SELECT t.request_at AS Day, ROUND(SUM(CASE WHEN t.status = 'completed' THEN 0 ELSE 1 END) / (SELECT COUNT(t.status)), 2) AS 'Cancellation Rate' FROM 
(SELECT *
FROM trips
INNER JOIN users 
ON trips.client_id = users.users_id 
WHERE users.banned = 'No') AS t 
GROUP BY t.request_at
HAVING t.request_at BETWEEN '2013-10-01' AND '2013-10-03';