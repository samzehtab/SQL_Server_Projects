
/*
Mohammad Hossein Zehtab
SQL-Server-Sundays-Tuesdays
Final_Project:_Pharmacy
*/
-------------------------------------------------------------------------------------------------
--Creating Database
create database Pharmacy

--Using Database
use Pharmacy
-------------------------------------------------------------------------------------------------
--Creating Tables

----Creating insurance table
	create table insurance_tbl
		(
		insurance_id varchar(10) primary key,
		insurance_name varchar(30) not null
		);

----Creating prescription table
	create table prescription_tbl
		(
		prescription_id int primary key identity(1000,1),
		prescription_name varchar(20) null,
		prescription_family varchar(20) null,
		prescription_date datetime not null,
		insurance_id varchar(10),
			constraint FK_insuranceprescription
			foreign key (insurance_id)
			references insurance_tbl(insurance_id)
		);

----Creating country table
	create table country_tbl
		(
		country_id varchar(3) primary key,
		country_name varchar(20) not null
		);

----Creating company table
	create table company_tbl
		(
		company_id varchar(10) primary key,
		company_name varchar(30) not null,
		country_id varchar(3),
			constraint FK_countrycompany
			foreign key (country_id)
			references country_tbl(country_id)
		);

----Creating drugtype table
	create table drugtype_tbl
		(
		drugtype_id int primary key identity(1,1),
		drugtype_name varchar(30) not null
		);

----Creating drug table
	create table drug_tbl
		(
		drug_id int primary key identity(100,1),
		drug_genericname varchar(50) not null,
		drugtype_id int,
			constraint FK_drugtypedrug
			foreign key (drugtype_id)
			references drugtype_tbl(drugtype_id)
		);

----Creating commercial table
	create table commercial_tbl
		(
		commercial_id int primary key identity(300,1),
		commercial_name varchar(50) null,
		company_id varchar(10),
			constraint FK_companycommercial
			foreign key (company_id)
			references company_tbl(company_id),
		drug_id int,
			constraint FK_drugcommercial
			foreign key (drug_id)
			references drug_tbl(drug_id),
		commercial_price money not null
		);

----Creating order table
	create table order_tbl
		(
		order_id int primary key identity(10000,1),
		prescription_id int,
			constraint FK_prescriptionorder
			foreign key (prescription_id)
			references prescription_tbl(prescription_id),
		commercial_id int,
			constraint FK_commercialorder
			foreign key (commercial_id)
			references commercial_tbl(commercial_id),
		order_measure int not null
		);

-------------------------------------------------------------------------------------------------
--Inserting Data into the Tables

----Inserting into insurance table
	insert into insurance_tbl (insurance_id, insurance_name)
	values ('INS001', 'TaminEjtemaei'),
		   ('INS002', 'Saman'),
		   ('INS003', 'NirouhayMosalah'),
		   ('INS004', 'Novin'),
		   ('INS005', 'Sina');

----Inserting into prescription table
--------Inserting 134 prescriptions for 'TaminEjtemaei'
		insert into prescription_tbl (prescription_name, prescription_family, prescription_date, insurance_id)
		select 
			'PName' + cast(ROW_NUMBER() over (order by (select NULL)) as varchar),
			'PFamily' + cast(ROW_NUMBER() over (order by (select NULL)) as varchar),
			 DATEADD(DAY, abs(CHECKSUM(newid())) % 1460, '2020-09-01'),
			'INS001'
		from master.dbo.spt_values where type='P' and number between 1 and 134;

--------Inserting 66 prescriptions for other insurances (random)
		insert into prescription_tbl (prescription_name, prescription_family, prescription_date, insurance_id)
		select 
			'PName' + cast(ROW_NUMBER() over (order by (select NULL)) as varchar),
			'PFamily' + cast(ROW_NUMBER() over (order by (select NULL)) as varchar),
			 DATEADD(DAY, abs(CHECKSUM(newid())) % 1460, '2020-09-01'),
			(case when number % 4 = 0 then 'INS002'
				  when number % 4 = 1 then 'INS003'
				  when number % 4 = 2 then 'INS004'
			 else 'INS005' end)
		from master.dbo.spt_values where type='P' and number between 1 and 66;

