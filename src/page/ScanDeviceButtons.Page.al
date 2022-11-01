page 50076 ScanDeviceButtons
{
    Caption = 'Actions Shortcut';
    PageType = ListPart;
    SourceTable = Table99008535;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            field(Button1; Blob)
            {
                ShowCaption = false;

                trigger OnAssistEdit()
                begin
                    MESSAGE('Button 1');
                end;

                trigger OnDrillDown()
                begin
                    MESSAGE('Button 1');
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        MyValue := 'Button';
    end;

    var
        MyValue: Text;
}

