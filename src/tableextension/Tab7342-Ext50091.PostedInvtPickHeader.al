tableextension 50091 "BC6_PostedInvtPickHeader" extends "Posted Invt. Pick Header" //7342
{
    fields
    {
        field(50000; "BC6_Sales Counter"; Boolean)
        {
            Caption = 'Sales Counter', Comment = 'FRA="Vente comptoire"';
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Your Reference"; Text[35])
        {
            Caption = 'Your Reference', Comment = 'FRA="Votre référence"';
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Destination Name"; Text[50])
        {
            Caption = 'Destination Name.', Comment = 'FRA="Nom destination"';
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Destination Name 2"; Text[50])
        {
            Caption = 'Destination Name 2', Comment = 'FRA="Nom destination 2"';
            DataClassification = CustomerContent;
        }
        field(50004; BC6_Comments; Text[50])
        {
            Caption = 'Comments', Comment = 'FRA="Commentaires"';
            DataClassification = CustomerContent;
        }
        field(50403; "BC6_Bin Code"; Code[20])
        {
            Caption = 'Bin Code', Comment = 'FRA="Code emplacement"';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                WMSManagement: Codeunit "WMS Management";
                BinCode: Code[20];
            begin
                BinCode := WMSManagement.BinLookUp("Location Code", '', '', '');

                IF BinCode <> '' THEN
                    VALIDATE("BC6_Bin Code", BinCode);
            end;

            trigger OnValidate()
            var
                WMSManagement: Codeunit "WMS Management";
            begin
            end;
        }
    }
}

