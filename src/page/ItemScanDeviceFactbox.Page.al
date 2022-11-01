page 50075 "Item ScanDevice Factbox"
{
    Caption = 'Item details';
    PageType = CardPart;
    SourceTable = Table27;

    layout
    {
        area(content)
        {
            field(ChangeDefaultBinCode; ScanDeviceInfoPaneMgt.GetDefaultBinContent("No.", ''))
            {
                Caption = 'Default Bin Code';

                trigger OnDrillDown()
                begin
                    ScanDeviceInfoPaneMgt.ChangeDefaultBinContent("No.", '');
                end;
            }
            field("Qty. on Purch. Order"; "Qty. on Purch. Order")
            {
            }
        }
    }

    actions
    {
    }

    var
        ScanDeviceInfoPaneMgt: Codeunit "50090";

    [Scope('Internal')]
    procedure ChangeDefaultBinContent()
    begin
        ScanDeviceInfoPaneMgt.ChangeDefaultBinContent("No.", '');
    end;
}

