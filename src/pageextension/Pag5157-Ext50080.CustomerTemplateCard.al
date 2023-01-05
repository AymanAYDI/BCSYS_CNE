pageextension 50080 "BC6_CustomerTemplateCard" extends "Customer Template Card" //5157
{
    layout
    {
        addafter("Shipment Method Code")
        {
            field("BC6_Submitted to DEEE"; Rec."BC6_Submitted to DEEE")
            {
            }
        }
    }
}
