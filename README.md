# Hospital-Database-Management-Project
The project's goal is to computerize the hospital's front office management in order to create software that is user friendly, simple, fast, and cost effective.

<img width="395" alt="Screenshot 2023-02-12 at 11 34 25 PM" src="https://user-images.githubusercontent.com/102799924/218373430-b3b5ec6b-6a12-4e91-a659-f6d57622ab55.png">

Healthcare is widely accepted to be the most fundamental human right. With the advancement of technology, there are several ways in which we can automate the data storing process for various stakeholders by developing a systematic database management system which will help in improving efficiency and reducing costs. 

MoMo Hospital is a multi-specialty hospital with specialized Intensive Care Unit (ICU) & 24-hrs emergency & laboratory service. With a team of world-class doctors and other healthcare professionals, we aim to provide unparalleled healthcare to our patients. From diagnosis to discharge, a patient goes through several intermediary steps as part of treatment, including, but not limited to, laboratory tests, medication, billing, etc. Hospital employees who contribute to the smooth functioning of the hospital are allocated to different departments. 

The project's goal is to computerize the hospital's front office management in order to create software that is user friendly, simple, fast, and cost effective. It is concerned with the gathering of patient information, diagnosis details, and so on. It was traditionally done by hand. The system's primary function is to register and store patient and doctor information, as well as to retrieve and manipulate this information as needed. System input contains patient and diagnosis information, while system output displays these details on the screen. A username and password are required to access the Hospital Management System. It can be accessed by an administrator or a receptionist. Only they have access to the database.
Stakeholders for the Hospital system 

At MoMo hospital, we strive to provide the highest level of care not just for our patients, but for all stakeholders within the organization. We have a number of stakeholders that impact the processes and outcomes of the hospital and for the scope of this project, we are recognizing the
##### Internal stakeholders:
Doctors
Nurses
Non-medical staff members

##### External stakeholders:
Inpatients and outpatients
Shareholders of the hospital 
Suppliers
Competitors

Both internal and external stakeholders have their own unique way in which they impact the functioning of the hospital and we would like to build a systematic database system to store their data in order to provide maximum efficiency in carrying out day-to-day operations. 

### Motivation and Objectives 
The main objective of building a hospital management system is to provide an efficient and faster way for each stakeholder [either admin or the user] to access, edit and update the database. By creating a database, we are able to eliminate the following problems which existed previously:
1. Loss of Data
As the influx of data produced in any hospital is very high and records of patients that need to be stored for a very long time. There is a high chance of losing data. By our Hospital management system, we are making sure that all the data stays stored in our database system and can be retrieved easily. 
2. Data Redundancy 
Since the Database has multiple records and multiple data about the same   patient, there is a high chance of data redundancy. Redundancy can be explained as a condition created within a database or data storage technology in which the same piece of data is held in two separate places. This can mean two different fields within a single database, or two different spots in multiple software environments or platforms. Whenever data is repeated, it basically constitutes data redundancy. Redundancy leads to an increase in cost of data storage. In this project we are making a hospital management system with no redundant data thus, eliminating added cost.  
3. Data Privacy and security
Data privacy is a very essential aspect of a hospital database. The data stored in a hospital system consists of data ranging from private and discreet information about the condition of a patient to their billing details. In our system we are securing the database with unique passwords on both user and admin end.
4. Data Transferring  
Data transferring is very essential for a hospital management system as sometimes patients get transferred from one hospital to another for better referencing and better treatment. By developing a hospital management system, we have made data transferring easy as one patient’s medical records can directly be downloaded and transferred.

### ER Schema
 
#### Entities, Attributes and Primary Keys

Patient(**<ins>patID</ins>**,patEmail,patPassword,patName,-patFirstName,-patLastName,patAddress, patSex,patDOB)
 
Doctor(**<ins>docID</ins>**,docEmail,docPassword,docName,-docFirstName,-docLastName)
 
MedicalHistory(**<ins>hstID</ins>**,hstAppointmentDate,hstDisease,hstSurgeries,hstPreviousMedication)
 
Nurse(**<ins>nurID</ins>** ,nurName,-nurFirstName,-nurLastName)

Department (**<ins>depID</ins>**, depName, depNumber, depEmail)
 
Room(**<ins>roomID</ins>**,roomType)
 
Medicine(**<ins>medID</ins>**,medName,medCost)

Bill(**<ins>bilID</ins>**,bilDoctorCharge,bilRoomCharge,bilNumberofdays)
 
#### Relationships, Attributes, Degrees, Participating Entities and Constraints

Work: binary relationship
1 doctor to 0 or many department
1 department to 1 or many doctor

Assist: binary relationship
1 doctor to 1 or many nurses 
1 nurse to 1 or many doctors

Allot: binary relationship
1 room to 1 or many patients
1 patient to 0 or 1 room

Store: binary relationship
1 patient to 1 or many medical histories
1 medical history to 1 patient

Pay: binary relationships 
1 patient to 1 or many bills
1 bill to 1 patient
 
Assign: binary relationship
1 nurse to 0 or many patients
1 patient to 1 or many nurses

Prescribe: ternary relationship
1 doctor and 1 medicine to 0 or many patient 
1 doctor and 1 patient to 0 or many medicines
1 patient and 1 medicine to 1 or many doctor



### ER Diagram:

