tableextension 50080 "BC6_Bin" extends Bin
{
    fields
    {
        field(50000; "BC6_To Make Available"; Boolean)
        {
            Caption = 'To Make Available';
        }
        field(50001; "BC6_Sales Order Not Shipped"; Boolean)
        {

            FieldClass = FlowField;
            CalcFormula = Exist("Sales Header" WHERE("Document Type" = CONST(Order),
                                                      "Completely Shipped" = CONST(false),
                                                      "Location Code" = FIELD("Location Code"),
                                                      "BC6_Bin Code" = FIELD(Code)));
            Caption = 'Sales Order To Ship';
            Editable = false;
        }
        field(50002; "BC6_Exclude Inventory Pick"; Boolean)
        {
            Caption = 'Exclude Inventory Pick';
        }
    }
}

