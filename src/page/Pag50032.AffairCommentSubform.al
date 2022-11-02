page 50032 "BC6_Affair Comment Sub-form"
{
    AutoSplitKey = true;
    Caption = 'Affair Comment Sub-form';
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
                field("Code"; Code)
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
        SetUpNewLine();
    end;
}

