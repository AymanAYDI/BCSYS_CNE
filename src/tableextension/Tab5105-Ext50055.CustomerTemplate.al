tableextension 50055 "BC6_CustomerTemplate" extends "Customer Template" //5105
{
    fields
    {
        field(80800; "BC6_Submitted to DEEE"; Boolean)
        {
            Caption = 'Submitted to DEEE', Comment = 'FRA="Soumis à la DEEE"';
            DataClassification = CustomerContent;
        }
    }
}

