pageextension 50091 "BC6_ReturnReasons" extends "Return Reasons" //6635
{
    layout
    {
        addafter("Inventory Value Zero")
        {
            field(BC6_Type; Rec.BC6_Type)
            {
                ApplicationArea = All;
            }
        }
    }
}
