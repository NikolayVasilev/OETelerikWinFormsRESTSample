 
/*------------------------------------------------------------------------
   File        : ServiceClient
   Purpose     : 
   Syntax      : 
   Description : Client consuming the SportsDagaService
   Author(s)   : nvasilev
   Created     : Wed Apr 22 15:29:55 EEST 2020
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.Core.WidgetHandle FROM PROPATH.
USING OpenEdge.Net.HTTP.ClientBuilder FROM PROPATH.
USING OpenEdge.Net.HTTP.Credentials FROM PROPATH.
USING OpenEdge.Net.HTTP.IHttpClient FROM PROPATH.
USING OpenEdge.Net.HTTP.IHttpRequest FROM PROPATH.
USING OpenEdge.Net.HTTP.IHttpResponse FROM PROPATH.
USING OpenEdge.Net.HTTP.RequestBuilder FROM PROPATH.
USING OpenEdge.Net.URI FROM PROPATH.
USING Progress.Json.ObjectModel.JsonObject FROM PROPATH.
USING Progress.Lang.AppError FROM PROPATH.
USING System.Data.* FROM ASSEMBLY.
USING Utils.TempTableToDataTableConverter FROM PROPATH.


BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Service.ServiceClient: 

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    
    {Entities/customer.i}
    DEFINE PRIVATE VARIABLE baseServiceUrl AS CHARACTER NO-UNDO.

    
    CONSTRUCTOR PUBLIC ServiceClient ( serviceBase AS CHARACTER ):
        SUPER ().
        
        
        IF serviceBase = "Productions" THEN DO:
            ASSIGN THIS-OBJECT:baseServiceUrl = "/SportsData/web/pdo/SportsDataService/". // TODO: Replace with injected value.
        END.
        
    END CONSTRUCTOR.
    
    METHOD PRIVATE JsonObject GetResourceObject(resource AS CHARACTER):
        DEFINE VARIABLE oClient      AS IHttpClient   NO-UNDO.
        DEFINE VARIABLE oJson        AS JsonObject    NO-UNDO.
        DEFINE VARIABLE oRequest     AS IHttpRequest  NO-UNDO.
        DEFINE VARIABLE oResponse    AS IHttpResponse NO-UNDO.
        DEFINE VARIABLE oURI         AS URI           NO-UNDO.
        
        
        ASSIGN oClient = ClientBuilder:Build():Client
            oUri = NEW URI("http", "localhost", 8810)
            oUri:Path = THIS-OBJECT:baseServiceUrl + resource.

        oRequest = RequestBuilder:Get(oUri):Request.

        oResponse = oClient:Execute(oRequest).

        IF oResponse:StatusCode = 200 THEN // Request succeeded.
        DO:
            IF TYPE-OF(oResponse:Entity, JsonObject) THEN
            DO:
                oJson = CAST(oResponse:Entity, JsonObject). // use this with dataset
                // oJson:WriteFile("xxx.json").

            END.
            ELSE DO:
                UNDO, THROW NEW AppError(SUBSTITUTE("Unknown response type. Content-Type: &1 Entity Class: &2",
                    oResponse:ContentType,
                    oResponse:Entity:GetClass():TypeName), 1).
            END.
        END. 
        ELSE DO: // Got an error status code
            UNDO, THROW NEW AppError(SUBSTITUTE("Request failed. StatusCode: &1 StatusReason: &2",
                oResponse:StatusCode,
                oResponse:StatusReason), 2).
        END.

        /*        MESSAGE "Done"                    */
        /*            VIEW-AS ALERT-BOX INFORMATION.*/

        RETURN oJson.

        CATCH e AS Progress.Lang.Error :
            MESSAGE e:GetMessage(1) e:CallStack
                VIEW-AS ALERT-BOX ERROR TITLE "HTTP Request Error".
        END CATCH.

        FINALLY:
            DELETE OBJECT oClient   NO-ERROR.
            DELETE OBJECT oRequest  NO-ERROR.
            DELETE OBJECT oResponse NO-ERROR.
        END FINALLY.
        
        
        
    END METHOD.    
    
    //METHOD PUBLIC DataTable GetCustomers(OUTPUT DATASET dsCustomer):
    METHOD PUBLIC DataTable GetCustomers():
        DEFINE VARIABLE oJsonResponse AS JsonObject    NO-UNDO.
        DEFINE VARIABLE oDataTableConverter AS TempTableToDataTableConverter NO-UNDO.
        DEFINE VARIABLE oCustomersDataTable AS DataTable NO-UNDO.
        ASSIGN oDataTableConverter = NEW TempTableToDataTableConverter().
        
        ASSIGN oJsonResponse = THIS-OBJECT:GetResourceObject("Customer").
        DATASET dsCustomer:READ-JSON("JSONObject", oJsonResponse, "EMPTY").
        
        oCustomersDataTable = oDataTableConverter:GetCustomersDataTable(INPUT DATASET dsCustomer BY-REFERENCE).           

        RETURN oCustomersDataTable.
        
    END METHOD.
    
    METHOD PUBLIC DataRow GetCustomerWithId(id AS INTEGER):
        DEFINE VARIABLE oJsonResponse AS JsonObject    NO-UNDO.
        DEFINE VARIABLE oDataTableConverter AS TempTableToDataTableConverter NO-UNDO.
        DEFINE VARIABLE oCustomersDataTable AS DataTable NO-UNDO.
        ASSIGN oDataTableConverter = NEW TempTableToDataTableConverter().
        
        ASSIGN oJsonResponse = THIS-OBJECT:GetResourceObject("Customer?filter=CustNum=" + STRING(id)).
        DATASET dsCustomer:READ-JSON("JSONObject", oJsonResponse, "EMPTY").
        
        oCustomersDataTable = oDataTableConverter:GetCustomersDataTable(INPUT DATASET dsCustomer BY-REFERENCE).           
        
        IF oCustomersDataTable:Rows:Count > 0 THEN DO:
            RETURN oCustomersDataTable:Rows[0].
        END. 
        
        RETURN.
        
    END METHOD.

END CLASS.