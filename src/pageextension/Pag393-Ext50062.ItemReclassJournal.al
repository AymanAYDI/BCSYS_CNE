pageextension 50062 "BC6_ItemReclassJournal" extends "Item Reclass. Journal" //393
{
    layout
    {
        modify("Bin Code")
        {
            Visible = true;
        }
        modify("New Location Code")
        {
            Visible = true;
        }
        modify("New Bin Code")
        {
            Visible = true;
        }
    }

    actions
    {
        addafter("Bin Contents")
        {
            action("BC6_Get Location Content")
            {
                ApplicationArea = All;
                Caption = 'Get Location Content', Comment = 'FRA="Extraire contenu magasin"';
                Ellipsis = true;
                image = Addresses;
                trigger OnAction()
                var
                    Item: Record Item;
                    Location: Record Location;
                    GetLocationContent: Report "BC6_Whse. Get Inventory";
                begin
                    Item.SETFILTER("Location Filter", Location.Code);
                    GetLocationContent.SETTABLEVIEW(Item);
                    GetLocationContent.InitializeItemJournalLine(Rec);
                    GetLocationContent.RUNMODAL();
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
    }
}
