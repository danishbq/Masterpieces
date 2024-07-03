--Name: Danish Badar Qureshi
--ERP: 22890

--DATABASE SYSTEMS - PROJECT: "CASE STUDY 1 - PAINTING HIRE BUSINESS"
--Submitted to: Ms. Samreen Kazi

--THE FOLLOWING SCRIPT CREATES THE DATABASE, INCLUDING ALL TABLES, SEQUENCES, TRIGGERS, PROCEDURES, AND INSERTS SOME DUMMY DATA IN THE TABLES
--Note that mp_category, mp_ref_countries, mp_ref_status, mp_ref_themes must be inserted with given data as they will not be altered later

--Sequences are used to auto increment the primary key to keep all the ID's unique
--Trigger is used to implement the primary key into the mp_ref_countries table
--Cursors are also used in many procedures including the ones that generate reports and search results
-----------------------------------------------------------------------------------------------------

-------------------Table Creations

drop table mp_artist;
drop table mp_category;
drop table mp_customer;
drop table mp_owner;
drop table mp_painting;
drop table mp_paintingdetails;
drop table mp_paintingrental;
drop table mp_ref_countries;
drop table mp_ref_status;
drop table mp_ref_themes;

--Records all the 4 customer categories
create table mp_category (
    id int primary key,
    name varchar2(255),
    description varchar2(255),
    discount int
)

create table mp_customer (
    id int primary key,
    name varchar2(255),
    address varchar2(255),
    categoryid int, 
    
    constraint fk_categoryid foreign key (categoryid) references mp_category(id)
)

create table mp_painting (
    id int primary key,
    title varchar2(255),
    artistid int,
    ownerid int,
    themeid int,
    price float,
    statusid int,
    entrydate date,
    returnDate date,
    
    constraint fk_artistid foreign key (artistid) references mp_artist(id),
    constraint fk_ownerid foreign key (ownerid) references mp_owner(id),
    constraint fk_themeid foreign key (themeid) references mp_ref_themes(id),
    constraint fk_statusid foreign key (statusid) references mp_ref_status(id)
)

create table mp_artist (
    id int primary key,
    name varchar2(255),
    countryofbirthid int,
    birthdate date,
    deathdate date,
    
    constraint fk_countryofbirthid foreign key (countryofbirthid) references mp_ref_countries(id)
)

create table mp_owner (
    id int primary key,
    name varchar2(255),
    telephone varchar2(255),
    address varchar2(255)
)

--contains the list of all countries
create table mp_ref_countries (
    id int primary key,
    name varchar(255),
    iso varchar(2)
)

--contains list of all 3 painting status (availabe, rented, returned)
create table mp_ref_status (
    id int primary key,
    status varchar2(255)
)

create table mp_PaintingRental (
    id int primary key,
    Paintingid int,
    customerid int,
    startdate date,
    enddate date,
    
    constraint fk_paintingid foreign key (paintingid) references mp_painting(id),
    constraint fk_customerid foreign key (customerid) references mp_customer(id)
)

create table mp_PaintingDetails (
    id int primary key,
    Paintingid int,
    themeid int,

    constraint fk_paintingid1 foreign key (paintingid) references mp_painting(id),
    constraint fk_themeid foreign key (themeid) references mp_ref_themes(id)
)

--contains list of all 5 themes
create table mp_ref_themes (
    id int primary key,
    name varchar2(255)
)


-------------------------Sequeces (used to auto increment primary key (ID) in each table)
drop sequence seq_mp_artist;
drop sequence seq_mp_category;
drop sequence seq_mp_customer;
drop sequence seq_mp_owner;
drop sequence seq_mp_painting;
drop sequence seq_mp_paintingrental;
drop sequence seq_mp_ref_countries;
drop sequence seq_mp_ref_status;
drop sequence seq_mp_ref_themes;

CREATE SEQUENCE seq_mp_artist MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_mp_category MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_mp_customer MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_mp_owner MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_mp_painting MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_mp_paintingrental MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_mp_ref_countries MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_mp_ref_status MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_mp_ref_themes MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;

commit;


----------------------------Triggers

--explicit trigger to add primary key to ref_countries table and its list was taken from github
create or replace trigger trig_id_ref_countries
    before insert on mp_ref_countries
    for each row
    begin
        select seq_mp_ref_countries.nextval
        into :new.id
        from dual;
    end;
    
--------------------------Insertion of Data in Tables

