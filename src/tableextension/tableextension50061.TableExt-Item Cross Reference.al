tableextension 50061 tableextension50061 extends "Item Cross Reference"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //>> CNE4.01
    // A:FE02 01.09.2011 : Assign Internal Item Code
    //                   - Add Field 50000 Internal Bar Code
    //                   - Add Field 50001 Inventory
    LookupPageID = 5724;
    fields
    {
        modify("Cross-Reference Type No.")
        {
            TableRelation = IF (Cross-Reference Type=CONST(Customer)) Customer.No.
                            ELSE IF (Cross-Reference Type=CONST(Vendor)) Vendor.No.;
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        field(50000; "Internal Bar Code"; Boolean)
        {
            Caption = 'Internal Bar Code';
            Description = 'CNE4.01';

            trigger OnValidate()
            begin
                //>> A:FE02 Begin
                IF ("Internal Bar Code") AND
                   ("Cross-Reference Type" <> "Cross-Reference Type"::"Bar Code")
                THEN
                    ERROR(Text001, TABLECAPTION);
                //<< End
            end;
        }
        field(50001; Inventory; Decimal)
        {
            CalcFormula = Sum ("Item Ledger Entry".Quantity WHERE (Item No.=FIELD(Item No.),
                                                                  Variant Code=FIELD(Variant Code)));
            Caption = 'Inventory';
            DecimalPlaces = 0:5;
            Description = 'CNE4.01';
            Editable = false;
            FieldClass = FlowField;
        }
    }


    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Cross-Reference Type No." <> '') AND
           ("Cross-Reference Type" = "Cross-Reference Type"::" ")
        THEN
          ERROR(Text000,FIELDCAPTION("Cross-Reference Type No."));
        IF xRec."Cross-Reference Type" = "Cross-Reference Type"::Vendor THEN
          DeleteItemVendor(xRec);
        IF "Cross-Reference Type" = "Cross-Reference Type"::Vendor THEN
          CreateItemVendor;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4

        IF ("Cross-Reference Type" = "Cross-Reference Type"::Vendor) AND NOT ItemVendorResetRequired(xRec,Rec) THEN
          UpdateItemVendorNo(xRec,"Cross-Reference No.")
        ELSE BEGIN
          IF xRec."Cross-Reference Type" = "Cross-Reference Type"::Vendor THEN
            DeleteItemVendor(xRec);
          IF "Cross-Reference Type" = "Cross-Reference Type"::Vendor THEN
            CreateItemVendor;
        END;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CreateItemVendor(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "CreateItemVendor(PROCEDURE 1)".

    //procedure CreateItemVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Cross-Reference Type" = "Cross-Reference Type"::Vendor) AND
           ItemVend.WRITEPERMISSION
        THEN BEGIN
          ItemVend.RESET;
          ItemVend.SETRANGE("Item No.","Item No.");
          ItemVend.SETRANGE("Vendor No.","Cross-Reference Type No.");
          ItemVend.SETRANGE("Variant Code","Variant Code");
          IF NOT ItemVend.FIND('-') THEN BEGIN
            ItemVend."Item No." := "Item No.";
            ItemVend."Vendor No." := "Cross-Reference Type No.";
            ItemVend.VALIDATE("Vendor No.");
            ItemVend."Variant Code" := "Variant Code";
            ItemVend."Vendor Item No." := "Cross-Reference No.";
            ItemVend.INSERT;
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
          IF ItemVend.ISEMPTY THEN BEGIN
        #9..16
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "DeleteItemVendor(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "DeleteItemVendor(PROCEDURE 2)".

    //procedure DeleteItemVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemCrossReference2.SETRANGE("Item No.",ItemCrossReference."Item No.");
        ItemCrossReference2.SETRANGE("Variant Code",ItemCrossReference."Variant Code");
        ItemCrossReference2.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type");
        ItemCrossReference2.SETRANGE("Cross-Reference Type No.",ItemCrossReference."Cross-Reference Type No.");
        ItemCrossReference2.SETRANGE("Cross-Reference No.",ItemCrossReference."Cross-Reference No.");
        ItemCrossReference2.SETFILTER("Unit of Measure",'<>%1',ItemCrossReference."Unit of Measure");
        IF NOT ItemCrossReference2.FINDFIRST THEN BEGIN
          ItemVend.RESET;
          ItemVend.SETRANGE("Item No.",ItemCrossReference."Item No.");
          ItemVend.SETRANGE("Vendor No.",ItemCrossReference."Cross-Reference Type No.");
          ItemVend.SETRANGE("Variant Code",ItemCrossReference."Variant Code");
          IF ItemVend.FIND('-') THEN
            REPEAT
              IF UPPERCASE(DELCHR(ItemVend."Vendor Item No.",'<',' ')) = ItemCrossReference."Cross-Reference No." THEN
                ItemVend.DELETE;
            UNTIL ItemVend.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT MultipleCrossReferencesExist(ItemCrossReference) THEN
          IF ItemVend.GET(ItemCrossReference."Cross-Reference Type No.",ItemCrossReference."Item No.",ItemCrossReference."Variant Code") THEN
            IF UPPERCASE(DELCHR(ItemVend."Vendor Item No.",'<',' ')) = ItemCrossReference."Cross-Reference No." THEN
              ItemVend.DELETE;
        */
    //end;

    local procedure UpdateItemVendorNo(ItemCrossReference: Record "5717";NewCrossRefNo: Code[20])
    begin
        IF NOT MultipleCrossReferencesExist(ItemCrossReference) THEN
          IF ItemVend.GET(ItemCrossReference."Cross-Reference Type No.",ItemCrossReference."Item No.",ItemCrossReference."Variant Code") THEN BEGIN
            ItemVend.VALIDATE("Vendor Item No.",NewCrossRefNo);
            ItemVend.MODIFY;
          END;
    end;

    local procedure ItemVendorResetRequired(OldItemCrossRef: Record "5717";NewItemCrossRef: Record "5717"): Boolean
    begin
        EXIT(
          (OldItemCrossRef."Item No." <> NewItemCrossRef."Item No.") OR
          (OldItemCrossRef."Variant Code" <> NewItemCrossRef."Variant Code") OR
          (OldItemCrossRef."Cross-Reference Type" <> NewItemCrossRef."Cross-Reference Type") OR
          (OldItemCrossRef."Cross-Reference Type No." <> NewItemCrossRef."Cross-Reference Type No."));
    end;

    local procedure MultipleCrossReferencesExist(ItemCrossReference: Record "5717"): Boolean
    var
        ItemCrossReference2: Record "5717";
    begin
        ItemCrossReference2.SETRANGE("Item No.",ItemCrossReference."Item No.");
        ItemCrossReference2.SETRANGE("Variant Code",ItemCrossReference."Variant Code");
        ItemCrossReference2.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type");
        ItemCrossReference2.SETRANGE("Cross-Reference Type No.",ItemCrossReference."Cross-Reference Type No.");
        ItemCrossReference2.SETRANGE("Cross-Reference No.",ItemCrossReference."Cross-Reference No.");
        ItemCrossReference2.SETFILTER("Unit of Measure",'<>%1',ItemCrossReference."Unit of Measure");

        EXIT(NOT ItemCrossReference2.ISEMPTY);
    end;

    procedure GetItemDescription(var ItemDescription: Text;ItemNo: Code[20];VariantCode: Code[10];UnitOfMeasureCode: Code[10];CrossRefType: Option;CrossRefTypeNo: Code[20]): Boolean
    var
        ItemCrossReference: Record "5717";
    begin
        ItemCrossReference.SETRANGE("Item No.",ItemNo);
        ItemCrossReference.SETRANGE("Variant Code",VariantCode);
        ItemCrossReference.SETRANGE("Unit of Measure",UnitOfMeasureCode);
        ItemCrossReference.SETRANGE("Cross-Reference Type",CrossRefType);
        ItemCrossReference.SETRANGE("Cross-Reference Type No.",CrossRefTypeNo);
        IF ItemCrossReference.FINDFIRST THEN BEGIN
          IF ItemCrossReference.Description = '' THEN
            EXIT(FALSE);
          ItemDescription := ItemCrossReference.Description;
          EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;

    procedure HasValidUnitOfMeasure(): Boolean
    var
        ItemUnitOfMeasure: Record "5404";
    begin
        IF "Unit of Measure" = '' THEN
          EXIT(TRUE);
        ItemUnitOfMeasure.SETRANGE("Item No.","Item No.");
        ItemUnitOfMeasure.SETRANGE(Code,"Unit of Measure");
        EXIT(ItemUnitOfMeasure.FINDFIRST);
    end;

    //Unsupported feature: Deletion (VariableCollection) on "DeleteItemVendor(PROCEDURE 2).ItemCrossReference2(Variable 1001)".

}

