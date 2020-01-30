# Admin Queries
SELECT CONCAT(City, ', ', Region) as Region, AVG(Population)
FROM charity
GROUP BY CONCAT(City, ', ', Region);

SELECT CONCAT(FirstName, ' ', LastName) as Name, AVG(Rate) as RateAvg
FROM delivery
         INNER JOIN driver d on delivery.DriverID = d.ID
GROUP BY DriverID
HAVING (AVG(Rate) >= 4);

SELECT CONCAT(FirstName, ' ', LastName) as Name, MIN(Rate) as MinRate, MAX(Rate) as MaxRate
FROM delivery
         INNER JOIN driver d on delivery.DriverID = d.ID
GROUP BY DriverID;

SELECT Name, SUM(Count) as SentFood
FROM delivery
         INNER JOIN restaurant r on delivery.RestaurantID = r.ID
GROUP BY RestaurantID
ORDER BY SentFood DESC;

SELECT DriverID, CONCAT(FirstName, ' ', LastName) as Name, COUNT(driver_log.ID) as ChangeCount
FROM driver_log
         INNER JOIN driver d on driver_log.DriverID = d.ID
WHERE Date >= SUBDATE(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
GROUP BY DriverID
ORDER BY ChangeCount DESC
LIMIT 1;

SELECT Name, Population
FROM charity;


SELECT t1.Name, TakenFood, Population, ContractedRestaurants, (TakenFood * ContractedRestaurants / Population) as Score
FROM ((SELECT c.Name, SUM(Count) as TakenFood
       FROM delivery
                INNER JOIN charity c on CharityID = c.ID
       GROUP BY CharityID)
      UNION
      (SELECT Name, 0 as TakenFood
       FROM charity
       WHERE ID NOT IN (SELECT DISTINCT CharityID FROM delivery d))
     ) as t1
         INNER JOIN (SELECT c7.Name, Population, ContractedRestaurants
                     FROM charity as c7
                              INNER JOIN ((SELECT Name, COUNT(RestaurantID) as ContractedRestaurants
                                           FROM contract
                                                    INNER JOIN charity c on contract.CharityID = c.ID
                                           GROUP BY CharityID)
                                          UNION
                                          (SELECT Name, 0 as ContractedRestaurants
                                           FROM charity
                                           WHERE ID NOT IN (SELECT DISTINCT CharityID FROM contract))) as t3
                                         ON t3.Name = c7.Name
) c2 ON c2.Name = t1.Name
ORDER BY Score DESC;

SELECT CONCAT(d.FirstName, ' ', d.LastName) as DriverName,
       c.Name                               as CharityName,
       r.Name                               as RestaurantName,
       Rate                                 as DriverRate
FROM delivery
         INNER JOIN charity c on delivery.CharityID = c.ID
         INNER JOIN restaurant r on delivery.RestaurantID = r.ID
         INNER JOIN driver d on delivery.DriverID = d.ID
WHERE Date = CURRENT_DATE()
  AND Rate > (SELECT AVG(Rate) FROM delivery);

# Restaurant Queries
SET @RestID = 'Akbar';

SELECT DISTINCT Name
FROM contract
         INNER JOIN restaurant r on contract.RestaurantID = r.ID
WHERE CharityID IN (SELECT CharityID FROM contract WHERE RestaurantID = @RestID)
  AND RestaurantID != @RestID;

SELECT Name as CharityName
FROM delivery
         INNER JOIN charity c on delivery.CharityID = c.ID
WHERE RestaurantID = @RestID
  AND CharityID IN (SELECT CharityID FROM contract WHERE contract.RestaurantID = @RestID)
GROUP BY CharityID
ORDER BY SUM(Count)
LIMIT 1;

#Skip

# Driver Queries
SET @DriverID = 'A.Reza';

SELECT CONCAT(City, ', ', Region) as Region, COUNT(ID) as DriversCount
FROM driver
WHERE State = 'Free'
GROUP BY CONCAT(City, ', ', Region);

SELECT Name, COUNT(DeliveryID) as DeliverCount
FROM delivery
         INNER JOIN restaurant r on delivery.RestaurantID = r.ID
WHERE DriverID = @DriverID
GROUP BY RestaurantID
ORDER BY DeliverCount DESC;

# Extra Needed
SELECT contract.CharityID, Name, GREATEST(DailyUsage - TodayReceive, 0) as NeededFood
FROM contract
INNER JOIN charity c on contract.CharityID = c.ID
INNER JOIN (SELECT CharityID, SUM(Count) as TodayReceive FROM delivery WHERE Date = CURRENT_DATE AND State = 'Done' GROUP BY CharityID) s ON s.CharityID = contract.CharityID
WHERE RestaurantID = @RestID;

INSERT INTO delivery(RestaurantID, CharityID, Count)
    VALUES ('Ahmad', 'Saeed', 12);

(SELECT ID, Name
FROM charity) ;

SELECT DeliveryID, c.Name as CharityName
FROM delivery
INNER JOIN charity c on delivery.CharityID = c.ID
INNER JOIN restaurant r on delivery.RestaurantID = r.ID
WHERE r.Region = (SELECT Region FROM driver WHERE ID = @DriverID)
AND
      State = 'Not Send';


UPDATE delivery
SET DriverID = @DriverID, State = 'In Progress'
WHERE DriverID IS NULL AND DeliveryID = 10;

UPDATE delivery
SET DriverID = @DriverID, State = 'Done'
WHERE DeliveryID = (SELECT DeliveryID FROM delivery WHERE DriverID = @DriverID AND State = 'In Progress');

SELECT CONCAT(FirstName, ' ', LastName) AS Name, State
FROM driver
WHERE ID = @DriverID;

UPDATE driver
SET Region = 'AhmadAbad'
WHERE ID = @DriverID;

SELECT DeliveryID, CharityID, CONCAT(FirstName, ' ', LastName) AS Name
FROM delivery
INNER JOIN driver d on delivery.DriverID = d.ID
WHERE CharityID = 'Reza' AND Rate = 0;

UPDATE delivery
SET Rate = 4
WHERE DeliveryID = 10;

INSERT INTO contract(RestaurantID, CharityID)
    VALUES ('Akbar', 'Reza');

UPDATE charity
SET DailyUsage = 45
WHERE ID = 'Hamid';

UPDATE user
SET Password = '1234abcd'
WHERE Username = 'Mobin';

SELECT *
FROM security_question;

SELECT SecurityQuestion FROM user INNER JOIN security_question sq on user.SecurityQuestion = sq.ID WHERE Username = 'abcd';

UPDATE charity
SET Name = 'Haideh'
where ID = 'Reza';

UPDATE user
SET Password = 'hi1234hi'
where Username = 'Reza';

DELETE from user
WHERE Username = 'Reza';

DELETE FROM  charity
WHERE ID = 'Reza';

DELETE FROM contract
WHERE CharityID = 'Reza';

DELETE FROM delivery
WHERE CharityID = 'Reza';


UPDATE driver
SET State = 'Free'
WHERE State != 'Busy' AND ID = 'Qolam';
