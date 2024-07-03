--Name: Danish Badar Qureshi
--ERP: 22890

--DATABASE SYSTEMS - PROJECT: "CASE STUDY 1 - PAINTING HIRE BUSINESS"
--Submitted to: Ms. Samreen Kazi

--THE FOLLOWING SCRIPT IS A DEMONSTRATION TO SHOW ALL THE PROCEDURES ARE FUNCTIONING PROPERLY

--Additionally, to show the working of procedures which update/insert the table, a select query is run to show that change
--Before running the reports, it is important to enable 'DBMS_Output' for the connection, as well as 'set serverouput on' 
--to show the output on the 'script output' block

SET SERVEROUTPUT ON;

---------------------------------------------------------------------------------------------------------------------------

--------------Use Case No. 1: Add Artist
--the website would make sure that country id is between 1 to 228 through a drop down menu
--in addition there is also a foreign key constraint in the database
--dead artist - calls another procedure addArtistDead

--parameters(p_name varchar2, p_countryofbirthid int, p_birthdate date, p_deathdate date)
execute addArtist('Da Vinci', '103', TO_DATE('1452-04-15','YYYY-MM-DD'), TO_DATE('1519-05-02','YYYY-MM-DD'));

--alive artist -- calls another procedure addArtistAlive
execute addArtist('Danish', '156', TO_DATE('1999-06-21','YYYY-MM-DD'), null);

select * from mp_Artist;

--------------Use Case No.2: Add Customer
--the website would make sure that the caterogy can only be between 1-4 through a drop down menu
--in addition there is also a foreign key constraint in the database
--CategoryID = 1 - Bronze
--CategoryID = 2 - Silver
--CategoryID = 3 - Gold
--CategoryID = 4 - Platinum

--parameters(p_name varchar2, p_address varchar2, p_category int)
execute addCustomer('Danish','Karachi', 4);

select * from mp_Customer;

--------------Use Case No.3: Add Owner
--parameters(p_name varchar2, p_telephone varchar2, p_address varchar2)
execute addOwner('Danish', '021222222', 'Karachi'); 
--the website would make sure that the phone number is valid
select * from mp_Owner;

--------------Use Case No.4: Add Painting
--parameters(p_title varchar2, p_themeid int, p_price float, p_artistID int, p_ownerID int)
execute addPainting('Mona Lisa', 5, 1000, 24, 11);
--the website would make sure that the owner id and aritist id is valid by checking it from their table
--in addition there are also a foreign key constraints for both in the database
select * from mp_Painting;

--------------Use Case No.5: Rent a Painting
delete from mp_painting where id = 300;
delete from mp_customer where id = 300;
insert into mp_painting values (300, 'Painting 1', 1, 1, 1, 10.0, 1, TO_DATE('2022-01-01','YYYY-MM-DD'), NULL);
insert into mp_customer values (300, 'Customer 1', 'Karachi', 1);

--parameters(p_paintingID int, p_customerID int, p_noOfMonths int)
execute RentPainting(300, 300, 5);
select * from mp_paintingRental;

--------------Use Case No.6: Search Painting by Artist
--the website would make sure that the artistID entered is valid and has a valid artist
--in addition there is also a foreign key constraint in the database
--parameters(p_ArtistID int)
execute SearchPaintingByArtist(2);

--------------Use Case No.7: Search Painting by Theme
--the website would make sure that the themeID entered is valid through a drop down menu
--in addition there is also a foreign key constraint in the database
--ThemeID = 1 - animal
--ThemeID = 2 - landscape
--ThemeID = 3 - seascape
--ThemeID = 4 - naval
--ThemeID = 5 - still life
--parameters(p_themeID int)
execute SearchPaintingByTheme(5);

--------------Use Case No.8: Resubmit a Returned Painting

--insetion of appropriate data
delete from mp_painting where id = 100;
delete from mp_painting where id = 200;
insert into mp_painting values (100, 'Sea View', 1, 3, 4, 10.0, 3, TO_DATE('2022-01-31','YYYY-MM-DD'), TO_DATE('2022-7-01','YYYY-MM-DD'));
insert into mp_painting values (200, 'Mountains', 1, 3, 4, 100.0, 3, TO_DATE('2022-05-31','YYYY-MM-DD'), TO_DATE('2022-11-01','YYYY-MM-DD'));

--StatusID = 1 - Painting Available
--StatusID = 2 - Painting Rented
--StatusID = 3 - Painting Returned

--parameters(p_paintingID int)
--id = 100 has been returned since more than 3 months so would return successfully
execute ResubmitPainting(100);
select * from mp_painting;

--id = 200 has been returned, but since less than 3 months so would not return and DBMS_ouput would say error
execute ResubmitPainting(200);
select * from mp_painting;

--------------Use Case No.9: Customer Return Painting
--isert appropriate data
delete from mp_painting where id = 150;
delete from mp_paintingRental where id = 151;

insert into mp_painting values (150, 'My Painting', 2, 1, 4, 10.0, 2, TO_DATE('2022-07-15','YYYY-MM-DD'), NULL);
insert into mp_paintingRental values(151, 150, 4, TO_DATE('2022-09-03','YYYY-MM-DD'), TO_DATE('2023-01-29','YYYY-MM-DD'));

--parameters(p_rentalID int)
execute customerReturnPainting(151);
--the procedure above changes EndDate in mp_PaintingRental to today's date and change the statusID to 1 in mp_Painting;

select * from mp_painting;
select * from mp_paintingRental;

--------------Use Case No.10: Customer Rental Report
--parameters(p_CustomerID int)
execute CustomerRentalReport(3);

--------------Use Case No.11: Artist Report
--parameters(p_ArtistID int)
execute ArtistReport(2);

--------------Use Case No.12: Return To Owner Report
--parameters(p_OwnerID int)
execute ReturnToOwnerReport(3);