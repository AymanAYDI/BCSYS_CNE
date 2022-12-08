var ArrayOfKeys = new Array();
var ControlId = "";
var ControlPrefix = "Control_";
var RowPrefix = "Row_";
var ButtonPrefix = "Button_";
var NbControl = 0;

function InitializeControl(controlId) {
    ControlId = controlId;
}

function AddControl(Id, Caption, Value) {    
    ArrayOfKeys[Id] = Value;
    var c = $("#" + ControlId);
    var myImg = '<table class="fadeInLeft"><tr id="' + RowPrefix + Id + '"><td><img class="scan-img" onclick="SetFocus(' + Id + ')" id="myImg" src="' + Microsoft.Dynamics.NAV.GetImageResource('barcode-icon.png') + '" /></td><td class="scan-caption"><label>' + Caption + ' :</label></td><td><input id="' + ControlPrefix + Id + '" class="scan-input"></input></td><td><button class="scan-button" id="' + ButtonPrefix + Id + '" onclick="OnDrillDown(' + Id + ')">...</button></td></tr></table>';
    c.append(myImg);
    $("#"+ControlPrefix + Id).keypress(OnKeypressed);
    $("#" + ControlPrefix + Id).keydown(OnKeyDown);    
    $("#" + ControlPrefix + Id).val(ArrayOfKeys[Id]);
    //$("#" + ControlPrefix + Id).focusout(function () {SaveValue(Id)});
    ArrayOfKeys[Id] = Value;
    if (Id == 1) {
        $("#"+ControlPrefix + Id).focus();
    }
    NbControl += 1;
}

function SubmitAllData(ActionID) {

    var xml = '<root>';
    for (i = 1; i <= NbControl; i++) {
        var element = $("#" + ControlPrefix + i);
        xml += "<control id='" + i + "'><![CDATA[";
        xml += element.val();
        xml += "]]></control>";
    }
    xml += '</root>';
    var arguments = new Array(2);
    arguments[0] = ActionID;
    arguments[1] = xml;
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('DataSubmited', arguments);
}

function OnKeyDown(e) {
    var Id = 0;
    Id = e.target.id.replace(ControlPrefix, "");
    get = window.event ? event : e;
    var key = get.keyCode ? get.keyCode : get.charCode;
    key = String.fromCharCode(key);    
    var arguments = [Id, ArrayOfKeys[Id]];    
    if ((get.keyCode == 13) | (get.keyCode == 9)) {        
        var element = $("#" + ControlPrefix + Id);            
        ArrayOfKeys[Id] = element.val();
        arguments = [Id, ArrayOfKeys[Id]];
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('TextCaptured', arguments);        
    } else if ((get.keyCode == 8) | (get.keyCode == 49)) {
        var element = $("#" + ControlPrefix + Id);
        ArrayOfKeys[Id] = element.val();
    } 
    else {
        arguments = [Id, get.keyCode];
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('KeyPressed', arguments);        
    }
}

function SaveValue(Id) {
    var element = $("#" + ControlPrefix + Id);
    ArrayOfKeys[Id] = element.val();
    var arguments = [Id, ArrayOfKeys[Id]];
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('FocusLost', arguments);
}

function OnDrillDown(Id) {
    var id = 0;
    id = Id
    var element = $("#" + ControlPrefix + Id);
    var arguments = [id, element.val()];    
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('AddInDrillDown', arguments);
}

function OnKeypressed(e) {         
    var Id = 0;
    Id = e.target.id.replace(ControlPrefix,"");
    get = window.event ? event : e;
    var key = get.keyCode ? get.keyCode : get.charCode;
    key = String.fromCharCode(key);
    ArrayOfKeys[Id] += key;
    var arguments = [Id, ArrayOfKeys[Id]];    
    if (get.keyCode == 13) {        
               
    } else {
        arguments = [Id, key];        
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('KeyPressed', arguments);
    }
}

function reset(Id) {
    ArrayOfKeys[Id] = '';
    $("#" + ControlPrefix + Id).val(ArrayOfKeys[Id])
}
function SetFocus(Id) {
    $("#"+ControlPrefix + Id).focus();
}
function GetText(Id) {
    var element = $("#" + ControlPrefix + Id);    
    return (element.val());
}

function SetText(Id, text) {
    $("#"+ControlPrefix + Id).val(text);
}
function SetBgColor(Id, color) {    
    $("#"+ControlPrefix + Id).css("background-color", color);
}
function SetHide(Id, hide) {
    if (hide) {
        $("#" + RowPrefix + Id).hide();
    }
    else {
        $("#" + RowPrefix + Id).show();
    }
}

