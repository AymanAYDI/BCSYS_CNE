pageextension 50107 pageextension50107 extends "Order Processor Role Center"
{
    layout
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Control 1901851508".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Control 1".

        addafter("Control 1907692008")
        {
            part("Company Picture"; 50099)
            {
                Caption = 'Company Picture';
            }
        }
        addafter("Control 1905989608")
        {
            part(; 681)
            {
            }
        }
        moveafter("Control 1901851508"; "Control 1907692008")
    }
}

