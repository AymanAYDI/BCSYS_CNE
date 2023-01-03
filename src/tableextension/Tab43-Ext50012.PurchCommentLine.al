tableextension 50012 "BC6_PurchCommentLine" extends "Purch. Comment Line" //43
{
    fields
    {
        field(50000; "BC6_User ID"; Code[50])
        {
            Caption = 'User ID', comment = 'FRA="Code utilisateur"';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Log Date"; DateTime)
        {
            Caption = 'Log Date', comment = 'FRA="Date de log"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Is Log"; Boolean)
        {
            Caption = 'Is Log', comment = 'FRA="Est un log"';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    trigger OnInsert()
    begin
        IF "BC6_Is Log" THEN BEGIN
            "BC6_Log Date" := CURRENTDATETIME;
            "BC6_User ID" := CopyStr(USERID, 1, MaxStrLen("BC6_User ID"));
        END;
    END;
}
