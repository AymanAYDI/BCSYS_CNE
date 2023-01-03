page 50072 "BC6_Douchettes Role Center"
{
    Caption = 'Role Center', Comment = 'FRA="Tableau de bord"';
    PageType = RoleCenter;
    UsageCategory = None;
    layout
    {
        area(rolecenter)
        {
            part("Whse Ship & Receive Activities"; "Scan Ship & Receive Activities")
            {
                Caption = 'Whse Ship & Receive Activities', Comment = 'FRA="Activités magasin"';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action(ReclassPickList)
            {
                Caption = 'Picking Liste', Comment = 'FRA="Prélèvements"';
                Image = PickLines;
                RunObject = Page "BC6_Item Journal Pick List";
                Visible = false;
                ApplicationArea = All;
            }
        }
        area(processing)
        {
            group(Activity)
            {
                Caption = 'Activity', Comment = 'FRA="Activité"';
                action(Customers)
                {
                    Promoted = true;
                    RunObject = Page "Customer List";
                    Visible = false;
                    ApplicationArea = All;
                }
                action(TestCapture)
                {
                    Caption = 'Capture Test', Comment = 'FRA="Teste Capture"';
                    Image = BarCode;
                    RunObject = Page "BC6_Test capture";
                    Visible = false;
                    ApplicationArea = All;
                }
                action(TestCapture2)
                {
                    Caption = 'Capture Test', Comment = 'FRA="Teste Capture"';
                    Image = Bin;
                    RunObject = Page BC6_ScanDeviceButtons;
                    Visible = false;
                    ApplicationArea = All;
                }
                action(SearchBarCode)
                {
                    Caption = 'Search Bar Code', Comment = 'FRA="Rechercher code barre"';
                    Image = Find;
                    RunObject = Page "BC6_Item List Search CNE";
                    Visible = false;
                    ApplicationArea = All;
                }
                action(Inventory2)
                {
                    Caption = 'Item Invt.', Comment = 'FRA="Stock article"';
                    Image = ItemLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "BC6_Item Invt.";
                    RunPageMode = Edit;
                    Visible = true;
                    ApplicationArea = All;
                }
                action(Inventory_2)
                {
                    Caption = 'Inventory', Comment = 'FRA="Inventaire"';
                    Image = InventoryJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "BC6_Inventory Card MiniForm";
                    ApplicationArea = All;
                }
                action(PalletReclass)
                {
                    Caption = 'Reclass. Item', Comment = 'FRA="Reclassement article"';
                    Image = TransferReceipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "BC6_Reclass. Card MiniForm";
                    RunPageMode = Edit;
                    ShortCutKey = 'F2';
                    ApplicationArea = All;
                }
                action(PalletReclass2)
                {
                    Caption = 'Invt. Pick', Comment = 'FRA="Prélèvement stock"';
                    Image = PickLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "BC6_Invt. Pick Card MiniForm";
                    RunPageMode = Edit;
                    ShortCutKey = 'F3';
                    ApplicationArea = All;
                }
            }
        }
    }
}

