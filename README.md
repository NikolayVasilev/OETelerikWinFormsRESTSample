# OETelerikWinFormsRESTSample

 This repo containing GUI for .NET OpenEdge examples of using [Telerik UI for WinForms](https://www.telerik.com/products/winforms.aspx) components for creating beautiful desktop applicatons.
 It utilises a simple JSDO REST service for data access. 

 The project was originally created with PDSOE 12.2.


## OpenEdge set-up

 Create a PDSOE standard project and added the following .dlls:

 * Telerik.WinControls.dll

 * Telerik.WinControls.GridView.dll
 
 * Telerik.WinControls.RadMap.dll
 
 * Telerik.WinControls.Themes.FluentDark.dll
 
 * Telerik.WinControls.UI.dll
 
 * Telerik.WinControls.UI.Design.dll
 
 * TelerikCommon.dll
 
 * TelerikData.dll

 The dialog to do this can be found on Project->Properties->Progress OpenEdge->Assemblies.

 Once selected and the 'Apply and Close' button has been pressed, an assemblies.xml file will be created in the root of the project with references to the above .dll files.

 If the .dlls have been added as Local Assembles, the assemblies.xml files must be in the same folder as the .dlls

## Map initial set-up

 Get a Bing map key as instructed in the official MSDN article: https://docs.microsoft.com/en-us/bingmaps/getting-started/bing-maps-dev-center-help/getting-a-bing-maps-key
 
 Replace "REPLACE_THIS_WITH_YOUR_BING_MAPS_KEY" in Form1.cls line 263 with your key. 

## Running the demos

 Open Form1 in the either design or code view and start the project.
