#pragma warning disable AL0432
pageextension 50080 "BC6_CustomerTemplateCard" extends "Customer Template Card" //5157
{
    layout
    {
        addafter("Shipment Method Code")
        {
            field("BC6_Submitted to DEEE"; "BC6_Submitted to DEEE")
            {
            }
        }
    }
}
#pragma warning restore AL0432