----Inserting into country table
	insert into country_tbl (country_id, country_name)
	values ('IRN', 'Iran'),
		   ('FRA', 'France'),
		   ('AUS', 'Australia'),
		   ('GER', 'Germany');

----Inserting into company table
	insert into company_tbl (company_id, company_name, country_id)
	values ('C001', 'DarouPakhsh', 'IRN'),
		   ('C002', 'SobhanDarou', 'IRN'),
		   ('C003', 'Osveh', 'IRN'),
		   ('C004', 'Exir', 'IRN'),
		   ('C005', 'Sanofi', 'FRA'),
		   ('C006', 'Servier', 'FRA'),
		   ('C007', 'Pierre Fabre', 'FRA'),
		   ('C008', 'Ipsen', 'FRA'),
		   ('C009', 'Boehringer', 'GER'),
		   ('C010', 'Bayer', 'GER'),
		   ('C011', 'Pfizer', 'AUS'),
		   ('C012', 'CSL Limited', 'AUS'),
		   ('C013', 'Novo Nordisk', 'AUS'),
		   ('C014', 'Roche', 'GER'),
		   ('C015', 'Aventis', 'FRA');

----Inserting into drugtype table
	insert into drugtype_tbl (drugtype_name)
	values ('Antibiotic'), ('Painkiller'), ('Antidepressant'), ('Antiviral'), ('Antifungal'),
		   ('Blood Pressure Regulator'), ('Diabetes Medication'), ('Cholesterol Lowering'),
		   ('Antihistamine'), ('Steroid'), ('Antiseptic'), ('Anticoagulant'),
		   ('Sedative'), ('Antiepileptic'), ('Hormonal Therapy'), ('Anti-inflammatory'),
		   ('Gastrointestinal Medication'), ('Neurological Drug'), ('Cardiovascular Drug'),
		   ('Oncology Drug'), ('Respiratory Drug'), ('Renal Drug'), ('Ophthalmic Drug'),
		   ('Dermatological Drug'), ('Psychotropic Drug'), ('Antipsychotic'),
		   ('Thyroid Medication'), ('Immunosuppressant'), ('Antirheumatic'), ('Anesthetic');

----Inserting into drug table
	insert into drug_tbl (drug_genericname, drugtype_id)
	values ('Amoxicillin', 1), ('Ciprofloxacin', 1), ('Doxycycline', 1), ('Azithromycin', 1), ('Ceftriaxone', 1),
		   ('Ibuprofen', 2), ('Paracetamol', 2), ('Naproxen', 2), ('Ketorolac', 2), ('Aspirin', 2),
		   ('Fluoxetine', 3), ('Sertraline', 3), ('Citalopram', 3), ('Escitalopram', 3), ('Venlafaxine', 3),
		   ('Oseltamivir', 4), ('Acyclovir', 4), ('Remdesivir', 4), ('Ribavirin', 4), ('Baloxavir', 4),
		   ('Fluconazole', 5), ('Itraconazole', 5), ('Ketoconazole', 5), ('Voriconazole', 5), ('Clotrimazole', 5),
		   ('Metformin', 7), ('Glimepiride', 7), ('Sitagliptin', 7), ('Empagliflozin', 7), ('Insulin Lispro', 7),
		   ('Atorvastatin', 8), ('Rosuvastatin', 8), ('Simvastatin', 8), ('Lovastatin', 8), ('Pravastatin', 8),
		   ('Diphenhydramine', 9), ('Cetirizine', 9), ('Fexofenadine', 9), ('Loratadine', 9), ('Desloratadine', 9),
		   ('Prednisone', 10), ('Hydrocortisone', 10), ('Methylprednisolone', 10), ('Dexamethasone', 10), ('Triamcinolone', 10),
		   ('Warfarin', 11), ('Heparin', 11), ('Apixaban', 11), ('Rivaroxaban', 11), ('Dabigatran', 11),
		   ('Diazepam', 12), ('Lorazepam', 12), ('Alprazolam', 12), ('Clonazepam', 12), ('Midazolam', 12),
		   ('Carbamazepine', 13), ('Valproic Acid', 13), ('Levetiracetam', 13), ('Lamotrigine', 13), ('Topiramate', 13),
		   ('Levothyroxine', 26), ('Methimazole', 26), ('Propylthiouracil', 26), ('Liothyronine', 26), ('Desiccated Thyroid', 26);