--insert into mp_category (this is necessary)
insert into mp_category (id, name, description, discount)
values (seq_mp_category.nextval, 'Bronze', 'no discount', 0);

insert into mp_category (id, name, description, discount)
values (seq_mp_category.nextval, 'Silver', '5% discount', 5);

insert into mp_category (id, name, description, discount)
values (seq_mp_category.nextval, 'Gold', '10% discount', 10);

insert into mp_category (id, name, description, discount)
values (seq_mp_category.nextval, 'Platinum', '15% discount', 15);

--insert into mp_ref_countries (necessary)
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Afghanistan', 'AF');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Albania', 'AL');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Algeria', 'DZ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('American Samoa', 'AS');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Andorra', 'AD');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Angola', 'AO');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Anguilla', 'AI');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Antarctica', 'AQ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Antigua and Barbuda', 'AG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Argentina', 'AR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Armenia', 'AM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Aruba', 'AW');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Australia', 'AU');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Austria', 'AT');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Azerbaijan', 'AZ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Bahamas', 'BS');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Bahrain', 'BH');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Bangladesh', 'BD');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Barbados', 'BB');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Belarus', 'BY');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Belgium', 'BE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Belize', 'BZ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Benin', 'BJ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Bermuda', 'BM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Bhutan', 'BT');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Bosnia and Herzegovina', 'BA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Botswana', 'BW');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Bouvet Island', 'BV');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Brazil', 'BR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('British Indian Ocean Territory', 'IO');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Brunei Darussalam', 'BN');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Bulgaria', 'BG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Burkina Faso', 'BF');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Burundi', 'BI');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Cambodia', 'KH');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Cameroon', 'CM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Canada', 'CA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Cape Verde', 'CV');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Cayman Islands', 'KY');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Central African Republic', 'CF');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Chad', 'TD');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Chile', 'CL');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('China', 'CN');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Christmas Island', 'CX');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Cocos (Keeling) Islands', 'CC');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Colombia', 'CO');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Comoros', 'KM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Congo', 'CG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Cook Islands', 'CK');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Costa Rica', 'CR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Croatia', 'HR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Cuba', 'CU');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Cyprus', 'CY');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Czech Republic', 'CZ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Denmark', 'DK');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Djibouti', 'DJ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Dominica', 'DM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Dominican Republic', 'DO');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Ecuador', 'EC');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Egypt', 'EG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('El Salvador', 'SV');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Equatorial Guinea', 'GQ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Eritrea', 'ER');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Estonia', 'EE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Ethiopia', 'ET');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Falkland Islands (Malvinas)' ,'FK');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Faroe Islands', 'FO');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Fiji', 'FJ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Finland', 'FI');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('France', 'FR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('French Guiana', 'GF');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('French Polynesia', 'PF');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('French Southern Territories', 'TF');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Gabon', 'GA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Gambia', 'GM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Georgia', 'GE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Germany', 'DE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Ghana', 'GH');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Gibraltar', 'GI');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Greece', 'GR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Greenland', 'GL');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Grenada', 'GD');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Guadeloupe', 'GP');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Guam', 'GU');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Guatemala', 'GT');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Guernsey', 'GG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Guinea', 'GN');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Guinea-Bissau', 'GW');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Guyana', 'GY');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Haiti', 'HT');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Heard Island and McDonald Islands', 'HM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Holy See (Vatican City State)' ,'VA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Honduras', 'HN');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Hong Kong', 'HK');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Hungary', 'HU');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Iceland', 'IS');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('India', 'IN');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Indonesia', 'ID');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Iraq', 'IQ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Ireland', 'IE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Isle of Man', 'IM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Israel', 'IL');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Italy', 'IT');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Jamaica', 'JM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Japan', 'JP');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Jersey', 'JE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Jordan', 'JO');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Kazakhstan', 'KZ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Kenya', 'KE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Kiribati', 'KI');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Kuwait', 'KW');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Kyrgyzstan', 'KG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Lao Peoples Democratic Republic', 'LA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Latvia', 'LV');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Lebanon', 'LB');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Lesotho', 'LS');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Liberia', 'LR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Libya', 'LY');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Liechtenstein', 'LI');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Lithuania', 'LT');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Luxembourg', 'LU');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Macao', 'MO');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Madagascar', 'MG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Malawi', 'MW');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Malaysia', 'MY');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Maldives', 'MV');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Mali', 'ML');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Malta', 'MT');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Marshall Islands', 'MH');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Martinique', 'MQ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Mauritania', 'MR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Mauritius', 'MU');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Mayotte', 'YT');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Mexico', 'MX');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Monaco', 'MC');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Mongolia', 'MN');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Montenegro', 'ME');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Montserrat', 'MS');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Morocco', 'MA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Mozambique', 'MZ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Myanmar', 'MM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Namibia', 'NA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Nauru', 'NR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Nepal', 'NP');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Netherlands', 'NL');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('New Caledonia', 'NC');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('New Zealand', 'NZ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Nicaragua', 'NI');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Niger', 'NE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Nigeria', 'NG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Niue', 'NU');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Norfolk Island', 'NF');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Northern Mariana Islands', 'MP');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Norway', 'NO');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Oman', 'OM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Pakistan', 'PK');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Palau', 'PW');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Panama', 'PA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Papua New Guinea', 'PG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Paraguay', 'PY');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Peru', 'PE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Philippines', 'PH');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Pitcairn', 'PN');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Poland', 'PL');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Portugal', 'PT');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Puerto Rico', 'PR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Qatar', 'QA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Romania', 'RO');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Russian Federation', 'RU');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Rwanda', 'RW');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Saint Kitts and Nevis', 'KN');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Saint Lucia', 'LC');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Saint Martin (French part)' ,'MF');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Saint Pierre and Miquelon', 'PM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Saint Vincent and the Grenadines', 'VC');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Samoa', 'WS');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('San Marino', 'SM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Sao Tome and Principe', 'ST');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Saudi Arabia', 'SA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Senegal', 'SN');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Serbia', 'RS');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Seychelles', 'SC');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Sierra Leone', 'SL');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Singapore', 'SG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Sint Maarten (Dutch part)' ,'SX');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Slovakia', 'SK');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Slovenia', 'SI');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Solomon Islands', 'SB');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Somalia', 'SO');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('South Africa', 'ZA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('South Georgia and the South Sandwich Islands', 'GS');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('South Sudan', 'SS');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Spain', 'ES');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Sri Lanka', 'LK');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Sudan', 'SD');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Suriname', 'SR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Svalbard and Jan Mayen', 'SJ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Swaziland', 'SZ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Sweden', 'SE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Switzerland', 'CH');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Syrian Arab Republic', 'SY');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Tajikistan', 'TJ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Thailand', 'TH');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Timor-Leste', 'TL');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Togo', 'TG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Tokelau', 'TK');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Tonga', 'TO');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Trinidad and Tobago', 'TT');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Tunisia', 'TN');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Turkey', 'TR');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Turkmenistan', 'TM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Turks and Caicos Islands', 'TC');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Tuvalu', 'TV');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Uganda', 'UG');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Ukraine', 'UA');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('United Arab Emirates', 'AE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('United Kingdom', 'GB');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('United States', 'US');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('United States Minor Outlying Islands', 'UM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Uruguay', 'UY');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Uzbekistan', 'UZ');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Vanuatu', 'VU');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Viet Nam', 'VN');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Wallis and Futuna', 'WF');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Western Sahara', 'EH');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Yemen', 'YE');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Zambia', 'ZM');
INSERT INTO mp_ref_countries (Name, ISO) VALUES ('Zimbabwe', 'ZW');

