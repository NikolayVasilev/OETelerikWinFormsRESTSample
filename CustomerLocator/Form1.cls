 
/*------------------------------------------------------------------------
   File        : Form1
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : 
   Created     : 
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Telerik.WinControls.UI.*.
USING Telerik.WinControls.UI.RadButton FROM ASSEMBLY.
USING Telerik.WinControls.ThemeResolutionService FROM ASSEMBLY.
USING Service.ServiceClient FROM PROPATH.
USING Utils.TempTableToDataTableConverter FROM PROPATH.
USING System.Data.DataTable FROM ASSEMBLY.
USING ViewModels.CustomerWindowViewModel FROM PROPATH.
USING System.Data.DataRow FROM ASSEMBLY.
USING System.Drawing.ContentAlignment FROM ASSEMBLY.
USING System.Drawing.Color FROM ASSEMBLY.
USING System.Math FROM ASSEMBLY.
USING System.Double FROM ASSEMBLY.
USING StringGenerator.SampleStringGenerator FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Form1 INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE CustomerAddressMap AS Telerik.WinControls.UI.RadMap NO-UNDO.
    DEFINE PRIVATE VARIABLE CustomerPropertyGrid AS Telerik.WinControls.UI.RadPropertyGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE CustomersGridView AS Telerik.WinControls.UI.RadGridView NO-UNDO.
    DEFINE PRIVATE VARIABLE fluentDarkTheme1 AS Telerik.WinControls.Themes.FluentDarkTheme NO-UNDO.
    DEFINE PRIVATE VARIABLE getCustomersButton AS Telerik.WinControls.UI.RadButton NO-UNDO.
    DEFINE PRIVATE VARIABLE office2013DarkTheme1 AS Telerik.WinControls.Themes.Office2013DarkTheme NO-UNDO.
    DEFINE PRIVATE VARIABLE radButton1 AS Telerik.WinControls.UI.RadButton NO-UNDO.
    DEFINE PRIVATE VARIABLE radButton2 AS Telerik.WinControls.UI.RadButton NO-UNDO.
    DEFINE PRIVATE VARIABLE SaveButton AS Telerik.WinControls.UI.RadButton NO-UNDO.
    DEFINE PRIVATE VARIABLE textBox1 AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE VARIABLE oViewModel AS CustomerWindowViewModel NO-UNDO.
		
    CONSTRUCTOR PUBLIC Form1 (  ):

        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:Add(THIS-OBJECT:components).
        
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID CustomersGridView_SelectionChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
        IF THIS-OBJECT:CustomersGridView:SelectedRows:Count > 0 THEN DO:
            THIS-OBJECT:oViewModel:SelectedDataRow = DYNAMIC-CAST (THIS-OBJECT:CustomersGridView:CurrentRow:DataBoundItem, "System.Data.DataRowView").
        END.
        
        THIS-OBJECT:CustomerPropertyGrid:SelectedObject = THIS-OBJECT:oViewModel:SelectedDataRow.
        
        THIS-OBJECT:SetCustomerLocation().
		
        RETURN.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID Form1_Load( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        
        THIS-OBJECT:oViewModel = NEW CustomerWindowViewModel().
        
        THIS-OBJECT:PrepareGridView().
        THIS-OBJECT:PrepareMap().
        RETURN.

    END METHOD.

    METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableViewDefinition1 AS Telerik.WinControls.UI.TableViewDefinition NO-UNDO.
        tableViewDefinition1 = NEW Telerik.WinControls.UI.TableViewDefinition().
        THIS-OBJECT:textBox1 = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:getCustomersButton = NEW Telerik.WinControls.UI.RadButton().
        THIS-OBJECT:office2013DarkTheme1 = NEW Telerik.WinControls.Themes.Office2013DarkTheme().
        THIS-OBJECT:CustomersGridView = NEW Telerik.WinControls.UI.RadGridView().
        THIS-OBJECT:fluentDarkTheme1 = NEW Telerik.WinControls.Themes.FluentDarkTheme().
        THIS-OBJECT:CustomerAddressMap = NEW Telerik.WinControls.UI.RadMap().
        THIS-OBJECT:CustomerPropertyGrid = NEW Telerik.WinControls.UI.RadPropertyGrid().
        THIS-OBJECT:SaveButton = NEW Telerik.WinControls.UI.RadButton().
        THIS-OBJECT:radButton1 = NEW Telerik.WinControls.UI.RadButton().
        THIS-OBJECT:radButton2 = NEW Telerik.WinControls.UI.RadButton().
        CAST(THIS-OBJECT:getCustomersButton, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:CustomersGridView, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:CustomersGridView:MasterTemplate, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:CustomerAddressMap, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:CustomerPropertyGrid, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:SaveButton, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:radButton1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:radButton2, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* textBox1 */
        /*  */
        THIS-OBJECT:textBox1:Location = NEW System.Drawing.Point(12, 12).
        THIS-OBJECT:textBox1:Name = "textBox1".
        THIS-OBJECT:textBox1:Size = NEW System.Drawing.Size(100, 20).
        THIS-OBJECT:textBox1:TabIndex = 0.
        THIS-OBJECT:textBox1:TextChanged:Subscribe(THIS-OBJECT:textBox1_TextChanged).
        /*  */
        /* getCustomersButton */
        /*  */
        THIS-OBJECT:getCustomersButton:Location = NEW System.Drawing.Point(12, 50).
        THIS-OBJECT:getCustomersButton:Name = "getCustomersButton".
        THIS-OBJECT:getCustomersButton:Size = NEW System.Drawing.Size(100, 20).
        THIS-OBJECT:getCustomersButton:TabIndex = 1.
        THIS-OBJECT:getCustomersButton:Text = "GetCustomers".
        THIS-OBJECT:getCustomersButton:ThemeName = "FluentDark".
        THIS-OBJECT:getCustomersButton:Click:Subscribe(THIS-OBJECT:telerikButton1_Clicked).
        /*  */
        /* CustomersGridView */
        /*  */
        THIS-OBJECT:CustomersGridView:Location = NEW System.Drawing.Point(118, 12).
        /*  */
        /*  */
        /*  */
        THIS-OBJECT:CustomersGridView:MasterTemplate:AutoGenerateColumns = FALSE.
        THIS-OBJECT:CustomersGridView:MasterTemplate:ViewDefinition = tableViewDefinition1.
        THIS-OBJECT:CustomersGridView:Name = "CustomersGridView".
        THIS-OBJECT:CustomersGridView:ReadOnly = TRUE.
        THIS-OBJECT:CustomersGridView:Size = NEW System.Drawing.Size(1028, 325).
        THIS-OBJECT:CustomersGridView:TabIndex = 2.
        THIS-OBJECT:CustomersGridView:ThemeName = "FluentDark".
        THIS-OBJECT:CustomersGridView:SelectionChanged:Subscribe(THIS-OBJECT:CustomersGridView_SelectionChanged).
        /*  */
        /* CustomerAddressMap */
        /*  */
        THIS-OBJECT:CustomerAddressMap:EnableTheming = FALSE.
        THIS-OBJECT:CustomerAddressMap:Location = NEW System.Drawing.Point(485, 343).
        THIS-OBJECT:CustomerAddressMap:Name = "CustomerAddressMap".
        THIS-OBJECT:CustomerAddressMap:Size = NEW System.Drawing.Size(661, 353).
        THIS-OBJECT:CustomerAddressMap:TabIndex = 4.
        THIS-OBJECT:CustomerAddressMap:ThemeName = "FluentDark".
        CAST(THIS-OBJECT:CustomerAddressMap:GetChildAt(0):GetChildAt(4), Telerik.WinControls.UI.MiniMapElement):Visibility = Telerik.WinControls.ElementVisibility:Collapsed.
        /*  */
        /* CustomerPropertyGrid */
        /*  */
        THIS-OBJECT:CustomerPropertyGrid:HelpVisible = FALSE.
        THIS-OBJECT:CustomerPropertyGrid:ItemHeight = 28.
        THIS-OBJECT:CustomerPropertyGrid:ItemIndent = 28.
        THIS-OBJECT:CustomerPropertyGrid:Location = NEW System.Drawing.Point(118, 344).
        THIS-OBJECT:CustomerPropertyGrid:Name = "CustomerPropertyGrid".
        THIS-OBJECT:CustomerPropertyGrid:Size = NEW System.Drawing.Size(361, 313).
        THIS-OBJECT:CustomerPropertyGrid:TabIndex = 5.
        THIS-OBJECT:CustomerPropertyGrid:ThemeName = "FluentDark".
        /*  */
        /* SaveButton */
        /*  */
        THIS-OBJECT:SaveButton:Location = NEW System.Drawing.Point(118, 664).
        THIS-OBJECT:SaveButton:Name = "SaveButton".
        THIS-OBJECT:SaveButton:Size = NEW System.Drawing.Size(361, 32).
        THIS-OBJECT:SaveButton:TabIndex = 6.
        THIS-OBJECT:SaveButton:Text = "Save Customer".
        THIS-OBJECT:SaveButton:ThemeName = "FluentDark".
        THIS-OBJECT:SaveButton:Click:Subscribe(THIS-OBJECT:SaveButton_Click).
        /*  */
        /* radButton1 */
        /*  */
        THIS-OBJECT:radButton1:Location = NEW System.Drawing.Point(13, 77).
        THIS-OBJECT:radButton1:Name = "radButton1".
        THIS-OBJECT:radButton1:Size = NEW System.Drawing.Size(99, 24).
        THIS-OBJECT:radButton1:TabIndex = 7.
        THIS-OBJECT:radButton1:Text = "CheckReferences".
        THIS-OBJECT:radButton1:ThemeName = "FluentDark".
        THIS-OBJECT:radButton1:Click:Subscribe(THIS-OBJECT:radButton1_Click).
        /*  */
        /* radButton2 */
        /*  */
        THIS-OBJECT:radButton2:Location = NEW System.Drawing.Point(13, 107).
        THIS-OBJECT:radButton2:Name = "radButton2".
        THIS-OBJECT:radButton2:Size = NEW System.Drawing.Size(99, 24).
        THIS-OBJECT:radButton2:TabIndex = 8.
        THIS-OBJECT:radButton2:Text = "radButton2".
        THIS-OBJECT:radButton2:ThemeName = "FluentDark".
        /*  */
        /* Form1 */
        /*  */
        THIS-OBJECT:BackColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(1158, 708).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:radButton2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:radButton1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:SaveButton).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:CustomerPropertyGrid).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:CustomerAddressMap).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:CustomersGridView).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:textBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:getCustomersButton).
        THIS-OBJECT:Name = "Form1".
        THIS-OBJECT:Text = "CustomerLocator".
        THIS-OBJECT:Load:Subscribe(THIS-OBJECT:Form1_Load).
        CAST(THIS-OBJECT:getCustomersButton, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:CustomersGridView:MasterTemplate, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:CustomersGridView, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:CustomerAddressMap, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:CustomerPropertyGrid, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:SaveButton, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:radButton1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:radButton2, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.
    
    METHOD PRIVATE VOID PrepareGridView():
        THIS-OBJECT:oViewModel:RefreshCustomers().
        THIS-OBJECT:CreateColumns().
        
        THIS-OBJECT:CustomersGridView:DataSource = THIS-OBJECT:oViewModel:CustomersDataTable.
        THIS-OBJECT:CustomersGridView:AutoSizeColumnsMode = GridViewAutoSizeColumnsMode:Fill.
    END.

    METHOD PRIVATE VOID CreateColumns():
        DEFINE VARIABLE textBoxColumn AS GridViewTextBoxColumn NO-UNDO.
        
        ASSIGN
            textBoxColumn = NEW GridViewTextBoxColumn()
            textBoxColumn:Name = "CustNumColumn"
            textBoxColumn:HeaderText = "CustNum"
            textBoxColumn:FieldName = "CustNum"
            textBoxColumn:MaxLength = 50
            textBoxColumn:Width = 50.
        THIS-OBJECT:CustomersGridView:MasterTemplate:Columns:Add(textBoxColumn).
        
        ASSIGN
            textBoxColumn = NEW GridViewTextBoxColumn()
            textBoxColumn:Name = "NameColumn"
            textBoxColumn:HeaderText = "Name"
            textBoxColumn:FieldName = "Name"
            textBoxColumn:MaxLength = 50
            textBoxColumn:Width = 150.
        THIS-OBJECT:CustomersGridView:MasterTemplate:Columns:Add(textBoxColumn).
        
        ASSIGN
            textBoxColumn = NEW GridViewTextBoxColumn()
            textBoxColumn:Name = "CountryColumn"
            textBoxColumn:HeaderText = "Country"
            textBoxColumn:FieldName = "Country"
            textBoxColumn:MaxLength = 50
            textBoxColumn:Width = 150.
        THIS-OBJECT:CustomersGridView:MasterTemplate:Columns:Add(textBoxColumn).
        
        ASSIGN
            textBoxColumn = NEW GridViewTextBoxColumn()
            textBoxColumn:Name = "CityColumn"
            textBoxColumn:HeaderText = "City"
            textBoxColumn:FieldName = "City"
            textBoxColumn:MaxLength = 50
            textBoxColumn:Width = 150.
        THIS-OBJECT:CustomersGridView:MasterTemplate:Columns:Add(textBoxColumn).
    END.
    
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID radButton1_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        DEFINE VARIABLE oStringGenerator AS SampleStringGenerator NO-UNDO.
        
        oStringGenerator = NEW SampleStringGenerator().
        
        MESSAGE oStringGenerator:GetSome()
            VIEW-AS ALERT-BOX.
        RETURN.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID SaveButton_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        THIS-OBJECT:oViewModel:SaveSelectedCustomer().
        RETURN.

    END METHOD.

    METHOD PRIVATE VOID SetCustomerLocation():
        DEFINE VARIABLE mapRequest AS Telerik.WinControls.UI.Map.Bing.SearchRequest NO-UNDO.
        DEFINE VARIABLE bingProvider AS BingRestMapProvider NO-UNDO.
        
        IF THIS-OBJECT:CustomerAddressMap:Providers:Count > 0 THEN DO:
            mapRequest = NEW Telerik.WinControls.UI.Map.Bing.SearchRequest().
            mapRequest:Query = THIS-OBJECT:oViewModel:CustomerAddress.
            mapRequest:SearchOptions:Count = 10.
            mapRequest:SearchOptions:QueryParse = TRUE.
            bingProvider = DYNAMIC-CAST(THIS-OBJECT:CustomerAddressMap:Providers[0], "Telerik.WinControls.UI.BingRestMapProvider").
            bingProvider:SearchAsync(mapRequest).
        END.
    END.
    
    METHOD PRIVATE VOID PrepareMap():
        DEFINE VARIABLE pinsLayer AS Telerik.WinControls.UI.MapLayer NO-UNDO.
        DEFINE VARIABLE bingProvider AS BingRestMapProvider NO-UNDO.
        DEFINE VARIABLE cacheFolder AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cache AS LocalFileCacheProvider NO-UNDO.
        
        cacheFolder = "cache".
        bingProvider = NEW Telerik.WinControls.UI.BingRestMapProvider().
        bingProvider:UseSession = TRUE.
        
        // INSERT YOUR BING MAPS KEY HERE
        bingProvider:BingKey = "REPLACE_THIS_WITH_YOUR_BING_MAPS_KEY".
        
        
        cache = NEW LocalFileCacheProvider(cacheFolder).
        bingProvider:CacheProvider = cache.
        THIS-OBJECT:CustomerAddressMap:Providers:Add(bingProvider).
        
        THIS-OBJECT:CustomerAddressMap:ShowSearchBar = TRUE.
        pinsLayer = NEW MapLayer("Pins").
        THIS-OBJECT:CustomerAddressMap:Layers:Add(pinsLayer).
        THIS-OBJECT:CustomerAddressMap:MapElement:SearchBarElement:SearchProvider = bingProvider.
    
        THIS-OBJECT:CustomerAddressMap:MapElement:SearchBarElement:SearchProvider:SearchCompleted:Subscribe(THIS-OBJECT:BingProviderSearchCompleted).
        THIS-OBJECT:CustomerAddressMap:MapElement:SearchBarElement:SearchProvider:SearchError:Subscribe(BingProviderSearchError).        
    END.
    
    METHOD PRIVATE VOID BingProviderSearchError( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        
        DEFINE VARIABLE eventArgs AS SearchErrorEventArgs NO-UNDO.
        
        eventArgs = DYNAMIC-CAST (e, "Telerik.WinControls.UI.SearchErrorEventArgs").
        
        MESSAGE eventArgs:Error:Message
            VIEW-AS ALERT-BOX.
        RETURN.

    END METHOD.
    
    
    METHOD PRIVATE VOID BingProviderSearchCompleted( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        
        DEFINE VARIABLE eventArgs AS SearchCompletedEventArgs NO-UNDO.
        DEFINE VARIABLE allPoints AS Telerik.WinControls.UI.Map.RectangleG NO-UNDO.        
        DEFINE VARIABLE locationIndex AS INTEGER NO-UNDO.
        DEFINE VARIABLE location AS Telerik.WinControls.UI.Map.Bing.Location NO-UNDO.  
        DEFINE VARIABLE point AS Telerik.WinControls.UI.Map.PointG NO-UNDO. 
        DEFINE VARIABLE pin AS MapPin NO-UNDO.
        
        eventArgs = DYNAMIC-CAST (e, "Telerik.WinControls.UI.SearchCompletedEventArgs").
        
        allPoints = NEW Telerik.WinControls.UI.Map.RectangleG(-200000, 200000, 200000, -200000).
        THIS-OBJECT:CustomerAddressMap:Layers["Pins"]:Clear().
        
        locationIndex = 0.
        
        DO locationIndex = 1 TO eventArgs:Locations:Length:
            location = DYNAMIC-CAST(eventArgs:Locations:GetValue(locationIndex - 1), "Telerik.WinControls.UI.Map.Bing.Location").
            
            point = NEW Telerik.WinControls.UI.Map.PointG(
                DYNAMIC-CAST (location:Point:Coordinates:GETVALUE(0), "System.Double"), 
                DYNAMIC-CAST (location:Point:Coordinates:GETVALUE(1), "System.Double")
                ).

            pin = NEW MapPin(point).
            pin:Size = NEW System.Drawing.Size(20, 40).
            pin:BackColor = Color:Red.
            pin:ToolTipText = location:Address:FormattedAddress.
            THIS-OBJECT:CustomerAddressMap:MapElement:Layers["Pins"]:Add(pin).
            allPoints:North = Math:Max(allPoints:North, point:Latitude).
            allPoints:South = Math:Min(allPoints:South, point:Latitude).
            allPoints:West = Math:Min(allPoints:West, point:Longitude).
            allPoints:East = Math:Max(allPoints:East, point:Longitude).
        END.
        
        
        IF (eventArgs:Locations:Length > 0) THEN DO:
        
            IF (eventArgs:Locations:Length = 1) THEN DO:
            
                location = DYNAMIC-CAST(eventArgs:Locations:GetValue(0), "Telerik.WinControls.UI.Map.Bing.Location").
                
                THIS-OBJECT:CustomerAddressMap:BringIntoView(NEW Telerik.WinControls.UI.Map.PointG(
                    DYNAMIC-CAST(location:Point:Coordinates:GETVALUE(0), "System.Double"), 
                    DYNAMIC-CAST(location:Point:Coordinates:GETVALUE(1), "System.Double"))
                    ).
            END.
            ELSE DO:           
                THIS-OBJECT:CustomerAddressMap:MapElement:BringIntoView(allPoints).
                THIS-OBJECT:CustomerAddressMap:Zoom(THIS-OBJECT:CustomerAddressMap:MapElement:ZoomLevel - 1).
            END.
        END.
        ELSE DO:
        
            MESSAGE "No result found for the provided search query!"
                VIEW-AS ALERT-BOX.
        END.



        RETURN.

    END METHOD.
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID textBox1_TextChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
        RETURN.

    END METHOD.

    METHOD PRIVATE VOID telerikButton1_Clicked( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):        
        
        THIS-OBJECT:oViewModel:RefreshCustomers().
        THIS-OBJECT:CustomersGridView:DataSource = THIS-OBJECT:oViewModel:CustomersDataTable.

        RETURN.
    END METHOD.

    DESTRUCTOR PUBLIC Form1 ( ):

    END DESTRUCTOR.

END CLASS.