----Inserting into commercial table
	insert into commercial_tbl (commercial_name, company_id, drug_id, commercial_price)
	values ('Augmentin', 'C001', 100, 15.99), ('Cipro', 'C002', 101, 12.50), ('Doryx', 'C003', 102, 20.75),
		   ('Zithromax', 'C004', 103, 25.99), ('Rocephin', 'C005', 104, 22.45), ('Advil', 'C006', 105, 9.50),
		   ('Tylenol', 'C007', 106, 10.99), ('Aleve', 'C008', 107, 8.75), ('Toradol', 'C009', 108, 14.50),
		   ('Bayer Aspirin', 'C010', 109, 7.20), ('Prozac', 'C011', 110, 25.75), ('Zoloft', 'C012', 111, 24.60),
		   ('Celexa', 'C013', 112, 19.99), ('Lexapro', 'C014', 113, 23.40), ('Effexor', 'C015', 114, 26.80),
		   ('Tamiflu', 'C001', 115, 30.99), ('Zovirax', 'C002', 116, 22.10), ('Veklury', 'C003', 117, 150.99),
		   ('Copegus', 'C004', 118, 35.50), ('Xofluza', 'C005', 119, 40.99), ('Diflucan', 'C006', 120, 18.45),
		   ('Sporanox', 'C007', 121, 21.99), ('Nizoral', 'C008', 122, 16.75), ('Vfend', 'C009', 123, 29.80),
		   ('Lotrimin', 'C010', 124, 12.40), ('Glucophage', 'C011', 125, 14.50), ('Amaryl', 'C012', 126, 11.80),
		   ('Januvia', 'C013', 127, 28.99), ('Jardiance', 'C014', 128, 32.50), ('Humalog', 'C015', 129, 35.99),
		   ('Lipitor', 'C001', 130, 22.80), ('Crestor', 'C002', 131, 26.99), ('Zocor', 'C003', 132, 18.50),
		   ('Mevacor', 'C004', 133, 15.99), ('Pravachol', 'C005', 134, 19.20), ('Benadryl', 'C006', 135, 12.99),
		   ('Zyrtec', 'C007', 136, 14.40), ('Allegra', 'C008', 137, 15.80), ('Claritin', 'C009', 138, 13.50),
		   ('Clarinex', 'C010', 139, 17.20), ('Prednisolone', 'C011', 140, 10.75), ('Cortef', 'C012', 141, 8.99),
		   ('Medrol', 'C013', 142, 13.50), ('Decadron', 'C014', 143, 9.99), ('Kenalog', 'C015', 144, 11.75),
		   ('Coumadin', 'C001', 145, 20.50), ('Fragmin', 'C002', 146, 21.99), ('Eliquis', 'C003', 147, 35.50),
		   ('Xarelto', 'C004', 148, 33.99), ('Pradaxa', 'C005', 149, 30.25), ('Valium', 'C006', 150, 16.20),
		   ('Ativan', 'C007', 151, 19.50), ('Xanax', 'C008', 152, 21.99), ('Klonopin', 'C009', 153, 18.50),
		   ('Versed', 'C010', 154, 22.40), ('Tegretol', 'C011', 155, 20.99), ('Depakene', 'C012', 156, 25.50),
		   ('Keppra', 'C013', 157, 28.80), ('Lamictal', 'C014', 158, 24.99), ('Topamax', 'C015', 159, 29.75),
		   ('Synthroid', 'C001', 160, 18.99), ('Tapazole', 'C002', 161, 15.49), ('PTU', 'C003', 162, 14.80),
		   ('Cytomel', 'C004', 163, 21.40), ('Armour Thyroid', 'C005', 164, 23.99), ('Methotrexate', 'C006', 143, 29.50),
		   ('Cyclosporine', 'C007', 100, 33.20), ('Azathioprine', 'C008', 153, 26.50), ('Mycophenolate', 'C009', 151, 40.60),
		   ('Enbrel', 'C010', 127, 55.30), ('Humira', 'C011', 129, 58.40), ('Remicade', 'C012', 160, 61.90),
		   ('Lidocaine', 'C013', 159, 12.99), ('Bupivacaine', 'C014', 145, 15.80), ('Ropivacaine', 'C015', 123, 17.40),
		   ('Propofol', 'C001', 154, 25.60), ('Etomidate', 'C002', 111, 22.30), ('Ketamine', 'C003', 134, 29.99),
		   ('Halothane', 'C004', 101, 33.99), ('Isoflurane', 'C005', 133, 27.99), ('Sevoflurane', 'C006', 114, 35.50),
		   ('Desflurane', 'C007', 101, 39.90), ('Opdivo', 'C008', 112, 72.50), ('Keytruda', 'C009', 164, 78.99),
		   ('Tecentriq', 'C010', 145, 85.99), ('Xalkori', 'C011', 146, 89.50), ('Zytiga', 'C012', 108, 95.20),
		   ('Ibrance', 'C013', 105, 98.30), ('Lynparza', 'C014', 121, 102.40), ('Tagrisso', 'C015', 100, 110.99);