--insertion in mp_ref_themes (necessary)
insert into mp_ref_themes values (seq_mp_ref_themes.nextval, 'animal');
insert into mp_ref_themes values (seq_mp_ref_themes.nextval, 'landscape');
insert into mp_ref_themes values (seq_mp_ref_themes.nextval, 'seascape');
insert into mp_ref_themes values (seq_mp_ref_themes.nextval, 'naval');
insert into mp_ref_themes values (seq_mp_ref_themes.nextval, 'still life');

--insert in mp_ref_status (necessary)
insert into mp_ref_status values (seq_mp_ref_status.nextval, 'Available');
insert into mp_ref_status values (seq_mp_ref_status.nextval, 'Rented');
insert into mp_ref_status values (seq_mp_ref_status.nextval, 'Returned');

--insertion in mp_artist
insert into mp_artist values (seq_mp_artist.nextval, 'Artist 1', 1, TO_DATE('1999-06-21','YYYY-MM-DD'), NULL);
insert into mp_artist values (seq_mp_artist.nextval, 'Artist 2', 2, TO_DATE('1923-02-15','YYYY-MM-DD'), TO_DATE('1993-01-15','YYYY-MM-DD'));
insert into mp_artist values (seq_mp_artist.nextval, 'Artist 3', 3, TO_DATE('1950-01-01','YYYY-MM-DD'), TO_DATE('2000-12-12','YYYY-MM-DD'));
insert into mp_artist values (seq_mp_artist.nextval, 'Artist 4', 4, TO_DATE('1947-08-14','YYYY-MM-DD'), NULL); 

