page 50072 "Douchettes Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part("Whse Ship & Receive Activities"; 50078)
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
                RunObject = Page 50080;
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
                    RunObject = Page 22;
                    Visible = false;
                }
                action(TestCapture)
                {
                    Caption = 'Capture Test';
                    Image = BarCode;
                    RunObject = Page 50060;
                    Visible = false;
                }
                action(TestCapture2)
                {
                    Caption = 'Capture Test';
                    Image = Bin;
                    RunObject = Page 50076;
                    Visible = false;
                }
                action(SearchBarCode)
                {
                    Caption = 'Search Bar Code';
                    Image = Find;
                    RunObject = Page 50074;
                    Visible = false;
                }
                action(Inventory2)
                {
                    Caption = 'Item Invt.';
                    Image = ItemLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 50056;
                    RunPageMode = Edit;
                    Visible = true;
                }
                action(Inventory_2)
                {
                    Caption = 'Inventory';
                    Image = InventoryJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 50057;
                }
                action(PalletReclass)
                {
                    Caption = 'Reclass. Item';
                    Image = TransferReceipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 50058;
                    RunPageMode = Edit;
                    ShortCutKey = 'F2';
                }
                action(PalletReclass2)
                {
                    Caption = 'Invt. Pick';
                    Image = PickLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 50059;
                    RunPageMode = Edit;
                    ShortCutKey = 'F3';
                }
            }
        }
    }
}

