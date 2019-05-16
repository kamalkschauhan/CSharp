select * from galileopcc where pcc like '30G4'
 declare @Counter int
set @Counter = 0
UPDATE AATTagList SET @Counter = PKID = @Counter + 1

select init, max(rowid) from test group by init
select init from test group by init having count(*)>1

SELECT * INTO aatdisplayNew
FROM DataMig..aatdisplay where tcty in ('bru','cai','yyz','ams') order by pkid desc

SELECT * FROM Segments where [TransactionRef] = 788845862

--data generator website
http://www.generatedata.com/#generator

declare @GTIDs varchar(max), @pos int, @nextpos int, @valuelen int
set @GTIDs= '146502/146504/1C5A03/1C5A04/F10145/1C5A05/C2A459/C2A45A'
SELECT @pos = 0, @nextpos = 1
WHILE @nextpos > 0
BEGIN
   SELECT @nextpos = charindex('/', @GTIDs, @pos + 1)
  SELECT @valuelen = CASE WHEN @nextpos > 0
                          THEN @nextpos
                          ELSE len(@GTIDs) + 1
                        END - @pos - 1
   INSERT PCC_GTID_MAP (PCC, GTID)
     VALUES ('k66', substring(@GTIDs, @pos + 1, @valuelen))
  SELECT @pos = @nextpos
END

select top 5 * from PCC_GTID_MAP where GTIDType is not null

declare @XmlParameter xml 

declare @GTIDs varchar(max), @pos int, @nextpos int, @valuelen int, @count int
Declare @gtid table(GTID varchar(6))
Select @GTIDs='C76711:C70EC4:C2A443:C2A44C:C2A000'

SELECT @pos = 0, @nextpos = 1
 WHILE @nextpos > 0
BEGIN
  SELECT @nextpos = charindex(':', @GTIDs, @pos + 1)
  SELECT @valuelen = CASE WHEN @nextpos > 0
                          THEN @nextpos
                          ELSE len(@GTIDs) + 1
                         END - @pos - 1
  INSERT INTO @gtid (gtid) values (substring(@GTIDs, @pos + 1, @valuelen))
  SELECT @pos = @nextpos
END
--select * from @gtid
select * FROM PCC_GTID_MAP WHERE PCC = 'k66' And GTID not in (Select gtid from @gtid) and  gtid='C76711'
 --DELETE FROM PCC_GTID_MAP WHERE PCC = @ACT And GTID not in (Select gtid from @gtid)
select * FROM UATDisplay WHERE GTID in (Select gtid from PCC_GTID_MAP where PCC = 'k66') and termtype like '%hco%'
 declare @GTIDs varchar(max)
set @GTIDs = 'EC073A:EC073B:EC073F:EC8DD6:EC52DE:ED4552'
select REPLACE(@GTIDs,':',',')

--Cannot resolve the collation conflict between 
--"SQL_Latin1_General_CP1_CI_AS" and 
 --"SQL_1xCompat_CP850_CI_AS" in the not equal to operation.

select some
select * from fn_helpcollations() where name like '%SQL_Latin1_General_CP1_CI_AS%'
--or name = 'Latin1_General_CI_AS'
 --or name like '%cp1%'

Select len(SID_CD), len(LTrim(RTrim(SID_CD))) from GAL_CUS_XREF where SID_CD like '0   '
Select SID_CD, Len(SID_CD) as 'length', Len(Ltrim(Rtrim(SID_CD)))as 'length' from GAL_CUS_XREF

ALTER TABLE PCC_GTID_MAP
drop column [status]

ALTER TABLE UATDisplay
add GlobalAccessGTID varchar(6) NULL

ALTER TABLE AATDisplay 
ALTER COLUMN AUTH varchar(3000)

ALTER TABLE CorpRefLookup 
 ALTER COLUMN ModifiedOn TO ModifiedOn1

--doesn't work
--ALTER TABLE CorpRefLookup 
--ALTER COLUMN [ModifiedOn] SET DEFAULT (getdate())

--doesn't work
--ALTER TABLE CorpRefLookup 
--ALTER COLUMN ModifiedOn DROP DEFAULT

SELECT * FROM sysobjects WHERE type = 'D'

IF EXISTS (SELECT name FROM sysobjects
         WHERE name ='DF_CorpRefLookup_ModifiedOn' 
            AND type = 'D')
BEGIN
 ALTER TABLE CorpRefLookup
  DROP CONSTRAINT DF_CorpRefLookup_ModifiedOn
END

select * from 

ALTER TABLE CorpRefLookup
ADD CONSTRAINT test DEFAULT getdate() for ModifiedOn
GO
 

select SID_CD, count(SID_CD) [count] from GAL_CUS_XREF group by SID_CD order by [count] desc
 select * from GAL_CUS_XREF where SID_CD = 'SY1'

select CIDB_CUS_ID, count(CIDB_CUS_ID) [count] from GAL_CUS_XREF group by CIDB_CUS_ID order by [count] desc
select * from GAL_CUS_XREF where CIDB_CUS_ID = '0000442686'
 Select * from GAL_CUS_XREF where CIDB_CUS_ID = '0000440076'

select Pseudo, count(Pseudo) [count] from Pseudo_City_Codes group by Pseudo order by [count] desc

SELECT * INTO eita2b FRoM ISO_Countries 

Select SID_CD as PCC, CIDB_CUS_ID as CIDB, Country_temp as Country from GAL_CUS_XREF Where Country_temp ='AE'


'<?xml version="1.0" ?>
<NewDataSet>
 <CIDBList>
   <PCC>01O</PCC>
  <CIDB>2050</CIDB>
 </CIDBList>
 <CIDBList>
  <PCC>07J</PCC>
  <CIDB>2051</CIDB>
 </CIDBList>
</NewDataSet>'

--------------------------------------------------------------------------------------------------
Declare @tblTemp Table(ID INT IDENTITY, MappingID INT, PCC Varchar(4),CIDB Int, RemoveFlag bit NULL DEFAULT (0))
 Insert Into @tblTemp select MappingID, Pseudo, CIDBNumber, RemoveFlag from PseudoCIDB_Mapping_History 
                union select MappingID, Pseudo, CIDBNumber, RemoveFlag  from PseudoCIDB_Mapping 
--select * from @tblTemp 
     
Declare @Count Int, @MappingID INT, @CIDBOrig INT, @PCC varchar(4), @CIDB INT
Set @Count=1
While (@Count <= (Select Count(*) From @tblTemp))
BEGIN
    Select @MappingID = MappingID, @PCC = PCC, @CIDB = CIDB From @tblTemp Where ID=@Count
 -------------- comparing from original table
    select @CIDBOrig = CIDBNumber from PseudoCIDB_Mapping where 
        Pseudo = @PCC and CIDBNumber = @CIDB

--@@IDENTITY - system function that returns the last-inserted identity value.
 --@@rowcount - returns the number of rows affected by the last statement. 
--If the number of rows is more than 2 billion, use ROWCOUNT_BIG
 
    if (@@rowcount < 1)
        Begin
            update @tblTemp set RemoveFlag = 1 Where ID=@Count
         End
    Else
        Begin
            update @tblTemp set RemoveFlag = 0 Where ID=@Count 
        end
    Set @Count =@Count+1
END
--select * from @tblTemp 
select * from @tblTemp where PCC='2323'
 --------------------------------------------------------------------------------------------------

CASE SIGN(1 - @VoucherMonth)   
      WHEN 0 THEN ISNULL(@DebitAmount, 0)   
      WHEN 1 THEN ISNULL(@DebitAmount, 0)  
       ELSE 0   
END

Insert into GalileoPCC (PCC,Process_Status) Select PCC,Process_Status from DataMig..GalileoPCC
Insert into ApolloPCC (PCC,Process_Status) Select PCC,Process_Status from DataMig..ApolloPCC

update ApolloPCC set Process_Status=null where PCC in (
select PCC from ApolloPCC where Process_Status = 'processed'
except
select ACT from AATDisplay
)
Declare @tblTemp Table(ID INT IDENTITY,PCC Varchar(4))
 Insert Into @tblTemp Select ACT From aATDisplay 
select * from @tblTemp 
Declare @Count Int,@PCCTemp NVarchar(4)
Set @Count=1
While (@Count <= (Select Count(*) From @tblTemp))
BEGIN
    Select @PCCTemp=PCC From @tblTemp Where ID=@Count    
     update ApolloPCC set Process_Status = 'Processed' where PCC = @PCCTemp
    Set @Count =@Count+1
END

Select Pseudo, CIDBNumber From PseudoCIDB_Mapping
Select Pseudo, CIDBNumber From PseudoCIDB_Mapping_History

Declare @tblTemp Table(ID INT IDENTITY, PCC Varchar(4),CIDB Varchar(20), RemoveFlag bit)
Insert Into @tblTemp( PCC,CIDB,RemoveFlag ) Select Pseudo, CIDBNumber,0 From PseudoCIDB_Mapping

Insert Into @tblTemp( PCC,CIDB,RemoveFlag) Select Pseudo PCC,CIDBNumber CIDB,1 from PseudoCIDB_Mapping_History 
 except Select pseudo,cidbnumber,1 from PseudoCIDB_Mapping

Select * from @tblTemp order by pcc

select Pseudo,UpdatedOnHost, count(CIDBNumber) [count] from PseudoCIDB_Mapping 
group by Pseudo,UpdatedOnHost order by count(CIDBNumber) desc


Select city_code, Count(*)[count] from City_Country_Map group by city_code order by 2 desc
select * from City_Country_Map where city_code in ('ATH','MOW','PRG','CUR',
'DXB','JNB','DKR','ACC','ADD','STO','SYD','SWI',
 'RAI','ROM','BRU','CAI','DLA','LUN') order by city_code

exec spGetCityCodeList

select * from ApolloPCC where pcc in ('17DV','16A5','1F0Y','1H4D','1H4J','1M97','1S6I','1WZ2','17D6','1C64')
 select auth from aatdisplay where act in ('36TU')
select [BULK], GLOB from aatdisplay  
select len('9E SAN HE PLAZA NO121 YAN PING RD.')

Insert into TestDataMig..uatdisplay ([HOSTID],[GTID],[GTIDType],[AGENCY],[NETWORK],[EUNAME],[EUMOD],[CITYCODE],[INIT]
       ,[TERMTYPE],[LASTUSED],[XMLGTID]) 
Select [HOSTID],[GTID],[GTIDType],[AGENCY],[NETWORK],[EUNAME],[EUMOD],[CITYCODE],[INIT]
      ,[TERMTYPE],[LASTUSED],[XMLGTID] from DataMig..uatdisplay where gtid='FFB187' 


CREATE TABLE t_float(c1 varchar(50), c2 varchar(50))
BULK INSERT t_float from 


Select Count(*) [null] from GalileoPCC where Process_Status is null
select count(*) [null] from ApolloPCC where Process_Status is null
 select count(*) AATDisplay FROM AATDisplay 
select count(*) UATDisplay FROM UATDisplay 
select top 5 * from AATDisplay order by pkid desc
select top 5 * from uATDisplay order by pkid desc
select count(*) PCC_GTID_MAP from PCC_GTID_MAP

select * from uatdisplay where gtid in ('14BF10','C4403D','F10145')

select g.* from GalileoPCC g join ApolloPCC a on g.pcc=a.pcc

select * from aatdisplay where act='00F' and hostid='GALILEO'--4778
 select * from aatdisplay where act='08S' and hostid='GALILEO'--4778
select * from aatdisplay where act='00U' and hostid='GALILEO'--4778
select * from pcc_gtid_map where host='apollo' and system='prod'
 select city,ndco,tcty,regn from aatdisplay where act in (select pcc from pcc_gtid_map where host='apollo' and system='prod')

select * from aattaglist

select top 100 pcc from galileopcc
select top 100 pcc from apollopcc

insert into GalileoPCC (PCC) values ('5TZ2')
insert into GalileoPCC (PCC) values ('52A3')
insert into GalileoPCC (PCC) values ('784K')
insert into GalileoPCC (PCC) values ('73CR')
 insert into GalileoPCC (PCC) values ('71BM')
insert into GalileoPCC (PCC) values ('56HZ')
insert into GalileoPCC (PCC) values ('71XD')
insert into GalileoPCC (PCC) values ('51XY')
 insert into GalileoPCC (PCC) values ('56UN')


insert into ApolloPCC (PCC) values ('1G1A')
insert into ApolloPCC (PCC) values ('1G0M')
insert into ApolloPCC (PCC) values ('141Z')
 insert into ApolloPCC (PCC) values ('17LI')
insert into ApolloPCC (PCC) values ('YI5')
insert into ApolloPCC (PCC) values ('H46')
insert into ApolloPCC (PCC) values ('1SS2')
insert into ApolloPCC (PCC) values ('M34')
 insert into ApolloPCC (PCC) values ('12I8')