--insertion in mp_customer
insert into mp_customer values (seq_mp_customer.nextval, 'Customer 1', 'Karachi', 1);
insert into mp_customer values (seq_mp_customer.nextval, 'Customer 2', 'Lahore', 1);
insert into mp_customer values (seq_mp_customer.nextval, 'Customer 3', 'Islamabad', 3);
insert into mp_customer values (seq_mp_customer.nextval, 'Customer 4', 'Hyderabad', 4);

--insert in mp_owner
insert into mp_owner values (seq_mp_owner.nextval, 'Owner 1', '0211234567', 'Karachi');
insert into mp_owner values (seq_mp_owner.nextval, 'Owner 2', '0210000000', 'Islamabad');
insert into mp_owner values (seq_mp_owner.nextval, 'Owner 3', '0218888888', 'Hyderabad');
insert into mp_owner values (seq_mp_owner.nextval, 'Owner 4', '0219999999', 'Sukkur');

--insert in mp_painting
insert into mp_painting values (seq_mp_painting.nextval, 'Painting 1', 1, 1, 1, 10.0, 1, TO_DATE('2022-01-01','YYYY-MM-DD'), NULL);
insert into mp_painting values (seq_mp_painting.nextval, 'Painting 2', 2, 2, 1, 20.0, 2, TO_DATE('2022-02-02','YYYY-MM-DD'), NULL);
insert into mp_painting values (seq_mp_painting.nextval, 'Painting 3', 3, 3, 3, 30.0, 3, TO_DATE('2022-03-03','YYYY-MM-DD'), TO_DATE('2022-09-03','YYYY-MM-DD'));
insert into mp_painting values (seq_mp_painting.nextval, 'Painting 4', 1, 1, 2, 10.0, 1, TO_DATE('2022-01-01','YYYY-MM-DD'), NULL);
insert into mp_painting values (seq_mp_painting.nextval, 'Painting 5', 3, 1, 5, 10.0, 1, TO_DATE('2021-11-03','YYYY-MM-DD'), NULL);
insert into mp_painting values (seq_mp_painting.nextval, 'Painting 6', 2, 1, 4, 10.0, 1, TO_DATE('2022-07-15','YYYY-MM-DD'), NULL);
insert into mp_painting values (seq_mp_painting.nextval, 'Painting 7', 1, 3, 4, 10.0, 3, TO_DATE('2021-12-31','YYYY-MM-DD'), TO_DATE('2022-06-01','YYYY-MM-DD'));

--insert into mp_paintingrental
insert into mp_paintingrental values(seq_mp_paintingrental.nextval, 1, 1, TO_DATE('2022-01-03','YYYY-MM-DD'), TO_DATE('2022-05-03','YYYY-MM-DD'));
insert into mp_paintingrental values(seq_mp_paintingrental.nextval, 2, 3, TO_DATE('2022-02-10','YYYY-MM-DD'), TO_DATE('2023-02-10','YYYY-MM-DD'));
insert into mp_paintingrental values(seq_mp_paintingrental.nextval, 4, 4, TO_DATE('2022-01-03','YYYY-MM-DD'), TO_DATE('2022-01-29','YYYY-MM-DD'));
insert into mp_paintingrental values(seq_mp_paintingrental.nextval, 5, 4, TO_DATE('2022-01-03','YYYY-MM-DD'), TO_DATE('2022-01-29','YYYY-MM-DD'));


---------------------------------All Procedures

--Add Owner
Create or Replace Procedure addOwner
(p_name varchar2, p_telephone varchar2, p_address varchar2)
IS
Begin
    Insert into mp_owner (id, name, telephone, address)
    values (seq_mp_owner.nextval, p_name, p_telephone, p_address);
END;

--Add Customer
Create or Replace Procedure addCustomer
(p_name varchar2, p_address varchar2, p_category int)
IS
Begin
    Insert into mp_customer (id, name, address, categoryid)
    values (seq_mp_customer.nextval, p_name, p_address, p_category);
