page 50075 "BC6_Item ScanDevice Factbox"
{
    Caption = 'Item details';
    PageType = CardPart;
    SourceTable = Item;

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
        ScanDeviceInfoPaneMgt: Codeunit 50090; TODO;


    procedure ChangeDefaultBinContent()
    begin
        ScanDeviceInfoPaneMgt.ChangeDefaultBinContent("No.", '');
    end;
}

