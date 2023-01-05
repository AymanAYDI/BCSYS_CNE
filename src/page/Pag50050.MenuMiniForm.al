page 50050 "BC6_Menu MiniForm"
{
    Caption = 'Whse Menu', Comment = 'FRA="Menu magasin"';
    LinksAllowed = false;
    PageType = Card;
    ShowFilter = false;
    ApplicationArea = all;
    UsageCategory = Tasks;

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
                Caption = 'Item Invt.', Comment = 'FRA="Stock article"';
                Image = ItemLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_Item Invt.";
                Visible = true;
                ApplicationArea = All;


                trigger OnAction()
                begin
                    //Page50057.RUN;
                    //Page50057.NewLine;
                end;

            }
            action(Inventory_2)
            {
                Caption = 'Inventory', Comment = 'FRA="Inventaire"';
                Image = InventoryJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_Inventory Card MiniForm";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(PalletReclass)
            {
                Caption = 'Reclass. Item', Comment = 'FRA="Reclassement article"';
                Image = TransferReceipt;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_Reclass. Card MiniForm";
                RunPageMode = Create;
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
                RunPageMode = Create;
                ShortCutKey = 'F3';
                ApplicationArea = All;
            }
            action("Raccourci clavier terminaux")
            {
                RunObject = Page "Raccourci clavier terminaux";
                ApplicationArea = All;
            }
            action(Commande)
            {
                RunObject = Page "Inventory Pick";
                ApplicationArea = All;
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
        Text001: Label 'COMPANY %1', Comment = 'FRA="SOCIETE %1"';
        WhseMenuTxt: Text[120];
}

