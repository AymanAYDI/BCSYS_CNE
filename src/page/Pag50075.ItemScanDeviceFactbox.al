page 50075 "BC6_Item ScanDevice Factbox"
{
    Caption = 'Item details', Comment = 'FRA="Détails article"';
    PageType = CardPart;
    SourceTable = Item;
    UsageCategory = None;
    layout
    {
        area(content)
        {
            field(ChangeDefaultBinCode; ScanDeviceInfoPaneMgt.GetDefaultBinContent("No.", ''))
            {
                Caption = 'Default Bin Code', Comment = 'FRA="Code empl. par déf."';

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
        ScanDeviceInfoPaneMgt: Codeunit BC6_ScanDeviceHelper;


    procedure ChangeDefaultBinContent()
    begin
        ScanDeviceInfoPaneMgt.ChangeDefaultBinContent("No.", '');
    end;
}

