tableextension 50062 "BC6_WarehouseActivityHeader" extends "Warehouse Activity Header"
{
    fields
    {
        modify("Destination No.")
        {
            trigger OnAfterValidate()
            begin
                case "Destination Type" of
                    "Destination Type"::Customer:
                        BEGIN
                            Customer.GET("Destination No.");
                            CASE Customer.Blocked OF
                                1, 3:
                                    Customer.TESTFIELD(Blocked, 0);
                            END;
                        END;
                end;
            end;
        }
        field(50000; "BC6_Sales Counter"; Boolean)
        {
            Caption = 'Sales Counter';

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
            Description = 'CN4.01';

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
                //>> C:FE09 Begin
                IF xRec."BC6_Bin Code" <> "BC6_Bin Code" THEN BEGIN
                END;

                IF "BC6_Bin Code" <> '' THEN BEGIN
                    TESTFIELD(Type, Type::"Invt. Pick");
                    // GetLocation("Location Code"); TODO:
                    TESTFIELD("Location Code");
                    Location.GET("Location Code");
                    Location.TESTFIELD("Bin Mandatory");
                END;
                //>> End
            end;
        }
    }

    var
        Customer: Record Customer;
        Location: Record Location;
        Text002: Label 'You cannot change %1 because one or more lines exist.', Comment = 'FRA="Vous ne pouvez pas modifier %1 car il existe une ou plusieurs lignes."';
}

