tableextension 50044 tableextension50044 extends "Purch. Comment Line"
{
    LookupPageID = 68;
    DrillDownPageID = 68;
    fields
    {
        field(50000; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(50001; "Log Date"; DateTime)
        {
            Caption = 'Log Date';
            Editable = false;
        }
        field(50002; "Is Log"; Boolean)
        {
            Caption = 'Is Log';
            Editable = false;
        }
    }


    //Unsupported feature: Code Insertion on "OnInsert".

    //trigger OnInsert()
    //begin
    /*
    //BCSYS - MM
    IF "Is Log" THEN BEGIN
      "Log Date" := CURRENTDATETIME;
      "User ID" := USERID;
    END;
    //FIN BCSYS - MM
    */
    //end;
}

