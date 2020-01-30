import mysql.connector
from tabulate import tabulate


def showQuery(mydb, query, h):
    mycursor = mydb.cursor()
    mycursor.execute(query)
    myresult = mycursor.fetchall()

    if mycursor.rowcount != 0:
        print(tabulate(myresult, headers=h, tablefmt='psql'))
    else:
        print("No Result")


def run(ID, MyDB):
    print('-------------------------------')
    print('Wellcome ' + str(ID) + ' To Admin Panel')
    while(True):
        print('-------------------------------')
        print("Choose One Of Below Options To Continue: ")
        print("""
        1.Show Average Charity's Population Per Region
        2.Show Drivers With Average Score More Than 4
        3.Show Min And Max Score For Each Driver
        4.Show Restaurants Ordered By Donated Food Amount
        5.Show Driver With Maximum State Changes
        6.Show Most Needful Charities
        7.Show Today's Deliveries With Driver Score More Than Avg 
        """)

        ans = input("Your Answer: ")
        if ans == '1':
            showQuery(MyDB,
                      """
            SELECT CONCAT(City, ', ', Region) as Region, AVG(Population) as AvgPopulation
            FROM charity
            GROUP BY CONCAT(City, ', ', Region);
            """,
                      ['Region', 'AvgPopulation'])
        elif ans == '2':
            showQuery(MyDB,
                      """
            SELECT CONCAT(FirstName, ' ', LastName) as Name, AVG(Rate) as RateAvg
            FROM delivery
                    INNER JOIN driver d on delivery.DriverID = d.ID
            GROUP BY DriverID
            HAVING (AVG(Rate) >= 4);
            """,
                      ['Name', 'RateAvg'])
        elif ans == '3':
            showQuery(MyDB,
                      """
            SELECT CONCAT(FirstName, ' ', LastName) as Name, MIN(Rate) as MinRate, MAX(Rate) as MaxRate
            FROM delivery
                    INNER JOIN driver d on delivery.DriverID = d.ID
            GROUP BY DriverID;
            """,
                      ['Name', 'MinRate', 'MaxRate'])
        elif ans == '4':
            showQuery(MyDB,
                      """
            SELECT Name, SUM(Count) as SentFood
            FROM delivery
                    INNER JOIN restaurant r on delivery.RestaurantID = r.ID
            GROUP BY RestaurantID
            ORDER BY SentFood DESC;
            """,
                      ['Name', 'DonatedAmount'])
        elif ans == '5':
            showQuery(MyDB,
                      """
            SELECT DriverID, CONCAT(FirstName, ' ', LastName) as Name, COUNT(driver_log.ID) as ChangeCount
            FROM driver_log
            INNER JOIN driver d on driver_log.DriverID = d.ID
            WHERE Date >= SUBDATE(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
            GROUP BY DriverID
            ORDER BY ChangeCount DESC
            LIMIT 1;
            """,
                      ['DriverID', 'Name', 'Change Count'])
        elif ans == '6':
            showQuery(MyDB,
                      """
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
            """,
                      ['Name', 'TakenFood', 'Population', 'ContractedRestaurants', 'Score'])
        elif ans == '7':
            showQuery(MyDB,
                      """
            SELECT CONCAT(d.FirstName, ' ', d.LastName) as DriverName, c.Name as CharityName, r.Name as RestaurantName, Rate as DriverRate
            FROM delivery
            INNER JOIN charity c on delivery.CharityID = c.ID
            INNER JOIN restaurant r on delivery.RestaurantID = r.ID
            INNER JOIN driver d on delivery.DriverID = d.ID
            WHERE Date = CURRENT_DATE() AND Rate > (SELECT AVG(Rate) FROM delivery);
            """,
                      ['Driver Name', 'Charity Name', 'Restaurant Name', 'Driver Rate'])
        else:
            print("Wrong Choice!")

        ans = input("Do You Want To Continue? (y/N): ")
        if ans == "Y" or ans == "y":
            continue
        break
