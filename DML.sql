
--how old are majority of the patients?
SELECT DATEDIFF(year,patDOB,GETDATE()) Age, count(*) AS 'Number of Patients' 
FROM [Hospital_System.Patient]
GROUP BY DATEDIFF(year,patDOB,GETDATE())
ORDER BY count(*) DESC

--which department has the most doctors?
SELECT o. depID AS 'Department ID' , d. depName AS 'Department Name', count(*) AS 'Number of Doctors'
FROM [Hospital_System.Department] d,[Hospital_System.Doctor] o
WHERE d.depID=o.depID
GROUP BY o.depID, d.depName
ORDER BY 'Number of Doctors' DESC

--what kind of room is preferred by most patients?
SELECT romType AS 'Room Preferred', COUNT(patID) AS 'Number of Patients'
FROM [Hospital_System.Room]
GROUP BY romType


-- which doctors prescribed the most medicines? 
SELECT d.docID, CONCAT (d.docFirstName,' ' ,d.docLastName) AS 'Doctor Name',  COUNT(distinct medID) AS 'No. of medicines prescribed'
FROM [Hospital_System.Doctor] d, [Hospital_System.Medicine] m
WHERE d.docID = m.docID
GROUP BY d.docID, CONCAT (d.docFirstName,' ' ,d.docLastName)
ORDER BY COUNT(DISTINCT medID) DESC

-- retrieve the first and last names of all patients who suffered from Covid-19
SELECT p.patFirstName, p.patLastName
FROM [Hospital_System.Patient] p
JOIN [Hospital_System.MedicalHistory] m
ON p.patID = m.patID
WHERE hstDisease = 'Covid-19'

