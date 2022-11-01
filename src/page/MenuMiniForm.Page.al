page 50050 "Menu MiniForm"
{
    // Migrationb 2013 almi delete company name

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
                RunObject = Page 50056;
                Visible = true;

                trigger OnAction()
                var
                    Page50057: Page "50057";
                begin
                    //Page50057.RUN;
                    //Page50057.NewLine;
                end;
            }
            action(Inventory_2)
            {
                Caption = 'Inventory';
                Image = InventoryJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 50057;
                RunPageMode = Create;
            }
            action(PalletReclass)
            {
                Caption = 'Reclass. Item';
                Image = TransferReceipt;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 50058;
                RunPageMode = Create;
                ShortCutKey = 'F2';
            }
            action(PalletReclass2)
            {
                Caption = 'Invt. Pick';
                Image = PickLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 50059;
                RunPageMode = Create;
                ShortCutKey = 'F3';
            }
            action("Raccourci clavier terminaux")
            {
                RunObject = Page 50069;
            }
            action(Commande)
            {
                RunObject = Page 7377;
            }
        }
    }

    trigger OnOpenPage()
    begin
        CompanyInfo.GET;
        WhseMenuTxt := STRSUBSTNO(Text001, CompanyInfo.Name);
    end;

    var
        Text001: Label 'COMPANY %1';
        WhseMenuTxt: Text[120];
        CompanyInfo: Record "79";
}