![Project_0506_01 (7)](https://user-images.githubusercontent.com/102799924/218373791-dbec5fa9-672d-4ae6-8d6b-cb1448606cc0.png)

### Relational schema

Patient(**<ins>patID</ins>**,patEmail,patPassword,patFirstName,patLastName,patAddress, patSex,patDOB)
 
Doctor(**<ins>docID</ins>**,docEmail,docPassword, docFirstName, docLastName, depID)
 
MedicalHistory(**<ins>hstID</ins>**,hstAppointmentDate,hstDisease,hstSurgeries,
hstPreviousMedication,patID)
 
Nurse(**<ins>nurID</ins>**, nurFirstName, nurLastName, depID, patID, docID)
 
Department (**<ins>depID</ins>**, depName, depNumber, depEmail)
 
Room (**<ins>romID</ins>**, romType, patID)
 
Medicine(**<ins>medID</ins>**, medName, medCost, docID)
 
Bill(**<ins>bilID</ins>**,bilDoctorCharge, bilRoomCharge, bilNumberOfDays)
 
Store (**<ins>patID</ins>**, **<ins>hstID</ins>**)
 
Prescribe (**<ins>docID</ins>**, **<ins>patID</ins>**, **<ins>medID</ins>**)
 
Allot (**<ins>romID</ins>**, **<ins>patID</ins>**)
 
Pay (**<ins>patID</ins>**, **<ins>bilID</ins>**, paymentDate)

Assign (**<ins>nurID</ins>**, **<ins>patID</ins>**)
 
Assist (**<ins>nurID</ins>**, **<ins>docID</ins>**)
 
Work (**<ins>depID</ins>**, **<ins>docID</ins>**)


### Business rules and determine referential integrity actions.

[R1] When a department is deleted from the database, the corresponding doctor’s information should also be deleted from the database.

[R2] When the information on a department is changed in the database, the corresponding doctor’s information should be changed in the database accordingly.

[R3] When a patient is deleted from the database, the corresponding medical history of the patient should also be deleted from the database.

[R4] When the information on a patient is updated in the database, the corresponding medical history of the patient should also be updated accordingly.

[R5] When a nurse is working in a specific department, the information of the department cannot be deleted or changed in the database.

[R6] When a nurse is tending to a certain patient, the information of the patient cannot be deleted or changed in the database.

[R7] When a nurse is working for a doctor, the doctor’s information cannot be deleted from the database.

[R8] When a nurse is working for a doctor, if the information of the doctor is changed in the database, the nurse’s information should be changed accordingly.

[R9] When a room is occupied by a patient, the patient’s information cannot be deleted from the database.

[R10] When a room is occupied by a patient, if the information of the patient is changed in the database, the room information should be changed accordingly.

[R11] When a doctor has prescribed a certain medicine, the doctor’s information cannot be deleted from the database.

[R12] When a doctor has prescribed a certain medicine, if the doctor’s information is changed in the database, the medicine information should be changed accordingly.

[R13] When a patient’s medical history is stored in the database, if the information of the patient is deleted or updated, the medical history of that patient should also be deleted or updated accordingly.

[R14] When a patient’s medical history is stored in the database, the medical history cannot be deleted or changed.

[R15] When a doctor has prescribed a medicine to a patient, if the doctor’s information is deleted or changed, the patient and the medicine information should also be deleted or changed accordingly.

[R16] When a doctor has prescribed a medicine to a patient, if the patient’s information is deleted or changed, the doctor and the medicine information should also be deleted or changed accordingly.

[R17] When a doctor has prescribed a medicine to a patient, the medicine information cannot be deleted or changed in the database.

[R18] When a room is allotted to a patient, the patient information cannot be deleted or updated in the database.

[R19] When a room is allotted to a patient, if the information on the room is deleted or changed in the database, the patient information should be deleted or updated accordingly.

[R20] When a patient has paid a bill, if the patient information is deleted or changed in the database, the bill information should be deleted or changed accordingly.

[R21] When a patient has paid a bill, the bill information cannot be deleted or updated in the database.

[R22] When a nurse has been assigned to a patient, if the nurse’s information is deleted or changed in the database, the patient’s information should also be deleted or changed in the database accordingly.

[R23] When a nurse has been assigned to a patient, if the patient’s information is deleted or changed in the database, the nurse’s information should also be deleted or changed in the database accordingly.

[R24] When a nurse is assisting a doctor, if the nurse’s  information is deleted or changed in the database, the doctor’s information should also be deleted or changed in the database accordingly.

[R25] When a nurse is assisting a doctor, the doctor’s information cannot be deleted or changed in the database.

[R26] When a doctor is working for a department, if the information on the department is deleted or changed in the database, the doctor’s information should be deleted or changed accordingly.

[R27] When a doctor is working for a department, the information on the doctor cannot be deleted or changed in the database.



### SAMPLE DATA


Department ('DEPT0001','Emergency','2409277750','emergency_momo@hospital.com')


Doctor('DOC0001','drmaria@hospital.com','Maria1234','Maria','Shaikh','DEPT0001')


Nurse('NUR0001','John','Cena','DEPT0001','DOC0001','PAT0001')


Patient('PAT0001','pat_seo.yuhyeon@hospital.com','gshji12','Yehyeon','Seo','7608 Adelphi RD, MD','Male','09/23/1997')


Medicine ('MED0001','Paracetamol',5.00,'DOC0001')


MedicalHistory('hst0001','10/22/2022','Covid-19','no_surgery','flu_medication','PAT0001')


Room('R001','Single room','PAT0001')


Bill ('BIL0000',500.00,200.00,4,'DOC0001','PAT0001','MED0001','R001')


Store ('PAT0001','hst0001')


Prescribe ('DOC0001', 'PAT0001', 'MED0001')


Allot ('R001','PAT0001')


Pay ('PAT0001', 'BIL0000','04-01-2021')


Assign ('NUR0001', 'PAT0001')


Assist ('NUR0001', 'DOC0001')


Work ('DEPT0001', 'DOC0001')