insert into ApolloPCC (PCC) values ('12R5')

/****** Object:  UserDefinedFunction [dbo].[RemoveAllSpaces]    Script Date: 01-05-2019 09:55:36 ******/
/****** remove all spaces from a string ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[RemoveAllSpaces]
(
    @InputStr varchar(max)
)
RETURNS varchar(max)
AS
BEGIN
    declare @ResultStr varchar(8000)
    set @ResultStr = @InputStr

    while charindex(' ', @ResultStr) > 0
        set @ResultStr = replace(@InputStr, ' ', '')

    return @ResultStr
END
------------------------------

select top 1 * from aatdisplay 
select * from processlog where value='5b3n'
select * from processlog where value='3M39'

select uat.* from pcc_Gtid_map map join uatdisplay uat
on map.gtid=uat.gtid where map.pcc='5b3n'
select * from pcc_Gtid_map where pcc='5b3n' and gtid not in (select gtid from uatdisplay where pcc ='5b3n') --6176
 select gtid from pcc_Gtid_map where pcc ='5b3n' --6186
select * from uatdisplay where gtid in ('D162C4', 'C56AC0')

--HostDataExtraction_260908
select ACT, unrn, AATType, Auth, hostid from aatdisplay where AATType = 'A' and auth='' order by auth
 select Count(*) from aatdisplay where AATType = 'A' and auth='' order by auth
select ACT, unrn, AATType, Auth, hostid from aatdisplay where AATType <>'A' 
select top 5 * from aatdisplay order by PKID desc
  
select * from pcc_gtid_map where gtid in (select gtid from pcc_gtid_map where host='apollo') and host='galileo'
select * from pcc_gtid_map where pcc='xz3'
begin tran
    select @@TRANCOUNT
     delete from uatdisplay where gtid in (select gtid from pcc_gtid_map where pcc='xz3')
    delete from pcc_gtid_map where pcc='xz3'

rollback

commit 

select count(*) from galileopcc where process_status is null
 select count(*) from uatdisplay --62
select count(*) from aatdisplay 
select count(*) from pcc_gtid_map 

select * from aatdisplay where city like 'MT %'



select * from apollopcc where pcc in ('1E3V','1E3W','1E3X','1E3Y')
 select * from pcc_gtid_map where pcc in ('1E3V','1E3W','1E3X','1E3Y')
select * from aatdisplay where act in ('1E3V','1E3W','1E3X','1E3Y')

select * from pcc_gtid_map where gtid in ('24AB3C','55BE1B','943FE4')
 select * from uatdisplay where gtid in ('24AB3C','55BE1B','943FE4')


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


ALTER PROCEDURE [dbo].[spAddAATDisplay] (@XmlParameter xml)
 AS
BEGIN

--DBCC CHECKIDENT ('[LNIA]', RESEED, 0)
--declare @Counter int
--set @Counter = 0
--UPDATE test SET @Counter = PKID = @Counter + 1

declare @HOSTID varchar(10)
declare @ACT varchar(10)
 declare @CurrentCityCode varchar(6)
declare @NewCityCode varchar(6)
declare @SYSTEM varchar(20)
declare @FilterElementXML xml
declare @count int
declare @CityCodeMappingID int

SELECT @FilterElementXML = @XmlParameter.query('(ArrayOfAATDisplay/AATDisplay)')  

SET @HOSTID = @FilterElementXML.value('(//AATDisplay/HOSTID)[1]','varchar(10)')
SET @ACT = @FilterElementXML.value('(//AATDisplay/ACT)[1]','varchar(6)')
SET @SYSTEM= @FilterElementXML.value('(//AATDisplay/SYSTEM)[1]','varchar(6)')
 SET @CurrentCityCode= @FilterElementXML.value('(//AATDisplay/CurrentCityCode)[1]','varchar(5)')
SET @NewCityCode= @FilterElementXML.value('(//AATDisplay/NewCityCode)[1]','varchar(5)')

--------  SET @count= (SELECT count(*) from PCC_GTID_MAP where PCC=@ACT and gtid=substring(@GTIDs, @pos + 1, @valuelen))
--------  IF (@count<1)
--------  BEGIN
--------     INSERT PCC_GTID_MAP (PCC, GTID, HOST, SYSTEM) VALUES (@ACT, substring(@GTIDs, @pos + 1, @valuelen), @HOSTID, @SYSTEM)
--------  END

SELECT @count=count(*) FROM CityCodeMapping WHERE OldCityCode=@CurrentCityCode and NewCityCode=@NewCityCode
IF @count<1
BEGIN
    INSERT INTO CityCodeMapping (OldCityCode, NewCityCode, ModifiedDateTime) VALUES (@CurrentCityCode,@NewCityCode,getdate())
 END
ELSE
IF @count=1
BEGIN
    SELECT @CityCodeMappingID=CityCodeMappingID FROM CityCodeMapping WHERE OldCityCode=@CurrentCityCode and NewCityCode=@NewCityCode
END

DELETE FROM UserProfile WHERE PCC = @ACT
 DELETE FROM GTID WHERE PCC = @ACT
DELETE FROM [AATDisplay] WHERE ACT = @ACT and HOSTID = @HOSTID and SYSTEM = @SYSTEM

INSERT INTO [AATDisplay]
(
    [HOSTID],[SYSTEM],[ACT],[UNRN],[UNRNNew],[BNDC],[BNDCNew],[NDCO],[NDCONew],[COAL],[COALNew]
         ,[CORD],[CORDNew],[ALOC],[ALOCNew],[ProcessStatus],CityCodeMappingID
)
  select        
        t.AATDisplay.value('(/AATDisplay/HOSTID)[1]','varchar(10)'),
        t.AATDisplay.value('(/AATDisplay/SYSTEM)[1]','varchar(20)'),
         t.AATDisplay.value('(/AATDisplay/ACT)[1]','varchar(10)'),
        t.AATDisplay.value('(/AATDisplay/UNRN)[1]','varchar(50)'),
        t.AATDisplay.value('(/AATDisplay/UNRNNew)[1]','varchar(50)'),
         t.AATDisplay.value('(/AATDisplay/BNDC)[1]','varchar(50)'),
        t.AATDisplay.value('(/AATDisplay/BNDCNew)[1]','varchar(50)'),
        t.AATDisplay.value('(/AATDisplay/NDCO)[1]','varchar(50)'),
         t.AATDisplay.value('(/AATDisplay/NDCONew)[1]','varchar(50)'),
        t.AATDisplay.value('(/AATDisplay/COAL)[1]','varchar(50)'),
        t.AATDisplay.value('(/AATDisplay/COALNew)[1]','varchar(50)'),
         t.AATDisplay.value('(/AATDisplay/CORD)[1]','varchar(50)'),
        t.AATDisplay.value('(/AATDisplay/CORDNew)[1]','varchar(50)'),
        t.AATDisplay.value('(/AATDisplay/ALOC)[1]','varchar(50)'),
         t.AATDisplay.value('(/AATDisplay/ALOCNew)[1]','varchar(50)'),
        t.AATDisplay.value('(/AATDisplay/ProcessStatus)[1]','varchar(200)'),
        @CityCodeMappingID
From (SELECT ArrayOfAATDisplay.[AATDisplay].query('.') AATDisplay  FROM
 @XmlParameter.nodes('/ArrayOfAATDisplay/AATDisplay') ArrayOfAATDisplay([AATDisplay]) ) T
Where t.AATDisplay.value('(/AATDisplay/PKID)[1]','int')  = 0


INSERT INTO GTID (PCC,GTID,ProcessStatus)
  (SELECT
    BulkInsertDataXML.d.value('PCC[1]', 'varchar(5)'),
    BulkInsertDataXML.d.value('GTIDValue[1]', 'varchar(6)'),
    BulkInsertDataXML.d.value('ProcessStatus[1]', 'varchar(200)')
   FROM @XmlParameter.nodes('/ArrayOfAATDisplay/AATDisplay/GetGTIDList/GTID') BulkInsertDataXML(d))


INSERT INTO UserProfile (PCC,STDName,UserName,ProcessStatus)
 (SELECT
    BulkInsertDataXML.d.value('PCC[1]', 'varchar(6)'),
     BulkInsertDataXML.d.value('STDName[1]', 'varchar(5)'),
    BulkInsertDataXML.d.value('UserName[1]', 'varchar(6)'),
    BulkInsertDataXML.d.value('ProcessStatus[1]', 'varchar(200)')
   FROM @XmlParameter.nodes('/ArrayOfAATDisplay/AATDisplay/GetUserProfileList/UserProfile') BulkInsertDataXML(d))

END

exec spAddProcessLog '<?xml version="1.0" ?><ArrayOfProcessLog xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProcessLog></ProcessLog></ArrayOfProcessLog>'

truncate table GTID
truncate table UserProfile
delete from aatdisplay 
delete from CityCodeMapping
truncate table ProcessLog


select * from GTID
select * from UserProfile
select * from aatdisplay 
 select * from CityCodeMapping
select * from ProcessLog

select top 1 CityCodeMappingID FROM CityCodeMapping order by CityCodeMappingID desc

select * from City_Country_Map where city_code='par'
 select * from ISO_Countries
 select distinct(pcc,updatedonhost) from Table_1
Select (SID_CD) PCC,(CIDB_CUS_ID) CIDB From Gal_Cus_Xref where PRTN_CD ='1G' order by PCC
truncate table PCCsNotFoundOnOracle
truncate table PCCsNotUpdatedOnHost
 truncate table PseudoCIDB_Mapping
truncate table PseudoCIDB_Mapping_History

select * from PCCsNotFoundOnOracle
select * from PCCsNotUpdatedOnHost
select * from PseudoCIDB_Mapping
select * from PseudoCIDB_Mapping_History
 select * from AATTagList

drop table GalileoPCCTest
drop procedure spAddCityCodeMap


update galileopcc set Process_Status=null where pcc='0CK'
select * from galileopcc where pcc='0CK'
 select * from aatdisplay where act='0CK'

select * from uatdisplay where gtid in (select gtid from PCC_GTID_MAP where pcc='xz3') and hostid='galileo' and system='prod'
select * from uatdisplay where gtid ='C53B25'
 select * from uatdisplay where gtid ='D6D402'

select * from PCC_GTID_MAP where pcc='5P4K'

delete from uatdisplay where gtid in (select gtid from PCC_GTID_MAP where pcc='X6L')
delete from aatdisplay where act='X6L'

'XG4', 'X6L', 'MZ8', 'B6N', '3E5I'

select * from uatdisplay where gtid in (select gtid from PCC_GTID_MAP where pcc='3E5I') 
and gtidtype='prt' and system = 'copy'

select @@NESTLEVEL

select [CDT Service Available (Actual)], [Vendor Work Complete (Acutal)] from CometAdmin.comet_all_data_cr where order# ='333469'
select [Vendor Work Complete (Forcasted)] from CometAdmin.comet_all_data_cr where order# ='356988' 

enable TRIGGER trd_MyTable ON UATTagList

insert into UATTagList (tag) values('ACICS')

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER insTrig
   ON  UATTagList
   AFTER INSERT 
 AS 
BEGIN
    SET NOCOUNT ON;
    if (select count(*) from UATTagList where tag in (select tag from inserted)) > 0
    begin
        print 'exists'
        if (select count(*) from UATTaglistCopy where tag in (select tag from inserted)) = 0
             insert into UATTaglistCopy (tag) (select tag from inserted)
    end    
    else
        print 'not exists'
--    select * from inserted 
END
GO

/****** Object:  Trigger [dbo].[UserSetModifiedDate]    Script Date: 01-05-2019 08:38:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[UserSetModifiedDate]
   ON  [dbo].[User]
   instead of UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
    SET NOCOUNT ON;

    --select * from deleted
    --select * from inserted

    --select 
    --    INSERTED.ID,
    --    INSERTED.UserSSOId,
    --    INSERTED.FirstName,
    --    INSERTED.LastName,
    --    deleted.CreatedBy,
    --    deleted.CreatedDate,
    --    INSERTED.ModifiedBy,
    --    INSERTED.ModifiedDate,
    --    INSERTED.IsActive
    --from inserted
    --join deleted on inserted.ID = deleted.ID

    UPDATE [User]
    SET 
        [User].[UserSSOId]    = INSERTED.UserSSOId,
        [User].[FirstName]    = INSERTED.FirstName,
        [User].[LastName]     = INSERTED.LastName,
        [User].[CreatedBy]    = DELETED.CreatedBy,
        [User].[CreatedDate]  = DELETED.CreatedDate,
        [User].[ModifiedBy]   = INSERTED.ModifiedBy,
        [User].[ModifiedDate] = INSERTED.ModifiedDate,
        [User].[IsActive]     = INSERTED.IsActive
    FROM [User] 
        JOIN INSERTED ON [User].ID = INSERTED.ID
        JOIN DELETED  ON [User].ID = DELETED.ID
END


ALTER TRIGGER trd_MyTable 
   ON  UATTagList
   INSTEAD OF INSERT
AS 
BEGIN
    SET NOCOUNT ON;
    if (select count(*) from UATTagList where tag in (select tag from inserted)) > 0
     begin
        print 'exists'
        if (select count(*) from UATTaglistCopy where tag in (select tag from inserted)) = 0
            insert into UATTaglistCopy (tag) (select tag from inserted)
    end    
     else
        print 'not exists'
--    select * from inserted 
END
GO

dbcc useroptions
--dateformat    mdy
--yyyy-mm-dd
set dateformat dmy
set dateformat mdy
select convert(varchar, 3)
 select CONVERT(varchar(10), CAST('0108-07-01 00:00:00' AS smalldatetime), 102)
select CONVERT(varchar(10), CAST('0008-08-25 00:00:00' AS smalldatetime), 102)


select CONVERT(varchar(10), CAST('2002-11-22 00:00:00' AS smalldatetime), 102)
 select CONVERT(varchar(10), CAST(null AS smalldatetime), 102)
SELECT CAST('2002-11-22 00:00:00' AS smalldatetime)
SELECT CAST(2007-10-1 AS smalldatetime) 


select     [CDT Service Available (Actual)], 
     [Vendor Work Complete (Acutal)]
from CometAdmin.comet_all_data_cr where order# ='333469'
select     [Vendor Work Complete (Forcasted)]
from CometAdmin.comet_all_data_cr where order# ='356988' 

update CometAdmin.comet_all_data_cr 
set [CDT Service Available (Actual)] ='2008-07-14 00:00:00'
where order# ='333469' -- 76th row updated 
update CometAdmin.comet_all_data_cr 
set [Vendor Work Complete (Acutal)] ='2008-07-14 00:00:00'
 where order# ='333469' -- 76th row updated 
update CometAdmin.comet_all_data_cr 
set [Vendor Work Complete (Forcasted)] ='2008-07-14 00:00:00'
where order# ='356988' -- 554th row updated

update CometAdmin.comet_all_data_cr 
set [CDT Service Available (Actual)] ='0108-07-01 00:00:00'
where order# ='333469' -- 76th row updated 
update CometAdmin.comet_all_data_cr 
set [Vendor Work Complete (Acutal)] ='0108-07-01 00:00:00'
 where order# ='333469' -- 76th row updated 
update CometAdmin.comet_all_data_cr 
set [Vendor Work Complete (Forcasted)] ='0008-08-25 00:00:00'
where order# ='356988' -- 554th row updated

select * from GalileoPCC where ISNULL(Process_Status, '') = '' order by pcc 
select * from GalileoPCC where pcc='0ee'

CREATE PROCEDURE CDTADMIN.cdtsp_rpt_comet_finance  
@p_vendor varchar(255) = '',  
 @p_bu varchar(255) = null,  
@p_order_type varchar(255)  
AS  
SELECT TOP 100 PERCENT c.ID AS FormNo, c.CIRCUIT_ORDER_TYPE AS OrderType, c.EXPEDITE_FLAG AS Expedited, 
c.STATUS_CODE AS CircuiREQStat, s.MNEMONIC, c.PORT_A_CIRCUIT_NAME AS CircuitID, ci.TYPE_CD AS CircuitType, 
 ci.CIRCUIT_SPEED AS Speed, pv.COMMITTED_INFORMATION_RATE AS CIR, ci.SPID1, ci.SPID2,  
(
    SELECT TOP 1 NAME FROM
    cdtadmin.vgr_contacts, cdtadmin.vgr_site_contacts
    WHERE cdtadmin.vgr_site_contacts.contact_id = cdtadmin.vgr_contacts.id 
     AND cdtadmin.vgr_site_contacts.contact_code = 'PRIMARY' AND cdtadmin.vgr_site_contacts.site_id = s.id
) AS Contact,
(
    SELECT TOP 1 Phone FROM
    cdtadmin.vgr_contacts, cdtadmin.vgr_site_contacts
     WHERE cdtadmin.vgr_site_contacts.contact_id = cdtadmin.vgr_contacts.id 
    AND cdtadmin.vgr_site_contacts.contact_code = 'PRIMARY' 
    AND cdtadmin.vgr_site_contacts.site_id = s.id
 ) AS Phone, ci.BILL_GROUP_NUMBER AS BillGrp, 
ci.TELCO_MASTER_BILLING_CODE AS TMBC, s.SITE_CODE AS BU, ci.STATUS_CODE AS CircuitStat, ci.BILLING_START_DATE, 
ci.BILLING_END_DATE, pv.PVC_BILLING_START_DATE, pv.PVC_BILLING_END_DATE, WVCA.VWC, c.BILLING_VERIFIED_DATE,
 (    
    SELECT TOP 1 cdtadmin.vgr_locations.address_line_1 FROM
    cdtadmin.vgr_locations
    WHERE cdtadmin.vgr_locations.site_id = s.id
) AS Address1,
(
    SELECT TOP 1 cdtadmin.vgr_locations.address_line_2 FROM
     cdtadmin.vgr_locations
    WHERE cdtadmin.vgr_locations.site_id = s.id
) AS Address2,
(
    SELECT TOP 1 cdtadmin.vgr_locations.city FROM
    cdtadmin.vgr_locations
     WHERE cdtadmin.vgr_locations.site_id = s.id
 ) AS City,
(
    SELECT TOP 1 cdtadmin.vgr_locations.State FROM
    cdtadmin.vgr_locations  
    WHERE cdtadmin.vgr_locations.site_id = s.id
) AS State,
(
    SELECT TOP 1 cdtadmin.vgr_locations.postal_code FROM 
     cdtadmin.vgr_locations
    WHERE cdtadmin.vgr_locations.site_id = s.id
) AS Zip,
(
    SELECT TOP 1 cdtadmin.vgr_locations.country_code FROM
    cdtadmin.vgr_locations
     WHERE cdtadmin.vgr_locations.site_id = s.id
 ) AS country, Q.name AS NIC, Q.email AS [NIC Email], v.NAME AS Vendor FROM
(
    SELECT n.id, nc.contact_code, co.name, co.phone, co.email, co.userid FROM
     cdtadmin.vgr_network_requests n, cdtadmin.vgr_network_request_contacts nc, cdtadmin.vgr_contacts co,  
     (
        SELECT n.id, MAX(nc.contact_id) AS contact_id FROM
        cdtadmin.vgr_network_requests n, cdtadmin.vgr_network_request_contacts nc, cdtadmin.vgr_contacts co
         WHERE n.id = nc.nr_id AND nc.contact_id = co.id AND co.email IS NOT NULL AND nc.contact_code = 'NET IMP CONTACT'  
         GROUP BY n.id
        UNION
        SELECT X.id, X.contact_id FROM
        (
            SELECT DISTINCT n.id FROM
             cdtadmin.vgr_network_requests n, cdtadmin.vgr_network_request_contacts nc, cdtadmin.vgr_contacts co  
             WHERE n.id = nc.nr_id AND nc.contact_id = co.id AND co.email IS NOT NULL AND nc.contact_code = 'NET IMP CONTACT'
         ) M 
        RIGHT OUTER JOIN  
         (
            SELECT n.id, MAX(nc.contact_id) AS contact_id FROM
            cdtadmin.vgr_network_requests n, cdtadmin.vgr_network_request_contacts nc, cdtadmin.vgr_contacts co  
             WHERE n.id = nc.nr_id AND nc.contact_id = co.id AND co.email IS NULL AND nc.contact_code = 'NET IMP CONTACT'  
            GROUP BY n.id
         ) X 
        ON M.id = X.id AND M.id IS NULL
    ) Z
    WHERE n.id = nc.nr_id AND nc.contact_id = co.id AND nc.contact_code = 'NET IMP CONTACT' AND N .id = Z.id AND NC.contact_id = Z.contact_id
 ) Q 
RIGHT OUTER JOIN
(
    SELECT DISTINCT circuit_request_id, cast(ACTUAL_VENDOR_WORK_COMPLETE AS datetime) AS VWC  
    FROM CDTAdmin.VGR_CIRCUIT_REQUEST_DATES
    WHERE isdate(ACTUAL_VENDOR_WORK_COMPLETE) = 1 AND ACTUAL_VENDOR_WORK_COMPLETE IS NOT NULL
 ) WVCA 
INNER JOIN  
CDTAdmin.VGR_CIRCUIT_INVENTORIES ci 
INNER JOIN  
CDTAdmin.VGR_CIRCUIT_ORDER_TYPES ct 
INNER JOIN  
CDTAdmin.VGR_CIRCUIT_REQUESTS c 
INNER JOIN  
CDTAdmin.VGR_CIRCUIT_REQUEST_DATES cd 
 ON c.ID = cd.CIRCUIT_REQUEST_ID 
INNER JOIN  
CDTAdmin.VGR_EVENT_LINE_ITEMS el 
INNER JOIN  
CDTAdmin.VGR_EVENTS e 
ON el.EVENT_ID = e.ID 
ON c.EVENT_LINE_ITEM_ID = el.ID 
ON ct.ORDER_TYPE = c.CIRCUIT_ORDER_TYPE 
 INNER JOIN  
CDTAdmin.VGR_SITES s 
INNER JOIN  
CDTAdmin.VGR_NETWORK_REQUESTS n 
ON s.ID = n.SITE_ID 
ON e.NETWORK_REQUEST_ID = n.ID 
ON ci.NAME = c.PORT_A_CIRCUIT_NAME 
ON WVCA.circuit_request_id = c.ID 
 ON Q.id = n.ID 
LEFT OUTER JOIN  
CDTAdmin.VGR_PVCS pv 
ON c.ID = pv.CIRCUIT_REQUEST_ID 
LEFT OUTER JOIN  
CDTAdmin.VGR_VENDORS v 
ON ci.TELCO_VENDOR_ID = v.ID  
WHERE (CAST(n.CREATE_DATE AS datetime) >= CONVERT(DATETIME, '2004-01-01 00:00:00', 102))
 AND (ct.BILLING_VERIFIED_FLAG = 'Y') AND (ci.BILL_GROUP_NUMBER <> 'CONB')
AND (DATEADD(dd, DATEDIFF(dd, 0, GETDATE()), - 90) > DATEADD(dd, DATEDIFF(dd, 0, WVCA.VWC), 0)) AND
(c.BILLING_VERIFIED_DATE IS NULL) AND 
 (
    (@p_vendor <> '--NULL--' AND (@p_vendor = '--ALL--' OR  v.name = @p_vendor)) OR
    (@p_vendor = '--NULL--' AND  v.name is null)
 ) AND
(
    (@p_bu <> '--NULL--' AND (@p_bu = '--ALL--' OR  s.site_code = @p_bu)) OR 
    (@p_bu = '--NULL--' AND  s.site_code is null)
) AND  
(
    (@p_order_type <> '--NULL--' AND (@p_order_type = '--ALL--' OR    c.circuit_order_type = @p_order_type)) OR
     (@p_order_type = '--NULL--' AND    c.circuit_order_type is null)
)
ORDER BY WVCA.VWC

CREATE PROCEDURE CometAdmin.cdtsp_rpt_comet_nic_last_month_totals  
 AS  
SELECT       
 co.name,   
  c.id as [Form],  
 count(c.id) as [qty]  
FROM           
 CDTRepository.CDTAdmin.vgr_circuit_requests c,   
 CDTRepository.CDTAdmin.vgr_network_requests n,   
  CDTRepository.CDTAdmin.vgr_events e,   
 CDTRepository.CDTAdmin.vgr_event_line_items el,   
 CDTRepository.CDTAdmin.vgr_network_request_contacts nc,   
 CDTRepository.CDTAdmin.vgr_contacts co  
WHERE       
  n.ID = e.network_request_id AND   
 e.id = el.event_id AND   
 el.id = c.event_line_item_id AND   
 n.id = nc.nr_id AND   
  nc.contact_id = co.id AND   
     co.email IS NOT NULL AND   
 nc.contact_code = 'NET IMP CONTACT' AND   
 (c.date_created BETWEEN dateAdd(month, - 1, DATEADD(dd, DATEDIFF(dd,0,getdate()), 0) ) AND dateAdd(day, - 1, DATEADD(dd, DATEDIFF(dd,0,getdate()), 0) ))  
 GROUP BY  co.name, c.id  
ORDER BY co.name  
----------------------------------------------------------------
 declare @XmlParameter xml 
 set @XmlParameter ='<ArrayOfAnyType xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
   <anyType xsi:type="xsd:string">AMS-GALILEO-PROD</anyType>
  <anyType xsi:type="xsd:string">59TI</anyType>
  <anyType xsi:type="xsd:string">5RV7</anyType>
   <anyType xsi:type="xsd:string">BV7</anyType>
  <anyType xsi:type="xsd:string">3IW0</anyType>
  <anyType xsi:type="xsd:string">3A7J</anyType>
</ArrayOfAnyType>'

--SELECT 
--d.value('anyType[1]', 'varchar(20)'),
--d.value('anyType[2]', 'varchar(20)'),
--d.value('anyType[3]', 'varchar(20)'),
--d.value('anyType[4]', 'varchar(20)'),
 --d.value('anyType[5]', 'varchar(20)'),
--d.value('anyType[6]', 'varchar(20)')
--FROM @XmlParameter.nodes('/ArrayOfAnyType') BulkInsertDataXML (d)

DECLARE @CityPCCMAPList XML
 SELECT @CityPCCMAPList = @XmlParameter.query('(ArrayOfAnyType/anyType)')  
  --SELECT @CityPCCMAPList 
DECLARE @CityPCCMAPs TABLE (Map xml,RowNumber int) 
    INSERT INTO @CityPCCMAPs 
        SELECT CityPCCMAP.query('.') ,ROW_NUMBER() OVER (ORDER BY CityPCCMAP) - 1 
             FROM @CityPCCMAPList.nodes('/anyType') CityPCCMAP(CityPCCMAP)
DECLARE @CityHostComplex varchar(16)
SELECT TOP 1 @CityHostComplex = Map.value('(/anyType)[1]','varchar(20)') from @CityPCCMAPs
 DECLARE @City varchar(3)
DECLARE @Host varchar(7)
DECLARE @Complex varchar(4)
--AMS-APOLLO-PROD
--select @CityHostComplex
--select Charindex('-',@CityHostComplex,0)
--select Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)
 --select Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)-Charindex('-',@CityHostComplex,0)-1
SET @City = substring(@CityHostComplex,0,Charindex('-',@CityHostComplex,0))
 SET @Host = substring(@CityHostComplex,
                Charindex('-', @CityHostComplex, 0) + 1,
                Charindex('-', @CityHostComplex, Charindex('-',@CityHostComplex,0) + 1)
                -Charindex('-',@CityHostComplex,0)-1)
 SET @Complex = substring(@CityHostComplex,Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)+1,4)
--SELECT @City, @Host, @Complex

--select top 1 @CityPCCMAP.value('(/anyType)[1]','nvarchar(100)') from @CityPCCMAPs
     --SELECT * FROM @CityPCCMAPs
DECLARE @TotalMap int   
SELECT @TotalMap = MAX(RowNumber) FROM @CityPCCMAPs  
DECLARE @MapIndex INT,@count INT
SET @MapIndex = 1
DECLARE @CityPCCMAP XML
WHILE @MapIndex <=  @TotalMap
     BEGIN
     SELECT @CityPCCMAP = Map FROM @CityPCCMAPs WHERE RowNumber = @MapIndex
        IF ((SELECT Count(*) FROM [CITY_PCC_MAP] WHERE [PCC]=@CityPCCMAP.value('(/anyType)[1]','varchar(5)') 
             AND [HOST]=@Host AND [COMPLEX]=@Complex)=0)
        BEGIN
--            DELETE FROM [CITY_PCC_MAP] WHERE [PCC]=@CityPCCMAP.value('(/anyType)[1]','varchar(5)') 
--                AND [HOST]=@Host AND [COMPLEX]=@Complex
             INSERT INTO [CITY_PCC_MAP] ([CITY],[PCC],[HOST],[COMPLEX])
            SELECT @City,@CityPCCMAP.value('(/anyType)[1]','varchar(5)'),@Host,@Complex
    --        SELECT @CityPCCMAP.value('(/anyType)[1]','varchar(100)')
         END
      SET @MapIndex = @MapIndex + 1
    END  

------------------------------------------------------------------
------------------------------------------------------------------

select @XmlParameter 
 declare @XmlParameter xml 
set @XmlParameter ='<ArrayOfAnyType xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
   <anyType xsi:type="xsd:string">AMS-GALILEO-PROD</anyType>
  <anyType xsi:type="xsd:string">59TI-P</anyType>
  <anyType xsi:type="xsd:string">5RV7-X</anyType>
   <anyType xsi:type="xsd:string">BV7-X</anyType>
  <anyType xsi:type="xsd:string">3IW0-M</anyType>
  <anyType xsi:type="xsd:string">3A7J-M</anyType>
 </ArrayOfAnyType>'

--SELECT 
--d.value('anyType[1]', 'varchar(20)'),
--d.value('anyType[2]', 'varchar(20)'),
--d.value('anyType[3]', 'varchar(20)'),
 --d.value('anyType[4]', 'varchar(20)'),
--d.value('anyType[5]', 'varchar(20)'),
--d.value('anyType[6]', 'varchar(20)')
--FROM @XmlParameter.nodes('/ArrayOfAnyType') BulkInsertDataXML (d)

DECLARE @CityPCCMAPList XML
SELECT @CityPCCMAPList = @XmlParameter.query('(ArrayOfAnyType/anyType)')  
  --SELECT @CityPCCMAPList 
DECLARE @CityPCCMAPs TABLE (Map xml,RowNumber int) 
    INSERT INTO @CityPCCMAPs 
         SELECT CityPCCMAP.query('.') ,ROW_NUMBER() OVER (ORDER BY CityPCCMAP) - 1 
            FROM @CityPCCMAPList.nodes('/anyType') CityPCCMAP(CityPCCMAP)
DECLARE @CityHostComplex varchar(16)
SELECT TOP 1 @CityHostComplex = Map.value('(/anyType)[1]','varchar(20)') from @CityPCCMAPs
 DECLARE @City varchar(3)
DECLARE @Host varchar(7)
DECLARE @Complex varchar(4)
--AMS-APOLLO-PROD
--select @CityHostComplex
--select Charindex('-',@CityHostComplex,0)
--select Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)
 --select Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)-Charindex('-',@CityHostComplex,0)-1
SET @City = substring(@CityHostComplex,0,Charindex('-',@CityHostComplex,0))
 SET @Host = substring(@CityHostComplex,Charindex('-',@CityHostComplex,0)+1,Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)-Charindex('-',@CityHostComplex,0)-1)
SET @Complex = substring(@CityHostComplex,Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)+1,4)
 --SELECT @City, @Host, @Complex

--select top 1 @CityPCCMAP.value('(/anyType)[1]','nvarchar(100)') from @CityPCCMAPs
    --SELECT * FROM @CityPCCMAPs
DECLARE @TotalMap int, @GTID varchar(6), @GTIDType varchar(1)
 SELECT @TotalMap = MAX(RowNumber) FROM @CityPCCMAPs  
DECLARE @MapIndex int 
SET @MapIndex = 1
DECLARE @CityPCCMAP xml
WHILE @MapIndex <=  @TotalMap
    BEGIN
     SELECT @CityPCCMAP = Map FROM @CityPCCMAPs WHERE RowNumber = @MapIndex
      SET @GTID = substring(@CityPCCMAP.value('(/anyType)[1]','varchar(10)'),0,Charindex('-',@CityPCCMAP.value('(/anyType)[1]','varchar(10)'),0))
     SET @GTIDType = substring(@CityPCCMAP.value('(/anyType)[1]','varchar(10)'),
                 Charindex('-', @CityPCCMAP.value('(/anyType)[1]','varchar(10)'), 0) + 1,1)
--     IF ((SELECT Count(*) FROM [PCC_GTID_MAP] WHERE [PCC_KEY]=@CityPCCMAP.value('(/anyType)[1]','varchar(5)') 
--            AND [HOST]=@Host)=0)
     BEGIN
        select @GTID, @GTIDType
--        INSERT INTO [PCC_GTID_MAP_2] ([CITY],[PCC],[HOST],[COMPLEX])
--        select @City, @CityPCCMAP.value('(/anyType)[1]','varchar(5)'),@Host,@Complex
--        select @CityPCCMAP.value('(/anyType)[1]','nvarchar(100)')
     END
     SET @MapIndex = @MapIndex + 1
    END  

-------------------------- ---------------------------

declare @XmlParameter xml 
 set @XmlParameter ='<ArrayOfAnyType xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
   <anyType xsi:type="xsd:string">3509-069002-M</anyType>
  <anyType xsi:type="xsd:string">3509-069003-P</anyType>
</ArrayOfAnyType>'

DECLARE @CityPCCMAPList XML
 SELECT @CityPCCMAPList = @XmlParameter.query('(ArrayOfAnyType/anyType)')  
  --SELECT @CityPCCMAPList 
DECLARE @CityPCCMAPs TABLE (Map xml,RowNumber int) 
    INSERT INTO @CityPCCMAPs 
        SELECT CityPCCMAP.query('.') ,ROW_NUMBER() OVER (ORDER BY CityPCCMAP) -- -1 
             FROM @CityPCCMAPList.nodes('/anyType') CityPCCMAP(CityPCCMAP)

--select * from @CityPCCMAPs 
DECLARE @CityHostComplex varchar(20)
SELECT TOP 1 @CityHostComplex = Map.value('(/anyType)[1]','varchar(20)') from @CityPCCMAPs
 select @CityHostComplex 

DECLARE @pcckey int
DECLARE @gtid varchar(6)
DECLARE @gtidtype varchar(1)
--SET @pcckey = substring(@CityHostComplex,0,Charindex('-',@CityHostComplex,0))
--SET @gtid = substring(@CityHostComplex,Charindex('-',@CityHostComplex,0)+1,Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)-Charindex('-',@CityHostComplex,0)-1)
 --SET @gtidtype = substring(@CityHostComplex,Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)+1,4)
--SELECT @pcckey, @gtid, @gtidtype

--SELECT * FROM [PCC_GTID_MAP] WHERE [PCC_KEY]=3509 AND [GTID]='069002'
 DECLARE @TotalMap int
SELECT @TotalMap = MAX(RowNumber) FROM @CityPCCMAPs  
DECLARE @MapIndex int 
SET @MapIndex = 1
DECLARE @CityPCCMAP varchar(20)
WHILE @MapIndex <=  @TotalMap
    BEGIN
     SELECT @CityPCCMAP = Map.value('(/anyType)[1]','varchar(20)') FROM @CityPCCMAPs WHERE RowNumber = @MapIndex
--     SELECT @CityPCCMAP
     SET @pcckey = substring(@CityPCCMAP,0,Charindex('-',@CityPCCMAP,0))
     SET @GTID = substring(@CityPCCMAP,Charindex('-',@CityPCCMAP,0)+1,Charindex('-',@CityPCCMAP,Charindex('-',@CityPCCMAP,0)+1)-Charindex('-',@CityPCCMAP,0)-1)
      SET @GTIDType = substring(@CityPCCMAP,Charindex('-',@CityPCCMAP,Charindex('-',@CityPCCMAP,0)+1)+1,4)

     IF ((SELECT Count(*) FROM [PCC_GTID_MAP] 
            WHERE [PCC_KEY]=@pcckey AND [GTID]=@GTID)=0)
      BEGIN
            INSERT INTO [PCC_GTID_MAP] ([PCC_KEY],[GTID],[GTIDType]) 
            select @pcckey, @GTID, @GTIDType
     END
     SET @MapIndex = @MapIndex + 1
    END  
-------------------------- ---------------------------
 declare @XmlParameter xml 
set @XmlParameter ='<ArrayOfGTID xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
   <GTID>
    <PCC_KEY>3511</PCC_KEY>
    <GTIDValue>154F41</GTIDValue>
    <GTIDType />
  </GTID>
  <GTID>
    <PCC_KEY>3511</PCC_KEY>
    <GTIDValue>154F42</GTIDValue>
     <GTIDType />
  </GTID>
  <GTID>
    <PCC_KEY>3511</PCC_KEY>
    <GTIDValue>3187B6</GTIDValue>
    <GTIDType />
  </GTID>
  <GTID>
    <PCC_KEY>3511</PCC_KEY>
     <GTIDValue>3187B7</GTIDValue>
    <GTIDType />
  </GTID>
</ArrayOfGTID>'

--SELECT 
--d.value('anyType[1]', 'varchar(20)'),
--d.value('anyType[2]', 'varchar(20)'),
 --d.value('anyType[3]', 'varchar(20)'),
--d.value('anyType[4]', 'varchar(20)'),
--d.value('anyType[5]', 'varchar(20)'),
--d.value('anyType[6]', 'varchar(20)')
 --FROM @XmlParameter.nodes('/ArrayOfAnyType') BulkInsertDataXML (d)

DECLARE @CityPCCMAPList XML
SELECT @CityPCCMAPList = @XmlParameter.query('(ArrayOfGTID/GTID)')  
--SELECT @CityPCCMAPList 
 DECLARE @CityPCCMAPs TABLE (Map xml,RowNumber int) 
    INSERT INTO @CityPCCMAPs 
        SELECT CityPCCMAP.query('.') ,ROW_NUMBER() OVER (ORDER BY CityPCCMAP)
            FROM @CityPCCMAPList.nodes('/GTID') CityPCCMAP(CityPCCMAP)
 DECLARE @CityHostComplex varchar(200)
--SELECT TOP 1 @CityHostComplex = Map.value('(/GTID)[1]','varchar(200)') from @CityPCCMAPs
--SELECT @CityHostComplex 

select * from @CityPCCMAPs 
--DECLARE @City varchar(3)
 --DECLARE @Host varchar(7)
--DECLARE @Complex varchar(4)
--AMS-APOLLO-PROD
--select @CityHostComplex
--select Charindex('-',@CityHostComplex,0)
--select Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)
 --select Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)-Charindex('-',@CityHostComplex,0)-1
--SET @City = substring(@CityHostComplex,0,Charindex('-',@CityHostComplex,0))
 --SET @Host = substring(@CityHostComplex,Charindex('-',@CityHostComplex,0)+1,Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)-Charindex('-',@CityHostComplex,0)-1)
--SET @Complex = substring(@CityHostComplex,Charindex('-',@CityHostComplex,Charindex('-',@CityHostComplex,0)+1)+1,4)
 --SELECT @City, @Host, @Complex

--select top 1 @CityPCCMAP.value('(/anyType)[1]','nvarchar(100)') from @CityPCCMAPs
    --SELECT * FROM @CityPCCMAPs
DECLARE @TotalMap int, @PCC_KEY int, @GTID varchar(6), @GTIDType varchar(1)
 SELECT @TotalMap = MAX(RowNumber) FROM @CityPCCMAPs  
DECLARE @MapIndex int 
SET @MapIndex = 1
DECLARE @CityPCCMAP xml
WHILE @MapIndex <=  @TotalMap
    BEGIN
     SELECT @CityPCCMAP = Map FROM @CityPCCMAPs WHERE RowNumber = @MapIndex
--     SET @GTID = substring(@CityPCCMAP.value('(/anyType)[1]','varchar(10)'),0,Charindex('-',@CityPCCMAP.value('(/anyType)[1]','varchar(10)'),0))
--     SET @GTIDType = substring(@CityPCCMAP.value('(/anyType)[1]','varchar(10)'),
--                Charindex('-', @CityPCCMAP.value('(/anyType)[1]','varchar(10)'), 0) + 1,1)
--     IF ((SELECT Count(*) FROM [PCC_GTID_MAP] WHERE [PCC_KEY]=@CityPCCMAP.value('(/anyType)[1]','varchar(5)') 
--            AND [HOST]=@Host)=0)
     BEGIN
--        select @GTID, @GTIDType
--        INSERT INTO [PCC_GTID_MAP_2] ([CITY],[PCC],[HOST],[COMPLEX])
--        select @City, @CityPCCMAP.value('(/anyType)[1]','varchar(5)'),@Host,@Complex
         select @CityPCCMAP.value('(/GTID/PCC_KEY)[1]','int'),
               @CityPCCMAP.value('(/GTID/GTIDValue)[1]','varchar(6)'),
               @CityPCCMAP.value('(/GTID/GTIDType)[1]','varchar(1)')
      END
     SET @MapIndex = @MapIndex + 1
    END  
-------------------------- ---------------------------

SELECT * FROM AATDisplay
SELECT gtid,count(*) FROM PCC_GTID_MAP group by gtid having count(*)>1 order by count(*) desc

select * from CITY_PCC_MAP where pkid in 
(SELECT pcc_key FROM PCC_GTID_MAP where gtid = 'F10145')

SELECT CITY_PCC_MAP.*, PCC_GTID_MAP.GTID FROM PCC_GTID_MAP 
INNER JOIN CITY_PCC_MAP ON PCC_GTID_MAP.PCC_KEY = CITY_PCC_MAP.PKID order by PCC_GTID_MAP.GTID 

SELECT PCC_GTID_MAP.GTID
        , CITY_PCC_MAP.HOST
        , CITY_PCC_MAP.COMPLEX
        , PCC_GTID_MAP.GTIDType 
        FROM PCC_GTID_MAP 
INNER JOIN CITY_PCC_MAP ON PCC_GTID_MAP.PCC_KEY = CITY_PCC_MAP.PKID 
     group by PCC_GTID_MAP.GTID
        , CITY_PCC_MAP.HOST
        , CITY_PCC_MAP.COMPLEX
        , PCC_GTID_MAP.GTIDType 
--        having count(*)>1 
            order by PCC_GTID_MAP.GTID        --4774

--227503    GALILEO    PROD
--C32390    GALILEO    PROD
--C3273D    GALILEO    PROD
--C34A9C    GALILEO    PROD
--C77F19    GALILEO    PROD

exec spGetGTIDList 40
--4779-4097
truncate table AATDisplay
 truncate table PCC_GTID_MAP
truncate table UATDisplay 

SELECT * from aatdisplay where act = 'LF6'
delete from aatdisplay where act = 'LF6'
select * from CITY_PCC_MAP 
select * from PCC_GTID_MAP where gtid = 'F10145'
 select * from UATDisplay where gtid = 'F10145'

declare @citypccmap table (RowNumber INT, pkid int, city varchar(3), 
                            pcc varchar(4), host varchar(7), complex varchar(4)) 
 INSERT INTO @citypccmap 
         SELECT ROW_NUMBER() OVER (ORDER BY host,complex ) , *
            FROM CITY_PCC_MAP 

declare @CurrentThread int, @NoOfThreads int, @PCCBatchSize int
declare @FromPosPCCList int, @ToPosPCCList int, @RemainingRows int
 set @NoOfThreads = 10
set @PCCBatchSize = (select count(*) from CITY_PCC_MAP)/@NoOfThreads 
set @FromPosPCCList = 1
set @ToPosPCCList = @PCCBatchSize
set @CurrentThread = 1

WHILE @CurrentThread <=  @NoOfThreads
 BEGIN
    if((SELECT count(*) FROM @citypccmap)/@PCCBatchSize < 2)
    BEGIN
        set @ToPosPCCList = (SELECT TOP 1 RowNumber FROM @citypccmap order by RowNumber DESC)
    END
--    SELECT * FROM @citypccmap where rownumber>=@FromPosPCCList and rownumber<=@ToPosPCCList 
     SELECT count(*) FROM @citypccmap where rownumber>=@FromPosPCCList and rownumber<=@ToPosPCCList 
    delete from @citypccmap where rownumber>=@FromPosPCCList and rownumber<=@ToPosPCCList 
    SET @FromPosPCCList = @FromPosPCCList + @PCCBatchSize 
     SET @ToPosPCCList = @ToPosPCCList + @PCCBatchSize 
    SET @CurrentThread = @CurrentThread + 1
END

sp_rename 'trigSetModifiedDate', 'trigUserSetModifiedDate';

select * from city_pcc_map

select top 1 * from (select top 5 * from marks order by marks desc) marks order by marks
select len('dd')
exec spAddAATDisplay '<?xml version="1.0" ?><ArrayOfAATDisplay xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><AATDisplay></AATDisplay></ArrayOfAATDisplay>'
 -------------------------- UK SERVER ---------------------------
select count(*) Apollopcc from HostDataExtract_1V.dbo.apollopcc where process_status is not null
select count(*) V_aatdisplay from HostDataExtract_1V.dbo.aatdisplay 
select count(*) V_uatdisplay from HostDataExtract_1V.dbo.uatdisplay 
select count(*) Galileopcc from HostDataExtract_1G.dbo.Galileopcc where process_status is not null
select count(*) G_aatdisplay from HostDataExtract_1G.dbo.aatdisplay 
select count(*) G_uatdisplay from HostDataExtract_1G.dbo.uatdisplay 

exec PseudoCityCodes.dbo.spGetCityCodeList

select * from PseudoCityCodes.dbo.PseudoCIDB_Mapping where Pseudo='M26'

exec testProc

ALTER TABLE CBN_CLS_DMN
ADD CONSTRAINT UK_SVC_CLS_CD_ARL_CD_EFF_DT UNIQUE (SVC_CLS_CD, ARL_CD, EFF_DT)
GO
 
SELECT count(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ARL_ALN_DMN'
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'CBN_CLS_DMN'

select * from aatdisplay where flex<>'' and tier<>'' sdet is not ''

sp_helptext usp_MenuItem

select DATEADD(dd, 2, '05-15-2009')
select datediff(dd, '11-11-2009', '11-15-2009') + 1
 select datename(dw, getdate())

select * from employee_master where status='true' and isdeleted='false' order by emp_id

select a.reporting_emp_id, b.emp_name from employee_master a
join employee_master b on a.reporting_emp_id = b.emp_id
 where a.status='true' and a.isdeleted='false' order by a.emp_id

select * into #temp_cooler from employee_master 
select * from #temp_cooler

SELECT * INTO XLImport3 FROM OPENDATASOURCE('Microsoft.Jet.OLEDB.4.0',
 'Data Source=C:\EXCEL_EXPORT_TEST\EMP_LEAVE_CALENDER_AUG_2009.xls;Extended Properties=Excel 8.0')...[Sheet1$]

SELECT * INTO XLImport4 FROM OPENROWSET('Microsoft.Jet.OLEDB.4.0',
'Excel 8.0;Database=C:\EXCEL_EXPORT_TEST\EMP_LEAVE_CALENDER_AUG_2009.xls', [Sheet1$])

SELECT * INTO XLImport5 FROM OPENROWSET('Microsoft.Jet.OLEDB.4.0',
'Excel 8.0;Database=C:\EXCEL_EXPORT_TEST\EMP_LEAVE_CALENDER_AUG_2009.xls', 'SELECT * FROM [Sheet1$]')

declare @x xml
 select @x = '<NewDataSet><Table1></Table1></NewDataSet>'
select @x 

select * from employee_master where emp_name like '%unknown%'
--DBCC CHECKIDENT ('[ResourceLeaveCalender]', RESEED, 0)

insert into ResourceLeaveCalender_Bulk ([Emp_Code]
      ,[Backfill_Emp_Code]
      ,[Leave_Date])  
    SELECT [Emp_Code]
      ,[Backfill_Emp_Code]
      ,[Leave_Date]
  FROM [SDMS].[dbo].[ResourceLeaveCalender] 

--
insert into ResourceLeaveCalender_Bulk values ('22047','20374','05-Feb-2009')

select emp_code, DATENAME(month, Leave_date) month_name from ResourceLeaveCalender_Bulk order by month_name

begin tran
    delete from ResourceLeaveCalender_Bulk where DATENAME(month, Leave_date) = 'August'
    select emp_code, DATENAME(month, Leave_date) month_name from ResourceLeaveCalender_Bulk order by month_name
     
rollback

commit 

Declare @tblTemp Table(ID INT IDENTITY, MappingID INT, PCC Varchar(4),CIDB Int, RemoveFlag bit NULL DEFAULT (0))

declare @x xml
set @x = '<NewDataSet><Table1></Table1></NewDataSet>'

Declare @tblTemp Table(Emp_Code varchar(10) NULL, Backfill_Emp_Code varchar(10) NULL, Leave_Date datetime NULL)
Insert Into @tblTemp (Emp_Code, Leave_Date, Backfill_Emp_Code)
     Select
     t.NewDataSet.value('(/Table1/Emp_Code)[1]','varchar(10)')Emp_Code, 
      t.NewDataSet.value('(/Table1/Leave_Date)[1]','datetime')Leave_Date,
     t.NewDataSet.value('(/Table1/Backfill_Emp_Code)[1]','varchar(10)')Leave_Date
     From (SELECT NewDataSet.[Table1].query('.') NewDataSet  
     FROM  @x.nodes('/NewDataSet/Table1') NewDataSet([Table1])) T  
--select * from @tblTemp order by Emp_Code
--select * from ResourceLeaveCalender_Bulk order by Emp_Code

--begin tran
--insert into ResourceLeaveCalender_Bulk (EMP_code, backfill_emp_code, leave_date)
 SELECT * FROM @tblTemp        EXCEPT 
                    SELECT t.* FROM @tblTemp t JOIN ResourceLeaveCalender_Bulk r
                    ON r.Emp_Code = t.Emp_Code AND r.Leave_Date = t.Leave_Date
                    SELECT * FROM ResourceLeaveCalender_Bulk ORDER BY emp_code
 rollback

--20148    00000    2009-08-24 00:00:00.000
--21613    NULL    2009-08-25 00:00:00.000
--21614    00000    2009-08-26 00:00:00.000

---==================================
select lower(substring([FirstName], 1, 1) + [LastName]) from [User]
select upper(substring([FirstName], 1, 1) + [LastName]) from [User]

select * from SixSigmaSummary
 select * from sixsigma_data where emp_id = '8935'
select * from sixsigmadetail where employeename like 'Av'
select * from six_sigma where name = 'Av'

select * from sixsigma_data where sow_name = '360 Fares Product Support'
 select * from six_sigma where sow_title = 'Fares Product Support - NGGF'

select * from employee_master where emp_name like 'sh%' order by emp_name 
select * from employee_master where seatno='518'
 --aarti 243
--kiran
select * from employee_master where emp_id='22288'
select * from employee_master where emp_id='8940' or emp_id='8616'

select * from employee_master where emp_id in (select distinct(emp_id) from sixsigma_data where sow_name = '360 Fares Product Support')

select datename(yy, getdate())

select emp_code, a.emp_name, b.emp_name manager, c.BU_Short_name, leave_date  from [ResourceLeaveCalender]
            JOIN employee_master a on a.Emp_id=Emp_Code 
            JOIN employee_master b on b.Emp_id=a.Reporting_Emp_id 
             JOIN Business_Unit c on c.Business_Unit_Id = a.Business_Unit_Id
            where 
                c.BU_Short_name='TBSG' 
                or c.BU_Short_name='WS' 
                and DATENAME(month, Leave_date) = 'August'
                 and DATENAME(yy, Leave_date) = '2009'
order by manager 
select 

select * from sysobjects where type in ('u','p', 'tf','k') order by name 
select * from datamig.dbo.sysobjects order by name 

-------------------------------------DB Objects information---------------------------------
-----START

DECLARE @tblTemp TABLE([row_index] int, ObjName VARCHAR(100) NULL, ObjType VARCHAR(100) NULL, [RowCount] int NULL)
 DECLARE @CompareNewDB varchar(100),@CompareWithDB varchar(100)

set @CompareNewDB = 'dbo.sysobjects'
set @CompareWithDB = 'dbo.sysobjects'

declare @query varchar(100)


INSERT @tblTemp (ObjName, [RowCount])
     EXEC sp_msForEachTable 
        'SELECT PARSENAME(''?'', 1), 
        COUNT(*) FROM ?' 

insert into @tblTemp (ObjName, ObjType)
    select [name], 
        case [type] 
            when 'p' then 'StoredProcedure' 
             when 'tf' then 'Function' 
            when 'k' then 'Index' 
        end

     from dbo.sysobjects where type in ('p','tf', 'k') order by [type] 

declare @Counter int
set @Counter = 0
UPDATE @tblTemp SET @Counter = [row_index] = @Counter + 1

UPDATE @tblTemp SET ObjType = 'Table' where ObjType is NULL

select ObjName,ObjType,[RowCount] from @tblTemp  order by ObjType 

-----END
-------------------------------------DB Objects information---------------------------------

exec sp_CompareDBCustom 'DataMig', 'DataMig1'
EXEC sp_helpindex UATDisplay 
select * from TPSQLEXPRESS.DataMig1.dbo.UATDisplay
 select @@servername

select * from information_schema.tables
select * from information_schema.columns 

EXEC sp_addlinkedserver @server='TPSQLEXPRESS'
    , @srvproduct=''
    , @provider='SQLNCLI'
     , @datasrc='GUR4361F103\TPSQLEXPRESS' 

select serverproperty('MachineName')
select @@version

select * from sys.linked_logins as L
select * from sys.servers as S 

select [name], salary,
     (case  
        when salary>3000 and salary<=4500  then 500
        when salary>4501 and salary<=6000  then 600
        when salary>6001 and salary<=7000  then 700
        when salary>7001 and salary<=8000  then 800
     end)
    as bonus
from employee

update employee
    set bonus = 
    (
        case  
            when salary>3000 and salary<=4500  then 500
            when salary>4501 and salary<=6000  then 600
             when salary>6001 and salary<=7000  then 700
            when salary>7001 and salary<=8000  then 800
        end
    )

Declare @Status VARCHAR(10)
Exec SaveNVMIRTemplate 'EDIT', 'Test 2', 'Custom', '2', 1, 'abcc', @Status=@Status OutPut
 Select @Status

declare @table table (id int, [name] varchar(10))
insert into @table values (1,'John')
insert into @table values (2,'Jonathan')
insert into @table values (3,'Jon')
 insert into @table values (4,'Joe')
insert into @table values (5,'Jack')

select count(*) from @table where [name] like 'Jo[^n]'

sp_MSforeachtable @command1='EXEC sp_spaceused ''?''', @whereand='or OBJECTPROPERTY(o.id, N''IsSystemTable'') = 1'


-- TEMP TABLE VS TABLE VARIABLES

BEGIN TRAN
declare @var table (id int, data varchar(20) )    -- TABLE VARIABLES
create table #temp (id int, data varchar(20) )    -- TEMP TABLE 

insert into @var
 select 1, 'data 1' union all
select 2, 'data 2' union all
select 3, 'data 3'

insert into #temp
select 1, 'data 1' union all
select 2, 'data 2' union all
select 3, 'data 3'

select * from #temp    
select * from @var

ROLLBACK

select * from @var
select * from #temp    

if object_id('tempdb..#temp') is null
    select '#temp does not exist outside the transaction'

----------------------------------------------------------use of DENSE_RANK()
IF OBJECT_ID('SalesHistory') IS NOT NULL
DROP TABLE SalesHistory
CREATE TABLE [dbo].[SalesHistory]
  (
        [Product] [varchar](10) NULL,
         [SaleDate] [datetime] NULL,
        [SalePrice] [money] NULL
  )
  GO
INSERT INTO SalesHistory(Product, SaleDate, SalePrice)
SELECT 'Computer','1919-03-18 00:00:00.000',1008.00
UNION ALL
 SELECT 'BigScreen','1927-03-18 00:00:00.000',91.00
UNION ALL
SELECT 'PoolTable','1927-04-01 00:00:00.000',139.00
UNION ALL
SELECT 'Computer','1919-03-18 00:00:00.000',1008.00
 UNION ALL
SELECT 'BigScreen','1927-03-25 00:00:00.000',92.00
UNION ALL
SELECT 'PoolTable','1927-03-25 00:00:00.000',108.00
UNION ALL
SELECT 'Computer','1919-04-01 00:00:00.000',150.00
 UNION ALL
SELECT 'BigScreen','1927-04-01 00:00:00.000',    123.00
UNION ALL
SELECT 'PoolTable','1927-04-01 00:00:00.000',    139.00
UNION ALL
SELECT 'Computer','1919-04-08 00:00:00.000',    168.00


;WITH SalesCTE(Product, SaleDate, SalePrice, Ranking)
AS
(
    SELECT Product, SaleDate, SalePrice
        , Ranking = DENSE_RANK() OVER(PARTITION BY Product, SaleDate, SalePrice ORDER BY NEWID() ASC)
     FROM SalesHistory
)

select * from SalesCTE 

DELETE FROM SalesCTE WHERE Ranking > 1

select * from SalesHistory order by product


select DENSE_RANK() OVER(PARTITION BY Product, SaleDate, SalePrice ORDER BY NEWID() ASC) FROM SalesHistory

----------------------------------------------------------use of DENSE_RANK()

DECLARE @myid uniqueidentifier
SET @myid = NEWID()
PRINT 'Value of @myid is: '+ CONVERT(varchar(255), @myid)

select NEWID(), NEWID() 
 --executing the function twice even in the same query generates different id


CREATE TABLE [dbo].[UIDTest]
(
    [IdDate] datetime NULL,
    CustomerID uniqueidentifier NOT NULL DEFAULT newid()
)

INSERT INTO UIDTest([IdDate], CustomerID)
SELECT getdate(),NEWID()

select * from UIDTest order by [IdDate]
truncate table UIDTest

select top 1 * from segments order by transactionref desc


 create table #temp2(a int,b int)

insert into #temp2 values(5,null)
insert into #temp2 values(null,5)
insert into #temp2 values(null,null)
insert into #temp2 values(5,2)
insert into #temp2 values(6,5)
 insert into #temp2 values(null,7)
insert into #temp2 values(5,null)
insert into #temp2 values(5,null)

create table #temp(a int,b int)

insert into #temp values(5,null)
insert into #temp values(null,5)
 insert into #temp values(null,null)
insert into #temp values(5,2)
insert into #temp values(6,5)
insert into #temp values(null,7)
insert into #temp values(5,null)
insert into #temp values(5,null)

update #temp set a=9, b=5 where a=5            --updating multiple columns 
 SELECT COUNT(*) FROM #temp2, #temp            --this is a simple cross join 

--EXEC sp_spaceused #temp                    --works only with non-temp tables
--Output
--name    rows reserved    data    index_size    unused
--temp    8    16 KB        8 KB    8 KB        0 KB

select * from #temp
SELECT COUNT(*) 'COUNT(*)' from #temp
SELECT COUNT_BIG(ALL a) 'COUNT_BIG(ALL a)' from #temp
SELECT COUNT_BIG(*) 'COUNT_BIG(*)' from #temp
 SELECT COUNT_BIG(b) 'COUNT_BIG(b)' from #temp                        --same output as below
SELECT COUNT_BIG(ALL b) 'COUNT_BIG(ALL b)' from #temp                --same output as above
SELECT COUNT_BIG(DISTINCT b) 'COUNT_BIG(DISTINCT b)' from #temp

select coalesce(a,b) from #temp
select a from #temp union 
select b from #temp 

create table #new3(a int, b int,c timestamp,timestamp) -- table can't contain more than 1 timestamp type column

 select * from #new2
 update #new set a=9, c=5 where a=5            --updating multiple columns 

insert into #new(a,b) values(6,null)
insert into #new(a,b) values(7,null)

CREATE clustered INDEX clsIn ON index_test(col_2)
alter table index_test add primary key (col_1)
 alter table index_test drop constraint PK_index_test 
drop index clsIn on index_test 
drop index PK__index_test__0F975522 on index_test 


sp_helptext usp_ReadByAccountCode

exec usp_ReadByAccountCode 'A4002'

--"Query error occured : Procedure or Function 'usp_GetLccTax' 
--    expects parameter '@bookingClass', which was not supplied."



SELECT Member.* FROM Member, Agency WHERE accountCode = 'A4002' and Member.AgencyId = Agency.AgencyId    

begin tran

delete from Member
delete from Agency 

rollback tran

-- experiment full outer and cross join

create table #temp2(a int,b int)

insert into #temp2 values(5,null)
insert into #temp2 values(null,5)
 insert into #temp2 values(null,null)
insert into #temp2 values(5,2)
insert into #temp2 values(6,5)
insert into #temp2 values(null,7)
insert into #temp2 values(5,null)
insert into #temp2 values(5,null)

 create table #temp(a int,b int)

insert into #temp values(5,null)
insert into #temp values(null,5)
insert into #temp values(null,null)
insert into #temp values(5,2)
insert into #temp values(6,5)
insert into #temp values(null,7)
 insert into #temp values(5,null)
insert into #temp values(5,null)

select * from airline where airlinecode = 'IT'
select * from airport where airlinename like '%british%'    

sp_helptext usp_GetAirlineCommissionOfAirlineForAgency

select CHECKSUM ('e')
select checksum('51;52;56;2204;')

-- query to migrate table-cum-data from one server to another
exec sp_addlinkedserver [192.168.0.28]    
select * into taxbreakup2 from [192.168.0.28].tektravelsnapshot.dbo.taxbreakup

ALTER TABLE TicketRequest ADD CONSTRAINT DF_TicketRequest_CreatedOn DEFAULT getdate() for CreatedOn
ALTER TABLE TicketRequest DROP CONSTRAINT DF_TicketRequest_CreatedOn

SELECT CONVERT(VARCHAR(10), GETDATE(), 103) AS [DD/MM/YYYY]
 SELECT CURRENT_TIMESTAMP
select substring(CONVERTselect substring(CONVERT(varchar(255), RateBreakTable.distance)
                            , 0, charindex('.', CONVERT(varchar(255), RateBreakTable.distance), 0)) + ' KMS'  
                     from Rate 
                        join RateBreakTable on RateBreakTable.rateId = Rate.rateId
                    where Rate.rateId = booking.rateId and booking.rateTypeId = 1select substring(CONVERT(varchar(255), RateBreakTable.distance)
                             , 0, charindex('.', CONVERT(varchar(255), RateBreakTable.distance), 0)) + ' KMS'  
                    from Rate 
                        join RateBreakTable on RateBreakTable.rateId = Rate.rateId
                     where Rate.rateId = booking.rateId and booking.rateTypeId = 1(VARCHAR(10), CURRENT_TIMESTAMP, 14), 0, charindex(':', CONVERT(VARCHAR(10), CURRENT_TIMESTAMP, 14), 4)) 
select Convert(float,10.5)
 declare @a float
set @a = DATEDIFF(mi, 04/04/2010, getdate())
select @a
select Convert(float,@a) /60

--00441610072205 , DLF PHASE I 
--HDFC0000044


WITH StudentCTE(studentname, subjectnameRanking, Ranking)
 AS
(
SELECT Studentname, subjectname, Ranking = DENSE_RANK() 
    OVER(PARTITION BY Studentname, subjectname ORDER BY NEWID() ASC)    
    FROM student
)
DELETE FROM StudentCTE WHERE Ranking > 1

 -------------------------------------------------------get custom error info
-------start
CREATE PROCEDURE usp_GetErrorInfo
AS
    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
         ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage;
GO

BEGIN TRY
    -- Generate divide-by-zero error.
     SELECT 1/0
END TRY
BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE usp_GetErrorInfo
END CATCH

-------start

select @@TRANCOUNT

-- Test XACT_STATE:
    -- If 1, the transaction is committable.
     -- If -1, the transaction is uncommittable and should 
    --     be rolled back.
    -- XACT_STATE = 0 means that there is no transaction and
    --     a commit or rollback operation would generate an error.
 SELECT XACT_STATE()

IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;
GO




-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------TRASH FROM HERE 


exec [usp_GetCompletedBooking] '03-01-2010', '03-22-2010', ''
-------------------------------------------------------------------------------------------------------------------


declare @CompanyList varchar(max)
set @CompanyList = 'all'

select 
          booking.bookingRef 'Ref No'
        , CONVERT(VARCHAR(10), booking.pickupdatetime, 103) 'Pick up date'
         , booking.crfno 'CRF No.'
        , guest.empcode 'Emp Code'
        , guest.firstname + ' ' + guest.lastname 'Guest Name'
        , guest.cellno1 'Guest Mob No.'
         , guest.costcentercode 'Cost Center Code'
        , address.city 'Employee Base Location'
        , [user].firstname + ' ' + [user].lastname 'Car booked by'
        , VehicleType.typeName 'Vehicle Type'
         , VehicleModel.modelName 'Vehicle Model'
        , substring(booking.pickUpDescription, charindex('&*&', booking.pickUpDescription, 0) + 3
                , len(booking.pickUpDescription)-charindex('&*&', booking.pickUpDescription, 0)) 
           'Destination (To & Fro)'
        , CityForRate.cityName 'Pick Up City'
        , case booking.rateTypeId 
            when 2 then 
                substring(booking.pickUpDescription, 0, charindex('&*&', booking.pickUpDescription, 0)) 
             else 
                ''
          END 'Flight No.'
        , case booking.rateTypeId 
            when 1 then 
                'Disposal'
            when 2 then 
                 'Airport'
            when 3 then 
                'City'
            when 4 then 
                'Outstation'
            else 
                'Hourly'
           END 'Type of trip'
        ,  substring(CONVERT(VARCHAR(10), DutySlip.garageReleaseTime, 14), 0, charindex(':', CONVERT(VARCHAR(10), DutySlip.garageReleaseTime, 14), 4)) 'Start Time'
         ,  substring(CONVERT(VARCHAR(10), DutySlip.startTime, 14), 0, charindex(':', CONVERT(VARCHAR(10), DutySlip.startTime, 14), 4)) 'Pick up time'
        ,  substring(CONVERT(VARCHAR(10), DutySlip.dropOffTime, 14), 0, charindex(':', CONVERT(VARCHAR(10), DutySlip.dropOffTime, 14), 4)) 'Drop off time'
         ,  substring(CONVERT(VARCHAR(10), DutySlip.slipCloseTime, 14), 0, charindex(':', CONVERT(VARCHAR(10), DutySlip.slipCloseTime, 14), 4)) 'Close time'
        , case CompanyEndLocation.endLocation 
             when 1 then --PointToPoint
                DATEDIFF(mi, DutySlip.startTime, DutySlip.dropOffTime)
            else        --GarageToGarage
                DATEDIFF(mi, DutySlip.garageReleaseTime, DutySlip.slipCloseTime)
           END 'Consumed hrs'
        , DutySlip.startReading 'Start Kms'     --GarageToGarage
        , DutySlip.pickUpReading 'Pick up kms'  --PointToPoint
        , DutySlip.dropOffReading 'Drop off kms'
         , DutySlip.closeReading   'Close kms'
        , case CompanyEndLocation.endLocation 
            when 1 then --PointToPoint
                DutySlip.dropOffReading - DutySlip.pickUpReading
            else        --GarageToGarage
                 DutySlip.closeReading - DutySlip.startReading
          END 'Consumed kms'
        , case booking.rateTypeId 
          when 1 then 
            isnull((select substring(CONVERT(varchar(255), RateBreakTable.duration)
                             , 0, charindex('.', CONVERT(varchar(255), RateBreakTable.duration), 0)) + ' HRS ' 
                    from RateBreakTable where RateBreakTable.rateId = booking.rateId and booking.rateTypeId = 1),'')
             +
            isnull((select substring(CONVERT(varchar(255), RateBreakTable.distance)
                            , 0, charindex('.', CONVERT(varchar(255), RateBreakTable.distance), 0)) + ' KMS'  
                     from RateBreakTable where RateBreakTable.rateId = booking.rateId and booking.rateTypeId = 1),'')
          ELSE
            ''
          END
          'Slab applied'
         , case CompanyEndLocation.endLocation 
            when 1 then --PointToPoint
                DutySlip.dropOffReading - DutySlip.pickUpReading 
            else        --GarageToGarage
                DutySlip.closeReading - DutySlip.startReading 
           END 'Extra kms'
        , case CompanyEndLocation.endLocation 
            when 1 then --PointToPoint
                DATEDIFF(hh, DutySlip.startTime, DutySlip.dropOffTime)
            else        --GarageToGarage
                 DATEDIFF(hh, DutySlip.garageReleaseTime, DutySlip.slipCloseTime)
          END 'Extra hrs'
        , case booking.rateTypeId 
          when 1 then 
            isnull((select PriceBreak.amount from priceBreak 
                 where priceId = booking.priceId and priceBreak.rateType = 1),0)
            + isnull((select PriceBreak.amount from priceBreak 
                where priceId = booking.priceId and priceBreak.rateType = 2),0)
           when 4 then 
            isnull((select PriceBreak.amount from priceBreak where priceId = booking.priceId and priceBreak.rateType = 1),0)
                + isnull((select PriceBreak.amount from priceBreak where priceId = booking.priceId and priceBreak.rateType = 2),0)
           else 
            0
          END 'Extra charges'
        , Price.transferAmount 'Basic fare'
        , Price.tollCharges 'Toll charges'
        , Price.parkingCharges 'Parking charges'
         , Price.otherCharges 'Other charges'
        , case CompanyEndLocation.endLocation 
            when 1 then                    --PointToPoint
                isnull((select PriceBreak.amount from priceBreak where priceId = booking.priceId and priceBreak.rateType = 3),0)
             else                        --GarageToGarage
                0
          END 'Fixed Amount'
        , Price.tollCharges + Price.parkingCharges + Price.otherCharges 'NON Taxable cost'
         , case booking.rateTypeId 
            when 4 then                    --NightCharges
                isnull((select PriceBreak.amount from priceBreak where priceId = booking.priceId and priceBreak.rateType = 4),0)
             else 
                0
          END 'Outstation charges'
        , DriverAccount.amtGivenToDriver 'Overnight charges'
        , Price.serviceTaxAmount 'Service tax (S.Tax)'
         , Price.educationTaxAmount 'Edu tax (S.Tax)'
        , Price.higherEducationTaxAmount 'Higher edu tax (S.Tax)'
        , Price.transferAmount + Price.tollCharges + Price.parkingCharges + Price.otherCharges 
             + Price.breakupTotalAmount
            + DriverAccount.amtGivenToDriver 
            + Price.serviceTaxAmount + Price.educationTaxAmount 
            + Price.higherEducationTaxAmount 
            ' Grand Total'
         , '' 'Comments (if any)'
        from
            dutyslip 
            join booking on booking.bookingid = DutySlip.bookingId 
            left join [user] on [user].userid = booking.userid 
             join guest on guest.guestid = booking.guestid 
            join CustomerCompany on CustomerCompany.custCompanyId = booking.companyId
            join address on address.addressId = CustomerCompany.addressId
             join Fleet on Fleet.fleetId = DutySlip.fleetId
            join VehicleType on VehicleType.typeId = Fleet.typeId
            join VehicleModel on VehicleModel.modelId = Fleet.modelId
            join CityForRate on CityForRate.cityId = booking.pickUpCity
             join Price on Price.priceId = booking.priceId
            left join CompanyEndLocation on CompanyEndLocation.companyId = booking.companyId 
                and    CompanyEndLocation.rateTypeId = booking.rateTypeId 
             join DriverAccount on DriverAccount.bookingId = DutySlip.bookingId 
        where 
            dutyslip.status = 2
            and    (booking.pickupdatetime > '01/01/2009' or booking.pickupdatetime = '01/01/2009')
             and (booking.pickupdatetime < '05/05/2010' or booking.pickupdatetime = '05/05/2010')
--            and (@CompanyList = 'All' or (booking.companyId in (select s from dbo.FnSplit(case @CompanyList when null then '' else @CompanyList END,','))))
             order by booking.pickupdatetime 


select companyId, count(*) from CompanyEndLocation 
group by companyId, ratetypeid
having count(*) > 0

select * from booking where booking.companyId in ('4','92')
 --where companyId is of int type and converts '4' and '92' to int internally
select * from booking where booking.companyId in ('4,92') 
--but fails to convert '4,92'
--Conversion failed when converting the varchar value '4,92' to data type int.

SET ROWCOUNT 4;
UPDATE Production.ProductInventory
SET Quantity = 400
WHERE Quantity < 300;
GO
--(4 row(s) affected)


-------------------------------------------------------------------------------------------------------------------
 select * from CustomerCompany where custCompanyId in (4,92)

declare @CompanyList varchar(10)
set @CompanyList = null
select s from dbo.FnSplit(case @CompanyList when null then '' else @CompanyList END,',')
        
select booking.* from booking 
    join DutySlip on DutySlip.bookingId = booking.bookingid
    where 
        dutyslip.status=2 
        and    (booking.pickupdatetime > '01/01/2009' or booking.pickupdatetime = '01/01/2009')
         and (booking.pickupdatetime < '05/05/2010' or booking.pickupdatetime = '05/05/2010')


select booking.*, RateBreakTable.duration, RateBreakTable.distance from booking 
    join RateBreakTable on RateBreakTable.breakrateid = booking.rateId
     where status=3 and booking.rateTypeId = 1

select substring(CONVERT(varchar(255), RateBreakTable.distance)
                            , 0, charindex('.', CONVERT(varchar(255), RateBreakTable.distance), 0)) + ' KMS'  
                     from Rate 
                        join RateBreakTable on RateBreakTable.rateId = Rate.rateId
                    where Rate.rateId = booking.rateId and booking.rateTypeId = 1




 --create table t1(col1 int, col2 int, col3 char(50))
--insert into t1 values (1, 2, 'data value two')
--insert into t1 values (1, 2, 'data value two')
--insert into t1 values (1, 2, 'data value two')
 --insert into t1 values (1, 3, 'data value two')
--insert into t1 values (1, 3, 'data value two')
--update t1 set col3 = 'data value three' where col1=1 and col2=3
--
--select * from t1
 --select col1, col2, col3, count(*) from t1 group by col1, col2, col3
--select rowcount, * from t1
--
--select @@rowcount 
--
--DELETE FROM t1 WHERE ROWID NOT IN (SELECT MIN(ROWID) FROM t1)ORDER BY SAL
 --
 --DELETE FROM t1 WHERE ROWID NOT IN (SELECT MAX(ROWID) FROM t1 GROUP BY col1,col2,col3)

create table t2(EmpID varchar(20))
insert into t2 values('Aufaq')
insert into t2 values('Aufaq')
insert into t2 values('Aufaq')
 insert into t2 values('Aufaq')
insert into t2 values('Aufaq')
insert into t2 values('Basharat')
insert into t2 values('Basharat')
insert into t2 values('Basharat')
insert into t2 values('Basharat')
 insert into t2 values('John')
insert into t2 values('John')
insert into t2 values('John')
insert into t2 values('John')
insert into t2 values('John')
insert into t2 values('John')

select * from t2

SELECT COUNT(*)-1 FROM t2 group by EmpID order by COUNT(*)
SELECT COUNT(*) FROM t2 group by EmpID order by COUNT(*)
select TOP 1
    (
        SELECT COUNT(*) -1 FROM t2 WHERE EmpID in 
             (select distinct EmpID from t2) 
    ) 

DELETE TOP (SELECT COUNT(*) -1 FROM dbo.Emptest WHERE EmpID = 'Basharat')
FROM dbo.Emptest WHERE EmpID = 'Basharat' 


WITH t2(EmpID, Ranking)
 AS
(
SELECT EmpID, Ranking = DENSE_RANK() 
    OVER(PARTITION BY EmpID ORDER BY NEWID() ASC)    
    FROM t2
)
delete from t2 where Ranking not in (select Min(Ranking) from t2 group by EmpID)
--DELETE FROM t2 WHERE Ranking > 1

select * from t2

--Table - person

--sno       Name      Add1          DOJ
------        -----      ----            ----
--1            A1        Rohini        23-08-2010
--2         A2        Azadpur       01-05-2010        
--3         A3        Pitam Pura    20-06-2010                        
--4         A3        Pitam Pura    20-06-2010                        
--5         A5        Punjabi Bagh  01-10-2010                        
--6         A6        Mahipalpur    08-03-2010                        
--7         A7        Jwalahedi     01-01-2010                        
--8         A8        Badli         15-12-2010                
--9         A9        Bawana        06-11-2010                
--10        A2        Azadpur       01-05-2010                        

--Delete Duplicate Rows single query
----------------------------------
--condition-if there is any unique row with unique values
delete from person where sno not in (select Min(sno) from person group by Name, Add1, DOJ)

declare @i int
begin try
    set @i = 1
    select 1/0 '1/0'
--    after execution of above statement control jumps to catch statement
--  and subsequent statements(if any) are not executed. if try-catch block
--    is commented then, after any error, the control continues with execution
--    of the next statements

    set @i = 2
    select 0/1 '0/1'

    select @@error '@@error', ' at point i = ' + convert(varchar, @i)
 end try
begin catch
    select @@error '@@error', ' at point i = ' + convert(varchar, @i)
end catch

select top 5 * from sys.messages order by message_id desc


--EXECUTE sp_dropmessage 50005;
 --GO
--EXECUTE sp_addmessage 50005, -- Message id number.
--    10, -- Severity.
--    N'The current database ID is: %d, the database name is: %s.';
--GO


DECLARE @DBID INT, @DBNAME NVARCHAR(128)

SET @DBID = DB_ID()
SET @DBNAME = DB_NAME()

RAISERROR
    (N'The current database ID is: %d, the database name is: %s.',
    10, -- Severity.
    1, -- State.
    @DBID, -- First substitution argument.
     @DBNAME); -- Second substitution argument.
GO


CREATE TABLE #T1 (ID int)
GO
INSERT #T1 VALUES (1)
INSERT #T1 VALUES (2)
INSERT #T1 VALUES (3)
INSERT #T1 VALUES (4)

--IF 3 < SOME (SELECT ID FROM #T1)
 --IF 3 < ANY (SELECT ID FROM #T1)
IF 3 < ALL (SELECT ID FROM #T1)
PRINT 'TRUE' 
ELSE
PRINT 'FALSE'

SELECT CAST(RAND() * 10000000 AS INT) AS [RandomNumber]


declare @pos int, @noofrecs int, @suff varchar(3)
 SELECT @pos = 0, @noofrecs = 1000

WHILE @pos < @noofrecs
BEGIN
    if @pos < 10
    begin
        set @suff = '00' + convert(varchar, @pos)
    end
    if @pos>9 and @pos<=99
     begin
        set @suff = '0' + convert(varchar, @pos)
    end
    if @pos>99 and @pos<=999
    begin
        set @suff = convert(varchar, @pos)
    end
    update RequestQueue set Pnr = 'PNR' + @suff, LastName = 'LN' + @suff where reqid = @pos + 1
     set @pos = @pos + 1 
END

--select * from RequestQueue where Processed = 'Y'

--update RequestQueue set Processed='N'
--truncate table RequestQueue 

declare @pos varchar(1), @pos2 varchar(1)
 set @pos = '1'
if (@pos = '1')
begin
    print 'hello'
end

if (null = null)
begin
    print 'h'
end
else
begin
    print 'k'
end

if (null is null)
 begin
    print 'h'
end
else
begin
    print 'k'
end

select * from ttbr_fo where 1=2
select * from ttbr_fo where 'a'='b'

Select * From Sys.sql_modules
Select * From Sys.Objects
select * from information_schema.tables where table_name = 'ttbr_fo'

SELECT DISTINCT (a.Amount) FROM [EmployeeSalaryDetails] A
WHERE 2 = (SELECT COUNT (DISTINCT (b.Amount)) FROM [EmployeeSalaryDetails] B WHERE a.Amount<=b.Amount)

declare @x xml, @i int
--error xml
--set @x='<ArrayOfFirmOrderConfirmList xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><FirmOrderConfirmList></FirmOrderConfirmList></ArrayOfFirmOrderConfirmList>'
 --xml without error
set @x='<ArrayOfFirmOrderConfirmList xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><FirmOrderConfirmList></FirmOrderConfirmList></ArrayOfFirmOrderConfirmList>'
 --select @x 
--2010-11-02 17:31:34.450    2010-11-02 17:23:05.203    684    1    2317    1    1    1    -1    1
exec USP_TBR_UpdateFirmOrderConfirm @x, @i out


SELECT * FROM  tTBR_Model_Mst_Copy 
       WHERE (ISNULL(@modelID,0) = 0 OR ModelID = @modelID)      


SELECT LEFT('201101',4)
SELECT RIGHT('201101',2)

-------------------------------------START
DECLARE @month VARCHAR(2), @vYearMth_n VARCHAR(6), @date DATETIME
SET @vYearMth_n = '201101'
 SET @date = DATEADD(MONTH, -1, CONVERT(DATETIME, RIGHT(@vYearMth_n,2)+'-15-'+LEFT(@vYearMth_n,4)))
SET @month = CONVERT(VARCHAR, DATEPART(MONTH, @date))

IF LEN(@month)=1
    SET @month = '0' + @month

SELECT CONVERT(VARCHAR, DATEPART(YEAR, @date)) + @month
-------------------------------------END
DECLARE @CBUFlag varchar(2), @Demand int
SET @CBUFlag = 'CB'
SET @Demand =   CASE @CBUFlag 
                    WHEN 'CB' THEN @Demand = 2 
                     WHEN 'NC' THEN @Demand = 3
                END
SELECT @Demand 
--in the case statement we can not do assignment
select CONVERT(DECIMAL (12,2), 10.2358)
select CONVERT(DECIMAL (12,2), 10.9)
 select FLOOR(123.1)

select * from tBR_MKT_Pct_Dist_Model
declare @SalesPlnPctID int
select top(1) @SalesPlnPctID = SalesPlnPctID from tBR_MKT_Pct_Dist_Model
select @SalesPlnPctID 
select count(1) from tBR_MKT_Pct_Dist_Model

select tym into #i
from
(select CAST('0000000' AS VARCHAR(3)) as tym) 
d
insert into #i values ('3')
select * from #i
drop table #i

declare @fl float, @dec DECIMAL(18,2), @i int
 set @fl = 1.66666666
set @dec = 1.66666666
--select @fl 
--select @dec 
select @i = CAST(@fl AS INT) 
select @i = CAST(@dec AS INT) 
select @i = @dec
select @i 

---experimentation of pivot table : start
 CREATE TABLE Sales ([Month] VARCHAR(20) ,SaleAmount INT)

INSERT INTO Sales VALUES ('January', 100)
INSERT INTO Sales VALUES ('February', 200)
INSERT INTO Sales VALUES ('March', 300)
 INSERT INTO Sales VALUES ('Apr', 400)
INSERT INTO Sales VALUES ('May', 450)
INSERT INTO Sales VALUES ('June', 250)

SELECT * FROM SALES

declare @TYM varchar(6)
set @TYM = '200909'
 Select substring(DateName(month, DateAdd(month, CAST(RIGHT(@TYM, 2) AS int), 0) - 1), 1, 3)


--Month             SaleAmount
------------------  -----------
--January           100
--February          200
--March             300 
--
--
--Suppose we wanted to convert the above into this:
--
-- 
--January     February    March
------------- ----------  ----------
--100         200         300
--
 --
--We can do this using the PIVOT operator, as follows:

SELECT  [January]
      , [February]
      , [March]
FROM    ( SELECT    [Month]
                  , SaleAmount
          FROM      Sales
         ) p PIVOT ( SUM(SaleAmount)
                    FOR [Month] 
                      IN ([January],[February],[March])
                  ) AS pvt

--sp_dbcmptlevel [Vitaltrans], 100
--ALTER DATABASE Vitaltrans
 --SET compatibility_level = 90
--GO
---experimentation of pivot table : end
select * from Sales where saleamount between 200 and 300 order by saleamount 

--dynamic column selection
Declare @sqlCommand nvarchar(3000)

SELECT region_id, region_name into #RepOutput
FROM
(
    select 1 region_id,  'RegionName1' region_name
    union
    select 2 region_id,  'RegionName2' region_name
    union
    select 3 region_id,  'RegionName3' region_name
     union
    select 4 region_id,  'RegionName4' region_name
)DATA

set @sqlCommand = 'select region_id,region_name from #RepOutput'
EXECUTE sp_executesql  @sqlCommand 


select PurchaseOrderID, UnitPrice from Purchasing.PurchaseOrderDetail
select PurchaseOrderID, MAX(UnitPrice) 'MAX(UnitPrice)' into #tempobase from Purchasing.PurchaseOrderDetail group by PurchaseOrderID
select PurchaseOrderID, MAX(UnitPrice) 'MAX(UnitPrice)' from Purchasing.PurchaseOrderDetail group by PurchaseOrderID

sp_help Purchasing.PurchaseOrderDetail

select * from #tempobase order by PurchaseOrderID

drop table #tempobase 

exec usp_select_SecurityFunction_Permission_by_Login @SecurityFunctionNo=3000001,@LoginNo=1984

vwSecurityLoginPermissions

exec usp_count_Session_for_Login @LoginNo=1984,@SessionName=N'5yoioz550g0ugeicx2ynkmq1'



--usp_selectAll_Customer_Order_Value 101		-- with CTE
sp_helptext usp_selectAll_Customer_Order_Value 101		-- with @table variable

select * from sys.dm_exec_query_stats 

select * into #table from
(select * from [Production].[WorkOrder]) t

exec tempdb..sp_help '#table'

SELECT 
    '[' + (OBJECT_SCHEMA_NAME(tables.object_id,db_id()) 
	+ '].[' + tables.NAME + ']') AS TableName,
    indexes.name as indexName,
    sum(partitions.rows) as RowCounts,
    sum(allocation_units.total_pages) as TotalPages, 
    sum(allocation_units.used_pages) as UsedPages, 
    sum(allocation_units.data_pages) as DataPages,
    (sum(allocation_units.total_pages) * 8) / 1024 as TotalSpaceMB, 
    (sum(allocation_units.used_pages) * 8) / 1024 as UsedSpaceMB, 
    (sum(allocation_units.data_pages) * 8) / 1024 as DataSpaceMB,
	GETDATE() AS Datemodified
FROM 
    sys.tables tables
INNER JOIN      
    sys.indexes indexes ON tables.OBJECT_ID = indexes.object_id
INNER JOIN 
    sys.partitions partitions ON indexes.object_id = partitions.OBJECT_ID
		 AND indexes.index_id = partitions.index_id
INNER JOIN 
    sys.allocation_units allocation_units ON partitions.partition_id = allocation_units.container_id
WHERE 
   -- t.NAME NOT LIKE 'dt%' AND
    indexes.OBJECT_ID > 255 AND   
    indexes.index_id <= 1
GROUP BY 
    tables.object_id,tables.NAME, indexes.object_id, indexes.index_id, indexes.name 
ORDER BY 
    RowCounts
    --TotalSpaceMB desc

--Microsoft SQL Server 2012 - 11.0.5058.0 (X64)   (64-bit) 
--on Windows NT 6.3 <X64> (Build 9600: ) (Hypervisor) 

--Microsoft SQL Server 2016 (RTM-GDR) (KB4019088) - 13.0.1742.0 (X64)   (64-bit) 
--on Windows 10 Pro 6.3 <X64> (Build 17134: NT) 

exec usp_datalistnugget_GoodsInLine @ClientId=101, @OrderBy=1,
    @SortDir=2, @PageIndex=0, @PageSize=50,
    @PartSearch=default, @CMSearch=default, @ReceivedBy=default,
    @AirWayBill=default, @IncludeInvoiced=0, @PurchaseOrderNoLo=default, 
    @PurchaseOrderNoHi=default, @GoodsInNoLo=default, @GoodsInNoHi=default,
    @DateReceivedFrom=default, @DateReceivedTo=default, @SupplierInvoice=default,
    @Reference=default, @RecentOnly=0, @UninspectedOnly=0,
    @ClientSearch=default, @IsPoHub=0, @IsGlobalLogin=0

SELECT TOP (100) * FROM [AdventureWorks2016].[HumanResources].[Employee]

select * from __MigrationHistory
select * from Student
select * from Course
select * from Enrollment

select * from [Sales].[ShoppingCartItem]