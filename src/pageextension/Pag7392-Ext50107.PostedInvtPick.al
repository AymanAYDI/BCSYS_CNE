pageextension 50107 "BC6_PostedInvtPick" extends "Posted Invt. Pick" //7392
{
    actions
    {
        addafter("Co&mments")
        {
            action("Mouvements enregistrés")
            {
                Caption = 'Mouvements enregistrés';
                RunObject = Page "Warehouse Entries";
                RunPageLink = "BC6_Whse. Document No. 2" = FIELD("Invt Pick No.");
                image = SaveasStandardJournal;
                RunPageView = SORTING("BC6_Whse. Document Type 2", "BC6_Whse. Document No. 2")
                              ORDER(Ascending)
                              WHERE("BC6_Whse. Document Type 2" = CONST("Invt. Pick"));
            }
        }
    }
}