tableextension 50041 "BC6_ItemJournalBatch" extends "Item Journal Batch" //233
{
    fields
    {
        field(50000; "BC6_Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID', Comment = 'FRA="Code utilisateur affecté"';
            DataClassification = CustomerContent;
            TableRelation = "Warehouse Employee";
        }
        field(50001; "BC6_Phys. Inv. Survey"; Boolean)
        {
            Caption = 'Relevé inventaire', Comment = 'FRA="Relevé inventaire"';
            DataClassification = CustomerContent;

            trigger OnValidate()

            begin
                IF "BC6_Phys. Inv. Survey" THEN BEGIN
                    ItemJnlTemplate.GET("Journal Template Name");
                    ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::"Phys. Inventory");
                END ELSE
                    "BC6_Phys. Inv. Check Bat. Name" := '';
            end;
        }
        field(50002; "BC6_Phys. Inv. Check Bat. Name"; Code[10])
        {
            Caption = 'Nom feuille contrôle inventaire', Comment = 'FRA="Nom feuille contrôle inventaire"';
            DataClassification = CustomerContent;
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
