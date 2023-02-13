DROP TABLE IF EXISTS [Hospital_System.Work];
DROP TABLE IF EXISTS [Hospital_System.Assist];
DROP TABLE IF EXISTS [Hospital_System.Assign];
DROP TABLE IF EXISTS [Hospital_System.Pay];
DROP TABLE IF EXISTS [Hospital_System.Allot];
DROP TABLE IF EXISTS [Hospital_System.Prescribe];
DROP TABLE IF EXISTS [Hospital_System.Store];
DROP TABLE IF EXISTS [Hospital_System.Bill];
DROP TABLE IF EXISTS [Hospital_System.MedicalHistory];
DROP TABLE IF EXISTS [Hospital_System.Medicine];
DROP TABLE IF EXISTS [Hospital_System.Room];
DROP TABLE IF EXISTS [Hospital_System.Nurse];
DROP TABLE IF EXISTS[Hospital_System.Doctor];
DROP TABLE IF EXISTS[Hospital_System.Department]
DROP TABLE IF EXISTS[Hospital_System.Patient];

CREATE TABLE [Hospital_System.Patient](
	patID VARCHAR(50) NOT NULL,
	patEmail VARCHAR(50) NOT NULL,
	patPassword VARCHAR(50) NOT NULL,
	patFistName VARCHAR(50) NOT NULL,
	patLastName VARCHAR(50) NOT NULL,
	patAddress VARCHAR(50) NOT NULL,
	patSex VARCHAR(50) NOT NULL,
	patDOB DATE NOT NULL,
	CONSTRAINT pk_Patient_patID PRIMARY KEY(patID))

CREATE TABLE [Hospital_System.Department](
	depID VARCHAR(50)NOT NULL,
	depName VARCHAR(50),
	depNumber VARCHAR(50),
	depEmail VARCHAR (50) NOT NULL,
	CONSTRAINT pk_Department_depID PRIMARY KEY(depID))

CREATE TABLE [Hospital_System.Doctor](
	docID VARCHAR(50) NOT NULL,
	docEmail VARCHAR (50) NOT NULL,
    docPassword VARCHAR (50) NOT NULL,
	docFirstName VARCHAR(50) NOT NULL,
	docLastName VARCHAR(50) NOT NULL,
	depID VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Doctor_docID PRIMARY KEY(docID),
	CONSTRAINT fk_Doctor_depID FOREIGN KEY(depID)
		REFERENCES [Hospital_System.Department] (depID)
		ON DELETE CASCADE ON UPDATE CASCADE)

CREATE TABLE [Hospital_System.Nurse](
	nurID VARCHAR(50) NOT NULL,
	nurFirstName VARCHAR(50) NOT NULL,
	nurLastName VARCHAR(50) NOT NULL,
	depID VARCHAR(50) NOT NULL,
	docID VARCHAR(50) NOT NULL,
	patID VARCHAR(50) NOT NULL
	CONSTRAINT pk_Nurse_nurID PRIMARY KEY (nurID),
	CONSTRAINT fk_Nurse_depID FOREIGN KEY (depID)
		REFERENCES [Hospital_System.Department] (depID)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Nurse_patID FOREIGN KEY (patID)
		REFERENCES[Hospital_System.Patient] (patID)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Nurse_docID FOREIGN KEY (docID)
		REFERENCES [Hospital_System.Doctor] (docID)
		ON DELETE NO ACTION ON UPDATE CASCADE)

CREATE TABLE [Hospital_System.Room](
	romID VARCHAR(50) NOT NULL,
	romType VARCHAR(50) NOT NULL,
	patID VARCHAR(50) NOT NULL
	CONSTRAINT pk_Room_romID PRIMARY KEY(romID)
	CONSTRAINT fk_Room_patID FOREIGN KEY(patID)
		REFERENCES[Hospital_System.Patient] (patID)
		ON DELETE NO ACTION ON UPDATE CASCADE)
	
CREATE TABLE [Hospital_System.Medicine](
	medID VARCHAR(50) NOT NULL,
	medName VARCHAR(50) NOT NULL,
	medCost DECIMAL(6,2) NOT NULL,
	docID VARCHAR(50) NOT NULL
	CONSTRAINT pk_Medicine_medID PRIMARY KEY(medID)
	CONSTRAINT fk_Medicine_docID FOREIGN KEY(docID)
		REFERENCES [Hospital_System.Doctor] (docID)
		ON DELETE NO ACTION ON UPDATE CASCADE)

CREATE TABLE [Hospital_System.MedicalHistory](
	hstID VARCHAR(50) NOT NULL,
	hstAppointmentDate DATE NOT NULL,
	hstDisease VARCHAR(50) NOT NULL,
	hstSurgery VARCHAR(50) NOT NULL,
	hstPreviousMedication VARCHAR(50) NOT NULL,
	patID VARCHAR(50),
	CONSTRAINT pk_MedicalHistory_hstID PRIMARY KEY(hstID))
	

CREATE TABLE [Hospital_System.Bill](
	bilID VARCHAR(50) NOT NULL,
	bilDoctorCharge DECIMAL(8,2) NOT NULL,
	bilRoomCharge DECIMAL(8,2) NOT NULL,
	bilNumberOfDays INTEGER NOT NULL,
	docID VARCHAR(50),
	patID VARCHAR(50),
	medID VARCHAR(50),
	romID VARCHAR(50),
	CONSTRAINT pk_Bill_bilID PRIMARY KEY(bilID),
	CONSTRAINT fk_Bill_docID FOREIGN KEY(docID)
		REFERENCES [Hospital_System.Doctor] (docID)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Bill_patID FOREIGN KEY(patID)
		REFERENCES[Hospital_System.Patient] (patID)
		ON DELETE NO ACTION ON UPDATE SET NULL,
	CONSTRAINT fk_Bill_medID FOREIGN KEY(medID)
		REFERENCES[Hospital_System.Medicine] (medID)
		ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_Bill_romID FOREIGN KEY(romID)
		REFERENCES[Hospital_System.Room] (romID)
		ON DELETE NO ACTION ON UPDATE NO ACTION)

