controladdin "BC6_ControlAddinScanCapture"
{
    VerticalStretch = true;
    HorizontalStretch = true;
    VerticalShrink = true;
    HorizontalShrink = true;
    Scripts = './src/controladdin/ControlAddinScanCapture/Script/JavaScript1.js', './src/controladdin/ControlAddinScanCapture/Script/jquery-2.1.0.min.js';
    StyleSheets = './src/controladdin/ControlAddinScanCapture/StyleSheet/scandevice.css';
}



// <?xml version="1.0" encoding="utf-8" ?>
// <Manifest>
//   <Resources>
//     <Script>JavaScript1.js</Script>
//     <Script>jquery-2.1.0.min.js</Script>    
//     <Image>barcode-icon.png</Image>
//     <StyleSheet>scandevice.css</StyleSheet>
//   </Resources>
//   <ScriptUrls>    
//   </ScriptUrls>
//   <Script>
//     <![CDATA[
//            InitializeControl('controlAddIn');
//            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlAddInReady', null);
//         ]]>
//   </Script>
//   <VerticalStretch>true</VerticalStretch>
//   <HorizontalStretch>true</HorizontalStretch>
//   <VerticalShrink>true</VerticalShrink>
//   <HorizontalShrink>true</HorizontalShrink>  
// </Manifest>