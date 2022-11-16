tableextension 50062 "BC6_WarehouseActivityHeader" extends "Warehouse Activity Header" //5766
{
    fields
    {
        field(50000; "BC6_Sales Counter"; Boolean)
        {
            Caption = 'Sales Counter', Comment = 'FRA="Vente comptoire"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF "BC6_Sales Counter" THEN BEGIN
                    TESTFIELD("Source Document", "Source Document"::"Sales Order");
                    TESTFIELD("Source No.", '');
                    IF LineExist() THEN
                        ERROR(Text002, FIELDCAPTION("BC6_Sales Counter"));
                    VALIDATE("Posting Date", WORKDATE());
                END;
            end;
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
                FctMangt: Codeunit BC6_FctMangt;
            begin
                // IF xRec."BC6_Bin Code" <> "BC6_Bin Code" THEN BEGIN //TODO: Check empty Conditional Statements
                // END;

                IF "BC6_Bin Code" <> '' THEN begin
                    TESTFIELD(Type, Type::"Invt. Pick");
                    FctMangt.GetLocation("Location Code");
                    TESTFIELD("Location Code");
                    Location.GET("Location Code");
                    Location.TESTFIELD("Bin Mandatory");
                end;
            end;
        }
    }

    var
        Customer: Record Customer;
        Location: Record Location;
        Text002: Label 'You cannot change %1 because one or more lines exist.', Comment = 'FRA="Vous ne pouvez pas modifier %1 car il existe une ou plusieurs lignes."';
}

