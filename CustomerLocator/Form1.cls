 
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

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Form1 INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE CustomersGridView AS Telerik.WinControls.UI.RadGridView NO-UNDO.
    DEFINE PRIVATE VARIABLE fluentDarkTheme1 AS Telerik.WinControls.Themes.FluentDarkTheme NO-UNDO.
    DEFINE PRIVATE VARIABLE office2013DarkTheme1 AS Telerik.WinControls.Themes.Office2013DarkTheme NO-UNDO.
    DEFINE PRIVATE VARIABLE textBox1 AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE telerikButton1 AS RadButton NO-UNDO.
    DEFINE VARIABLE oSportsDataServiceClient AS Service.ServiceClient NO-UNDO.
		
    CONSTRUCTOR PUBLIC Form1 (  ):

        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:Add(THIS-OBJECT:components).
        
        oSportsDataServiceClient = NEW ServiceClient("Production").
        
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID Form1_Load( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		THIS-OBJECT:PrepareGridView().
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
        CAST(THIS-OBJECT:telerikButton1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:CustomersGridView, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:CustomersGridView:MasterTemplate, System.ComponentModel.ISupportInitialize):BeginInit().
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
        THIS-OBJECT:CustomersGridView:MasterTemplate:ViewDefinition = tableViewDefinition1.
        THIS-OBJECT:CustomersGridView:Name = "CustomersGridView".
        THIS-OBJECT:CustomersGridView:Size = NEW System.Drawing.Size(747, 562).
        THIS-OBJECT:CustomersGridView:TabIndex = 2.
        THIS-OBJECT:CustomersGridView:ThemeName = "FluentDark".
        /*  */
        /* Form1 */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(877, 586).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:CustomersGridView).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:textBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:telerikButton1).
        THIS-OBJECT:Name = "Form1".
        THIS-OBJECT:Text = "CustomerLocator".
        THIS-OBJECT:Load:Subscribe(THIS-OBJECT:Form1_Load).
        CAST(THIS-OBJECT:telerikButton1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:CustomersGridView:MasterTemplate, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:CustomersGridView, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.
    
    METHOD PRIVATE VOID PrepareGridView():
        DEFINE VARIABLE oCustomersDataTable AS DataTable NO-UNDO.
       
        ASSIGN oCustomersDataTable = THIS-OBJECT:oSportsDataServiceClient:GetCustomers().
             
        THIS-OBJECT:CustomersGridView:DataSource = oCustomersDataTable.
        THIS-OBJECT:CustomersGridView:AutoSizeColumnsMode = GridViewAutoSizeColumnsMode:Fill.
    END.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID textBox1_TextChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
        RETURN.

    END METHOD.

    METHOD PRIVATE VOID telerikButton1_Clicked( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):        
        
        DEFINE VARIABLE oCustomersDataTable AS DataTable NO-UNDO.      
        
        oCustomersDataTable = THIS-OBJECT:oSportsDataServiceClient:GetCustomers().
        
        MESSAGE "Number of row in the data table:" oCustomersDataTable:Rows:Count
            VIEW-AS ALERT-BOX INFORMATION.
        
        RETURN.
    END METHOD.

    DESTRUCTOR PUBLIC Form1 ( ):

    END DESTRUCTOR.

END CLASS.