----Inserting into order table
	insert into order_tbl (prescription_id, commercial_id, order_measure)
	select 
		(1000 + abs(CHECKSUM(newid())) % 200),
		(502 + abs(CHECKSUM(newid())) % 90),
		(1 + abs(CHECKSUM(newid())) % 5)
	from master.dbo.spt_values where type='P' and number between 1 and 320;

-------------------------------------------------------------------------------------------------
--Getting Reports
----1.Number of prescriptions that have French drugs
	select count(distinct o.prescription_id) as 'PrescriptionsWithFrenchDrugs'
	from order_tbl o join commercial_tbl commer
	on o.commercial_id = commer.commercial_id
	join company_tbl comp
	on commer.company_id = comp.company_id
	join country_tbl con
	on comp.country_id = con.country_id
	where con.country_name like 'France';

----2.Insurance company names with more than 100 prescriptions in the last year-----------------

----Note: Since we have 29 prescriptions in 2024, so instead of 100 prescription,
----for having some results, we consider more than 20 prescriptions for this report.

	select i.insurance_name, count(p.prescription_id) as NumberofPrescriptions
	from insurance_tbl i join prescription_tbl p
	on i.insurance_id = p.insurance_id
	where year(p.prescription_date) = 2024
	group by i.insurance_name
	having count(p.prescription_id) > 20;
	
----3.Function for showing the most expensive drug of a given company---------------------------
--------Function Implementation----------------------------------
go
	create function MostExpensiveDrug (@companyid varchar(10))
	returns varchar(50)
	as
	begin
		return
			(
			select top 1 d.drug_genericname
			from company_tbl comp join commercial_tbl comm
			on comp.company_id = comm.company_id
			join drug_tbl d
			on comm.drug_id = d.drug_id
			where comp.company_id like @companyid
			order by comm.commercial_price desc
			)
	end;

--------Function Calling------------------------------------------
go
	select dbo.MostExpensiveDrug ('C001') as 'MostExpensiveDrug'

----4.The most expensive drug in each drug type------------------------------------------------
--------Creating CTE--------------------------------
	with CTE1
	as
	(
	select dense_rank() over (partition by dt.drugtype_id order by comm.commercial_price desc) as CommercialPriceRank,
		   comm.commercial_name, comm.commercial_price, d.drug_genericname, dt.drugtype_name
	from commercial_tbl comm join drug_tbl d
	on comm.drug_id = d.drug_id
	join drugtype_tbl dt
	on d.drugtype_id = dt.drugtype_id
	)

--------Selecting from CTE--------------------------
	select commercial_name, drug_genericname, commercial_price, drugtype_name
	from CTE1
	where CommercialPriceRank = 1;

----5.Drug name and 3% increase on commercial price-------------------------------------------
	select comm.commercial_name, d.drug_genericname,
		   comm.commercial_price as 'OldPrice', comm.commercial_price * (1 + 0.03) as '3%Increase'
	from commercial_tbl comm join drug_tbl d
	on comm.drug_id = d.drug_id;

-----Showing general drugs information--------------------------------------------------------
select d.drug_genericname, dt.drugtype_name, comm.commercial_name, comm.commercial_price, comp.company_name, con.country_name
from drugtype_tbl dt full join drug_tbl d
on dt.drugtype_id = d.drugtype_id
full join commercial_tbl comm
on d.drug_id = comm.drug_id
full join company_tbl comp
on comm.company_id = comp.company_id
full join country_tbl con
on comp.country_id = con.country_id;