page 50072 "BC6_Douchettes Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part("Whse Ship & Receive Activities"; "Scan Ship & Receive Activities")
            {
                Caption = 'Whse Ship & Receive Activities';
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action(ReclassPickList)
            {
                Caption = 'Picking Liste';
                Image = PickLines;
                RunObject = Page "Item Journal Pick List";
                Visible = false;
            }
        }
        area(processing)
        {
            group(Activity)
            {
                Caption = 'Activity';
                action(Customers)
                {
                    Promoted = true;
                    RunObject = Page "Customer List";
                    Visible = false;
                }
                action(TestCapture)
                {
                    Caption = 'Capture Test';
                    Image = BarCode;
                    RunObject = Page "BC6_Test capture";
                    Visible = false;
                }
                action(TestCapture2)
                {
                    Caption = 'Capture Test';
                    Image = Bin;
                    RunObject = Page ScanDeviceButtons;
                    Visible = false;
                }
                action(SearchBarCode)
                {
                    Caption = 'Search Bar Code';
                    Image = Find;
                    RunObject = Page "Item List Search CNE";
                    Visible = false;
                }
                action(Inventory2)
                {
                    Caption = 'Item Invt.';
                    Image = ItemLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "BC6_Item Invt.";
                    RunPageMode = Edit;
                    Visible = true;
                }
                action(Inventory_2)
                {
                    Caption = 'Inventory';
                    Image = InventoryJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "BC6_Inventory Card MiniForm";
                }
                action(PalletReclass)
                {
                    Caption = 'Reclass. Item';
                    Image = TransferReceipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "BC6_Reclass. Card MiniForm";
                    RunPageMode = Edit;
                    ShortCutKey = 'F2';
                }
                action(PalletReclass2)
                {
                    Caption = 'Invt. Pick';
                    Image = PickLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "BC6_Invt. Pick Card MiniForm";
                    RunPageMode = Edit;
                    ShortCutKey = 'F3';
                }
            }
        }
    }
}

