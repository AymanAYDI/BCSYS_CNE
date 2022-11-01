page 55021 "Code Coverage Code 2"
{
    // **************************************************************************************************************************
    // Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including,
    // but not limited to, the implied warranties of merchantability or fitness for a particular purpose. This posting assumes
    // that you are familiar with the programming language that is being demonstrated and the tools that are used to create and
    // debug procedures.
    // 
    // Copyright ® Microsoft Corporation. All Rights Reserved.
    // This code released under the terms of the
    // Microsoft Public License (MS-PL, http://opensource.org/licenses/ms-pl.html)
    // **************************************************************************************************************************

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table2000000049;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    StyleExpr = LineStyle;
                }
                field(Line; Line)
                {
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

