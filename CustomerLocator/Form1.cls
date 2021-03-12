 
/*------------------------------------------------------------------------
   File        : Form1
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : 
   Created     : 
   Notes       : 
 ----------------------------------------------------------------------*/

using Progress.Lang.*.
using Progress.Windows.Form.
using Telerik.WinControls.UI.*.
using Telerik.WinControls.UI.RadButton from assembly.
using Telerik.WinControls.ThemeResolutionService from assembly.
using Service.ServiceClient from propath.
using Utils.TempTableToDataTableConverter from propath.
using System.Data.DataTable from assembly.
using ViewModels.CustomerWindowViewModel from propath.
using System.Data.DataRow from assembly.
using System.Drawing.ContentAlignment from assembly.
using System.Drawing.Color from assembly.
using System.Math from assembly.
using System.Double from assembly.
using StringGenerator.SampleStringGenerator from assembly.

block-level on error undo, throw.

class Form1 inherits Form: 
	
    define private variable bindingSource1 as Progress.Data.BindingSource no-undo.
    define private variable components as System.ComponentModel.IContainer no-undo.
    define private variable CustomerAddressMap as Telerik.WinControls.UI.RadMap no-undo.
    define private variable CustomerPropertyGrid as Telerik.WinControls.UI.RadPropertyGrid no-undo.
    define private variable CustomersGridView as Telerik.WinControls.UI.RadGridView no-undo.
    define private variable fluentDarkTheme1 as Telerik.WinControls.Themes.FluentDarkTheme no-undo.
    define private variable getCustomersButton as Telerik.WinControls.UI.RadButton no-undo.
    define private variable office2013DarkTheme1 as Telerik.WinControls.Themes.Office2013DarkTheme no-undo.
    define private variable radButton1 as Telerik.WinControls.UI.RadButton no-undo.
    define private variable SaveButton as Telerik.WinControls.UI.RadButton no-undo.
    define private variable textBox1 as System.Windows.Forms.TextBox no-undo.
    define variable oViewModel as CustomerWindowViewModel no-undo.
		
    constructor public Form1 (  ):

        InitializeComponent().
        this-object:ComponentsCollection:Add(this-object:components).
        
        catch e as Progress.Lang.Error:
            undo, throw e.
        end catch.

    end constructor.

    /*------------------------------------------------------------------------------
     Purpose: Sync Selected Item with ViewModel
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    method private void CustomersGridView_SelectionChanged( input sender as System.Object, input e as System.EventArgs ):
		
        if this-object:CustomersGridView:SelectedRows:Count > 0 then do:
            this-object:oViewModel:SelectedDataRow = dynamic-cast (this-object:CustomersGridView:CurrentRow:DataBoundItem, "System.Data.DataRowView").
        end.
        
        this-object:CustomerPropertyGrid:SelectedObject = this-object:oViewModel:SelectedDataRow.
        
        this-object:SetCustomerLocation().
		
        return.

    end method.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    method private void Form1_Load( input sender as System.Object, input e as System.EventArgs ):
        
        this-object:oViewModel = new CustomerWindowViewModel().
        
        this-object:PrepareGridView().
        this-object:PrepareMap().
        return.

    end method.

    method private void InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        this-object:components = new System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        define variable tableViewDefinition3 as Telerik.WinControls.UI.TableViewDefinition no-undo.
        tableViewDefinition3 = new Telerik.WinControls.UI.TableViewDefinition().
        this-object:textBox1 = new System.Windows.Forms.TextBox().
        this-object:getCustomersButton = new Telerik.WinControls.UI.RadButton().
        this-object:office2013DarkTheme1 = new Telerik.WinControls.Themes.Office2013DarkTheme().
        this-object:CustomersGridView = new Telerik.WinControls.UI.RadGridView().
        this-object:fluentDarkTheme1 = new Telerik.WinControls.Themes.FluentDarkTheme().
        this-object:CustomerAddressMap = new Telerik.WinControls.UI.RadMap().
        this-object:CustomerPropertyGrid = new Telerik.WinControls.UI.RadPropertyGrid().
        this-object:SaveButton = new Telerik.WinControls.UI.RadButton().
        this-object:radButton1 = new Telerik.WinControls.UI.RadButton().
        this-object:bindingSource1 = new Progress.Data.BindingSource(this-object:components).
        cast(this-object:getCustomersButton, System.ComponentModel.ISupportInitialize):BeginInit().
        cast(this-object:CustomersGridView, System.ComponentModel.ISupportInitialize):BeginInit().
        cast(this-object:CustomersGridView:MasterTemplate, System.ComponentModel.ISupportInitialize):BeginInit().
        cast(this-object:CustomerAddressMap, System.ComponentModel.ISupportInitialize):BeginInit().
        cast(this-object:CustomerPropertyGrid, System.ComponentModel.ISupportInitialize):BeginInit().
        cast(this-object:SaveButton, System.ComponentModel.ISupportInitialize):BeginInit().
        cast(this-object:radButton1, System.ComponentModel.ISupportInitialize):BeginInit().
        cast(this-object:bindingSource1, System.ComponentModel.ISupportInitialize):BeginInit().
        this-object:SuspendLayout().
        /*  */
        /* textBox1 */
        /*  */
        this-object:textBox1:Location = new System.Drawing.Point(12, 12).
        this-object:textBox1:Name = "textBox1".
        this-object:textBox1:Size = new System.Drawing.Size(100, 20).
        this-object:textBox1:TabIndex = 0.
        this-object:textBox1:TextChanged:Subscribe(this-object:textBox1_TextChanged).
        /*  */
        /* getCustomersButton */
        /*  */
        this-object:getCustomersButton:Location = new System.Drawing.Point(12, 50).
        this-object:getCustomersButton:Name = "getCustomersButton".
        this-object:getCustomersButton:Size = new System.Drawing.Size(100, 20).
        this-object:getCustomersButton:TabIndex = 1.
        this-object:getCustomersButton:Text = "GetCustomers".
        this-object:getCustomersButton:ThemeName = "FluentDark".
        this-object:getCustomersButton:Click:Subscribe(this-object:telerikButton1_Clicked).
        /*  */
        /* CustomersGridView */
        /*  */
        this-object:CustomersGridView:Location = new System.Drawing.Point(118, 12).
        /*  */
        /*  */
        /*  */
        this-object:CustomersGridView:MasterTemplate:AutoGenerateColumns = false.
        this-object:CustomersGridView:MasterTemplate:ViewDefinition = tableViewDefinition3.
        this-object:CustomersGridView:Name = "CustomersGridView".
        this-object:CustomersGridView:ReadOnly = true.
        this-object:CustomersGridView:Size = new System.Drawing.Size(1028, 325).
        this-object:CustomersGridView:TabIndex = 2.
        this-object:CustomersGridView:ThemeName = "FluentDark".
        this-object:CustomersGridView:SelectionChanged:Subscribe(this-object:CustomersGridView_SelectionChanged).
        /*  */
        /* CustomerAddressMap */
        /*  */
        this-object:CustomerAddressMap:EnableTheming = false.
        this-object:CustomerAddressMap:Location = new System.Drawing.Point(485, 343).
        this-object:CustomerAddressMap:Name = "CustomerAddressMap".
        this-object:CustomerAddressMap:Size = new System.Drawing.Size(661, 353).
        this-object:CustomerAddressMap:TabIndex = 4.
        this-object:CustomerAddressMap:ThemeName = "FluentDark".
        cast(this-object:CustomerAddressMap:GetChildAt(0):GetChildAt(4), Telerik.WinControls.UI.MiniMapElement):Visibility = Telerik.WinControls.ElementVisibility:Collapsed.
        /*  */
        /* CustomerPropertyGrid */
        /*  */
        this-object:CustomerPropertyGrid:HelpVisible = false.
        this-object:CustomerPropertyGrid:ItemHeight = 28.
        this-object:CustomerPropertyGrid:ItemIndent = 28.
        this-object:CustomerPropertyGrid:Location = new System.Drawing.Point(118, 344).
        this-object:CustomerPropertyGrid:Name = "CustomerPropertyGrid".
        this-object:CustomerPropertyGrid:Size = new System.Drawing.Size(361, 313).
        this-object:CustomerPropertyGrid:TabIndex = 5.
        this-object:CustomerPropertyGrid:ThemeName = "FluentDark".
        /*  */
        /* SaveButton */
        /*  */
        this-object:SaveButton:Location = new System.Drawing.Point(118, 664).
        this-object:SaveButton:Name = "SaveButton".
        this-object:SaveButton:Size = new System.Drawing.Size(361, 32).
        this-object:SaveButton:TabIndex = 6.
        this-object:SaveButton:Text = "Save Customer".
        this-object:SaveButton:ThemeName = "FluentDark".
        this-object:SaveButton:Click:Subscribe(this-object:SaveButton_Click).
        /*  */
        /* radButton1 */
        /*  */
        this-object:radButton1:Location = new System.Drawing.Point(13, 77).
        this-object:radButton1:Name = "radButton1".
        this-object:radButton1:Size = new System.Drawing.Size(99, 24).
        this-object:radButton1:TabIndex = 7.
        this-object:radButton1:Text = "CheckReferences".
        this-object:radButton1:ThemeName = "FluentDark".
        this-object:radButton1:Click:Subscribe(this-object:radButton1_Click).
        /*  */
        /* bindingSource1 */
        /*  */
        this-object:bindingSource1:MaxDataGuess = 0.
        this-object:bindingSource1:NoLOBs = false.
        this-object:bindingSource1:TableSchema = ?.
        /*  */
        /* Form1 */
        /*  */
        this-object:BackColor = System.Drawing.Color:DimGray.
        this-object:ClientSize = new System.Drawing.Size(1158, 708).
        this-object:Controls:Add(this-object:radButton1).
        this-object:Controls:Add(this-object:SaveButton).
        this-object:Controls:Add(this-object:CustomerPropertyGrid).
        this-object:Controls:Add(this-object:CustomerAddressMap).
        this-object:Controls:Add(this-object:CustomersGridView).
        this-object:Controls:Add(this-object:textBox1).
        this-object:Controls:Add(this-object:getCustomersButton).
        this-object:Name = "Form1".
        this-object:Text = "CustomerLocator".
        this-object:Load:Subscribe(this-object:Form1_Load).
        cast(this-object:getCustomersButton, System.ComponentModel.ISupportInitialize):EndInit().
        cast(this-object:CustomersGridView:MasterTemplate, System.ComponentModel.ISupportInitialize):EndInit().
        cast(this-object:CustomersGridView, System.ComponentModel.ISupportInitialize):EndInit().
        cast(this-object:CustomerAddressMap, System.ComponentModel.ISupportInitialize):EndInit().
        cast(this-object:CustomerPropertyGrid, System.ComponentModel.ISupportInitialize):EndInit().
        cast(this-object:SaveButton, System.ComponentModel.ISupportInitialize):EndInit().
        cast(this-object:radButton1, System.ComponentModel.ISupportInitialize):EndInit().
        cast(this-object:bindingSource1, System.ComponentModel.ISupportInitialize):EndInit().
        this-object:ResumeLayout(false).
        this-object:PerformLayout().
        catch e as Progress.Lang.Error:
            undo, throw e.
        end catch.
    end method.

    
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    method private void radButton1_Click( input sender as System.Object, input e as System.EventArgs ):
        define variable oStringGenerator as SampleStringGenerator no-undo.
        
        oStringGenerator = new SampleStringGenerator().
        
        
        message oStringGenerator:GetSome()
            view-as alert-box.
        return.

    end method.


    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    method private void SaveButton_Click( input sender as System.Object, input e as System.EventArgs ):
        this-object:oViewModel:SaveSelectedCustomer().
        return.

    end method.
    
    method private void PrepareGridView():
        this-object:oViewModel:RefreshCustomers().
        this-object:CreateColumns().
        
        this-object:CustomersGridView:DataSource = this-object:oViewModel:CustomersDataTable.
        this-object:CustomersGridView:AutoSizeColumnsMode = GridViewAutoSizeColumnsMode:Fill.
    end.
    
    method private void CreateColumns():
        define variable textBoxColumn as GridViewTextBoxColumn no-undo.
        
        assign
            textBoxColumn = new GridViewTextBoxColumn()
            textBoxColumn:Name = "CustNumColumn"
            textBoxColumn:HeaderText = "CustNum"
            textBoxColumn:FieldName = "CustNum"
            textBoxColumn:MaxLength = 50
            textBoxColumn:Width = 50.
        this-object:CustomersGridView:MasterTemplate:Columns:Add(textBoxColumn).
        
        assign
            textBoxColumn = new GridViewTextBoxColumn()
            textBoxColumn:Name = "NameColumn"
            textBoxColumn:HeaderText = "Name"
            textBoxColumn:FieldName = "Name"
            textBoxColumn:MaxLength = 50
            textBoxColumn:Width = 150.
        this-object:CustomersGridView:MasterTemplate:Columns:Add(textBoxColumn).
        
        assign
            textBoxColumn = new GridViewTextBoxColumn()
            textBoxColumn:Name = "CountryColumn"
            textBoxColumn:HeaderText = "Country"
            textBoxColumn:FieldName = "Country"
            textBoxColumn:MaxLength = 50
            textBoxColumn:Width = 150.
        this-object:CustomersGridView:MasterTemplate:Columns:Add(textBoxColumn).
        
        assign
            textBoxColumn = new GridViewTextBoxColumn()
            textBoxColumn:Name = "CityColumn"
            textBoxColumn:HeaderText = "City"
            textBoxColumn:FieldName = "City"
            textBoxColumn:MaxLength = 50
            textBoxColumn:Width = 150.
        this-object:CustomersGridView:MasterTemplate:Columns:Add(textBoxColumn).
    end.

    method private void SetCustomerLocation():
        define variable mapRequest as Telerik.WinControls.UI.Map.Bing.SearchRequest no-undo.
        define variable bingProvider as BingRestMapProvider no-undo.
        
        if this-object:CustomerAddressMap:Providers:Count > 0 then do:
            mapRequest = new Telerik.WinControls.UI.Map.Bing.SearchRequest().
            mapRequest:Query = this-object:oViewModel:CustomerAddress.
            mapRequest:SearchOptions:Count = 10.
            mapRequest:SearchOptions:QueryParse = true.
            bingProvider = dynamic-cast(this-object:CustomerAddressMap:Providers[0], "Telerik.WinControls.UI.BingRestMapProvider").
            bingProvider:SearchAsync(mapRequest).
        end.
    end.
    
    method private void PrepareMap():
        define variable pinsLayer as Telerik.WinControls.UI.MapLayer no-undo.
        define variable bingProvider as BingRestMapProvider no-undo.
        define variable cacheFolder as character no-undo.
        define variable cache as LocalFileCacheProvider no-undo.
        
        cacheFolder = "cache".
        bingProvider = new Telerik.WinControls.UI.BingRestMapProvider().
        bingProvider:UseSession = true.
        
        // INSERT YOUR BING MAPS KEY HERE
        bingProvider:BingKey = "REPLACE_THIS_WITH_YOUR_BING_MAPS_KEY".
        bingProvider:BingKey = "Audxd9rehcmI76cwkNYHhCNgkbQxsCmccC0-M4f6oc66VQOxMLhZluCSwi10PSp_".
        
        cache = new LocalFileCacheProvider(cacheFolder).
        bingProvider:CacheProvider = cache.
        this-object:CustomerAddressMap:Providers:Add(bingProvider).
        
        this-object:CustomerAddressMap:ShowSearchBar = true.
        pinsLayer = new MapLayer("Pins").
        this-object:CustomerAddressMap:Layers:Add(pinsLayer).
        this-object:CustomerAddressMap:MapElement:SearchBarElement:SearchProvider = bingProvider.
    
        this-object:CustomerAddressMap:MapElement:SearchBarElement:SearchProvider:SearchCompleted:Subscribe(this-object:BingProviderSearchCompleted).
        this-object:CustomerAddressMap:MapElement:SearchBarElement:SearchProvider:SearchError:Subscribe(BingProviderSearchError).  
    end.
    
    method private void BingProviderSearchError( input sender as System.Object, input e as System.EventArgs ):
        
        define variable eventArgs as SearchErrorEventArgs no-undo.
        
        eventArgs = dynamic-cast (e, "Telerik.WinControls.UI.SearchErrorEventArgs").
        
        message eventArgs:Error:Message
            view-as alert-box.
        return.

    end method.  
    
    method private void BingProviderSearchCompleted( input sender as System.Object, input e as System.EventArgs ):
        
        define variable eventArgs as SearchCompletedEventArgs no-undo.
        define variable allPoints as Telerik.WinControls.UI.Map.RectangleG no-undo.        
        define variable locationIndex as integer no-undo.
        define variable location as Telerik.WinControls.UI.Map.Bing.Location no-undo.  
        define variable point as Telerik.WinControls.UI.Map.PointG no-undo. 
        define variable pin as MapPin no-undo.
        
        eventArgs = dynamic-cast (e, "Telerik.WinControls.UI.SearchCompletedEventArgs").
        
        // Use fully qualified names to access static type members
        // Double translates to Decimal and min/max values are out of scope.    
        allPoints = new Telerik.WinControls.UI.Map.RectangleG(-2000000, 2000000, 2000000, -2000000). 
        this-object:CustomerAddressMap:Layers["Pins"]:Clear().
        
        locationIndex = 0.
        
        do locationIndex = 1 to eventArgs:Locations:Length:
            location = dynamic-cast(eventArgs:Locations:GetValue(locationIndex - 1), "Telerik.WinControls.UI.Map.Bing.Location").
            
            point = new Telerik.WinControls.UI.Map.PointG(
                dynamic-cast (location:Point:Coordinates:GETVALUE(0), "System.Double"), 
                dynamic-cast (location:Point:Coordinates:GETVALUE(1), "System.Double")
                ).

            pin = new MapPin(point).
            pin:Size = new System.Drawing.Size(20, 40).
            pin:BackColor = Color:Red.
            pin:ToolTipText = location:Address:FormattedAddress.
            this-object:CustomerAddressMap:MapElement:Layers["Pins"]:Add(pin).
            allPoints:North = Math:Max(allPoints:North, point:Latitude).
            allPoints:South = Math:Min(allPoints:South, point:Latitude).
            allPoints:West = Math:Min(allPoints:West, point:Longitude).
            allPoints:East = Math:Max(allPoints:East, point:Longitude).
        end.
              
        if (eventArgs:Locations:Length > 0) then do:
        
            if (eventArgs:Locations:Length = 1) then do:
            
                location = dynamic-cast(eventArgs:Locations:GetValue(0), "Telerik.WinControls.UI.Map.Bing.Location"). //get element at index
                
                this-object:CustomerAddressMap:BringIntoView(new Telerik.WinControls.UI.Map.PointG(
                    dynamic-cast(location:Point:Coordinates:GETVALUE(0), "System.Double"), //get element at index
                    dynamic-cast(location:Point:Coordinates:GETVALUE(1), "System.Double"))
                    ).
            end.
            else do:           
                this-object:CustomerAddressMap:MapElement:BringIntoView(allPoints).
                this-object:CustomerAddressMap:Zoom(this-object:CustomerAddressMap:MapElement:ZoomLevel - 1).
            end.
        end.
        else do:
        
            message "No result found for the provided search query!"
                view-as alert-box.
        end.

        return.

    end method.
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    method private void textBox1_TextChanged( input sender as System.Object, input e as System.EventArgs ):
		
        return.

    end method.

    method private void telerikButton1_Clicked( input sender as System.Object, input e as System.EventArgs ):        
        
        this-object:oViewModel:RefreshCustomers().
        this-object:CustomersGridView:DataSource = this-object:oViewModel:CustomersDataTable.

        return.
    end method.

    destructor public Form1 ( ):

    end destructor.

end class.