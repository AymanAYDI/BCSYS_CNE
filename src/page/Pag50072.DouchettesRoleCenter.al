page 50072 "BC6_Douchettes Role Center"
{
    Caption = 'Role Center', Comment = 'FRA="Tableau de bord"';
    PageType = RoleCenter;
    UsageCategory = None;
    layout
    {
        area(rolecenter)
        {
            part("Whse Ship & Receive Activities"; "BC6_Scan Ship Rece Activities")
            {
                ApplicationArea = All;
                Caption = 'Whse Ship & Receive Activities', Comment = 'FRA="Activités magasin"';
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action(ReclassPickList)
            {
                ApplicationArea = All;
                Caption = 'Picking Liste', Comment = 'FRA="Prélèvements"';
                Image = PickLines;
                RunObject = Page "BC6_Item Journal Pick List";
                Visible = false;
            }
        }
        area(processing)
        {
            group(Activity)
            {
                Caption = 'Activity', Comment = 'FRA="Activité"';
                action(Customers)
                {
                    ApplicationArea = All;
                    Image = Customer;
                    RunObject = Page "Customer List";
                    Visible = false;
                }
                action(TestCapture)
                {
                    ApplicationArea = All;
                    Caption = 'Capture Test', Comment = 'FRA="Teste Capture"';
                    Image = BarCode;
                    RunObject = Page "BC6_Test capture";
                    Visible = false;
                }
                action(TestCapture2)
                {
                    ApplicationArea = All;
                    Caption = 'Capture Test', Comment = 'FRA="Teste Capture"';
                    Image = Bin;
                    RunObject = Page BC6_ScanDeviceButtons;
                    Visible = false;
                }
                action(SearchBarCode)
                {
                    ApplicationArea = All;
                    Caption = 'Search Bar Code', Comment = 'FRA="Rechercher code barre"';
                    Image = Find;
                    RunObject = Page "BC6_Item List Search CNE";
                    Visible = false;
                }
                action(Inventory2)
                {
                    ApplicationArea = All;
                    Caption = 'Item Invt.', Comment = 'FRA="Stock article"';
                    Image = ItemLines;
                    RunObject = Page "BC6_Item Invt.";
                    RunPageMode = Edit;
                    Visible = true;
                }
                action(Inventory_2)
                {
                    ApplicationArea = All;
                    Caption = 'Inventory', Comment = 'FRA="Inventaire"';
                    Image = InventoryJournal;
                    RunObject = Page "BC6_Inventory Card MiniForm";
                }
                action(PalletReclass)
                {
                    ApplicationArea = All;
                    Caption = 'Reclass. Item', Comment = 'FRA="Reclassement article"';
                    Image = TransferReceipt;
                    RunObject = Page "BC6_Reclass. Card MiniForm";
                    RunPageMode = Edit;
                    ShortCutKey = 'F2';
                }
                action(PalletReclass2)
                {
                    ApplicationArea = All;
                    Caption = 'Invt. Pick', Comment = 'FRA="Prélèvement stock"';
                    Image = PickLines;
                    RunObject = Page "BC6_Invt. Pick Card MiniForm";
                    RunPageMode = Edit;
                    ShortCutKey = 'F3';
                }
            }
        }
    }
}