CREATE TABLE [Hospital_System.Store](
	patID VARCHAR(50) NOT NULL,
	hstID VARCHAR(50) NOT NULL, 
	CONSTRAINT pk_Store_patID_hstID PRIMARY KEY(patID, hstID),
	CONSTRAINT fk_Store_patID FOREIGN KEY(patID)
		REFERENCES[Hospital_System.Patient] (patID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Store_hstID FOREIGN KEY(hstID)
		REFERENCES[Hospital_System.MedicalHistory] (hstID)
		ON DELETE NO ACTION ON UPDATE NO ACTION)


CREATE TABLE [Hospital_System.Prescribe](
	docID VARCHAR(50) NOT NULL,
	patID VARCHAR(50) NOT NULL,
	medID VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Prescribe_docID_patID_medID PRIMARY KEY(docID, patID, medID),
	CONSTRAINT fk_Prescribe_docID FOREIGN KEY(docID)
		REFERENCES[Hospital_System.Doctor] (docID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Prescribe_patID FOREIGN KEY(patID)
		REFERENCES[Hospital_System.Patient] (patID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Prescribe_medID FOREIGN KEY(medID)
		REFERENCES[Hospital_System.Medicine] (medID)
		ON DELETE NO ACTION ON UPDATE NO ACTION)

CREATE TABLE [Hospital_System.Allot](
	romID VARCHAR(50) NOT NULL,
	patID VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Allot_romID_patID PRIMARY KEY(romID, patID),
	CONSTRAINT fk_Allot_romID FOREIGN KEY(romID)
		REFERENCES[Hospital_System.Room] (romID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Allot_patID FOREIGN KEY(patID)
		REFERENCES[Hospital_System.Patient] (patID)
		ON DELETE NO ACTION ON UPDATE NO ACTION)

CREATE TABLE [Hospital_System.Pay](
	patID VARCHAR(50) NOT NULL,
	bilID VARCHAR(50) NOT NULL,
	paymentDate DATE,
	CONSTRAINT pk_Pay_patID_bilID PRIMARY KEY(patID, bilID),
	CONSTRAINT fk_Pay_patID FOREIGN KEY(patID)
		REFERENCES[Hospital_System.Patient] (patID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Pay_bilID FOREIGN KEY(bilID)
		REFERENCES[Hospital_System.Bill] (bilID)
		ON DELETE NO ACTION ON UPDATE NO ACTION)

CREATE TABLE [Hospital_System.Assign](
	nurID VARCHAR(50) NOT NULL,
	patID VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Assign_nurID_patID PRIMARY KEY(nurID, patID),
	CONSTRAINT fk_Assign_nurID FOREIGN KEY (nurID)
		REFERENCES [Hospital_System.Nurse] (nurID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Assign_patID FOREIGN KEY(patID)
		REFERENCES[Hospital_System.Patient] (patID)
		ON DELETE CASCADE ON UPDATE CASCADE)

CREATE TABLE [Hospital_System.Assist](
	nurID VARCHAR(50) NOT NULL,
	docID VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Assist_nurID_docID PRIMARY KEY(nurID, docID),
	CONSTRAINT fk_Assist_nurID FOREIGN KEY (nurID)
		REFERENCES [Hospital_System.Nurse] (nurID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Assist_docID FOREIGN KEY(docID)
		REFERENCES[Hospital_System.Doctor] (docID)
		ON DELETE NO ACTION ON UPDATE NO ACTION)

CREATE TABLE [Hospital_System.Work](
	depID VARCHAR(50) NOT NULL,
	docID VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Work_depID_docID PRIMARY KEY(depID, docID),
	CONSTRAINT fk_Work_depID FOREIGN KEY (depID)
		REFERENCES [Hospital_System.Department] (depID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Work_docID FOREIGN KEY(docID)
		REFERENCES[Hospital_System.Doctor] (docID)
		ON DELETE NO ACTION ON UPDATE NO ACTION)

INSERT INTO [Hospital_System.Department] VALUES
	('DEPT0001','Emergency', '2409277750','emergency_momo@hospital.com'),
	('DEPT0002','Orthopedic','2409286638','orthopedic_momo@hospital.com'),
	('DEPT0003','Physician','2409382210','Physician_momo@hospital.com'),
	('DEPT0004','Accident','2409912250','Accident_momo@hospital.com'),
	('DEPT0005','Burn/SkinCare','2409921133','Burn/SkinCare_momo@hospital.com'),
	('DEPT0006','Anesthetics','2409927732','Anesthetics_momo@hospital.com'),
	('DEPT0007','Admission','2409238841','Admission_momo@hospital.com'),
	('DEPT0008','Cardiology','2409918821','Cardiology_momo@hospital.com'),
	('DEPT0009','Gynecology','2409116271','Gynecology_momo@hospital.com'),
	('DEPT0010','Haemotology','2409112383','Haemotology_momo@hospital.com'),
	('DEPT0013','Dental','2409511199','Dental_momo@hospital.com'),
	('DEPT0015','Radiology','2409916987','Radiology_momo@hospital.com')

INSERT INTO [Hospital_System.Doctor] VALUES
	('DOC0001','drmaria@hospital.com','Maria1234','Maria', 'Shaikh','DEPT0001'),
	('DOC0002','drsakar@hospital.com','Sakar9876','Sakar','Phuyal','DEPT0002'),
	('DOC0003','drrisikesh@hospital.com','Rishi1771','Rishikesh','Jadav','DEPT0003'),
	('DOC0004','drashish1@hospital.com','Ashish1121','Ashish','Pagote','DEPT0004'),
	('DOC0005','draayush@hospital.com','Aayush222$','Aayush','Gadia','DEPT0005'),
	('DOC0006','drrachit@hospital.com','Rachit001@','Rachit','Kamdhar','DEPT0006'),
	('DOC0007','drnishant@hospital.com','N23pandey@','Nishant','Pandey','DEPT0007'),
	('DOC0008','drtejus@hospital.com','Tejus0401','Tejus','Verma','DEPT0008'),
	('DOC0009','dranuja@hospital.com','Anuja2020*','Anuja','Sinha','DEPT0009'),
	('DOC0010','drsukriti@hospital.com','Sukriti29@','Sukriti','Jaitly','DEPT0010'),
	('DOC0011','drpreeti@hospital.com','Preeti##11','Preeti','Khana','DEPT0013'),
	('DOC0012','drnikhil@hospital.com','Nikhil0501','Nikhil','Verma','DEPT0015'),
	('DOC0013','drrashi@hospital.com','Rashi@@!#9','Rashi','Jain','DEPT0001'),
	('DOC0014','drarchana@hospital.com','Archana0012','Archana','Kumar','DEPT0002'),
	('DOC0015','drtanwi@hospital.com','tanwi^^11','Tanwi','Sethi','DEPT0003'),
	('DOC0016','drmax@hospital.com','maxseofotty1','Max','Sangwan','DEPT0004'),
	('DOC0017','drkevin@hospital.com','kingkev121','Kevin','Wang','DEPT0005'),
	('DOC0018','drandrea@hospital.com','Andrea@@','Andrea','Wang','DEPT0006'),
	('DOC0019','drnishank@hospital.com','Nishank@r11','Nishank','Kumar','DEPT0007'),
	('DOC0020','drsalman@hospital.com','beingsalman27','Salman','Khan','DEPT0008'),
	('DOC0021','drshahid@hospital.com','shahidhaider@12','Shahid','Kapoor','DEPT0009'),
	('DOC0022','drhritik@hospital.com','Hritikgreek87','Hritik','Roshan','DEPT0006'),
	('DOC0023','drprakash@hospital.com','prakashGoat11','Prakash','Raj','DEPT0006'),
	('DOC0024','dranuj@hospital.com','Anuj##!#','Anuj','Verma','DEPT0010'),
	('DOC0025','drneeraj@hospital.com','neeral@mama','Neeraj','Chopra','DEPT0013')

INSERT INTO[Hospital_System.Patient] VALUES
	('PAT0001','pat_seo.yuhyeon@hospital.com','gshji12','Yehyeon','Seo','7608 Adelphi RD, MD','Male','09/23/1997'),
	('PAT0002','pat_verma.mohak@hospital.com','mohak1234','Mohak','Verma','7605 villanova RD, MD','Male','01/17/2000'),
	('PAT0003','pat_aagard.ally@hospital.com','ally122','Ally','Aagaard','7592 Sycamore Ave Astoria,NY','femlar','01/21/2000'),
	('PAT0004','pat_abadi.alex@hospital.com','alex11@!','Alex','Abadi','74 Bohemia Drive Canfield, OH','Female','12/20/1989'),
	('PAT0005','pat_abbott.lyla@hospital.com','lyla12345','Lyla','Abbott','64 Deerfield Street Clemmons, NC','Female','05/22/1992'),
	('PAT0006','pat_anderson.peter@hospital.com','peter@@238','Peter','Anderson','9978 Meadow St.West Springfield, MA ','Male','12/01/1999'),
	('PAT0007','pat_antonio.billy@hospital.com','abillu12','Billy','Antonio','9518 E. Carriage St.Skokie, IL ','Male', '04/23/1981'),
	('PAT0008','pat_fletcher.christine@hospital.com','flter223','Christine','Fletcher','6802 Cunninghum Drive MD','Female','12/16/1990'),
	('PAT0009','pat_stone.eileen@hospital.com','eileen123','Eileen','Stone','108 Windfall Dr rolla, NC','Female','11/05/2002'),
	('PAT0010','pat_flitzgerald.amber@hospital.com','johnnyamder','Amber','Flitzgerald','106 smith dr. Fuquay Varina, NC','Female','10/04/2005'),
	('PAT0011','pat_barker.victoria@hospital.com','victoria991','Victoria','Barker','7484 Villanova Road MD','Female','12/20/2001'),
	('PAT0012','pat_davidson.janiyah@hospital.com','janiyahhehe','Janiyah','Davidson','6021 Qubec Street MD','Female','03/22/2006'),
	('PAT0013','pat_yates.ruby@hospital.com','ruby12','Ruby','Yates','213 church street Ankey MD','Female','03/30/2004'),
	('PAT0014','pat_west.gillian@hospital.com','west_kanya','Gillian','West','18 W Parker St Crofton MD','Female','04/11/1998'),
	('PAT0015','pat_mathews.ada@hospital.com','june@122','Ada','Mathews','7030 Villanova RD MD','Female','05/22/2005'),
	('PAT0016','pat_wilcox.june@hospital.com','wilcoxjune22','June','Wilcox','7738 Qubec Street MD','Female','05/02/2004'),
	('PAT0017','pat_krause.amber@hospital.com','amher9910','Amber','Krause','8179 New Hampshire MD','Female','06/01/2005'),
	('PAT0018','pat_lam.journey@hospital.com','lam@11','Journey','Lam','931 Blackburn Street MD','Female','07/13/1998'),
	('PAT0019','pat_herrera.sanai@hospital.com','herrera0019','Sanai','Herrera','9111 Miles street MD','Female','02/22/2020'),
	('PAT0020','pat_hayden.ivy@hospital.com','haydenivy','Ivy','Hayden','388 Wood Drive New Hampshire MD','Female','01/22/2012'),
	('PAT0021','pat_farmer.sofia@hospital.com','soifial122','Sofia','Farmer','51 River Avenue Mosiac MD','Female','09/11/2010'),
	('PAT0022','pat_hayden.craig@hospital.com','hayden_king','Craig','Hayden','7071 Villanova RD MD','Male','01/12/2001'),
	('PAT0023','pat_west.mike@hospital.com','west_kanye','Mike','West','7119 Villanova RD MD','Male','04/22/1982'),
	('PAT0024','pat_rocha.casey@hospital.com','rocha_1220','Casey','Rocha','83 Williams St Westmont MD','Male','05/20/2004'),
	('PAT0025','pat_rice.nathan@hospital.com','rice_tikka','Nathan','Rice','938 South Wild Horse MD','Male','07/11/2005'),
	('PAT0026','pat_rooney.wayne@hospital.com','rooney251','Wayne','Rooney','729 Maryland Ave, MD','Male','05/21/1992'),
	('PAT0027','pat_mount_mason@hospital.com','chelsea123','Mason','Mount','930 Tarkilin Hill Ave, MD ','Male','12/12/2001'),
	('PAT0028','pat_foden.phil@hospital.com','mancity13','Phill','Foden','7035 cicrle stockport MD','Male','11/12/2000'),
	('PAT0029','pat_chettri.sunil@hospital.com','bangalurufc','Sunil','Chettri','8615 bangalore city, MD','Male','01/12/1990'),
	('PAT0030','pat_pogba.paul@hospital.com','juventus1223','Paul','Pobga','127 pierce road MD','Male','03/22/1999'),
	('PAT0031','pat_fernandez.bruno@hospital.com','reddevil@@','Bruno','Fernandez','339 Lyme road MD','Male','06/28/1992'),
	('PAT0032','pat_shaw.luke@hospital.com','fooodie@123','Luke','Shaw','9662 Healther Ave MD','Male','04/12/2005'),
	('PAT0033','pat_valverde.fede@hospital.com','halamadrid14','Fede','Valverde','9621 Caterpiller Ave MD','Male','12/05/2000'),
	('PAT0034','pat_kross.tony@hospital.com','germansniper','Tony','Kross','122 sleepy street Ave MD','Male','09/11/2003'),
	('PAT0035','pat_malacia.tyler@hospital.com','leftback@utd','Tyler','Malacia','912 shadyshide Ave MD','Male','03/02/2000'),
	('PAT0036','pat_mctominay.scott@hospital.com','lordisgreat','Scott','Mactoninay','134 Healther Ave MD','Male','07/15/1997'),
	('PAT0037','pat_martial.antony@hospital.com','ballondeor','Antony','Martial','152 indirapurm Ave MD','Male','08/14/1998'),
	('PAT0038','pat_rashford.marcus@hospital.com','sprintmerchant','Marcus','Rashford','123 south oak valley Ave MD','Male','02/18/2004'),
	('PAT0039','pat_maguire.harry@hospital.com','fridge','Harry','Maguire','831 Healther Ave MD','Male','01/19/2001'),
	('PAT0040','pat_lindelof.victor@hospital.com','goodbutnotgood','Victor','Lindelof','482 villanova road Ave MD','Male','01/31/2003'),
	('PAT0041','pat_martinez.lutaro@hospital.com','intermilan','Lutaro','Martinez','9662 gaucher Ave MD','Male','01/29/1999'),
	('PAT0042','pat_lukaku.romelu@hospital.com','intermilan@@','Romelu','Lukaku','132 Heaton street MD','Male','01/30/1998'),
	('PAT0043','pat_ericson.christen@hospital.com','reddevil@@@','Christen','Ericson','672 bablyon Ave MD','Male','01/25/1992'),
	('PAT0044','pat_kante.ngolo@hospital.com','vivalafrance','Ngolo','Kante','932 Bank street Ave MD','Male','02/22/2005'),
	('PAT0045','pat_pirlo.andreas@hospital.com','acmilan@@','Andreas','Pirlo','821 Kings landing Ave MD','Male','04/22/2004'),
	('PAT0046','pat_gerrard.steven@hospital.com','slippyg','Steven','Gerrard','9669 Healther Ave MD','Male','04/11/2003'),
	('PAT0047','pat_lampard.frank@hospital.com','goatmidfeilder','Frank','Lampard','9662 Healtrow Ave MD','Male','06/11/2005'),
	('PAT0048','pat_drogba_didier@hospital.com','drogbaaaaaaa','Didier','Drogba','991 Highstreet Ave MD','Male','04/17/2000'),
	('PAT0049','pat_caroll.andy@hospital.com','looserpool','Andy','Caroll','291 Healther Ave MD','Male','08/12/2000'),
	('PAT0050','pat_robertson.andrew@hospital.com','liverpool','Andrew','Robertson',' 128 Villanova Ave MD','Male','09/11/2000')

 
INSERT INTO [Hospital_System.Nurse] VALUES
	('NUR0001','John','Cena','DEPT0001','DOC0001','PAT0001'),
	('NUR0002','Brock','Lesnar','DEPT0002','DOC0002','PAT0002'),
	('NUR0003','Darlene','Love','DEPT0015','DOC0003','PAT0003'),
	('NUR0004','Kenny ','Nguyen','DEPT0013','DOC0004','PAT0021'),
	('NUR0005','Sam','Hill','DEPT0001','DOC0005','PAT0022'),
	('NUR0006','Heather','Burton','DEPT0006','DOC0014','PAT0032'),
	('NUR0007','Wareen','Alexandar','DEPT0007','DOC0021','PAT0010'),
	('NUR0008','Alison','Jensen','DEPT0008','DOC0013','PAT0011'),
	('NUR0009','Phyllis','Nichols','DEPT0009','DOC0024','PAT0012'),
	('NUR0010','Allen','Wheelers','DEPT0010','DOC0013','PAT0031'),
	('NUR0011','Guy','Park','DEPT0013','DOC0011','PAT0009'),
	('NUR0012','Rodney','Love','DEPT0013','DOC0012','PAT0019'),
	('NUR0013','Blake','Morris','DEPT0009','DOC0013','PAT0029'),
	('NUR0014','Charlie','Curry','DEPT0009','DOC0014','PAT0023'),
	('NUR0015','Frank','Simons','DEPT0007','DOC0015','PAT0013'),
	('NUR0016','Felix','Gilbert','DEPT0005','DOC0016','PAT0015'),
	('NUR0017','Ben','Sullivan','DEPT0003','DOC0017','PAT0017'),
	('NUR0018','Darel','Dixon','DEPT0001','DOC0018','PAT0019'),
	('NUR0019','Luke','Burke','DEPT0009','DOC0019','PAT0030'),
	('NUR0020','Charlene','Mendez','DEPT0008','DOC0020','PAT0050'),
	('NUR0021','Darrin','Sharma','DEPT0002','DOC0021','PAT0028'),
	('NUR0022','Marianne','Verma','DEPT0007','DOC0022','PAT0047'),
	('NUR0023','Bryant','Kumar','DEPT0013','DOC0023','PAT0037'),
	('NUR0024','Johnnie','Stanley','DEPT0013','DOC0024','PAT0048'),
	('NUR0025','Erin','weber','DEPT0015','DOC0025','PAT0040'),
	('NUR0026','Mahinder','Singh','DEPT0002','DOC0001','PAT0035'),
	('NUR0027','Mohammed','Veron','DEPT0007','DOC0002','PAT0046'),
	('NUR0028','Bryant','Kobi','DEPT0013','DOC0001','PAT0017'),
	('NUR0029','John','Morrison','DEPT0013','DOC0013','PAT0009'),
	('NUR0030','Erin','Webnikowshki','DEPT0015','DOC0017','PAT0032'),
	('NUR0031','Noor','Ramagun','DEPT0001','DOC0017','PAT0036'),
	('NUR0032','Brian','Christopher','DEPT0001','DOC0024','PAT0033'),
	('NUR0033','Darlene','Love','DEPT0005','DOC0024','PAT0045'),
	('NUR0034','Kenny ','Nguyen','DEPT0005','DOC0011','PAT0021'),
	('NUR0035','Sam','Hill','DEPT0013','DOC0021','PAT0032'),
	('NUR0036','Heather','Burton','DEPT0006','DOC0015','PAT0049'),
	('NUR0037','Wareen','Alexandar','DEPT0006','DOC0014','PAT0044'),
	('NUR0038','Alison','Jensen','DEPT0007','DOC0013','PAT0047'),
	('NUR0039','Phyllis','Nichols','DEPT0003','DOC0024','PAT0041'),
	('NUR0040','Allen','Wheelers','DEPT0015','DOC0023','PAT0031')


INSERT INTO[Hospital_System.Room] VALUES
	('R001','Single room','PAT0001'),
	('R002','Shared room','PAT0002'),
	('R003','Single room','PAT0003'),
	('R004','Single room','PAT0004'),
	('R005','Single room','PAT0005'),
	('R006','Single room','PAT0006'),
	('R007','Shared room','PAT0007'),
	('R008','Shared room','PAT0008'),
	('R009','Shared room','PAT0009'),
	('R010','Shared room','PAT0010'),
	('R011','Single room','PAT0012'),
	('R012','Shared room','PAT0016'),
	('R013','Single room','PAT0011'),
	('R014','Shared room','PAT0014'),
	('R015','Shared room','PAT0013'),
	('R016','Shared room','PAT0018'),
	('R017','Single room','PAT0017'),
	('R018','Shared room','PAT0019'),
	('R019','Single room','PAT0020'),
	('R020','Shared room','PAT0021'),
	('R021','Shared room','PAT0022'),
	('R022','Shared room','PAT0024'),
	('R023','Shared room','PAT0025'),
	('R024','Shared room','PAT0015'),
	('R025','Shared room','PAT0023'),
	('R026','Shared room','PAT0026'),
	('R027','Shared room','PAT0027'),
	('R028','Shared room','PAT0028'),
	('R029','Shared room','PAT0029'),
	('R030','Shared room','PAT0030'),
	('R031','Shared room','PAT0031'),
	('R032','Shared room','PAT0032'),
	('R033','Shared room','PAT0033'),
	('R034','Shared room','PAT0036'),
	('R035','Shared room','PAT0039'),
	('R036','Shared room','PAT0041'),
	('R037','Shared room','PAT0042'),
	('R038','Shared room','PAT0045'),
	('R039','Shared room','PAT0048'),
	('R040','Shared room','PAT0049')

INSERT INTO [Hospital_System.Medicine] VALUES
	('MED0001','Paracetamol',5.00,'DOC0001'),
	('MED0002','D-Cold',10.00,'DOC0002'),
	('MED0003','Hydrochlorothiazide',10.00,'DOC0003'),
	('MED0004','Ventolin',10.00,'DOC0004'),
	('MED0005','Azithromycin',10.00,'DOC0005'),
	('MED0006','Trazodone Hydrochloride',10.00,'DOC0023'),
	('MED0007','Lisinopril',10.00,'DOC0023'),
	('MED0008','Basaglar',10.00,'DOC0012'),
	('MED0009','Metoprolol Succinate',10.00,'DOC0008'),
	('MED0010','Escitalopram Oxalate',10.00,'DOC0018'),
	('MED0011','Gabapentin',10.00,'DOC0023'),
	('MED0012','Metformin',15.00,'DOC0010'),
	('MED0013','Amlodipine',12.00,'DOC0014'),
	('MED0014','Omeprazole',10.00,'DOC0015'),
	('MED0015','Losartan',10.00,'DOC0023'),
	('MED0016','Pantoprazole',10.00,'DOC0022'),
	('MED0017','Fluoxetine',10.00,'DOC0021'),
	('MED0018','Meloxicam',10.00,'DOC0020'),
	('MED0019','Tramado',10.00,'DOC0018'),
	('MED0020','Pravastatin',10.00,'DOC0023'),
	('MED0021','Cyclobenzaprine',10.00,'DOC0025'),
	('MED0022','Zolpidem',10.00,'DOC0023'),
	('MED0023','Amoxicillin',10.00,'DOC0021'),
	('MED0024','Oxycodone',10.00,'DOC0018'),
	('MED0025','Lamotrigine',10.00,'DOC0023'),
	('MED0026','Astelin',5.00,'DOC0015'),
	('MED0027','Astemizole',10.00,'DOC0012'),
	('MED0028','Atridox',10.00,'DOC0023'),
	('MED0029','Halcion',10.00,'DOC0022'),
	('MED0030','Haldol Decanoate',10.00,'DOC0015'),
	('MED0031', 'Hydrochloride',10.00,'DOC0016'),
	('MED0032','Helidac',10.00,'DOC0007'),
	('MED0033','Combiflam',10.00,'DOC0012'),
	('MED0034','Succinate Havrix',10.00,'DOC0008'),
	('MED0035','Humulin N',10.00,'DOC0024'),
	('MED0036','Paclitaxel',10.00,'DOC0009'),
	('MED0037','Palonosetron',10.00,'DOC0010'),
	('MED0038','Paser',10.00,'DOC0014'),
	('MED0039','Paxil',10.00,'DOC0015'),
	('MED0040','Tabloid',10.00,'DOC0023')

INSERT INTO[Hospital_System.MedicalHistory] VALUES
	('hst0001','10/22/2022','Covid-19','no surgery','flu_medication','PAT0001'),
	('hst0002','12/21/2021','broken ankle','no surgery','Plaster','PAT0002'),
	('hst0003','12/21/2021','general check up','no surgery','Physical check up','PAT0003'),
	('hst0004','12/21/2021','Cold and Flu','no surgery','Plaster','PAT0004'),
	('hst0005','12/21/2021','Broken limb','no surgery','Plaster','PAT0005'),
	('hst0006','12/21/2021','general check up','no surgery','Physical check up','PAT0006'),
	('hst0007','12/21/2021','broken finger','no surgery','Plaster','PAT0007'),
	('hst0008','12/21/2021','general check up','no surgery','Physical check up','PAT0008'),
	('hst0009','12/21/2021','ankle ligament tear','surgery','Plaster','PAT0009'),
	('hst0010','12/21/2021','general check up','no surgery','Physical check up','PAT0010'),
	('hst0011','12/21/2021','general check up','no surgery','Physical check up','PAT0011'),
	('hst0012','12/21/2021','broken toe nail','no surgery','wound cover ','PAT0012'),
	('hst0013','12/21/2021','general check up','no surgery','Physical check up','PAT0013'),
	('hst0014','12/21/2021','Food Poisioning','no surgery','drip','PAT0014'),
	('hst0015','12/21/2021','general check up','no surgery','Physical check up','PAT0015'),
	('hst0016','12/21/2021','broken elbow','surgery to fix','Plaster','PAT0016'),
	('hst0017','12/21/2021','high blood sugar','no surgery','insulin shots','PAT0017'),
	('hst0018','12/21/2021','general check up','no surgery','Physical check up','PAT0018'),
	('hst0019','12/21/2021','broken ankle','no surgery','Plaster','PAT0019'),
	('hst0021','12/21/2021','broken ankle','no surgery','Plaster','PAT0021'),
	('hst0022','10/22/2022','Covid-19','no surgery','flu_medication','PAT0022'),
	('hst0023','12/21/2021','broken ankle','no surgery','Plaster','PAT0023'),
	('hst0024','12/21/2021','general check up','no surgery','Physical check up','PAT0024'),
	('hst0025','12/21/2021','Cold and Flu','no surgery','Plaster','PAT0025'),
	('hst0026','12/21/2021','Broken limb','no surgery','Plaster','PAT0026'),
	('hst0027','12/21/2021','general check up','no surgery','Physical check up','PAT0027'),
	('hst0028','12/21/2021','broken finger','no surgery','Plaster','PAT0028'),
	('hst0029','12/21/2021','general check up','no surgery','Physical check up','PAT0029'),
	('hst0030','12/21/2021','ankle ligament tear','surgery','Plaster','PAT0030'),
	('hst0031','12/21/2021','general check up','no surgery','Physical check up','PAT0031'),
	('hst0032','12/21/2021','general check up','no surgery','Physical check up','PAT0032'),
	('hst0033','12/21/2021','broken toe nail','no surgery','wound cover ','PAT0033'),
	('hst0034','12/21/2021','general check up','no surgery','Physical check up','PAT0034'),
	('hst0035','12/21/2021','Food Poisioning','no surgery','drip','PAT0035'),
	('hst0036','12/21/2021','general check up','no surgery','Physical check up','PAT0036'),
	('hst0037','12/21/2021','broken elbow','surgery to fix','Plaster','PAT0037'),
	('hst0038','12/21/2021','high blood sugar','no surgery','insulin shots','PAT0038'),
	('hst0039','12/21/2021','general check up','no surgery','Physical check up','PAT0039'),
	('hst0040','12/21/2021','broken ankle','no surgery','Plaster','PAT0040'),
	('hst0041','12/21/2021','broken ankle','no surgery','Plaster','PAT0041'),
	('hst0042','12/21/2021','general check up','no surgery','Physical check up','PAT0042'),
	('hst0043','12/21/2021','broken toe nail','no surgery','wound cover ','PAT0043'),
	('hst0044','12/21/2021','general check up','no surgery','Physical check up','PAT0044'),
	('hst0045','12/21/2021','Food Poisioning','no surgery','drip','PAT0045'),
	('hst0046','12/21/2021','general check up','no surgery','Physical check up','PAT0046'),
	('hst0047','12/21/2021','broken elbow','surgery to fix','Plaster','PAT0047'),
	('hst0048','12/21/2021','high blood sugar','no surgery','insulin shots','PAT0048'),
	('hst0049','12/21/2021','general check up','no surgery','Physical check up','PAT0049'),
	('hst0050','12/21/2021','broken ankle','no surgery','Plaster','PAT0050')

INSERT INTO[Hospital_System.Bill] VALUES
	('BIL0000',500.00,200.00,4,'DOC0001','PAT0001','MED0001','R001'),
	('BIL0002',100.00,250.00,5,'DOC0002','PAT0002','MED0002','R002'),
	('BIL0003',247.00,100.00,4,'DOC0003','PAT0003','MED0003','R003'),
	('BIL0004',290.00,150.00,3,'DOC0004','PAT0004','MED0004','R004'),
	('BIL0005',240.00,350.00,7,'DOC0005','PAT0005','MED0005','R005'),
	('BIL0006',213.00,150.00,3,'DOC0006','PAT0006','MED0006','R006'),
	('BIL0007',114.00,50.00,1,'DOC0007','PAT0007','MED0007','R007'),
	('BIL0008',110.00,200.00,4,'DOC0008','PAT0008','MED0008','R008'),
	('BIL0009',71.00,50.00,1,'DOC0002','PAT0009','MED0009','R009'),
	('BIL0010',350.00,500.00,10,'DOC0009','PAT0010','MED0010','R010'),
	('BIL0011',310.00,350.00,7,'DOC0010','PAT0011','MED0011','R011'),
	('BIL0012',400.00,150.00,3,'DOC0013','PAT0012','MED0012','R012'),
	('BIL0013',427.00,50.00,1,'DOC0015','PAT0013','MED0013','R013'),
	('BIL0014',132.00,300.00,6,'DOC0015','PAT0014','MED0014','R014'),
	('BIL0015',134.00,350.00,7,'DOC0007','PAT0015','MED0015','R015'),
	('BIL0016',410.00,200.00,4,'DOC0002','PAT0016','MED0016','R016'),
	('BIL0017',138.00,250.00,5,'DOC0003','PAT0017','MED0017','R017'),
	('BIL0018',131.00,100.00,2,'DOC0024','PAT0018','MED0018','R018'),
	('BIL0019',412.00,150.00,3,'DOC0025','PAT0019','MED0019','R019'),
	('BIL0020',482.00,150.00,3,'DOC0016','PAT0020','MED0020','R020'),
	('BIL0021',500.00,200.00,4,'DOC0017','PAT0021','MED0021','R021'),
	('BIL0022',100.00,250.00,5,'DOC0018','PAT0022','MED0022','R022'),
	('BIL0023',247.00,100.00,4,'DOC0019','PAT0023','MED0023','R023'),
	('BIL0024',290.00,150.00,3,'DOC0010','PAT0024','MED0024','R024'),
	('BIL0025',240.00,350.00,7,'DOC0011','PAT0025','MED0025','R025'),
	('BIL0026',213.00,150.00,3,'DOC0012','PAT0026','MED0026','R026'),
	('BIL0027',114.00,50.00,1,'DOC0013','PAT0027','MED0027','R027'),
	('BIL0028',110.00,200.00,4,'DOC0015','PAT0028','MED0028','R028'),
	('BIL0029',71.00,50.00,1,'DOC0014','PAT0029','MED0029','R029'),
	('BIL0030',350.00,500.00,10,'DOC0016','PAT0030','MED0030','R030'),
	('BIL0031',500.00,200.00,4,'DOC0017','PAT0031','MED0031','R031'),
	('BIL0032',100.00,250.00,5,'DOC0018','PAT0032','MED0032','R032'),
	('BIL0033',247.00,100.00,4,'DOC0019','PAT0033','MED0033','R033'),
	('BIL0034',290.00,150.00,3,'DOC0020','PAT0034','MED0034','R034'),
	('BIL0035',240.00,350.00,7,'DOC0021','PAT0035','MED0035','R035'),
	('BIL0036',213.00,150.00,3,'DOC0022','PAT0036','MED0036','R036'),
	('BIL0037',114.00,50.00,1,'DOC0023','PAT0037','MED0037','R037'),
	('BIL0038',110.00,200.00,4,'DOC0024','PAT0038','MED0038','R038'),
	('BIL0039',71.00,50.00,1,'DOC0001','PAT0039','MED0039','R039'),
	('BIL0040',350.00,500.00,10,'DOC0002','PAT0040','MED0020','R030'),
	('BIL0041',500.00,200.00,4,'DOC0003','PAT0041','MED0001','R031'),
	('BIL0042',100.00,250.00,5,'DOC0004','PAT0042','MED0002','R032'),
	('BIL0043',247.00,100.00,4,'DOC0005','PAT0043','MED0003','R033'),
	('BIL0044',290.00,150.00,3,'DOC0006','PAT0044','MED0004','R034'),
	('BIL0045',240.00,350.00,7,'DOC0007','PAT0045','MED0005','R035'),
	('BIL0046',213.00,150.00,3,'DOC0008','PAT0046','MED0006','R036'),
	('BIL0047',114.00,50.00,1,'DOC0009','PAT0047','MED0007','R037'),
	('BIL0048',110.00,200.00,4,'DOC0010','PAT0048','MED0008','R038'),
	('BIL0049',71.00,50.00,1,'DOC0025','PAT0049','MED0009','R039'),
	('BIL0050',350.00,500.00,10,'DOC0009','PAT0050','MED0010','R030')

INSERT INTO[Hospital_System.Store] VALUES
	('PAT0001','hst0001'),
	('PAT0002', 'hst0002'),
	('PAT0003', 'hst0003'),
	('PAT0004','hst0004'),
	('PAT0005', 'hst0005'),
	('PAT0006', 'hst0006'),
	('PAT0007','hst0007'),
	('PAT0008', 'hst0008'),
	('PAT0009', 'hst0009'),
	('PAT0010','hst0010'),
	('PAT0011', 'hst0011'),
	('PAT0012', 'hst0012')

INSERT INTO[Hospital_System.Prescribe] VALUES
	('DOC0001', 'PAT0001', 'MED0001'),
	('DOC0002', 'PAT0002', 'MED0002'),
	('DOC0003', 'PAT0003', 'MED0003'),
	('DOC0004', 'PAT0004', 'MED0004'),
	('DOC0005', 'PAT0005', 'MED0005'),
	('DOC0006', 'PAT0006', 'MED0006'),
	('DOC0007', 'PAT0007', 'MED0007'),
	('DOC0008', 'PAT0008', 'MED0008'),
	('DOC0009', 'PAT0009', 'MED0009'),
	('DOC0010', 'PAT0010', 'MED0010'),
	('DOC0011', 'PAT0011', 'MED0012')


INSERT INTO[Hospital_System.Allot] VALUES
	('R001','PAT0001'),
	('R002','PAT0002'),
	('R003','PAT0003'),
	('R004','PAT0004'),
	('R005','PAT0005'),
	('R006','PAT0006'),
	('R007','PAT0007'),
	('R008','PAT0008'),
	('R009','PAT0009'),
	('R010','PAT0010'),
	('R011','PAT0011'),
	('R012','PAT0012'),
	('R013','PAT0013')


INSERT INTO[Hospital_System.Pay] VALUES
	('PAT0001', 'BIL0000','04-01-2021'),
	('PAT0002', 'BIL0002','06-01-2002'),
	('PAT0003', 'BIL0003','03-01-2019'),
	('PAT0004', 'BIL0004','01-01-2020'),
	('PAT0005', 'BIL0005','01-01-2021'),
	('PAT0006', 'BIL0006','04-01-2022'),
	('PAT0007', 'BIL0007','05-01-2022'),
	('PAT0008', 'BIL0008','06-01-2017'),
	('PAT0009', 'BIL0009','01-01-2018'),
	('PAT0010', 'BIL0010','11-01-2022'),
	('PAT0011', 'BIL0011','10-01-2022'),
	('PAT0012', 'BIL0012','01-01-2022')

INSERT INTO[Hospital_System.Assign] VALUES
	('NUR0001', 'PAT0001'),
	('NUR0002', 'PAT0002'),
	('NUR0003', 'PAT0003'),
	('NUR0004', 'PAT0004'),
	('NUR0005', 'PAT0005'),
	('NUR0006', 'PAT0006'),
	('NUR0007', 'PAT0007'),
	('NUR0008', 'PAT0008'),
	('NUR0009', 'PAT0009'),
	('NUR0010', 'PAT0010'),
	('NUR0011', 'PAT0011'),
	('NUR0012', 'PAT0012'),
	('NUR0013', 'PAT0013')

INSERT INTO[Hospital_System.Assist] VALUES
	('NUR0001', 'DOC0001'),
	('NUR0002', 'DOC0002'),
	('NUR0003', 'DOC0003'),
	('NUR0004', 'DOC0004'),
	('NUR0005', 'DOC0005'),
	('NUR0006', 'DOC0006'),
	('NUR0007', 'DOC0007'),
	('NUR0008', 'DOC0008'),
	('NUR0009', 'DOC0009'),
	('NUR0010', 'DOC0010'),
	('NUR0011', 'DOC0011'),
	('NUR0012', 'DOC0012'),
	('NUR0013', 'DOC0013')

INSERT INTO[Hospital_System.Work] VALUES
	('DEPT0001', 'DOC0001'),
	('DEPT0002', 'DOC0002'),
	('DEPT0003', 'DOC0003'),
	('DEPT0004', 'DOC0004'),
	('DEPT0005', 'DOC0005'),
	('DEPT0006', 'DOC0006'),
	('DEPT0007', 'DOC0007'),
	('DEPT0008', 'DOC0008'),
	('DEPT0009', 'DOC0009'),
	('DEPT0010', 'DOC0010'),
	('DEPT0013', 'DOC0011'),
	('DEPT0015', 'DOC0012')
