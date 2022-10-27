tableextension 50024 tableextension50024 extends "Item Journal Batch"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>> CNE4.01
    // B:FE04 01.09.2011 : MiniForm Menu User
    //                        - Add Field : 50000 Assigned User
    //                        - Add Field : 50001 Phys. Inv. Survey
    //                        - Add Field : 50002 Phys. Inv. Check Batch
    LookupPageID = 262;
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }
        field(50000; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            TableRelation = "Warehouse Employee";
        }
        field(50001; "Phys. Inv. Survey"; Boolean)
        {
            Caption = 'Relevé inventaire';

            trigger OnValidate()
            begin
                //>> CNE4.01 B:FE04 Begin
                IF "Phys. Inv. Survey" THEN BEGIN
                    ItemJnlTemplate.GET("Journal Template Name");
                    ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::"Phys. Inventory");
                END ELSE BEGIN
                    "Phys. Inv. Check Batch Name" := '';
                END;
                //<< End
            end;
        }
        field(50002; "Phys. Inv. Check Batch Name"; Code[10])
        {
            Caption = 'Nom feuille contrôle inventaire';
            TableRelation = "Item Journal Batch".Name WHERE (Journal Template Name=FIELD(Journal Template Name),
                                                             Phys. Inv. Survey=CONST(No));

            trigger OnValidate()
            begin
                //>> CNE4.01 B:FE04 Begin
                IF "Phys. Inv. Survey" THEN BEGIN
                    ItemJnlTemplate.GET("Journal Template Name");
                    ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::"Phys. Inventory");
                    TESTFIELD("Phys. Inv. Survey");
                END;
                //<< End
            end;
        }
    }
}

