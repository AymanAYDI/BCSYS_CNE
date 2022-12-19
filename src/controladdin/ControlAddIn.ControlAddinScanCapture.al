controladdin "BC6_ControlAddinScanCapture"
{
    VerticalStretch = true;
    HorizontalStretch = true;
    VerticalShrink = true;
    HorizontalShrink = true;
    Scripts = './src/controladdin/ControlAddinScanCapture/Script/JavaScript1.js', './src/controladdin/ControlAddinScanCapture/Script/jquery-2.1.0.min.js';
    StyleSheets = './src/controladdin/ControlAddinScanCapture/StyleSheet/scandevice.css';
    Images = './src/controladdin/ControlAddinScanCapture/Image/barcode-icon.png';


    event ControlAddInReady()

    procedure AddControl(Id: Integer; Caption: Text; Value: Text)

    procedure SetFocus(Id: Integer)

    procedure focus();

    event KeyPressed(index: Integer; data: Text)

    procedure SubmitAllData(ActionID: Integer)

    event TextCaptured(index: Integer; data: Text)

    procedure reset(Id: Integer)

    procedure SetText(Id: Integer; text: Text)

    procedure SetHide(Id: Integer; hide: Boolean)

    procedure GetText(Id: Integer);

    event EventGetText(Id: Text)

    procedure SetBgColor(Id: Integer; color: Text);

    event AddInDrillDown(index: Integer; data: Text)

    event Focused(index: Integer; data: Text)

    event FocusLost(index: Integer; data: Text)

    event DataSubmited(index: Integer; data: Text)
}
