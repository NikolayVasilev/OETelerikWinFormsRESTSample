 
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
USING StringGenerator.SampleStringGenerator FROM ASSEMBLY.
USING System.Drawing.ContentAlignment FROM ASSEMBLY.
USING System.Drawing.Color FROM ASSEMBLY.
USING System.Math FROM ASSEMBLY.
USING System.Double FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Form1 INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE CustomerPropertyGrid AS Telerik.WinControls.UI.RadPropertyGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE CustomerAddressMap AS Telerik.WinControls.UI.RadMap NO-UNDO.
    DEFINE PRIVATE VARIABLE CustomersGridView AS Telerik.WinControls.UI.RadGridView NO-UNDO.
    DEFINE PRIVATE VARIABLE fluentDarkTheme1 AS Telerik.WinControls.Themes.FluentDarkTheme NO-UNDO.
    DEFINE PRIVATE VARIABLE office2013DarkTheme1 AS Telerik.WinControls.Themes.Office2013DarkTheme NO-UNDO.
    DEFINE PRIVATE VARIABLE textBox1 AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE telerikButton1 AS RadButton NO-UNDO.
    DEFINE VARIABLE oViewModel AS CustomerWindowViewModel NO-UNDO.
		
    CONSTRUCTOR PUBLIC Form1 (  ):

        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:Add(THIS-OBJECT:components).
        
        THIS-OBJECT:oViewModel = NEW CustomerWindowViewModel().
        
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
		
        RETURN.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID Form1_Load( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
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
        THIS-OBJECT:telerikButton1 = NEW Telerik.WinControls.UI.RadButton().
        THIS-OBJECT:office2013DarkTheme1 = NEW Telerik.WinControls.Themes.Office2013DarkTheme().
        THIS-OBJECT:CustomersGridView = NEW Telerik.WinControls.UI.RadGridView().
        THIS-OBJECT:fluentDarkTheme1 = NEW Telerik.WinControls.Themes.FluentDarkTheme().
        THIS-OBJECT:CustomerPropertyGrid = NEW Telerik.WinControls.UI.RadPropertyGrid().
        THIS-OBJECT:CustomerAddressMap = NEW Telerik.WinControls.UI.RadMap().
        CAST(THIS-OBJECT:telerikButton1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:CustomersGridView, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:CustomersGridView:MasterTemplate, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:CustomerPropertyGrid, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:CustomerAddressMap, System.ComponentModel.ISupportInitialize):BeginInit().
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
        /* telerikButton1 */
        /*  */
        THIS-OBJECT:telerikButton1:Location = NEW System.Drawing.Point(12, 50).
        THIS-OBJECT:telerikButton1:Name = "telerikButton1".
        THIS-OBJECT:telerikButton1:Size = NEW System.Drawing.Size(100, 20).
        THIS-OBJECT:telerikButton1:TabIndex = 1.
        THIS-OBJECT:telerikButton1:Text = "GetCustomers".
        THIS-OBJECT:telerikButton1:ThemeName = "FluentDark".
        THIS-OBJECT:telerikButton1:Click:Subscribe(THIS-OBJECT:telerikButton1_Clicked).
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
        THIS-OBJECT:CustomersGridView:Size = NEW System.Drawing.Size(747, 325).
        THIS-OBJECT:CustomersGridView:TabIndex = 2.
        THIS-OBJECT:CustomersGridView:ThemeName = "FluentDark".
        THIS-OBJECT:CustomersGridView:SelectionChanged:Subscribe(THIS-OBJECT:CustomersGridView_SelectionChanged).
        /*  */
        /* CustomerPropertyGrid */
        /*  */
        THIS-OBJECT:CustomerPropertyGrid:EnableCustomGrouping = TRUE.
        THIS-OBJECT:CustomerPropertyGrid:HelpVisible = FALSE.
        THIS-OBJECT:CustomerPropertyGrid:ItemHeight = 28.
        THIS-OBJECT:CustomerPropertyGrid:ItemIndent = 28.
        THIS-OBJECT:CustomerPropertyGrid:Location = NEW System.Drawing.Point(118, 343).
        THIS-OBJECT:CustomerPropertyGrid:Name = "CustomerPropertyGrid".
        THIS-OBJECT:CustomerPropertyGrid:ReadOnly = TRUE.
        THIS-OBJECT:CustomerPropertyGrid:Size = NEW System.Drawing.Size(361, 231).
        THIS-OBJECT:CustomerPropertyGrid:TabIndex = 3.
        THIS-OBJECT:CustomerPropertyGrid:ThemeName = "FluentDark".
        /*  */
        /* CustomerAddressMap */
        /*  */
        THIS-OBJECT:CustomerAddressMap:EnableTheming = FALSE.
        THIS-OBJECT:CustomerAddressMap:Location = NEW System.Drawing.Point(485, 343).
        THIS-OBJECT:CustomerAddressMap:Name = "CustomerAddressMap".
        THIS-OBJECT:CustomerAddressMap:Size = NEW System.Drawing.Size(380, 231).
        THIS-OBJECT:CustomerAddressMap:TabIndex = 4.
        THIS-OBJECT:CustomerAddressMap:ThemeName = "FluentDark".
        /*  */
        /* Form1 */
        /*  */
        THIS-OBJECT:BackColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(877, 586).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:CustomerAddressMap).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:CustomerPropertyGrid).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:CustomersGridView).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:textBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:telerikButton1).
        THIS-OBJECT:Name = "Form1".
        THIS-OBJECT:Text = "CustomerLocator".
        THIS-OBJECT:Load:Subscribe(THIS-OBJECT:Form1_Load).
        CAST(THIS-OBJECT:telerikButton1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:CustomersGridView:MasterTemplate, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:CustomersGridView, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:CustomerPropertyGrid, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:CustomerAddressMap, System.ComponentModel.ISupportInitialize):EndInit().
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
    
    METHOD PRIVATE VOID PrepareMap():
        DEFINE VARIABLE pinsLayer AS Telerik.WinControls.UI.MapLayer NO-UNDO.
        DEFINE VARIABLE bingProvider AS BingRestMapProvider NO-UNDO.
        DEFINE VARIABLE cacheFolder AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cache AS LocalFileCacheProvider NO-UNDO.
        
        cacheFolder = "cache".
        bingProvider = NEW Telerik.WinControls.UI.BingRestMapProvider().
        bingProvider:UseSession = TRUE.
        bingProvider:BingKey = "Audxd9rehcmI76cwkNYHhCNgkbQxsCmccC0-M4f6oc66VQOxMLhZluCSwi10PSp_".
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
        

        allPoints = NEW Telerik.WinControls.UI.Map.RectangleG(Double:MinValue, Double:MaxValue, Double:MaxValue, Double:MinValue).
        THIS-OBJECT:CustomerAddressMap:Layers["Pins"]:Clear().
        
        locationIndex = 0.
        
        DO locationIndex = 0 TO eventArgs:Locations:Length - 1:
            location = DYNAMIC-CAST(eventArgs:Locations:GetValue(locationIndex), "Telerik.WinControls.UI.Map.Bing.Location").
            
            location:Point:Coordinates.
