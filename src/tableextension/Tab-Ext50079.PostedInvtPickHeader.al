tableextension 50079 "BC6_PostedInvtPickHeader" extends "Posted Invt. Pick Header"
{
    fields
    {
        field(50000; "BC6_Sales Counter"; Boolean)
        {
            Caption = 'Sales Counter';
        }
        field(50001; "BC6_Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(50002; "BC6_Destination Name"; Text[50])
        {
            Caption = 'Destination Name.';
        }
        field(50003; "BC6_Destination Name 2"; Text[50])
        {
            Caption = 'Destination Name 2';
        }
        field(50004; BC6_Comments; Text[50])
        {
            Caption = 'Comments';
        }
        field(50403; "BC6_Bin Code"; Code[20])
        {
            Caption = 'Bin Code';

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

