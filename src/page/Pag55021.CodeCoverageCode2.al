page 55021 "BC6_Code Coverage Code 2"
{
    ApplicationArea = All;
    Caption = 'Code coverage';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Code Coverage";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LineStyle;
                }
                field(Line; Rec.Line)
                {
                    ApplicationArea = All;
                    StyleExpr = LineStyle;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        LineStyle := 'None';

        CASE TRUE OF
            Rec."Line Type" = Rec."Line Type"::Object:
                LineStyle := 'Strong';
            Rec."Line Type" = Rec."Line Type"::"Trigger/Function":
                LineStyle := 'StrongAccent';
            (Rec."Line Type" = Rec."Line Type"::Code) AND (Rec."No. of Hits" = 0):
                LineStyle := 'Ambiguous';
            (Rec."Line Type" = Rec."Line Type"::Empty):
                LineStyle := 'Ambiguous';
        END;
    end;

    var
        LineStyle: Text;
}