/*            point = NEW Telerik.WinControls.UI.Map.PointG(location:Point:Coordinates[0], location:Point:Coordinates[1]).*/
            
            point = NEW Telerik.WinControls.UI.Map.PointG(0,0).
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
        
            if (eventArgs:Locations:Length = 1) THEN DO:
            
                //THIS-OBJECT:CustomerAddressMap:BringIntoView(new Telerik.WinControls.UI.Map.PointG(eventArgs:Locations[0]:Point:Coordinates[0], eventArgs:Locations[0]:Point:Coordinates[1])).
            END.
            else do:           
                THIS-OBJECT:CustomerAddressMap:MapElement:BringIntoView(allPoints).
                THIS-OBJECT:CustomerAddressMap:Zoom(THIS-OBJECT:CustomerAddressMap:MapElement:ZoomLevel - 1).
            end.
        END.
        else do:
        
            MESSAGE "No result found for the provided search query!"
            VIEW-AS ALERT-BOX.
        end.



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
        

        

        /*        MESSAGE "Number of row in the data table:" oCustomersDataTable:Rows:Count*/
        /*            VIEW-AS ALERT-BOX INFORMATION.                                       */
        
        RETURN.
    END METHOD.

    DESTRUCTOR PUBLIC Form1 ( ):

    END DESTRUCTOR.

END CLASS.