END;

--Add Artist - doesn't allow birthdate to be after today's date, and death date to be before brith date
Create or Replace Procedure addArtist
(p_name varchar2, p_countryofbirthid int, p_birthdate date, p_deathdate date)
IS
Begin
    IF p_birthdate > SYSDATE THEN
        DBMS_OUTPUT.PUT_LINE('Error: Invalid birth date');
    ELSE
        if p_deathdate is null then
            addArtistAlive(p_name, p_countryofbirthid, p_birthdate);
            
        elsif p_birthdate > p_deathdate THEN
            DBMS_OUTPUT.PUT_LINE('Error: Death date cannot be before birthdate');
        
        else
            addArtistDead(p_name, p_countryofbirthid, p_birthdate, p_deathdate);
        end if;    
    END IF;
END;

------Add Artist (alive) - used in addArtist
Create or Replace Procedure addArtistAlive
(p_name varchar2, p_countryofbirthid int, p_birthdate date)
IS
Begin
    Insert into mp_artist (id, name, countryofbirthid, birthdate, deathdate)
    values (seq_mp_artist.nextval, p_name, p_countryofbirthid, p_birthdate, NULL);
END;
 
------Add Artist (dead) - used in addArtist
Create or Replace Procedure addArtistDead
(p_name varchar2, p_countryofbirthid int, p_birthdate date, p_deathdate date)
IS
Begin
    Insert into mp_artist (id, name, countryofbirthid, birthdate, deathdate)
    values (seq_mp_artist.nextval, p_name, p_countryofbirthid, p_birthdate, p_deathdate);
END;

--Add Painting - auto assigns entry date to today's date, 
--return date is null as it will be returned to owner after six months if not rented
Create or Replace Procedure addPainting
(p_title varchar2, p_themeid int, p_price float, p_artistID int, p_ownerID int)
IS
Begin
    Insert into mp_painting (id, title, artistid, ownerid, themeid, price, statusid, entrydate, returndate)
    values (seq_mp_painting.nextval, p_title, p_artistid, p_ownerid, p_themeid, p_price, 1, sysdate, NULL);
END;

--Search Available Painting by Artist
create or replace procedure SearchPaintingByArtist
(p_ArtistID int)
IS

CURSOR cursor_painting IS
    SELECT id, title, artistID, ownerID, themeID, price
    FROM mp_painting
    WHERE ArtistID = p_ArtistID AND statusID = 1;

Begin
FOR i_cursor IN cursor_painting
  LOOP
    DBMS_output.put_line('Painting ID: ' || i_cursor.id || ' | Title: ' || i_cursor.title ||  ' | Artist ID: ' || i_cursor.artistID 
    || ' | Owner ID: ' || i_cursor.ownerID || ' | Theme ID: ' || i_cursor.themeID || ' | Monthly Rental Price: ' || i_cursor.price);
  END LOOP;

END;

--Search Available Painting by Theme
create or replace procedure SearchPaintingByTheme
(p_themeID int)
IS

CURSOR cursor_painting IS
    SELECT id, title, artistID, ownerID, themeID, price
    FROM mp_painting
    WHERE themeID = p_themeID AND statusID = 1;

Begin
FOR i_cursor IN cursor_painting
  LOOP
    DBMS_output.put_line('Painting ID: ' || i_cursor.id || ' | Title: ' || i_cursor.title ||  ' | Artist ID: ' || i_cursor.artistID 
    || ' | Owner ID: ' || i_cursor.ownerID || ' | Theme ID: ' || i_cursor.themeID || ' | Monthly Rental Price: ' || i_cursor.price);
  END LOOP;

END;

--Rent Painting
create or replace Procedure RentPainting
(p_paintingID int, p_customerID int, p_noOfMonths int)
IS
v_endDate date;
Begin

v_endDate := ADD_MONTHS(SYSDATE, +p_noOfMonths);

insert into mp_paintingrental (id, paintingID, customerID, startDate, endDate) 
values(seq_mp_paintingrental.nextval, p_paintingID, p_customerID, SYSDATE, v_EndDate);
END;

--Customer Return a Painting
create or replace Procedure CustomerReturnPainting
(p_rentalID int)
IS
selectedPaintingID int;
Begin

    UPDATE mp_PaintingRental
    SET EndDate = SYSDATE
    WHERE id = p_RentalID;

    Select paintingID into selectedPaintingID from mp_paintingRental where id = p_RentalID;
    MakePaintingAvailable(selectedPaintingID);

