 
/*------------------------------------------------------------------------
   File        : ServiceClient
   Purpose     : 
   Syntax      : 
   Description : Client consuming the SportsDagaService
   Author(s)   : nvasilev
   Created     : Wed Apr 22 15:29:55 EEST 2020
   Notes       : 
 ----------------------------------------------------------------------*/

using Progress.Lang.*.
using OpenEdge.Core.WidgetHandle from propath.
using OpenEdge.Net.HTTP.ClientBuilder from propath.
using OpenEdge.Net.HTTP.Credentials from propath.
using OpenEdge.Net.HTTP.IHttpClient from propath.
using OpenEdge.Net.HTTP.IHttpRequest from propath.
using OpenEdge.Net.HTTP.IHttpResponse from propath.
using OpenEdge.Net.HTTP.RequestBuilder from propath.
using OpenEdge.Net.URI from propath.
using Progress.Json.ObjectModel.JsonObject from propath.
using Progress.Lang.AppError from propath.
using System.Data.* from assembly.
using Utils.TempTableToDataTableConverter from propath.


block-level on error undo, throw.

class Service.ServiceClient: 

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    
    {Entities/customer.i}
    define private variable baseServiceUrl as character no-undo.

    
    constructor public ServiceClient ( serviceBase as character ):
        super ().
        
        
        if serviceBase = "Production" then do:
            assign this-object:baseServiceUrl = "/SportsData/web/pdo/SportsDataService/".
            //assign this-object:baseServiceUrl = "/SportsKendo/rest/SportsKendoService/".
        end.
        
    end constructor.
    
    method private JsonObject GetResourceObject(resource as character):
        define variable oClient      as IHttpClient   no-undo.
        define variable oJson        as JsonObject    no-undo.
        define variable oRequest     as IHttpRequest  no-undo.
        define variable oResponse    as IHttpResponse no-undo.
        define variable oURI         as URI           no-undo.
        
        
        assign oClient = ClientBuilder:Build():Client
            oUri = new URI("http", "localhost", 8810)
            oUri:Path = this-object:baseServiceUrl + resource.

        oRequest = RequestBuilder:Get(oUri):Request.

        oResponse = oClient:Execute(oRequest).

        if oResponse:StatusCode = 200 then // Request succeeded.
        do:
            if type-of(oResponse:Entity, JsonObject) then
            do:
                oJson = cast(oResponse:Entity, JsonObject). // use this with dataset
                // oJson:WriteFile("xxx.json").

            end.
            else do:
                undo, throw new AppError(substitute("Unknown response type. Content-Type: &1 Entity Class: &2",
                    oResponse:ContentType,
                    oResponse:Entity:GetClass():TypeName), 1).
            end.
        end. 
        else do: // Got an error status code
            undo, throw new AppError(substitute("Request failed. StatusCode: &1 StatusReason: &2",
                oResponse:StatusCode,
                oResponse:StatusReason), 2).
        end.

        /*        MESSAGE "Done"                    */
        /*            VIEW-AS ALERT-BOX INFORMATION.*/

        return oJson.

        catch e as Progress.Lang.Error :
            message e:GetMessage(1) e:CallStack
                view-as alert-box error title "HTTP Request Error".
        end catch.

        finally:
            delete object oClient   no-error.
            delete object oRequest  no-error.
            delete object oResponse no-error.
        end finally.
        
        
        
    end method.   
    
    method private JsonObject PutResourceObject(resource as character, payload as JsonObject):
        define variable oClient      as IHttpClient   no-undo.
        define variable oJson        as JsonObject    no-undo.
        define variable oRequest     as IHttpRequest  no-undo.
        define variable oResponse    as IHttpResponse no-undo.
        define variable oURI         as URI           no-undo.
        
        
        assign oClient = ClientBuilder:Build():Client
            oUri = new URI("http", "localhost", 8810)
            oUri:Path = this-object:baseServiceUrl + resource.

        oRequest = RequestBuilder:Put(oUri, payload):Request.

        oResponse = oClient:Execute(oRequest).

        if oResponse:StatusCode = 200 then // Request succeeded.
        do:
            if type-of(oResponse:Entity, JsonObject) then
            do:
                oJson = cast(oResponse:Entity, JsonObject). // use this with dataset
                // oJson:WriteFile("xxx.json").

            end.
            else do:
                undo, throw new AppError(substitute("Unknown response type. Content-Type: &1 Entity Class: &2",
                    oResponse:ContentType,
                    oResponse:Entity:GetClass():TypeName), 1).
            end.
        end. 
        else do: // Got an error status code
            undo, throw new AppError(substitute("Request failed. StatusCode: &1 StatusReason: &2",
                oResponse:StatusCode,
                oResponse:StatusReason), 2).
        end.

        /*        MESSAGE "Done"                    */
        /*            VIEW-AS ALERT-BOX INFORMATION.*/

        return oJson.

        catch e as Progress.Lang.Error :
            message e:GetMessage(1) e:CallStack
                view-as alert-box error title "HTTP Request Error".
        end catch.

        finally:
            delete object oClient   no-error.
            delete object oRequest  no-error.
            delete object oResponse no-error.
        end finally.
        
        
        
    end method.    
    
    //METHOD PUBLIC DataTable GetCustomers(OUTPUT DATASET dsCustomer):
    method public DataTable GetCustomers():
        define variable oJsonResponse as JsonObject    no-undo.
        define variable oDataTableConverter as TempTableToDataTableConverter no-undo.
        define variable oCustomersDataTable as DataTable no-undo.
        assign oDataTableConverter = new TempTableToDataTableConverter().
        
        assign oJsonResponse = this-object:GetResourceObject("Customer").
        dataset dsCustomer:read-json("JSONObject", oJsonResponse, "EMPTY").
        
        oCustomersDataTable = oDataTableConverter:GetCustomersDataTable(input DATASET dsCustomer by-reference).           

        return oCustomersDataTable.
        
    end method.
    
    method public DataRow GetCustomerWithId(id as integer):
        define variable oJsonResponse as JsonObject    no-undo.
        define variable oDataTableConverter as TempTableToDataTableConverter no-undo.
        define variable oCustomersDataTable as DataTable no-undo.
        assign oDataTableConverter = new TempTableToDataTableConverter().
        
        assign oJsonResponse = this-object:GetResourceObject("Customer?filter=CustNum=" + STRING(id)).
        dataset dsCustomer:read-json("JSONObject", oJsonResponse, "EMPTY").
        
        oCustomersDataTable = oDataTableConverter:GetCustomersDataTable(input DATASET dsCustomer by-reference).           
        
        if oCustomersDataTable:Rows:Count > 0 then do:
            return oCustomersDataTable:Rows[0].
        end. 
        
        return ?.
        
    end method.
    
    method public void SaveCustomer(dataRow as DataRowView):
        define variable vCustNum            as integer          no-undo.
        define variable oJsonResponse       as JsonObject       no-undo.
        define variable oJsonPayload        as JsonObject       no-undo.
        
        vCustNum = dataRow["CustNum"].
        
        assign oJsonResponse = this-object:GetResourceObject("Customer?filter=CustNum=" + STRING(vCustNum)).
        dataset dsCustomer:read-json("JSONObject", oJsonResponse, "EMPTY").
        
        for first ttCustomer where ttCustomer.CustNum = vCustNum:
            assign
                ttCustomer.Name = dataRow["Name"].
        end.
        
        /*        hDsCustomer = DATASET dsCustomer:HANDLE.           */
        /*                                                           */
        /*        hDsCustomer:WRITE-JSON("JSONObject", oJsonPayload).*/
        
        oJsonPayload = new JsonObject().
        oJsonPayload:Read(dataset dsCustomer:HANDLE).
        
        assign oJsonResponse = this-object:PutResourceObject("Customer", oJsonPayload).
        
    end method.

end class.