page 50050 "BC6_Menu MiniForm"
{
    ApplicationArea = all;
    Caption = 'Whse Menu', Comment = 'FRA="Menu magasin"';
    LinksAllowed = false;
    PageType = Card;
    ShowFilter = false;
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
                ApplicationArea = All;
                Caption = 'Item Invt.', Comment = 'FRA="Stock article"';
                Image = ItemLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_Item Invt.";
                Visible = true;
            }
            action(Inventory_2)
            {
                ApplicationArea = All;
                Caption = 'Inventory', Comment = 'FRA="Inventaire"';
                Image = InventoryJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_Inventory Card MiniForm";
                RunPageMode = Create;
            }
            action(PalletReclass)
            {
                ApplicationArea = All;
                Caption = 'Reclass. Item', Comment = 'FRA="Reclassement article"';
                Image = TransferReceipt;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_Reclass. Card MiniForm";
                RunPageMode = Create;
                ShortCutKey = 'F2';
            }
            action(PalletReclass2)
            {
                ApplicationArea = All;
                Caption = 'Invt. Pick', Comment = 'FRA="Prélèvement stock"';
                Image = PickLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "BC6_Invt. Pick Card MiniForm";
                RunPageMode = Create;
                ShortCutKey = 'F3';
            }
            action("Raccourci clavier terminaux")
            {
                ApplicationArea = All;
                RunObject = Page "BC6_Racc. clavier terminaux";
            }
            action(Commande)
            {
                ApplicationArea = All;
                Image = Order;
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
        Text001: Label 'COMPANY %1', Comment = 'FRA="SOCIETE %1"';
        WhseMenuTxt: Text[120];
}
