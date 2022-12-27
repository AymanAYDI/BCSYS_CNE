page 50060 "BC6_Test capture"
{
    Caption = 'Item Invt.', Comment = 'FRA="Stock article"';
    MultipleNewLines = false;
    PageType = ListPlus;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Item Journal Line";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(ScanDeviceHelper)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                usercontrol(ScanZone; "BC6_ControlAddinScanCapture")
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
                field("ArrayValue[1]"; ArrayValue[1])
                {
                    Editable = false;
                    QuickEntry = false;
                }
                field("ArrayValue[2]"; ArrayValue[2])
                {
                    Editable = false;
                    QuickEntry = false;
                }
                field("ArrayValue[3]"; ArrayValue[3])
                {
                    Editable = false;
                    QuickEntry = false;
                }
                field("ArrayValue[4]"; ArrayValue[4])
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
            group(Control1)
            {
                action(Button1)
                {
                    Gesture = RightSwipe;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        MESSAGE('Button 1');
                    end;
                }
                action(GetText)
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.ScanZone.SubmitAllData(1);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(ArrayCaption) DO
            ArrayCaption[i] := STRSUBSTNO(TextCst, i);
    end;

    var
        ScanDeviceHelper: Codeunit BC6_ScanDeviceHelper;
        TextCst: Label 'Field %1', Comment = 'FRA="Champ %1"';
        ArrayCaption: array[4] of Text;
        ArrayValue: array[4] of Text;
}

