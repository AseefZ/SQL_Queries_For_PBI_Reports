
Select 
[Asset] as DESCR
,[Defect] as DEFECT_CODE
,[Stage__Code] as DEFECT_STAGE
,[Date_Created] as CRDATEI
,'' as VAL_ALPHA21,

[Completion_Date] as COMPL_DATEI
,[Created_By] as CRUSER
,[Comments] as VAL_ALPHA5
from
[dbo].[Works_Defects]