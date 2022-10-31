tableextension 50080 "BC6_Bin" extends Bin
{
    fields
    {
        field(50000; "BC6_To Make Available"; Boolean)
        {
            Caption = 'To Make Available';
            Description = 'CNE4.02';
        }
        field(50001; "BC6_Sales Order Not Shipped"; Boolean)
        {
            // CalcFormula = Exist("Sales Header" WHERE("Document Type" = CONST(Order), TODO:
            //                                           "Completely Shipped" = CONST(No), 
            //                                           "Location Code" = FIELD("Location Code"),
            //                                           "Bin Code" = FIELD(Code)));
            Caption = 'Sales Order To Ship';
            Description = 'CNE4.02';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "BC6_Exclude Inventory Pick"; Boolean)
        {
            Caption = 'Exclude Inventory Pick';
        }
    }
}

