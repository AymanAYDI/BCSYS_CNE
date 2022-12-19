try {   
    InitializeControl('controlAddIn');
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlAddInReady', null);
} catch (error) {
    console.error("[Control] InvokeExtensibilityMethod - OnInitialized " + error);
}