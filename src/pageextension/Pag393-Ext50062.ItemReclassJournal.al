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
                Caption = 'Get Location Content', Comment = 'FRA="Extraire contenu magasin"';
                Ellipsis = true;
                ApplicationArea = All;

                // trigger OnAction() TODO: missing report
                // var
                //     Location: Record Location;
                //     Item: Record Item;
                //     GetLocationContent: Report 50055;
                // begin
                //     Item.SETFILTER("Location Filter", Location.Code);
                //     GetLocationContent.SETTABLEVIEW(Item);
                //     GetLocationContent.InitializeItemJournalLine(Rec);
                //     GetLocationContent.RUNMODAL;
                //     CurrPage.UPDATE(FALSE);
                // end;
            }
        }
    }
}
