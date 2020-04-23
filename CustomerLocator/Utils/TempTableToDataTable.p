/*------------------------------------------------------------------------
  File        : TempTableToDataTable.p
  Purpose     : Demostrate populating a .Net data table from an ABL
                temp-table without having to write the data to disk. 
                
                Program first writea the temp-table to XML. This is 
                converted into a .Net ByteArray, which can be read by a 
                .Net data table. 

  Syntax      :

  Description : 

  Author(s)   : nvasilev
  Created     : Tue Feb 18 14:40:46 EET 2020
  Notes       :
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING System.Data.DataColumn FROM ASSEMBLY.
USING System.Data.DataTable FROM ASSEMBLY.
USING System.IO.MemoryStream FROM ASSEMBLY.
 
{Entities/customer.i}
DEFINE TEMP-TABLE ttName NO-UNDO
    FIELD FirstName AS CHARACTER
    FIELD LastName  AS CHARACTER.
 
CREATE ttName.
ASSIGN ttName.FirstName = "Fred"
    ttName.LastName = " Bloggs".
 
CREATE ttName.
ASSIGN ttName.FirstName = "Walter"
    ttName.LastName = "Dog".
 
 
DEFINE VARIABLE iSize           AS INTEGER      NO-UNDO.
DEFINE VARIABLE ix              AS INTEGER      NO-UNDO.
DEFINE VARIABLE customersTable  AS DataTable    NO-UNDO.
DEFINE VARIABLE oMemStream      AS MemoryStream NO-UNDO.
DEFINE VARIABLE p               AS MEMPTR       NO-UNDO.

customersTable = NEW DataTable("ttCustomerRow").

customersTable:Columns:Add(NEW DataColumn("CustNum", System.Type:GetType("System.Int32"))).
customersTable:Columns:Add(NEW DataColumn("Country", System.Type:GetType("System.String"))).
customersTable:Columns:Add(NEW DataColumn("Name", System.Type:GetType("System.String"))).
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
  
FOR EACH ttCustomer : 
    DISPLAY ttCustomer.Name.
END.
  
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

MESSAGE "Number of row in the data table:" customersTable:Rows:Count
    VIEW-AS ALERT-BOX INFORMATION.

FINALLY:
  
  // Free the allocated memory.
    SET-SIZE(p) = 0.   
  
END FINALLY.