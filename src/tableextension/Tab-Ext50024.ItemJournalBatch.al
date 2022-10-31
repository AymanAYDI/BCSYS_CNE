tableextension 50024 "BC6_ItemJournalBatch" extends "Item Journal Batch"
{
    LookupPageID = "Item Journal Batches";
    fields
    {
        field(50000; "BC6_Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            TableRelation = "Warehouse Employee";
        }
        field(50001; "BC6_Phys. Inv. Survey"; Boolean)
        {
            Caption = 'Relevé inventaire';

            trigger OnValidate()

            begin
                IF "BC6_Phys. Inv. Survey" THEN BEGIN
                    ItemJnlTemplate.GET("Journal Template Name");
                    ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::"Phys. Inventory");
                END ELSE BEGIN
                    "BC6_Phys. Inv. Check Batch Name" := '';
                END;

            end;
        }
        field(50002; "BC6_Phys. Inv. Check Batch Name"; Code[10])
        {
            Caption = 'Nom feuille contrôle inventaire';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"),
                                                             "BC6_Phys. Inv. Survey" = CONST(false));

            trigger OnValidate()
            begin

                IF "BC6_Phys. Inv. Survey" THEN BEGIN
                    ItemJnlTemplate.GET("Journal Template Name");
                    ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::"Phys. Inventory");
                    TESTFIELD("BC6_Phys. Inv. Survey");
                END;

            end;
        }
    }
    var
        ItemJnlTemplate: Record "Item Journal Template";
}

