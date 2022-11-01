page 50026 "DEEE Ledger Entries"
{
    Caption = 'DEEE Ledger Entries';
    Editable = false;
    PageType = List;
    SourceTable = Table50008;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                }
                field("Entry No."; "Entry No.")
                {
                }
                field("Item No."; "Item No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Entry Type"; "Entry Type")
                {
                }
                field("Source No."; "Source No.")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Invoiced Quantity"; "Invoiced Quantity")
                {
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                }
                field("Source Type"; "Source Type")
                {
                }
                field("DEEE Category Code"; "DEEE Category Code")
                {
                }
                field("DEEE Unit Tax"; "DEEE Unit Tax")
                {
                }
                field("DEEE HT Amount"; "DEEE HT Amount")
                {
                }
                field("DEEE VAT Amount"; "DEEE VAT Amount")
                {
                }
                field("DEEE TTC Amount"; "DEEE TTC Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}

