tableextension 50044 "BC6_PurchCommentLine" extends "Purch. Comment Line"
{
    LookupPageID = "Purch. Comment List";
    DrillDownPageID = "Purch. Comment List";
    fields
    {
        field(50000; "BC6_User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(50001; "BC6_Log Date"; DateTime)
        {
            Caption = 'Log Date';
            Editable = false;
        }
        field(50002; "BC6_Is Log"; Boolean)
        {
            Caption = 'Is Log';
            Editable = false;
        }
    }

}

