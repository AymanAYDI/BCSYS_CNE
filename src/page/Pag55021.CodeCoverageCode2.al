page 55021 "BC6_Code Coverage Code 2"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Code Coverage";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    StyleExpr = LineStyle;
                    ApplicationArea = All;
                }
                field(Line; Line)
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
            "Line Type" = "Line Type"::Object:
                LineStyle := 'Strong';
            "Line Type" = "Line Type"::"Trigger/Function":
                LineStyle := 'StrongAccent';
            ("Line Type" = "Line Type"::Code) AND ("No. of Hits" = 0):
                LineStyle := 'Ambiguous';
            ("Line Type" = "Line Type"::Empty):
                LineStyle := 'Ambiguous';
        END;
    end;

    var
        LineStyle: Text;
}

