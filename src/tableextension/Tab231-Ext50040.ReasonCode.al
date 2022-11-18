tableextension 50040 "BC6_ReasonCode" extends "Reason Code"  //231
{
    fields
    {

        field(80800; "BC6_Disable DEEE"; Boolean)
        {
            Caption = 'Disable DEEE', Comment = 'FRA="Désactiver DEEE"';
            DataClassification = CustomerContent;

        }
    }

}

