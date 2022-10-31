tableextension 50087 "BC6_PurchaseCue" extends "Purchase Cue"
{
    fields
    {
        field(50010; "BC6_Purchase Return - Location"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER("Return Order"),
                                                         "BC6_Return Order Type" = FILTER(Location),
                                                         Status = FILTER(Open),
                                                         "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Retours achat - Magasin';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "BC6_Purchase Return - SAV"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER("Return Order"),
                                                         "BC6_Return Order Type" = FILTER(SAV),
                                                         Status = FILTER(Open),
                                                         "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Retours achat - SAV';
            FieldClass = FlowField;
        }
    }
}

