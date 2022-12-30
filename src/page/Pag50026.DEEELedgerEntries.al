page 50026 "BC6_DEEE Ledger Entries"
{
    Caption = 'DEEE Ledger Entries', Comment = 'FRA="Ecritures DEEE"';
    Editable = false;
    PageType = List;
    SourceTable = "BC6_DEEE Ledger Entry";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Invoiced Quantity"; "Invoiced Quantity")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; "Source Type")
                {
                    ApplicationArea = All;
                }
                field("DEEE Category Code"; "DEEE Category Code")
                {
                    ApplicationArea = All;
                }
                field("DEEE Unit Tax"; "DEEE Unit Tax")
                {
                    ApplicationArea = All;
                }
                field("DEEE HT Amount"; "DEEE HT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE VAT Amount"; "DEEE VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE TTC Amount"; "DEEE TTC Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

