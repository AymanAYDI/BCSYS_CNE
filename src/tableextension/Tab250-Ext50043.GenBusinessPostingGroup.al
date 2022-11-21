tableextension 50043 "BC6_GenBusinessPostingGroup" extends "Gen. Business Posting Group" //250
{
    fields
    {
        field(80800; "BC6_Subject to DEEE"; Boolean)
        {
            Caption = 'Subject to DEEE', Comment = 'FRA="Soumis à la DEEE"';
            DataClassification = CustomerContent;
        }
    }
}
