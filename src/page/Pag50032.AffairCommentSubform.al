page 50032 "BC6_Affair Comment Sub-form"
{
    AutoSplitKey = true;
    Caption = 'Affair Comment Sub-form', Comment = 'FRA="Commentaire affaire sous-form"';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Comment Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Date"; Date)
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
                field("Table Name"; "Table Name")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetUpNewLine();
    end;
}

