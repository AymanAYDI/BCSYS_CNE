page 50076 "BC6_ScanDeviceButtons"
{
    Caption = 'Actions Shortcut', Comment = 'FRA="Actions raccourci"';
    PageType = ListPart;
    SourceTable = "Tenant Media"; // TODO: check replace record tempBlob by "Tenant Media"
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            field(Button1; Rec.Content)
            {
                ShowCaption = false;
                ApplicationArea = All;

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

