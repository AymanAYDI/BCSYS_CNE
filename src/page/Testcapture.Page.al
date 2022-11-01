page 50060 "Test capture"
{
    // CurrPage.ScanZone.SubmitAllData(1);
    // 
    // ScanZone::ControlAddInReady()
    // FOR i := 1 TO ARRAYLEN(ArrayCaption) DO BEGIN
    //   CurrPage.ScanZone.AddControl(i, ArrayCaption[i],  ArrayValue[i]);
    //   IF i <> 1 THEN
    //     CurrPage.ScanZone.SetHide(i, TRUE);
    // END;
    // 
    // ScanZone::KeyPressed(index : Integer;data : Text)
    // 
    // ScanZone::TextCaptured(index : Integer;data : Text)
    // CurrPage.ScanZone.SetBgColor(index, 'green');
    // CurrPage.ScanZone.reset(index);
    // ArrayValue[index] := ScanDeviceHelper.ConvertScanData(data);
    // CurrPage.ScanZone.SetText(index, ArrayValue[index]);
    // //CurrPage.ScanZone.SetHide(index, TRUE);
    // CurrPage.ScanZone.SetHide(index + 1, FALSE);
    // CurrPage.ScanZone.SetFocus(index + 1);
    // 
    // ScanZone::AddInDrillDown(index : Integer;data : Text)
    // MESSAGE('%1 %2', index, data);
    // 
    // ScanZone::Focused(index : Integer;data : Text)
    // 
    // ScanZone::FocusLost(index : Integer;data : Text)
    // 
    // ScanZone::DataSubmited(ScanDeviceXml : Text)
    // MESSAGE('%1', ScanDeviceHelper.GetValueOfSubmition(1, ScanDeviceXml));

    Caption = 'Item Invt.';
    MultipleNewLines = false;
    PageType = ListPlus;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = Table83;

    layout
    {
        area(content)
        {
            group(ScanDeviceHelper)
            {
                field("Line No."; "Line No.")
                {
                }
                usercontrol(ScanZone; "ControlAddinScanCapture")
                {

                    trigger ControlAddInReady()
                    var
                        i: Integer;
                    begin
                        FOR i := 1 TO ARRAYLEN(ArrayCaption) DO BEGIN
                            CurrPage.ScanZone.AddControl(i, ArrayCaption[i], ArrayValue[i]);
                            IF i <> 1 THEN
                                CurrPage.ScanZone.SetHide(i, TRUE);
                        END;
                    end;

                    trigger KeyPressed(index: Integer; data: Text)
                    begin
                    end;

                    trigger TextCaptured(index: Integer; data: Text)
                    begin
                        CurrPage.ScanZone.SetBgColor(index, 'green');
                        CurrPage.ScanZone.reset(index);
                        ArrayValue[index] := ScanDeviceHelper.ConvertScanData(data);
                        CurrPage.ScanZone.SetText(index, ArrayValue[index]);
                        //CurrPage.ScanZone.SetHide(index, TRUE);
                        CurrPage.ScanZone.SetHide(index + 1, FALSE);
                        CurrPage.ScanZone.SetFocus(index + 1);
                    end;

                    trigger AddInDrillDown(index: Integer; data: Text)
                    begin
                        MESSAGE('%1 %2', index, data);
                    end;

                    trigger Focused(index: Integer; data: Text)
                    begin
                    end;

                    trigger FocusLost(index: Integer; data: Text)
                    begin
                    end;

                    trigger DataSubmited(index: Integer; data: Text)
                    begin
                        MESSAGE('%1', ScanDeviceHelper.GetValueOfSubmition(1, data));
                    end;
                }
                field(ArrayValue[1];ArrayValue[1])
                {
                    Editable = false;
                    QuickEntry = false;
                }
                field(ArrayValue[2];ArrayValue[2])
                {
                    Editable = false;
                    QuickEntry = false;
                }
                field(ArrayValue[3];ArrayValue[3])
                {
                    Editable = false;
                    QuickEntry = false;
                }
                field(ArrayValue[4];ArrayValue[4])
                {
                    Editable = false;
                    QuickEntry = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group()
            {
                action(Button1)
                {
                    Gesture = RightSwipe;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        MESSAGE('Button 1');
                    end;
                }
                action(GetText)
                {

                    trigger OnAction()
                    var
                        myValue: Text;
                    begin
                        CurrPage.ScanZone.SubmitAllData(1);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        BinContent: Record "7302";
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(ArrayCaption) DO
          ArrayCaption[i] := STRSUBSTNO('Field %1', i);
    end;

    var
        ScanDeviceHelper: Codeunit "50090";
        [InDataSet]
        IsScanEditable: Boolean;
        ScanZoneCaption: Label 'Scan Zone';
        ArrayCaption: array [4] of Text;
        ArrayValue: array [4] of Text;
        test: Text;
        Result: Text;
}

