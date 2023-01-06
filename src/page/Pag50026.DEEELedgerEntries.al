page 50026 "BC6_DEEE Ledger Entries"
{
    Caption = 'DEEE Ledger Entries', Comment = 'FRA="Ecritures DEEE"';
    Editable = false;
    PageType = List;
    SourceTable = "BC6_DEEE Ledger Entry";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("DEEE Category Code"; Rec."DEEE Category Code")
                {
                    ApplicationArea = All;
                }
                field("DEEE Unit Tax"; Rec."DEEE Unit Tax")
                {
                    ApplicationArea = All;
                }
                field("DEEE HT Amount"; Rec."DEEE HT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE VAT Amount"; Rec."DEEE VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE TTC Amount"; Rec."DEEE TTC Amount")
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

