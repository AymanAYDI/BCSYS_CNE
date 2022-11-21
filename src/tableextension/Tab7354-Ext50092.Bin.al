tableextension 50092 "BC6_Bin" extends Bin //7354
{
    fields
    {
        field(50000; "BC6_To Make Available"; Boolean)
        {
            Caption = 'To Make Available', Comment = 'FRA="Mettre à disposition"';
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Sales Order Not Shipped"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Header" WHERE("Document Type" = CONST(Order),
                                                      "Completely Shipped" = CONST(false),
                                                      "Location Code" = FIELD("Location Code"),
                                                      "BC6_Bin Code" = FIELD(Code)));
            Caption = 'Sales Order To Ship', Comment = 'FRA="Commande vente à livrer"';
            Editable = false;
        }
        field(50002; "BC6_Exclude Inventory Pick"; Boolean)
        {
            Caption = 'Exclude Inventory Pick', Comment = 'FRA="Exclure prélèvement stock"';
            DataClassification = CustomerContent;
        }
    }
}
