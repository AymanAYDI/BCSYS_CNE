pageextension 50065 pageextension50065 extends "Purchases & Payables Setup"
{
    layout
    {

        //Unsupported feature: Property Modification (Level) on "Control 55".


        //Unsupported feature: Property Modification (Level) on "Control 57".


        //Unsupported feature: Property Modification (Level) on "Control 59".


        //Unsupported feature: Property Modification (Level) on "Control 61".

        addafter("Control 38")
        {
            field("Minima de cde"; "Minima de cde")
            {
                ShowCaption = false;
            }
            group("Freigth charge")
            {
                Caption = 'Freigth charge';
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field("DEEE Management"; "DEEE Management")
                {
                    ShowCaption = false;
                }
                field("Ask custom purch price"; "Ask custom purch price")
                {
                    ShowCaption = false;
                }
            }
        }
        addafter("Control 40")
        {
            field("SAV Return Order Nos."; "SAV Return Order Nos.")
            {
            }
        }
    }
}

