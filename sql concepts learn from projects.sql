-- CONCEPTS LEARN FROM PROJECTS

Q1- IF YOU WANT TO EXTRACT MONTH FROM DATE-COLUMN?
	`phly chack kro k vo column DATE format m h ya nhi, is k liye 
    use DESCRIBE TABLE_NAME, and then use method MONTH e.g: MONTH(date_col);`
    
Q2- HOW TO CHANGE COLUMN FORMAT FROM TEXT TO DATE USING STR_TO_DATE?
	`behter h k usi column k format ko convert na kro q k issues ay gy blk 
     ek new column bnao jis ki datatype DATE ho, like this:
	 ALTER TABLE TABLE_NAME ADD COLUMN NEW_DATE_DTYPE_COL DATE; and purany vala
     column (jis ki type text h or hmy date m convert krna h) ko date format m 
     convert kro and us ko new column ko de do and puray column ko delete kro do
     like this: UPDATE TABLE_NAME SET NEW_DATE_DTYPE_COL = STR_TO_DATE(PURANA_COL, %d,%m,%y);
     AND THEN PURAY COLUMN KO DELETE KRO DO`
	
Q3: DIFFERENCE BETWEEN UPDATE AND ALTER?
	`update is used to change data of table and alter is used to change structure of table 
     such as add col, delete col, change DATATYPE, rename column etc`
    
-- if ypu want to get output bpoth from the table made using CTE and the 
-- main table, don't forget to use join 

-- Nested aggregate functions such as sum(count(*)) cannot be used with group by, you must have to 
-- use window functions for it 







    
    