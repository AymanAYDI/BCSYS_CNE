page 50050 "BC6_Menu MiniForm"
{
    Caption = 'Whse Menu';
    LinksAllowed = false;
    PageType = Card;
    ShowFilter = false;

    layout
    {
        area(content)
        {
        }
    }

    actions
    {
        area(processing)
        {
            action(Inventory2)
            {
                Caption = 'Item Invt.';
                Image = ItemLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_Item Invt.";
                Visible = true;
            }
            action(Inventory_2)
            {
                Caption = 'Inventory';
                Image = InventoryJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_Inventory Card MiniForm";
                RunPageMode = Create;
            }
            action(PalletReclass)
            {
                Caption = 'Reclass. Item';
                Image = TransferReceipt;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_Reclass. Card MiniForm";
                RunPageMode = Create;
                ShortCutKey = 'F2';
            }
            action(PalletReclass2)
            {
                Caption = 'Invt. Pick';
                Image = PickLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_Invt. Pick Card MiniForm";
                RunPageMode = Create;
                ShortCutKey = 'F3';
            }
            action("Raccourci clavier terminaux")
            {
                RunObject = Page "Raccourci clavier terminaux";
            }
            action(Commande)
            {
                RunObject = Page "Inventory Pick";
            }
        }
    }

    trigger OnOpenPage()
    begin
        CompanyInfo.GET();
        WhseMenuTxt := STRSUBSTNO(Text001, CompanyInfo.Name);
    end;

    var
        CompanyInfo: Record "Company Information";
        Text001: Label 'COMPANY %1';
        WhseMenuTxt: Text[120];
}

