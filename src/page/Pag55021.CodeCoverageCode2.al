page 55021 "BC6_Code Coverage Code 2"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Code Coverage";
    UsageCategory = Lists;
    ApplicationArea = All;
    Caption = 'Code coverage';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    StyleExpr = LineStyle;
                    ApplicationArea = All;
                }
                field(Line; Rec.Line)
                {
                    StyleExpr = LineStyle;
                    ApplicationArea = All;
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