END;

--Resubmit a Retured Painting after 3 months
create or replace Procedure ResubmitPainting
(p_paintingID int)
IS
v_returnDate date;
v_statusID int;

Begin
Select ReturnDate, statusID INTO v_returnDate, v_statusID FROM mp_Painting WHERE id = p_paintingID;

If v_returnDate <= ADD_MONTHS(SYSDATE, -3) and v_statusID = 3 then
    MakePaintingAvailable(p_paintingID);
    update mp_painting set ReturnDate = null where id = p_paintingID;

else
    DBMS_output.put_line('Painting cannot be resubmitted before 3 months');
end if;
END;

--Make Painting Available (to be used in other procedures)
create or replace procedure MakePaintingAvailable
(p_paintingID int)
IS
Begin

Update mp_painting
    set statusID = 1
    where id = p_paintingID;
end;

--Customer Rental Report
create or replace PROCEDURE CustomerRentalReport
(p_CustomerID int)
IS
      
    CURSOR customer_cursor IS
      SELECT c.ID as cID ,c.Name as cName, c.Address as cAddress, 
      cat.Name as catName, cat.Description as catDescription, cat.Discount as catDiscount
      FROM mp_Customer c
   INNER JOIN mp_Category cat ON c.CategoryID = cat.ID
   where c.id = p_CustomerID;

 v_customer_cursor customer_cursor%rowtype;


    CURSOR painting_cursor IS
      SELECT p.ID as pID, p.Title as pTitle, t.Name as pTheme, 
   pr.startdate as prStartDate, pr.endDate as prEndDate, p.statusID as pstatusID
   FROM mp_Customer c
   INNER JOIN mp_PaintingRental pr ON c.ID = pr.customerID
   INNER JOIN mp_Painting p ON pr.paintingID = p.ID
   INNER JOIN mp_ref_themes t ON p.themeID = t.ID
   where c.id = p_CustomerID;

 v_painting_cursor painting_cursor%rowtype;

v_returned varchar2(1);

begin

open customer_cursor;
loop
fetch customer_cursor into v_customer_cursor;

DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_customer_cursor.cID);    
DBMS_OUTPUT.PUT_LINE('Customer Name: ' ||v_customer_cursor.cName);
DBMS_OUTPUT.PUT_LINE('Customer Address: ' ||v_customer_cursor.cAddress);
DBMS_OUTPUT.PUT_LINE('Customer Category: ' ||v_customer_cursor.catName);
DBMS_OUTPUT.PUT_LINE('Category Description: ' ||v_customer_cursor.catDescription);
DBMS_OUTPUT.PUT_LINE('Category Discount: ' ||v_customer_cursor.catDiscount);

exit when customer_cursor%found;
end loop;
close customer_cursor;

DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE('--------------');    
DBMS_OUTPUT.PUT_LINE('');

open painting_cursor;
loop
fetch painting_cursor into v_painting_cursor;
exit when painting_cursor%notfound;

if v_painting_cursor.pStatusID = 2 then
    v_returned := 'N';
else
    v_returned := 'Y';
END IF;

DBMS_OUTPUT.PUT_LINE('Painting ID: ' || v_painting_cursor.pID || ' | ' || 'Painting Title: ' ||v_painting_cursor.pTitle 
    || '|' || 'Painting Theme: ' ||v_painting_cursor.ptheme || ' | ' || 'Date of Hire: ' ||v_painting_cursor.prStartDate
    || ' | ' || 'Due Date Back: ' ||v_painting_cursor.prEndDate  || ' | ' || 'Returned(Y/N): ' ||v_returned ); 

end loop;
close painting_cursor;

end;

