pageextension 50113 pageextension50113 extends "Posted Invt. Pick"
{
    actions
    {
        addafter("Action 30")
        {
            action("Mouvements enregistrés")
            {
                Caption = 'Mouvements enregistrés';
                RunObject = Page 7318;
                RunPageLink = Whse. Document No. 2=FIELD(Invt Pick No.);
                RunPageView = SORTING(Whse. Document Type 2,Whse. Document No. 2)
                              ORDER(Ascending)
                              WHERE(Whse. Document Type 2=CONST(Invt. Pick));
            }
        }
    }
}

