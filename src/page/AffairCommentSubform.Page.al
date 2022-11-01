page 50032 "Affair Comment Sub-form"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 14/11/2007 : Gestion des appeles d'offres clients
    //  - Form created
    // ------------------------------------------------------------------------

    AutoSplitKey = true;
    Caption = 'Affair Comment Sub-form';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = Table97;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Date; Date)
                {
                }
                field(Comment; Comment)
                {
                }
                field("Table Name"; "Table Name")
                {
                }
                field("No."; "No.")
                {
                }
                field("Line No."; "Line No.")
                {
                }
                field(Code; Code)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetUpNewLine;
    end;
}