--Artist Report
create or replace PROCEDURE ArtistReport
(p_ArtistID int)
IS
    v_year_of_birth int;
    v_year_of_death int;
    v_age NUMBER;

    CURSOR artist_cursor IS
      SELECT a.ID As aID, a.Name AS aName, rc.Name AS rcName,
          a.BirthDate as aBirthDate, a.DeathDate as aDeathDate
   FROM mp_Artist a
   INNER JOIN mp_ref_countries rc ON a.countryofbirthid = rc.id
   where a.id = p_ArtistID;

 v_artist_cursor artist_cursor%rowtype;


    CURSOR painting_cursor IS
      SELECT 
        p.ID as pID, p.Title as pTitle, t.Name as tName, p.price as pprice,
        o.id as oID, o.name as oName, o.telephone as oTel
   FROM mp_Artist a
   INNER JOIN mp_Painting p ON a.ID = p.artistID
   INNER JOIN mp_ref_themes t ON p.themeID = t.ID
   INNER JOIN mp_owner o ON p.ownerID = o.ID
   where a.id = p_ArtistID;

 v_painting_cursor painting_cursor%rowtype;


begin

open artist_cursor;
loop
fetch artist_cursor into v_artist_cursor;

v_year_of_birth := EXTRACT(YEAR FROM v_artist_cursor.aBirthDate);
v_age := EXTRACT(YEAR FROM SYSDATE) - v_year_of_birth;

DBMS_OUTPUT.PUT_LINE('Artist ID: ' || v_artist_cursor.aID);    
DBMS_OUTPUT.PUT_LINE('Artist Name: ' ||v_artist_cursor.aName);
DBMS_OUTPUT.PUT_LINE('Country of Birth: ' ||v_artist_cursor.rcName);
DBMS_OUTPUT.PUT_LINE('Year of Birth: ' ||v_year_of_birth);

IF v_artist_cursor.aDeathDate IS NOT NULL THEN
      v_year_of_death := EXTRACT(YEAR FROM v_artist_cursor.aDeathDate);
      DBMS_OUTPUT.PUT_LINE('Year of Birth: ' || v_year_of_death);

      v_age := FLOOR(MONTHS_BETWEEN(v_artist_cursor.aDeathDate, v_artist_cursor.aBirthDate) / 12);
END IF;

DBMS_OUTPUT.PUT_LINE('Age: ' ||v_age);

exit when artist_cursor%found;
end loop;
close artist_cursor;

DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE('--------------');    
DBMS_OUTPUT.PUT_LINE('');

open painting_cursor;
loop
fetch painting_cursor into v_painting_cursor;
exit when painting_cursor%notfound;

DBMS_OUTPUT.PUT_LINE('Paiting ID: ' || v_painting_cursor.pID || ' | ' || 'Painting Title: ' ||v_painting_cursor.pTitle 
    || '|' || 'Painting Theme: ' ||v_painting_cursor.tname || ' | ' || 'Rental Price: ' ||v_painting_cursor.pprice
    || ' | ' || 'Owner ID: ' ||v_painting_cursor.oID || ' | ' || 'Owner Name: ' ||v_painting_cursor.oName
    || ' | ' || 'Owner Tel: ' ||v_painting_cursor.oTel); 

end loop;
close painting_cursor;

end;

--Return to Owner Report
create or replace PROCEDURE ReturnToOwnerReport
(p_OwnerID int)
IS
      
    CURSOR Owner_cursor IS
      SELECT o.ID As oID, o.Name AS oName, o.Address AS oAddress
   FROM mp_Owner o
   where o.id = p_OwnerID;

 v_Owner_cursor owner_cursor%rowtype;


    CURSOR painting_cursor IS
      SELECT 
        p.ID as pID, p.Title as pTitle, p.ReturnDate as pReturnDate
   FROM mp_Painting p
   where p.Ownerid = p_OwnerID and p.statusID = 3;

 v_painting_cursor painting_cursor%rowtype;


begin

open owner_cursor;
loop
fetch owner_cursor into v_owner_cursor;

DBMS_OUTPUT.PUT_LINE('Owner ID: ' || v_owner_cursor.oID);    
DBMS_OUTPUT.PUT_LINE('Artist Name: ' ||v_owner_cursor.oName);
DBMS_OUTPUT.PUT_LINE('Address: ' ||v_owner_cursor.oAddress);

exit when owner_cursor%found;
end loop;
close owner_cursor;

DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE('--------------');    
DBMS_OUTPUT.PUT_LINE('');

open painting_cursor;
loop
fetch painting_cursor into v_painting_cursor;
exit when painting_cursor%notfound;

DBMS_OUTPUT.PUT_LINE('Paiting ID: ' || v_painting_cursor.pID || ' | ' || 'Painting Title: ' ||v_painting_cursor.pTitle 
    || ' | ' || 'Return Date: ' ||v_painting_cursor.pReturnDate); 

end loop;
close painting_cursor;

end;