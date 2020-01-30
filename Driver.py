import mysql.connector
from tabulate import tabulate


def showQueryA(mydb, query, h, args):
    mycursor = mydb.cursor()
    mycursor.execute(query, args)
    myresult = mycursor.fetchall()

    if mycursor.rowcount != 0:
        print(tabulate(myresult, headers=h, tablefmt='psql'))
    else:
        print("No Result")


def justExec(mydb, query, args):
    mycursor = mydb.cursor()
    mycursor.execute(query, args)


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
    print('Wellcome ' + str(ID) + ' To Driver Panel')
    while(True):
        print('-------------------------------')
        print("Choose One Of Below Options To Continue: ")
        print("""
        1.Show Available Drivers Count In Each Region
        2.Show List Of Restaurants That You Deliver Food To Them
        3.Show Orders
        4.Get Job
        5.Finish Delivering
        6.Get Current State
        7.Change Region
        8.Change Location
        9.Set Me Free
        10.Set Me Not Available
        11.Delete Acount
        """)

        ans = input("Your Answer: ")
        if ans == '1':
            showQuery(MyDB,
                      """
            SELECT CONCAT(City, ', ', Region) as Region, COUNT(ID) as DriversCount
            FROM driver
            WHERE State = 'Free'
            GROUP BY CONCAT(City, ', ', Region);
            """,
                      ['Region', 'Drivers Count'])
        elif ans == '2':
            showQueryA(MyDB,
                       """
            SELECT Name, COUNT(DeliveryID) as DeliverCount
            FROM delivery
            INNER JOIN restaurant r on delivery.RestaurantID = r.ID
            WHERE DriverID = %s
            GROUP BY RestaurantID
            ORDER BY DeliverCount DESC;
            """,
                       ['Name', 'Delivery Count'], (ID,))
        elif ans == '3':
            showQueryA(MyDB,
                       """
            SELECT DeliveryID, c.Name as CharityName
            FROM delivery
            INNER JOIN charity c on delivery.CharityID = c.ID
            INNER JOIN restaurant r on delivery.RestaurantID = r.ID
            WHERE r.Region = (SELECT Region FROM driver WHERE ID = %s)
            AND
                State = 'Not Send';
            """,
                       ['ID', 'Charity Name'], (ID,))
        elif ans == '4':
            jobId = input("Enter Job ID: ")
            justExec(MyDB,
                     """
            UPDATE delivery
            SET DriverID = %s, State = 'In Progress'
            WHERE DriverID IS NULL AND DeliveryID = %s
            """,
                     (ID, jobId,))
        elif ans == '5':
            justExec(MyDB,
                     """
            UPDATE delivery
            SET DriverID = %s, State = 'Done'
            WHERE DeliveryID = (SELECT DeliveryID FROM delivery WHERE DriverID = %s AND State = 'In Progress')
            """, (ID, ID,))
        elif ans == '6':
            justExec(MyDB,
                     """
            SELECT CONCAT(FirstName, ' ', LastName) AS Name, State
            FROM driver
            WHERE ID = %s
            """, (ID,))
        elif ans == '7':
            region = input("Enter Your New Region: ")
            justExec(MyDB,
                     """
            UPDATE driver
            SET Region = %s
            WHERE ID = %s
            """, (region, ID,))
        elif ans == '8':
            x = input("Enter New X: ")
            y = input("Enter New Y: ")
            justExec(MyDB,
                     """
            UPDATE driver
            SET Lat = %s, Lng = %s
            WHERE ID = %s
            """, (x, y, ID,)
            )
        elif ans == '9':
            justExec(MyDB,
                     """
            UPDATE driver
            SET State = 'Free'
            WHERE State != 'Busy' AND ID = %s;
            """, (ID,))
        elif ans == '10':
            justExec(MyDB,
                     """
            UPDATE driver
            SET State = 'NotAvailable'
            WHERE State != 'Busy' AND ID = %s;
            """, (ID,)
            )
        elif ans == '11':
            justExec(MyDB,
                     """
            DELETE FROM user
            WHERE Username = %s;   

            """, (ID, ))
            break
        else:

            print("Wrong Choice!")

        ans = input("Do You Want To Continue? (y/N): ")
        if ans == "Y" or ans == "y":
            continue
        break
