 
/*------------------------------------------------------------------------
   File        : TempTableToDataTableConverter
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : nvasilev
   Created     : Wed Apr 22 19:05:03 EEST 2020
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING System.Data.DataTable FROM ASSEMBLY.
USING Service.ServiceClient FROM PROPATH.
USING System.Data.DataColumn FROM ASSEMBLY.
USING System.Data.DataTable FROM ASSEMBLY.
USING System.IO.MemoryStream FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Utils.TempTableToDataTableConverter: 

    {Entities/customer.i}
    METHOD PUBLIC DataTable GetCustomersDataTable(INPUT DATASET dsCustomer):
        DEFINE VARIABLE oServiceClient AS Service.ServiceClient NO-UNDO.      
        
        DEFINE VARIABLE iSize           AS INTEGER      NO-UNDO.
        DEFINE VARIABLE ix              AS INTEGER      NO-UNDO.
        DEFINE VARIABLE customersTable  AS DataTable    NO-UNDO.
        DEFINE VARIABLE oMemStream      AS MemoryStream NO-UNDO.
        DEFINE VARIABLE p               AS MEMPTR       NO-UNDO.

        customersTable = NEW DataTable("ttCustomerRow").
        
        customersTable:Columns:Add(NEW DataColumn("CustNum", System.Type:GetType("System.Int32"))).
        customersTable:Columns:Add(NEW DataColumn("Name", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("Country", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("State", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("Address", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("Address2", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("City", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("PostalCode", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("Phone", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("SalesRep", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("CreditLimit", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("Balance", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("Terms", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("Discount", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("Comments", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("Fax", System.Type:GetType("System.String"))).
        customersTable:Columns:Add(NEW DataColumn("EmailAddress", System.Type:GetType("System.String"))).
        
  
        TEMP-TABLE ttCustomer:WRITE-XML("memptr", p).
 
 
// Create and populate a ByteArray

        ASSIGN iSize = GET-SIZE(p)
            oMemStream = NEW System.IO.MemoryStream(iSize).

        DO ix = 1 TO iSize:
            oMemStream:WriteByte(GET-BYTE(p, ix)).
        END.   

        oMemStream:Flush().

        oMemStream:Position = 0. 
 
        customersTable:ReadXml(oMemStream).

        RETURN customersTable.
        
        FINALLY:
  
  // Free the allocated memory.
            SET-SIZE(p) = 0.   
  
        END FINALLY.
    END.

END CLASS.