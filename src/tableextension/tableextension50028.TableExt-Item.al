tableextension 50028 tableextension50028 extends Item
{
    // ----------------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ----------------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout des champs 50000, 50001
    //                                                      Ajout de code dans le trigger OnInsert() pour alimenter ces champs
    // //DEFAULT SM 16/10/06 NCS1.01 [FE024V1] valeur par défaut pour Calcul prix ou marge = "Prix=Coût + Marge"
    //                                                                Mode évaluation stock = "Standard"
    //                                                             et Méthode réapprovisionnement = "Qté maximum"
    //                                         Ajout du champ 50021 Goupe Marge Vente Article
    // //DEBLOQUER_ARTICLE FG 04/12/2006 NSC1.01 [007] Débloquer article
    // //GESTION_REMISE FG 06/12/06 NSC1.01
    // 
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800..80803
    //           - OnInsert()
    // 
    // //>>CNE3.01
    // SSOBINAV_200910_06_CNE:NIRO 03/11/09 : - add test on vendor no.
    // 
    // //>> CNE4.01
    // B:FE06 01.09.2011 : Item Card - Show Quantity on Invt Pick List
    //        - Add Field    : 50040 Pick Qty
    //        - Add Function : CalcQtyAvailToPick
    // 
    // //>> CNE4.03 Calc. Price Include VAT
    //   - Add Field    : 50041 Unit Price Includes VAT
    //                  : 50042 Print Unit Price Includes VAT
    //   - Add Code in OnValidate function : Price/Profit Calculation
    // 
    // //>>MODIF HL
    // TI287704 DO.GEPO 03/08/2015 : Modify  Price/Profit Calculation - OnValidate and OnInsert
    // 
    // ------------------------------------------------------------------------------------
    // 
    // //>>BCSYS Flux SAV
    //     - Add Field : "Qty. Return Order SAV" ID 50060
    LookupPageID = 31;
    DrillDownPageID = 31;
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Search Description")
        {
            Caption = 'Search Description';
        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }
        modify("Price/Profit Calculation")
        {
            OptionCaption = 'Price=Cost+Profit,Profit=Price-Cost,No Relationship';

            //Unsupported feature: Property Modification (OptionString) on ""Price/Profit Calculation"(Field 19)".

            Description = 'DEFAULT SM 16/10/06 NCS1.01 [FE024V1] valeur par défaut Prix=Coût+Marge';
        }
        modify("Costing Method")
        {
            OptionCaption = 'Standard,FIFO,LIFO,Specific,Average';

            //Unsupported feature: Property Modification (OptionString) on ""Costing Method"(Field 21)".

            Description = 'DEFAULT SM 16/10/06 NCS1.01 [FE024V1] valeur par défaut Standard';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Lead Time Calculation"(Field 33)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reorder Point"(Field 34)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Maximum Inventory"(Field 35)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reorder Quantity"(Field 36)".


        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 53)".


        //Unsupported feature: Property Modification (CalcFormula) on "Inventory(Field 68)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Net Invoiced Qty."(Field 69)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Net Change"(Field 70)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Purchases (Qty.)"(Field 71)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Sales (Qty.)"(Field 72)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Positive Adjmt. (Qty.)"(Field 73)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Negative Adjmt. (Qty.)"(Field 74)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Purchases (LCY)"(Field 77)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Sales (LCY)"(Field 78)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Positive Adjmt. (LCY)"(Field 79)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Negative Adjmt. (LCY)"(Field 80)".


        //Unsupported feature: Property Modification (CalcFormula) on ""COGS (LCY)"(Field 83)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. on Purch. Order"(Field 84)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Qty. on Purch. Order"(Field 84)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. on Sales Order"(Field 85)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Qty. on Sales Order"(Field 85)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Drop Shipment Filter"(Field 89)".


        //Unsupported feature: Property Modification (Data type) on "Picture(Field 92)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Transferred (Qty.)"(Field 93)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Transferred (LCY)"(Field 94)".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Reserve(Field 100)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Qty. on Inventory"(Field 101)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reserved Qty. on Inventory"(Field 101)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Qty. on Purch. Orders"(Field 102)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reserved Qty. on Purch. Orders"(Field 102)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Qty. on Sales Orders"(Field 103)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reserved Qty. on Sales Orders"(Field 103)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Res. Qty. on Outbound Transfer"(Field 107)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Res. Qty. on Outbound Transfer"(Field 107)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Res. Qty. on Inbound Transfer"(Field 108)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Res. Qty. on Inbound Transfer"(Field 108)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Cost of Open Production Orders"(Field 200)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Assembly Policy"(Field 910)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Res. Qty. on Assembly Order"(Field 929)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Res. Qty. on Assembly Order"(Field 929)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Res. Qty. on  Asm. Comp."(Field 930)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Res. Qty. on  Asm. Comp."(Field 930)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. on Assembly Order"(Field 977)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. on Asm. Component"(Field 978)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. on Job Order"(Field 1001)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Res. Qty. on Job Order"(Field 1002)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Res. Qty. on Job Order"(Field 1002)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Lot Size"(Field 5401)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Scrap %"(Field 5407)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Minimum Order Quantity"(Field 5411)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Maximum Order Quantity"(Field 5412)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Safety Stock Quantity"(Field 5413)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Order Multiple"(Field 5414)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Safety Lead Time"(Field 5415)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Flushing Method"(Field 5417)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Replenishment System"(Field 5419)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Scheduled Receipt (Qty.)"(Field 5420)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Scheduled Need (Qty.)"(Field 5421)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Rounding Precision"(Field 5422)".

        modify("Sales Unit of Measure")
        {
            TableRelation = IF (No.=FILTER(<>'')) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
                            ELSE "Unit of Measure";
        }
        modify("Purch. Unit of Measure")
        {
            TableRelation = IF (No.=FILTER(<>'')) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
                            ELSE "Unit of Measure";
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Time Bucket"(Field 5428)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Qty. on Prod. Order"(Field 5429)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Reserved Qty. on Prod. Order"(Field 5429)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Res. Qty. on Prod. Order Comp."(Field 5430)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Res. Qty. on Prod. Order Comp."(Field 5430)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Res. Qty. on Req. Line"(Field 5431)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Res. Qty. on Req. Line"(Field 5431)".

        modify("Reordering Policy")
        {

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Reordering Policy"(Field 5440)".

            Description = 'DEFAULT SM 16/10/06 NCS1.01 [FE024V1] valeur par défaut Maximum Qty., -> Remis en std MIG 2017';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Include Inventory"(Field 5441)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Manufacturing Policy"(Field 5442)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Rescheduling Period"(Field 5443)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Lot Accumulation Period"(Field 5444)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Dampener Period"(Field 5445)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Dampener Quantity"(Field 5446)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Overflow Level"(Field 5447)".


        //Unsupported feature: Property Modification (Data type) on ""Item Category Code"(Field 5702)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Created From Nonstock Item"(Field 5703)".


        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Product Group Code"(Field 5704)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Substitutes Exist"(Field 5706)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. in Transit"(Field 5707)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Trans. Ord. Receipt (Qty.)"(Field 5708)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Trans. Ord. Shipment (Qty.)"(Field 5709)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. Assigned to ship"(Field 5776)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. Picked"(Field 5777)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. on Service Order"(Field 5901)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Res. Qty. on Service Orders"(Field 5902)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Res. Qty. on Service Orders"(Field 5902)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Substitutes"(Field 7171)".

        modify("Put-away Unit of Measure Code")
        {
            TableRelation = IF (No.=FILTER(<>'')) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
                            ELSE "Unit of Measure";

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Put-away Unit of Measure Code"(Field 7307)".

        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Last Counting Period Update"(Field 7381)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Last Phys. Invt. Date"(Field 7383)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Use Cross-Docking"(Field 7384)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Overhead Rate"(Field 99000757)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Rolled-up Subcontracted Cost"(Field 99000758)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Planning Issues (Qty.)"(Field 99000761)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Planning Receipt (Qty.)"(Field 99000762)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Planned Order Receipt (Qty.)"(Field 99000765)".


        //Unsupported feature: Property Modification (CalcFormula) on ""FP Order Receipt (Qty.)"(Field 99000766)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Rel. Order Receipt (Qty.)"(Field 99000767)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Planning Release (Qty.)"(Field 99000768)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Planned Order Release (Qty.)"(Field 99000769)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Purch. Req. Receipt (Qty.)"(Field 99000770)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Purch. Req. Release (Qty.)"(Field 99000771)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Prod. Forecast Quantity (Base)"(Field 99000774)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. on Prod. Order"(Field 99000777)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Qty. on Component Lines"(Field 99000778)".



        //Unsupported feature: Code Modification on "Type(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ItemLedgEntry.RESET;
            ItemLedgEntry.SETCURRENTKEY("Item No.");
            ItemLedgEntry.SETRANGE("Item No.","No.");
            #4..20
              VALIDATE("Costing Method","Costing Method"::FIFO);
              VALIDATE("Production BOM No.",'');
              VALIDATE("Routing No.",'');
              VALIDATE("Reordering Policy","Reordering Policy"::" ");
              VALIDATE("Order Tracking Policy","Order Tracking Policy"::None);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..23
              //MIG2017 >>
              //VALIDATE("Reordering Policy","Reordering Policy"::" ");
              VALIDATE("Reordering Policy","Reordering Policy"::" ");
              //MIG2017<<
              VALIDATE("Order Tracking Policy","Order Tracking Policy"::None);
            END;
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Price/Profit Calculation"(Field 19).OnValidate".

        //trigger (Variable: InvSetup)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Price/Profit Calculation"(Field 19).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CASE "Price/Profit Calculation" OF
              "Price/Profit Calculation"::"Profit=Price-Cost":
                IF "Unit Price" <> 0 THEN
                  IF "Unit Cost" = 0 THEN
                    "Profit %" := 0
            #6..9
                               ("Unit Price" / (1 + CalcVAT))),0.00001)
                ELSE
                  "Profit %" := 0;
              "Price/Profit Calculation"::"Price=Cost+Profit":
                IF "Profit %" < 100 THEN BEGIN
                  GetGLSetup;
                  "Unit Price" :=
            #17..19
                      GLSetup."Unit-Amount Rounding Precision");
                END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CASE "Price/Profit Calculation" OF
              "Price/Profit Calculation"::"Price=Cost+Profit":
            #3..12
              "Price/Profit Calculation"::"Profit=Price-Cost":
            #14..22

            // CNE4.03
            IF NOT "Price Includes VAT" THEN
              //>>TI287704
              IF "VAT Prod. Posting Group" <>'' THEN
              //<<TI287704
              BEGIN
                "Unit Price Includes VAT" := 0;
                GetGLSetup;
                InvSetup.GET;
                IF InvSetup."VAT Bus. Posting Gr. (Price)" <> '' THEN
                  BEGIN
                    VATPostingSetup2.GET(InvSetup."VAT Bus. Posting Gr. (Price)","VAT Prod. Posting Group");
                    "Unit Price Includes VAT" := ROUND("Unit Price" * (1 + VATPostingSetup2."VAT %" / 100),GLSetup."Unit-Amount Rounding Precision")
                END;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Costing Method"(Field 21).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Costing Method" = xRec."Costing Method" THEN
              EXIT;

            IF "Costing Method" <> "Costing Method"::FIFO THEN
              TESTFIELD(Type,Type::Inventory);

            IF "Costing Method" = "Costing Method"::Specific THEN BEGIN
              TESTFIELD("Item Tracking Code");

              ItemTrackingCode.GET("Item Tracking Code");
            #11..18
            TestNoEntriesExist(FIELDCAPTION("Costing Method"));

            ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,FALSE,FALSE,TRUE,FIELDNO("Costing Method"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
            IF "Costing Method" = "Costing Method"::LIFO THEN BEGIN
            #8..21
            */
        //end;


        //Unsupported feature: Code Modification on ""Unit Cost"(Field 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Costing Method" = "Costing Method"::Standard THEN
              VALIDATE("Standard Cost","Unit Cost")
            ELSE
              TestNoEntriesExist(FIELDCAPTION("Unit Cost"));
            VALIDATE("Price/Profit Calculation");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ("Costing Method" = "Costing Method"::Average) THEN
            #2..5
            */
        //end;


        //Unsupported feature: Code Modification on ""Standard Cost"(Field 24).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Costing Method" = "Costing Method"::Standard) AND (CurrFieldNo <> 0) THEN
              IF NOT GUIALLOWED THEN BEGIN
                "Standard Cost" := xRec."Standard Cost";
                EXIT;
            #5..14
                END;

            ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,FALSE,FALSE,TRUE,FIELDNO("Standard Cost"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ("Costing Method" = "Costing Method"::Average) AND (CurrFieldNo <> 0) THEN
            #2..17
            */
        //end;


        //Unsupported feature: Code Modification on ""Vendor No."(Field 31).OnValidate".

        //trigger "(Field 31)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF (xRec."Vendor No." <> "Vendor No.") AND
               ("Vendor No." <> '')
            THEN
              IF Vend.GET("Vendor No.") THEN
                "Lead Time Calculation" := Vend."Lead Time Calculation";
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              IF Vend.GET("Vendor No.") THEN BEGIN
                "Lead Time Calculation" := Vend."Lead Time Calculation";
                //BCSYS 09032020
              Vend.TESTFIELD(Blocked,0);

            END;
            */
        //end;


        //Unsupported feature: Code Insertion on ""Lead Time Calculation"(Field 33)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");
            */
        //end;


        //Unsupported feature: Code Insertion on "Blocked(Field 54)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //"- MIGNAV2013 -": Integer;
            //RecLAccessControl: Record "2000000053";
        //begin
            /*
            //>>MIGRATION NAV 2013
            //DEBLOQUER_ARTICLE FG 04/12/2006 NSC1.01 [007] Débloquer article
            //OLD
            {
            MemberOf.RESET;
            MemberOf.SETRANGE("User ID",USERID);
            MemberOf.SETRANGE("Role ID",'MODIFART');
            IF NOT MemberOf.FIND('-') THEN BEGIN
              ERROR('Vous n''avez pas l''autorisation d''effectuer cette opération.') ;
            END ;
            }
            //DEBLOQUER_ARTICLE FG 04/12/2006 NSC1.01 [007] Débloquer article

            //NEW
            RecLAccessControl.RESET;
            RecLAccessControl.SETRANGE("User Security ID",USERSECURITYID);
            RecLAccessControl.SETRANGE("Role ID",'MODIFART');
            IF NOT RecLAccessControl.FINDFIRST THEN BEGIN
              ERROR(CstG001) ;
            END ;
            //<<MIGRATION NAV 2013
            */
        //end;

        //Unsupported feature: Property Deletion (SubType) on "Picture(Field 92)".



        //Unsupported feature: Code Modification on ""Reordering Policy"(Field 5440).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            "Include Inventory" :=
              "Reordering Policy" IN ["Reordering Policy"::"Lot-for-Lot",
                                      "Reordering Policy"::"Maximum Qty.",
                                      "Reordering Policy"::"Fixed Reorder Qty."];

            IF "Reordering Policy" <> "Reordering Policy"::" " THEN
              TESTFIELD(Type,Type::Inventory);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            "Include Inventory" :=
              "Reordering Policy" IN ["Reordering Policy"::Order,
                                      "Reordering Policy"::" ",
                                      "Reordering Policy"::"Fixed Reorder Qty."];

            //MIG2017 >>
            // IF "Reordering Policy" <> "Reordering Policy"::" " THEN
            //  TESTFIELD(Type,Type::Inventory);
            //MIG2017 <<
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Item Category Code"(Field 5702).OnValidate".

        //trigger (Variable: ItemAttributeManagement)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Item Category Code"(Field 5702).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Item Category Code" <> xRec."Item Category Code" THEN BEGIN
              IF ItemCategory.GET("Item Category Code") THEN BEGIN
                IF "Gen. Prod. Posting Group" = '' THEN
                  VALIDATE("Gen. Prod. Posting Group",ItemCategory."Def. Gen. Prod. Posting Group");
                IF ("VAT Prod. Posting Group" = '') OR
                   (GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") AND
                    ("Gen. Prod. Posting Group" = ItemCategory."Def. Gen. Prod. Posting Group") AND
                    ("VAT Prod. Posting Group" = GenProdPostingGrp."Def. VAT Prod. Posting Group"))
                THEN
                  VALIDATE("VAT Prod. Posting Group",ItemCategory."Def. VAT Prod. Posting Group");
                IF "Inventory Posting Group" = '' THEN
                  VALIDATE("Inventory Posting Group",ItemCategory."Def. Inventory Posting Group");
                IF "Tax Group Code" = '' THEN
                  VALIDATE("Tax Group Code",ItemCategory."Def. Tax Group Code");
                VALIDATE("Costing Method",ItemCategory."Def. Costing Method");
              END;

              IF NOT ProductGrp.GET("Item Category Code","Product Group Code") THEN
                VALIDATE("Product Group Code",'')
              ELSE
                VALIDATE("Product Group Code");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ItemAttributeManagement.InheritAttributesFromItemCategory(Rec,"Item Category Code",xRec."Item Category Code");
            */
        //end;


        //Unsupported feature: Code Modification on ""Item Tracking Code"(Field 6500).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Item Tracking Code" <> '' THEN
              TESTFIELD(Type,Type::Inventory);
            IF "Item Tracking Code" = xRec."Item Tracking Code" THEN
            #4..13
            THEN
              TestNoEntriesExist(FIELDCAPTION("Item Tracking Code"));

            IF "Costing Method" = "Costing Method"::Specific THEN BEGIN
              TestNoEntriesExist(FIELDCAPTION("Item Tracking Code"));

              TESTFIELD("Item Tracking Code");
            #21..26
                  FORMAT(TRUE),ItemTrackingCode.TABLECAPTION,ItemTrackingCode.Code,
                  FIELDCAPTION("Costing Method"),"Costing Method");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..16
            IF "Costing Method" = "Costing Method"::LIFO THEN BEGIN
            #18..29

            TestNoOpenDocumentsWithTrackingExist;
            */
        //end;


        //Unsupported feature: Code Modification on ""Phys Invt Counting Period Code"(Field 7380).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Phys Invt Counting Period Code" <> '' THEN BEGIN
              PhysInvtCountPeriod.GET("Phys Invt Counting Period Code");
              PhysInvtCountPeriod.TESTFIELD("Count Frequency per Year");
            #4..6
                       Text7380,
                       FALSE,
                       FIELDCAPTION("Phys Invt Counting Period Code"),
                       FIELDCAPTION("Next Counting Period"))
                  THEN
                    ERROR(Text7381);

                "Next Counting Period" :=
                  PhysInvtCountPeriodMgt.CalcPeriod(
                    "Last Counting Period Update",'',PhysInvtCountPeriod."Count Frequency per Year",
                    ("Last Counting Period Update" = 0D) OR
                    ("Phys Invt Counting Period Code" <> xRec."Phys Invt Counting Period Code"));
              END;
            END ELSE BEGIN
              IF CurrFieldNo <> 0 THEN
                IF NOT CONFIRM(Text003,FALSE,FIELDCAPTION("Phys Invt Counting Period Code")) THEN
                  ERROR(Text7381);
              "Next Counting Period" := '';
              "Last Counting Period Update" := 0D;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..9
                       FIELDCAPTION("Next Counting Start Date"),
                       FIELDCAPTION("Next Counting End Date"))
            #11..13
                IF ("Last Counting Period Update" = 0D) OR
                   ("Phys Invt Counting Period Code" <> xRec."Phys Invt Counting Period Code")
                THEN
                  PhysInvtCountPeriodMgt.CalcPeriod(
                    "Last Counting Period Update","Next Counting Start Date","Next Counting End Date",
                    PhysInvtCountPeriod."Count Frequency per Year");
            #19..23
              "Next Counting Start Date" := 0D;
              "Next Counting End Date" := 0D;
              "Last Counting Period Update" := 0D;
            END;
            */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Next Counting Period"(Field 7382)".



        //Unsupported feature: Code Modification on ""Production BOM No."(Field 99000751).OnValidate".

        //trigger "(Field 99000751)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Production BOM No." <> '' THEN
              TESTFIELD(Type,Type::Inventory);

            #4..11
              IF ProdBOMHeader.Status = ProdBOMHeader.Status::Certified THEN BEGIN
                MfgSetup.GET;
                IF MfgSetup."Dynamic Low-Level Code" THEN
                  CalcLowLevel.RUN(Rec);
              END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..14
                  CODEUNIT.RUN(CODEUNIT::"Calculate Low-Level Code",Rec);
              END;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Order Tracking Policy"(Field 99000773).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Order Tracking Policy" <> "Order Tracking Policy"::None THEN
              TESTFIELD(Type,Type::Inventory);
            IF xRec."Order Tracking Policy" = "Order Tracking Policy" THEN
            #4..15
                  ActionMessageEntry.SETRANGE("Reservation Entry",ReservEntry."Entry No.");
                  ActionMessageEntry.DELETEALL;
                  IF "Order Tracking Policy" = "Order Tracking Policy"::None THEN
                    IF (ReservEntry."Lot No." <> '') OR (ReservEntry."Serial No." <> '') THEN BEGIN
                      TempReservationEntry := ReservEntry;
                      TempReservationEntry."Reservation Status" := TempReservationEntry."Reservation Status"::Surplus;
                      TempReservationEntry.INSERT;
            #23..29
                  ReservEntry.MODIFY;
                UNTIL TempReservationEntry.NEXT = 0;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..18
                    IF ReservEntry.TrackingExists THEN BEGIN
            #20..32
            */
        //end;
        field(63;"Last Time Modified";Time)
        {
            Caption = 'Last Time Modified';
            Editable = false;
        }
        field(109;"Res. Qty. on Sales Returns";Decimal)
        {
            AccessByPermission = TableData 6660=R;
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE (Item No.=FIELD(No.),
                                                                           Source Type=CONST(37),
                                                                           Source Subtype=CONST(5),
                                                                           Reservation Status=CONST(Reservation),
                                                                           Location Code=FIELD(Location Filter),
                                                                           Variant Code=FIELD(Variant Filter),
                                                                           Shipment Date=FIELD(Date Filter)));
            Caption = 'Res. Qty. on Sales Returns';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(110;"Res. Qty. on Purch. Returns";Decimal)
        {
            AccessByPermission = TableData 6650=R;
            CalcFormula = -Sum("Reservation Entry"."Quantity (Base)" WHERE (Item No.=FIELD(No.),
                                                                            Source Type=CONST(39),
                                                                            Source Subtype=CONST(5),
                                                                            Reservation Status=CONST(Reservation),
                                                                            Location Code=FIELD(Location Filter),
                                                                            Variant Code=FIELD(Variant Filter),
                                                                            Expected Receipt Date=FIELD(Date Filter)));
            Caption = 'Res. Qty. on Purch. Returns';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(1217;GTIN;Code[14])
        {
            Caption = 'GTIN';
            Numeric = true;
        }
        field(1700;"Default Deferral Template Code";Code[10])
        {
            Caption = 'Default Deferral Template Code';
            TableRelation = "Deferral Template"."Deferral Code";
        }
        field(5449;"Planning Transfer Ship. (Qty).";Decimal)
        {
            CalcFormula = Sum("Requisition Line"."Quantity (Base)" WHERE (Replenishment System=CONST(Transfer),
                                                                          Type=CONST(Item),
                                                                          No.=FIELD(No.),
                                                                          Variant Code=FIELD(Variant Filter),
                                                                          Transfer-from Code=FIELD(Location Filter),
                                                                          Transfer Shipment Date=FIELD(Date Filter)));
            Caption = 'Planning Transfer Ship. (Qty).';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5450;"Planning Worksheet (Qty.)";Decimal)
        {
            CalcFormula = Sum("Requisition Line"."Quantity (Base)" WHERE (Planning Line Origin=CONST(Planning),
                                                                          Type=CONST(Item),
                                                                          No.=FIELD(No.),
                                                                          Location Code=FIELD(Location Filter),
                                                                          Variant Code=FIELD(Variant Filter),
                                                                          Due Date=FIELD(Date Filter),
                                                                          Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                          Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter)));
            Caption = 'Planning Worksheet (Qty.)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6650;"Qty. on Purch. Return";Decimal)
        {
            AccessByPermission = TableData 6660=R;
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE (Document Type=CONST(Return Order),
                                                                               Type=CONST(Item),
                                                                               No.=FIELD(No.),
                                                                               Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                               Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                               Location Code=FIELD(Location Filter),
                                                                               Drop Shipment=FIELD(Drop Shipment Filter),
                                                                               Variant Code=FIELD(Variant Filter),
                                                                               Expected Receipt Date=FIELD(Date Filter)));
            Caption = 'Qty. on Purch. Return';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(6660;"Qty. on Sales Return";Decimal)
        {
            AccessByPermission = TableData 6650=R;
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE (Document Type=CONST(Return Order),
                                                                            Type=CONST(Item),
                                                                            No.=FIELD(No.),
                                                                            Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                            Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                            Location Code=FIELD(Location Filter),
                                                                            Drop Shipment=FIELD(Drop Shipment Filter),
                                                                            Variant Code=FIELD(Variant Filter),
                                                                            Shipment Date=FIELD(Date Filter)));
            Caption = 'Qty. on Sales Return';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(7300;"Warehouse Class Code";Code[10])
        {
            Caption = 'Warehouse Class Code';
            TableRelation = "Warehouse Class";
        }
        field(7385;"Next Counting Start Date";Date)
        {
            Caption = 'Next Counting Start Date';
            Editable = false;
        }
        field(7386;"Next Counting End Date";Date)
        {
            Caption = 'Next Counting End Date';
            Editable = false;
        }
        field(50000;"Creation Date";Date)
        {
            Caption = 'Creation Date';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
        }
        field(50001;User;Code[50])
        {
            Caption = 'User';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
            TableRelation = User;
        }
        field(50021;"Item Sales Profit Group";Code[10])
        {
            Caption = 'Goupe Marge Vente Article';
            Description = 'GRPMARGEITEM SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Item Sales Profit Group";
        }
        field(50040;"Pick Qty.";Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" WHERE (Location Code=FIELD(Location Filter),
                                                                                         Bin Code=FIELD(Bin Filter),
                                                                                         Item No.=FIELD(No.),
                                                                                         Variant Code=FIELD(Variant Filter),
                                                                                         Action Type=CONST(Take),
                                                                                         Lot No.=FIELD(Lot No. Filter),
                                                                                         Serial No.=FIELD(Serial No. Filter)));
            Caption = 'Pick Qty.';
            DecimalPlaces = 0:5;
            Description = 'CNE4.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50041;"Unit Price Includes VAT";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price Includes VAT';
            Description = 'CNE4.03';
            MinValue = 0;
        }
        field(50042;"Print Unit Price Includes VAT";Boolean)
        {
            AutoFormatType = 2;
            Caption = 'Print Unit Price Includes VAT On Label';
            Description = 'CNE4.03';
            MinValue = false;
        }
        field(50050;"Cost Increase Coeff %";Decimal)
        {
            Caption = 'Cost Increase Coeff (%)';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50051;"Search Description 2";Code[50])
        {
            Caption = 'Search Description 2';
        }
        field(50060;"Qty. Return Order SAV";Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE (Document Type=CONST(Return Order),
                                                                            Type=CONST(Item),
                                                                            No.=FIELD(No.),
                                                                            Return Order Type=FILTER(SAV),
                                                                            Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                            Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                                                            Location Code=FIELD(Location Filter),
                                                                            Drop Shipment=FIELD(Drop Shipment Filter),
                                                                            Variant Code=FIELD(Variant Filter),
                                                                            Shipment Date=FIELD(Date Filter)));
            Caption = ' Qty. Return Order SAV';
            Description = 'BCSYS';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80800;"DEEE Category Code";Code[10])
        {
            Caption = 'DEEE Category Code ';
            Description = 'DEEE1.00';
            TableRelation = "Categories of item".Category WHERE (Eco Partner=FIELD(Eco partner DEEE));

            trigger OnValidate()
            var
                LRecDEEECategory: Record "50006";
            begin
                //<<DEEE1.00
                IF ("DEEE Category Code")=''
                  THEN BEGIN
                  "DEEE Category Code":='' ;
                  "DEEE Unit Tax":=0 ;
                  "Number of Units DEEE":=0 ;
                  "Eco partner DEEE":='' ;
                END ;
                //>>DEEE1.00
            end;
        }
        field(80801;"DEEE Unit Tax";Decimal)
        {
            Caption = 'DEEE Unit Tax';
            Description = 'DEEE1.00';
        }
        field(80802;"Number of Units DEEE";Decimal)
        {
            Caption = 'Number of Units DEEE';
            Description = 'DEEE1.00';
        }
        field(80803;"Eco partner DEEE";Code[20])
        {
            Caption = 'Eco partner DEEE';
            Description = 'DEEE1.00';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                //<<DEEE1.00
                IF ("Eco partner DEEE")=''
                  THEN BEGIN
                  "DEEE Category Code":='' ;
                  "DEEE Unit Tax":=0 ;
                  "Number of Units DEEE":=0 ;
                  "Eco partner DEEE":='' ;
                END ;
                //>>DEEE1.00
            end;
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on ""Production BOM No."(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Routing No."(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on "Description(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Base Unit of Measure"(Key)".

        key(Key1;"Search Description 2")
        {
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CheckJournalsAndWorksheets(0);
        CheckDocuments(0);

        MoveEntries.MoveItemEntries(Rec);

        ServiceItem.RESET;
        ServiceItem.SETRANGE("Item No.","No.");
        IF ServiceItem.FIND('-') THEN
          REPEAT
            ServiceItem.VALIDATE("Item No.",'');
            ServiceItem.MODIFY(TRUE);
          UNTIL ServiceItem.NEXT = 0;

        ItemBudgetEntry.SETCURRENTKEY("Analysis Area","Budget Name","Item No.");
        ItemBudgetEntry.SETRANGE("Item No.","No.");
        ItemBudgetEntry.DELETEALL(TRUE);

        ItemSub.RESET;
        ItemSub.SETRANGE(Type,ItemSub.Type::Item);
        ItemSub.SETRANGE("No.","No.");
        ItemSub.DELETEALL;

        ItemSub.RESET;
        ItemSub.SETRANGE("Substitute Type",ItemSub."Substitute Type"::Item);
        ItemSub.SETRANGE("Substitute No.","No.");
        ItemSub.DELETEALL;

        SKU.RESET;
        SKU.SETCURRENTKEY("Item No.");
        SKU.SETRANGE("Item No.","No.");
        SKU.DELETEALL;

        NonstockItemMgt.NonstockItemDel(Rec);
        CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::Item);
        CommentLine.SETRANGE("No.","No.");
        CommentLine.DELETEALL;

        ItemVend.SETCURRENTKEY("Item No.");
        ItemVend.SETRANGE("Item No.","No.");
        ItemVend.DELETEALL;

        SalesPrice.SETRANGE("Item No.","No.");
        SalesPrice.DELETEALL;

        SalesLineDisc.SETRANGE(Type,SalesLineDisc.Type::Item);
        SalesLineDisc.SETRANGE(Code,"No.");
        SalesLineDisc.DELETEALL;

        SalesPrepmtPct.SETRANGE("Item No.","No.");
        SalesPrepmtPct.DELETEALL;

        PurchPrice.SETRANGE("Item No.","No.");
        PurchPrice.DELETEALL;

        PurchLineDisc.SETRANGE("Item No.","No.");
        PurchLineDisc.DELETEALL;

        PurchPrepmtPct.SETRANGE("Item No.","No.");
        PurchPrepmtPct.DELETEALL;

        ItemTranslation.SETRANGE("Item No.","No.");
        ItemTranslation.DELETEALL;

        ItemUnitOfMeasure.SETRANGE("Item No.","No.");
        ItemUnitOfMeasure.DELETEALL;

        ItemVariant.SETRANGE("Item No.","No.");
        ItemVariant.DELETEALL;

        ExtTextHeader.SETRANGE("Table Name",ExtTextHeader."Table Name"::Item);
        ExtTextHeader.SETRANGE("No.","No.");
        ExtTextHeader.DELETEALL(TRUE);

        ItemAnalysisViewEntry.SETRANGE("Item No.","No.");
        ItemAnalysisViewEntry.DELETEALL;

        ItemAnalysisBudgViewEntry.SETRANGE("Item No.","No.");
        ItemAnalysisBudgViewEntry.DELETEALL;

        PlanningAssignment.SETRANGE("Item No.","No.");
        PlanningAssignment.DELETEALL;

        BOMComp.RESET;
        BOMComp.SETRANGE("Parent Item No.","No.");
        BOMComp.DELETEALL;

        TroubleshSetup.RESET;
        TroubleshSetup.SETRANGE(Type,TroubleshSetup.Type::Item);
        TroubleshSetup.SETRANGE("No.","No.");
        TroubleshSetup.DELETEALL;

        ResSkillMgt.DeleteItemResSkills("No.");
        DimMgt.DeleteDefaultDim(DATABASE::Item,"No.");

        ItemIdent.RESET;
        ItemIdent.SETCURRENTKEY("Item No.");
        ItemIdent.SETRANGE("Item No.","No.");
        ItemIdent.DELETEALL;

        ServiceItemComponent.RESET;
        ServiceItemComponent.SETRANGE(Type,ServiceItemComponent.Type::Item);
        ServiceItemComponent.SETRANGE("No.","No.");
        ServiceItemComponent.MODIFYALL("No.",'');

        BinContent.SETCURRENTKEY("Item No.");
        BinContent.SETRANGE("Item No.","No.");
        BinContent.DELETEALL;

        ItemCrossReference.SETRANGE("Item No.","No.");
        ItemCrossReference.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ApprovalsMgmt.OnCancelItemApprovalRequest(Rec);

        #1..13
        DeleteRelatedData;
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "No." = '' THEN BEGIN
          GetInvtSetup;
          InvtSetup.TESTFIELD("Item Nos.");
        #4..6
        DimMgt.UpdateDefaultDim(
          DATABASE::Item,"No.",
          "Global Dimension 1 Code","Global Dimension 2 Code");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9

        SetLastDateTimeModified;
        //>>MIGARTION NAV 2013
        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout de code pour alimenter les champs créés
        "Creation Date" := WORKDATE;
        User := USERID;
        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout de code pour alimenter les champs créés

        //CHAMPS_DEFAUT FG 05/12/06 NSC1.01
        NaviSetup.GET ;
        NaviSetup.TESTFIELD(NaviSetup."Base Unit of Measure") ;
        NaviSetup.TESTFIELD(NaviSetup."Gen. Prod. Posting Group") ;
        NaviSetup.TESTFIELD(NaviSetup."VAT Prod. Posting Group") ;
        NaviSetup.TESTFIELD(NaviSetup."Inventory Posting Group") ;
        NaviSetup.TESTFIELD(NaviSetup."Sales Unit of Measure") ;
        //NaviSetup.TESTFIELD(NaviSetup."Lead Time Calculation Item") ;
        //>>FLGR
        ItemUnitOfMeasure."Item No." :="No.";
        ItemUnitOfMeasure.Code := NaviSetup."Base Unit of Measure";
        ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
        ItemUnitOfMeasure.INSERT;
        "Base Unit of Measure" := NaviSetup."Base Unit of Measure";
        "Purch. Unit of Measure" := NaviSetup."Base Unit of Measure";

        "Costing Method" :=NaviSetup."Costing Method" ;
        VALIDATE("Gen. Prod. Posting Group",NaviSetup."Gen. Prod. Posting Group") ;
        VALIDATE("VAT Prod. Posting Group",NaviSetup."VAT Prod. Posting Group") ;
        VALIDATE("Inventory Posting Group",NaviSetup."Inventory Posting Group") ;
        VALIDATE("Sales Unit of Measure",NaviSetup."Sales Unit of Measure") ;
        VALIDATE("Replenishment System",NaviSetup."Replenishment System") ;
        VALIDATE("Lead Time Calculation",NaviSetup."Lead Time Calculation Item") ;
        VALIDATE("Reordering Policy",NaviSetup."Reordering Policy") ;
        VALIDATE("Include Inventory",NaviSetup."Include Inventory") ;
        VALIDATE(Reserve,NaviSetup."Reserve Item") ;
        VALIDATE("Order Tracking Policy",NaviSetup."Order Tracking Policy") ;

        //>>TI287704
        VALIDATE("Unit Price");
        //<<TI287704
        //<<FLGR
        //Fin CHAMPS_DEFAUT FG 05/12/06 NSC1.01

        //<<DEEE1.00
        "Number of Units DEEE":=1 ;
        //>>DEEE1.00
        //<<MIGARTION NAV 2013
        */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Last Date Modified" := TODAY;

        PlanningAssignment.ItemChange(Rec,xRec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        //>>MIGRATION NAV 2013
        //>>SSOBINAV_200910_06_CNE
        //MIG 2017 à décommenter après migration
        IF NOT (UPPERCASE(USERID) IN['CNE\BCSYS'])
          //OR (COPYSTR(UPPERCASE(USERID),1,5) <> 'BCSYS')
          THEN
        //<<MIG2017
          TESTFIELD("Vendor No.");
        //<<SSOBINAV_200910_06_CNE
        //<<MIGRATION NAV 2013


        SetLastDateTimeModified;
        PlanningAssignment.ItemChange(Rec,xRec);
        */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnRename".

    //trigger (Variable: SalesLine)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Last Date Modified" := TODAY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SalesLine.RenameNo(SalesLine.Type::Item,xRec."No.","No.");
        PurchLine.RenameNo(PurchLine.Type::Item,xRec."No.","No.");
        ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);
        ItemAttributeValueMapping.RenameItemAttributeValueMapping(xRec."No.","No.");
        SetLastDateTimeModified;
        */
    //end;


    //Unsupported feature: Code Modification on "FindItemVend(PROCEDURE 5)".

    //procedure FindItemVend();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("No.");
        ItemVend.RESET;
        ItemVend.SETRANGE("Item No.","No.");
        #4..9
          GetPlanningParameters.AtSKU(SKU,"No.",ItemVend."Variant Code",LocationCode);
          IF ItemVend."Vendor No." = '' THEN
            ItemVend."Vendor No." := SKU."Vendor No.";
          IF (ItemVend."Vendor Item No." = '') AND (ItemVend."Vendor No." = SKU."Vendor No.") THEN
            ItemVend."Vendor Item No." := SKU."Vendor Item No.";
          ItemVend."Lead Time Calculation" := SKU."Lead Time Calculation";
        END;
        IF FORMAT(ItemVend."Lead Time Calculation") = '' THEN
          IF Vend.GET(ItemVend."Vendor No.") THEN
            ItemVend."Lead Time Calculation" := Vend."Lead Time Calculation";
        ItemVend.RESET;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..12
          IF ItemVend."Vendor Item No." = '' THEN
        #14..20
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "ValidateShortcutDimCode(PROCEDURE 8)".


    //Unsupported feature: Variable Insertion (Variable: PurchaseLine) (VariableCollection) on "TestNoEntriesExist(PROCEDURE 1006)".


    //Unsupported feature: Property Insertion (Local) on "TestNoEntriesExist(PROCEDURE 1006)".



    //Unsupported feature: Code Modification on "TestNoEntriesExist(PROCEDURE 1006)".

    //procedure TestNoEntriesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemLedgEntry.SETCURRENTKEY("Item No.");
        ItemLedgEntry.SETRANGE("Item No.","No.");
        IF NOT ItemLedgEntry.ISEMPTY THEN
          ERROR(
            Text007,
            CurrentFieldName);

        PurchOrderLine.SETCURRENTKEY("Document Type",Type,"No.");
        PurchOrderLine.SETFILTER(
          "Document Type",'%1|%2',
          PurchOrderLine."Document Type"::Order,
          PurchOrderLine."Document Type"::"Return Order");
        PurchOrderLine.SETRANGE(Type,PurchOrderLine.Type::Item);
        PurchOrderLine.SETRANGE("No.","No.");
        IF PurchOrderLine.FINDFIRST THEN
          ERROR(
            Text008,
            CurrentFieldName,
            PurchOrderLine."Document Type");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "No." = '' THEN
          EXIT;

        #1..7
        PurchaseLine.SETCURRENTKEY("Document Type",Type,"No.");
        PurchaseLine.SETFILTER(
          "Document Type",'%1|%2',
          PurchaseLine."Document Type"::Order,
          PurchaseLine."Document Type"::"Return Order");
        PurchaseLine.SETRANGE(Type,PurchaseLine.Type::Item);
        PurchaseLine.SETRANGE("No.","No.");
        IF PurchaseLine.FINDFIRST THEN
        #16..18
            PurchaseLine."Document Type");
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "TestNoOpenEntriesExist(PROCEDURE 4)".


    //Unsupported feature: Property Insertion (Local) on "GetInvtSetup(PROCEDURE 14)".


    //Unsupported feature: Property Insertion (Local) on "ProdOrderExist(PROCEDURE 7)".


    //Unsupported feature: Parameter Insertion (Parameter: ReturnValue) (ParameterCollection) on "TryGetItemNo(PROCEDURE 9)".


    //Unsupported feature: Parameter Insertion (Parameter: ItemText) (ParameterCollection) on "TryGetItemNo(PROCEDURE 9)".


    //Unsupported feature: Parameter Insertion (Parameter: DefaultCreate) (ParameterCollection) on "TryGetItemNo(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Name) on "PlanningTransferShptQty(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "PlanningTransferShptQty(PROCEDURE 9)".

    //procedure PlanningTransferShptQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ReqLine.SETCURRENTKEY(Type,"No.","Variant Code","Transfer-from Code","Transfer Shipment Date");
        ReqLine.SETRANGE("Replenishment System",ReqLine."Replenishment System"::Transfer);
        ReqLine.SETRANGE(Type,ReqLine.Type::Item);
        ReqLine.SETRANGE("No.","No.");
        COPYFILTER("Variant Filter",ReqLine."Variant Code");
        COPYFILTER("Location Filter",ReqLine."Transfer-from Code");
        COPYFILTER("Date Filter",ReqLine."Transfer Shipment Date");
        IF ReqLine.ISEMPTY THEN
          EXIT;

        IF ReqLine.FINDSET THEN
          REPEAT
            Sum += ReqLine."Quantity (Base)";
          UNTIL ReqLine.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(TryGetItemNoOpenCard(ReturnValue,ItemText,DefaultCreate,TRUE));
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: ItemName) (ParameterCollection) on "CreateNewItem(PROCEDURE 3)".


    //Unsupported feature: Parameter Insertion (Parameter: ShowItemCard) (ParameterCollection) on "CreateNewItem(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: Item) (VariableCollection) on "CreateNewItem(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: ItemTemplate) (VariableCollection) on "CreateNewItem(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: ItemCard) (VariableCollection) on "CreateNewItem(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Name) on "PlanningReleaseQty(PROCEDURE 3)".


    //Unsupported feature: Property Insertion (Local) on "PlanningReleaseQty(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "PlanningReleaseQty(PROCEDURE 3)".

    //procedure PlanningReleaseQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ReqLine.SETCURRENTKEY(Type,"No.","Variant Code","Location Code");
        ReqLine.SETRANGE(Type,ReqLine.Type::Item);
        ReqLine.SETRANGE("No.","No.");
        COPYFILTER("Variant Filter",ReqLine."Variant Code");
        COPYFILTER("Location Filter",ReqLine."Location Code");
        COPYFILTER("Date Filter",ReqLine."Starting Date");
        COPYFILTER("Global Dimension 1 Filter",ReqLine."Shortcut Dimension 1 Code");
        COPYFILTER("Global Dimension 2 Filter",ReqLine."Shortcut Dimension 2 Code");
        IF ReqLine.ISEMPTY THEN
          EXIT;

        IF ReqLine.FINDSET THEN
          REPEAT
            Sum += ReqLine."Quantity (Base)";
          UNTIL ReqLine.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT ItemTemplate.NewItemFromTemplate(Item) THEN
          ERROR(SelectItemErr);

        Item.Description := ItemName;
        Item.MODIFY(TRUE);
        COMMIT;
        IF NOT ShowItemCard THEN
          EXIT(Item."No.");
        Item.SETRANGE("No.",Item."No.");
        ItemCard.SETTABLEVIEW(Item);
        IF NOT (ItemCard.RUNMODAL = ACTION::OK) THEN
          ERROR(SelectItemErr);

        EXIT(Item."No.");
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: ItemText) (ParameterCollection) on "GetItemNo(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Data type) on "CalcSalesReturn(PROCEDURE 10).ReturnValue".


    //Unsupported feature: Property Insertion (Length) on "CalcSalesReturn(PROCEDURE 10).ReturnValue".


    //Unsupported feature: Variable Insertion (Variable: ItemNo) (VariableCollection) on "GetItemNo(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Name) on "CalcSalesReturn(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "CalcSalesReturn(PROCEDURE 10)".

    //procedure CalcSalesReturn();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesLine.SETCURRENTKEY("Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Shipment Date");
        SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::"Return Order");
        SalesLine.SETRANGE(Type,SalesLine.Type::Item);
        SalesLine.SETRANGE("No.","No.");
        SalesLine.SETFILTER("Location Code",GETFILTER("Location Filter"));
        SalesLine.SETFILTER("Drop Shipment",GETFILTER("Drop Shipment Filter"));
        SalesLine.SETFILTER("Variant Code",GETFILTER("Variant Filter"));
        SalesLine.SETFILTER("Shipment Date",GETFILTER("Date Filter"));
        SalesLine.CALCSUMS("Outstanding Qty. (Base)");
        EXIT(SalesLine."Outstanding Qty. (Base)");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TryGetItemNo(ItemNo,ItemText,TRUE);
        EXIT(COPYSTR(ItemNo,1,MAXSTRLEN("No.")));
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: DateFilter) (ParameterCollection) on "SetLastDateTimeFilter(PROCEDURE 29)".


    //Unsupported feature: Variable Insertion (Variable: DateFilterCalc) (VariableCollection) on "SetLastDateTimeFilter(PROCEDURE 29)".


    //Unsupported feature: Variable Insertion (Variable: SyncDateTimeUtc) (VariableCollection) on "SetLastDateTimeFilter(PROCEDURE 29)".


    //Unsupported feature: Variable Insertion (Variable: CurrentFilterGroup) (VariableCollection) on "SetLastDateTimeFilter(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Name) on "CalcPlanningWorksheetQty(PROCEDURE 29)".



    //Unsupported feature: Code Modification on "CalcPlanningWorksheetQty(PROCEDURE 29)".

    //procedure CalcPlanningWorksheetQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RequisitionLine.SETRANGE(Type,RequisitionLine.Type::Item);
        RequisitionLine.SETRANGE("No.","No.");
        RequisitionLine.SETFILTER("Variant Code",GETFILTER("Variant Filter"));
        RequisitionLine.SETFILTER("Location Code",GETFILTER("Location Filter"));
        RequisitionLine.SETFILTER("Shortcut Dimension 1 Code",GETFILTER("Global Dimension 1 Filter"));
        RequisitionLine.SETFILTER("Shortcut Dimension 2 Code",GETFILTER("Global Dimension 2 Filter"));
        RequisitionLine.SETFILTER("Due Date",GETFILTER("Date Filter"));
        RequisitionLine.SETRANGE("Planning Line Origin",RequisitionLine."Planning Line Origin"::Planning);
        RequisitionLine.CALCSUMS("Quantity (Base)");
        EXIT(RequisitionLine."Quantity (Base)");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SyncDateTimeUtc := DateFilterCalc.ConvertToUtcDateTime(DateFilter);
        CurrentFilterGroup := FILTERGROUP;
        SETFILTER("Last Date Modified",'>=%1',DT2DATE(SyncDateTimeUtc));
        FILTERGROUP(-1);
        SETFILTER("Last Date Modified",'>%1',DT2DATE(SyncDateTimeUtc));
        SETFILTER("Last Time Modified",'>%1',DT2TIME(SyncDateTimeUtc));
        FILTERGROUP(CurrentFilterGroup);
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: BinContent) (VariableCollection) on "DeleteRelatedData(PROCEDURE 12)".


    //Unsupported feature: Variable Insertion (Variable: ItemCrossReference) (VariableCollection) on "DeleteRelatedData(PROCEDURE 12)".


    //Unsupported feature: Variable Insertion (Variable: SocialListeningSearchTopic) (VariableCollection) on "DeleteRelatedData(PROCEDURE 12)".


    //Unsupported feature: Variable Insertion (Variable: MyItem) (VariableCollection) on "DeleteRelatedData(PROCEDURE 12)".


    //Unsupported feature: Variable Insertion (Variable: ItemAttributeValueMapping) (VariableCollection) on "DeleteRelatedData(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Name) on "CalcPurchReturn(PROCEDURE 12)".


    //Unsupported feature: Property Insertion (Local) on "CalcPurchReturn(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "CalcPurchReturn(PROCEDURE 12)".

    //procedure CalcPurchReturn();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchLine.SETCURRENTKEY("Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Expected Receipt Date");
        PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::"Return Order");
        PurchLine.SETRANGE(Type,PurchLine.Type::Item);
        PurchLine.SETRANGE("No.","No.");
        PurchLine.SETFILTER("Location Code",GETFILTER("Location Filter"));
        PurchLine.SETFILTER("Drop Shipment",GETFILTER("Drop Shipment Filter"));
        PurchLine.SETFILTER("Variant Code",GETFILTER("Variant Filter"));
        PurchLine.SETFILTER("Expected Receipt Date",GETFILTER("Date Filter"));
        PurchLine.CALCSUMS("Outstanding Qty. (Base)");
        EXIT(PurchLine."Outstanding Qty. (Base)");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ItemBudgetEntry.SETCURRENTKEY("Analysis Area","Budget Name","Item No.");
        ItemBudgetEntry.SETRANGE("Item No.","No.");
        ItemBudgetEntry.DELETEALL(TRUE);

        ItemSub.RESET;
        ItemSub.SETRANGE(Type,ItemSub.Type::Item);
        ItemSub.SETRANGE("No.","No.");
        ItemSub.DELETEALL;

        ItemSub.RESET;
        ItemSub.SETRANGE("Substitute Type",ItemSub."Substitute Type"::Item);
        ItemSub.SETRANGE("Substitute No.","No.");
        ItemSub.DELETEALL;

        SKU.RESET;
        SKU.SETCURRENTKEY("Item No.");
        SKU.SETRANGE("Item No.","No.");
        SKU.DELETEALL;

        NonstockItemMgt.NonstockItemDel(Rec);
        CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::Item);
        CommentLine.SETRANGE("No.","No.");
        CommentLine.DELETEALL;

        ItemVend.SETCURRENTKEY("Item No.");
        ItemVend.SETRANGE("Item No.","No.");
        ItemVend.DELETEALL;

        SalesPrice.SETRANGE("Item No.","No.");
        SalesPrice.DELETEALL;

        SalesLineDisc.SETRANGE(Type,SalesLineDisc.Type::Item);
        SalesLineDisc.SETRANGE(Code,"No.");
        SalesLineDisc.DELETEALL;

        SalesPrepmtPct.SETRANGE("Item No.","No.");
        SalesPrepmtPct.DELETEALL;

        PurchPrice.SETRANGE("Item No.","No.");
        PurchPrice.DELETEALL;

        //>>MIGRATION NAV 2013
        //GESTION_REMISE FG 06/12/06 NSC1.01
        PurchLineDisc.SETRANGE(Type,PurchLineDisc.Type::Item) ;
        //Fin GESTION_REMISE FG 06/12/06 NSC1.01
        //<<MIGRATION NAV 2013

        PurchLineDisc.SETRANGE("Item No.","No.");
        //PurchLineDisc.SETRANGE("Item No.","No.");
        PurchLineDisc.DELETEALL;

        PurchPrepmtPct.SETRANGE("Item No.","No.");
        PurchPrepmtPct.DELETEALL;

        ItemTranslation.SETRANGE("Item No.","No.");
        ItemTranslation.DELETEALL;

        ItemUnitOfMeasure.SETRANGE("Item No.","No.");
        ItemUnitOfMeasure.DELETEALL;

        ItemVariant.SETRANGE("Item No.","No.");
        ItemVariant.DELETEALL;

        ExtTextHeader.SETRANGE("Table Name",ExtTextHeader."Table Name"::Item);
        ExtTextHeader.SETRANGE("No.","No.");
        ExtTextHeader.DELETEALL(TRUE);

        ItemAnalysisViewEntry.SETRANGE("Item No.","No.");
        ItemAnalysisViewEntry.DELETEALL;

        ItemAnalysisBudgViewEntry.SETRANGE("Item No.","No.");
        ItemAnalysisBudgViewEntry.DELETEALL;

        PlanningAssignment.SETRANGE("Item No.","No.");
        PlanningAssignment.DELETEALL;

        BOMComp.RESET;
        BOMComp.SETRANGE("Parent Item No.","No.");
        BOMComp.DELETEALL;

        TroubleshSetup.RESET;
        TroubleshSetup.SETRANGE(Type,TroubleshSetup.Type::Item);
        TroubleshSetup.SETRANGE("No.","No.");
        TroubleshSetup.DELETEALL;

        ResSkillMgt.DeleteItemResSkills("No.");
        DimMgt.DeleteDefaultDim(DATABASE::Item,"No.");

        ItemIdent.RESET;
        ItemIdent.SETCURRENTKEY("Item No.");
        ItemIdent.SETRANGE("Item No.","No.");
        ItemIdent.DELETEALL;

        ServiceItemComponent.RESET;
        ServiceItemComponent.SETRANGE(Type,ServiceItemComponent.Type::Item);
        ServiceItemComponent.SETRANGE("No.","No.");
        ServiceItemComponent.MODIFYALL("No.",'');

        BinContent.SETCURRENTKEY("Item No.");
        BinContent.SETRANGE("Item No.","No.");
        BinContent.DELETEALL;

        ItemCrossReference.SETRANGE("Item No.","No.");
        ItemCrossReference.DELETEALL;

        MyItem.SETRANGE("Item No.","No.");
        MyItem.DELETEALL;

        IF NOT SocialListeningSearchTopic.ISEMPTY THEN BEGIN
          SocialListeningSearchTopic.FindSearchTopic(SocialListeningSearchTopic."Source Type"::Item,"No.");
          SocialListeningSearchTopic.DELETEALL;
        END;

        ItemAttributeValueMapping.RESET;
        ItemAttributeValueMapping.SETRANGE("Table ID",DATABASE::Item);
        ItemAttributeValueMapping.SETRANGE("No.","No.");
        ItemAttributeValueMapping.DELETEALL;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DateFilterCalc) (VariableCollection) on "SetLastDateTimeModified(PROCEDURE 16)".


    //Unsupported feature: Variable Insertion (Variable: Now) (VariableCollection) on "SetLastDateTimeModified(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Name) on "CalcResvQtyOnPurchReturn(PROCEDURE 16)".


    //Unsupported feature: Property Insertion (Local) on "CalcResvQtyOnPurchReturn(PROCEDURE 16)".



    //Unsupported feature: Code Modification on "CalcResvQtyOnPurchReturn(PROCEDURE 16)".

    //procedure CalcResvQtyOnPurchReturn();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ReservationEntry.SETCURRENTKEY(
          "Item No.","Source Type","Source Subtype","Reservation Status",
          "Location Code","Variant Code","Shipment Date","Expected Receipt Date");
        ReservationEntry.SETRANGE("Item No.","No.");
        ReservationEntry.SETRANGE("Source Type",DATABASE::"Purchase Line");
        ReservationEntry.SETRANGE("Source Subtype",5); // return order
        ReservationEntry.SETRANGE("Reservation Status",ReservationEntry."Reservation Status"::Reservation);
        ReservationEntry.SETFILTER("Location Code",GETFILTER("Location Filter"));
        ReservationEntry.SETFILTER("Variant Code",GETFILTER("Variant Filter"));
        ReservationEntry.SETFILTER("Shipment Date",GETFILTER("Date Filter"));
        ReservationEntry.CALCSUMS("Quantity (Base)");
        EXIT(-ReservationEntry."Quantity (Base)");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Now := DateFilterCalc.ConvertToUtcDateTime(CURRENTDATETIME);
        "Last Date Modified" := DT2DATE(Now);
        "Last Time Modified" := DT2TIME(Now);
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CheckForProductionOutput(PROCEDURE 17)".



    //Unsupported feature: Code Modification on "CheckDocuments(PROCEDURE 23)".

    //procedure CheckDocuments();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CheckBOM(CurrFieldNo);
        CheckPurchLine(CurrFieldNo);
        CheckSalesLine(CurrFieldNo);
        #4..10
        CheckAsmHeader(CurrFieldNo);
        CheckAsmLine(CurrFieldNo);
        CheckJobPlanningLine(CurrFieldNo);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "No." = '' THEN
          EXIT;

        #1..13
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: PurchaseLine) (VariableCollection) on "CheckPurchLine(PROCEDURE 26)".



    //Unsupported feature: Code Modification on "CheckPurchLine(PROCEDURE 26)".

    //procedure CheckPurchLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchOrderLine.SETCURRENTKEY(Type,"No.");
        PurchOrderLine.SETRANGE(Type,PurchOrderLine.Type::Item);
        PurchOrderLine.SETRANGE("No.","No.");
        IF NOT PurchOrderLine.ISEMPTY THEN BEGIN
          IF CurrFieldNo = 0 THEN
            ERROR(Text000,TABLECAPTION,"No.",PurchOrderLine."Document Type");
          IF CurrFieldNo = FIELDNO(Type) THEN
            ERROR(CannotChangeFieldErr,FIELDCAPTION(Type),TABLECAPTION,"No.",PurchOrderLine.TABLECAPTION);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        PurchaseLine.SETCURRENTKEY(Type,"No.");
        PurchaseLine.SETRANGE(Type,PurchaseLine.Type::Item);
        PurchaseLine.SETRANGE("No.","No.");
        IF PurchaseLine.FINDFIRST THEN BEGIN
          IF CurrFieldNo = 0 THEN
            ERROR(Text000,TABLECAPTION,"No.",PurchaseLine."Document Type");
          IF CurrFieldNo = FIELDNO(Type) THEN
            ERROR(CannotChangeFieldErr,FIELDCAPTION(Type),TABLECAPTION,"No.",PurchaseLine.TABLECAPTION);
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SalesLine) (VariableCollection) on "CheckSalesLine(PROCEDURE 28)".



    //Unsupported feature: Code Modification on "CheckSalesLine(PROCEDURE 28)".

    //procedure CheckSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesOrderLine.SETCURRENTKEY(Type,"No.");
        SalesOrderLine.SETRANGE(Type,SalesOrderLine.Type::Item);
        SalesOrderLine.SETRANGE("No.","No.");
        IF NOT SalesOrderLine.ISEMPTY THEN BEGIN
          IF CurrFieldNo = 0 THEN
            ERROR(Text001,TABLECAPTION,"No.",SalesOrderLine."Document Type");
          IF CurrFieldNo = FIELDNO(Type) THEN
            ERROR(CannotChangeFieldErr,FIELDCAPTION(Type),TABLECAPTION,"No.",SalesOrderLine.TABLECAPTION);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SalesLine.SETCURRENTKEY(Type,"No.");
        SalesLine.SETRANGE(Type,SalesLine.Type::Item);
        SalesLine.SETRANGE("No.","No.");
        IF SalesLine.FINDFIRST THEN BEGIN
          IF CurrFieldNo = 0 THEN
            ERROR(Text001,TABLECAPTION,"No.",SalesLine."Document Type");
          IF CurrFieldNo = FIELDNO(Type) THEN
            ERROR(CannotChangeFieldErr,FIELDCAPTION(Type),TABLECAPTION,"No.",SalesLine.TABLECAPTION);
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ProductionBOMVersion) (VariableCollection) on "CheckProdBOMLine(PROCEDURE 30)".



    //Unsupported feature: Code Modification on "CheckProdBOMLine(PROCEDURE 30)".

    //procedure CheckProdBOMLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ProdBOMLine.RESET;
        ProdBOMLine.SETCURRENTKEY(Type,"No.");
        ProdBOMLine.SETRANGE(Type,ProdBOMLine.Type::Item);
        #4..10
                 (ProdBOMHeader.Status = ProdBOMHeader.Status::Certified)
              THEN
                ERROR(Text004,TABLECAPTION,"No.");
            UNTIL ProdBOMLine.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..13
              IF ProductionBOMVersion.GET(ProdBOMLine."Production BOM No.",ProdBOMLine."Version Code") AND
                 (ProductionBOMVersion.Status = ProductionBOMVersion.Status::Certified)
              THEN
                ERROR(CannotDeleteItemIfProdBOMVersionExistsErr,TABLECAPTION,"No.");
            UNTIL ProdBOMLine.NEXT = 0;
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "CalcVAT(PROCEDURE 40)".

    //procedure CalcVAT();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Price Includes VAT" AND
           ("Price/Profit Calculation" < "Price/Profit Calculation"::"No Relationship")
        THEN BEGIN
          VATPostingSetup.GET("VAT Bus. Posting Gr. (Price)","VAT Prod. Posting Group");
          CASE VATPostingSetup."VAT Calculation Type" OF
            VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
        #7..14
          CLEAR(VATPostingSetup);

        EXIT(VATPostingSetup."VAT %" / 100);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Price Includes VAT" THEN BEGIN
        #4..17
        */
    //end;


    //Unsupported feature: Code Modification on "CalcUnitPriceExclVAT(PROCEDURE 41)".

    //procedure CalcUnitPriceExclVAT();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT("Unit Price" * (1 - CalcVAT));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetGLSetup;
        IF 1 + CalcVAT = 0 THEN
          EXIT(0);
        EXIT(ROUND("Unit Price" / (1 + CalcVAT),GLSetup."Unit-Amount Rounding Precision"));
        */
    //end;

    local procedure TestNoOpenDocumentsWithTrackingExist()
    var
        TrackingSpecification: Record "336";
        ReservationEntry: Record "337";
        RecRef: RecordRef;
        SourceType: Integer;
        SourceID: Code[20];
    begin
        IF ItemTrackingCode2.Code = '' THEN
          EXIT;

        TrackingSpecification.SETRANGE("Item No.","No.");
        IF TrackingSpecification.FINDFIRST THEN BEGIN
          SourceType := TrackingSpecification."Source Type";
          SourceID := TrackingSpecification."Source ID";
        END ELSE BEGIN
          ReservationEntry.SETRANGE("Item No.","No.");
          ReservationEntry.SETFILTER("Item Tracking",'<>%1',ReservationEntry."Item Tracking"::None);
          IF ReservationEntry.FINDFIRST THEN BEGIN
            SourceType := ReservationEntry."Source Type";
            SourceID := ReservationEntry."Source ID";
          END;
        END;

        IF SourceType = 0 THEN
          EXIT;

        RecRef.OPEN(SourceType);
        ERROR(OpenDocumentTrackingErr,RecRef.CAPTION,SourceID);
    end;

    procedure TryGetItemNoOpenCard(var ReturnValue: Text;ItemText: Text;DefaultCreate: Boolean;ShowItemCard: Boolean): Boolean
    var
        Item: Record "27";
        SalesLine: Record "37";
        TypeHelper: Codeunit "10";
        ItemNo: Code[20];
        ItemWithoutQuote: Text;
        ItemFilterContains: Text;
        FoundRecordCount: Integer;
    begin
        ReturnValue := COPYSTR(ItemText,1,MAXSTRLEN(ReturnValue));
        IF ItemText = '' THEN
          EXIT(DefaultCreate);

        FoundRecordCount := TypeHelper.FindRecordByDescription(ReturnValue,SalesLine.Type::Item,ItemText);

        IF FoundRecordCount = 1 THEN
          EXIT(TRUE);

        ReturnValue := COPYSTR(ItemText,1,MAXSTRLEN(ReturnValue));
        IF FoundRecordCount = 0 THEN BEGIN
          IF NOT DefaultCreate THEN
            EXIT(FALSE);

          IF NOT GUIALLOWED THEN
            ERROR(SelectItemErr);

          IF Item.WRITEPERMISSION THEN
            CASE STRMENU(
                   STRSUBSTNO('%1,%2',STRSUBSTNO(CreateNewItemTxt,CONVERTSTR(ItemText,',','.')),SelectItemTxt),1,ItemNotRegisteredTxt)
            OF
              0:
                ERROR(SelectItemErr);
              1:
                BEGIN
                  ReturnValue := CreateNewItem(COPYSTR(ItemText,1,MAXSTRLEN(Item.Description)),ShowItemCard);
                  EXIT(TRUE);
                END;
            END;
        END;

        IF NOT GUIALLOWED THEN
          ERROR(SelectItemErr);

        ItemWithoutQuote := CONVERTSTR(ItemText,'''','?');
        ItemFilterContains := '''@*' + ItemWithoutQuote + '*''';
        Item.FILTERGROUP(-1);
        Item.SETFILTER("No.",ItemFilterContains);
        Item.SETFILTER(Description,ItemFilterContains);
        Item.SETFILTER("Base Unit of Measure",ItemFilterContains);

        IF ShowItemCard THEN
          ItemNo := PickItem(Item)
        ELSE BEGIN
          ReturnValue := '';
          EXIT(TRUE);
        END;

        IF ItemNo <> '' THEN BEGIN
          ReturnValue := ItemNo;
          EXIT(TRUE);
        END;

        IF NOT DefaultCreate THEN
          EXIT(FALSE);
        ERROR(SelectItemErr);
    end;

    local procedure PickItem(var Item: Record "27"): Code[20]
    var
        ItemList: Page "31";
    begin
        IF Item.FINDSET THEN
          REPEAT
            Item.MARK(TRUE);
          UNTIL Item.NEXT = 0;
        IF Item.FINDFIRST THEN;
        Item.MARKEDONLY := TRUE;

        ItemList.SETTABLEVIEW(Item);
        ItemList.SETRECORD(Item);
        ItemList.LOOKUPMODE := TRUE;
        IF ItemList.RUNMODAL = ACTION::LookupOK THEN
          ItemList.GETRECORD(Item)
        ELSE
          CLEAR(Item);

        EXIT(Item."No.");
    end;

    procedure CalcQtyAvailToPick(ExcludeQty: Decimal): Decimal
    var
        InvNotToPick: Decimal;
    begin
        CALCFIELDS(Inventory,"Pick Qty.");
        // InvNotToPick := CalcQtyNotToPick();
        // EXIT(Inventory - InvNotToPick ("Pick Qty." - ExcludeQty));
        EXIT(Inventory - ("Pick Qty." - ExcludeQty));
    end;

    procedure CalcQtyNotToPick(): Decimal
    var
        FromBinContent: Record "7302";
        InvNotToPick: Decimal;
        ItemInvNotToPick: Decimal;
    begin
        //>> 29.03.2012
        ItemInvNotToPick := 0;
        InvNotToPick := 0;
        FromBinContent.SETCURRENTKEY(Default,"Location Code","Item No.","Variant Code","Bin Code");
        IF "Location Filter" <> '' THEN
          FromBinContent.SETFILTER("Location Code","Location Filter");
        FromBinContent.SETRANGE("Item No.","No.");
        IF "Serial No. Filter" <> '' THEN
          FromBinContent.SETFILTER("Serial No. Filter","Serial No. Filter");
        IF "Lot No. Filter" <> '' THEN
          FromBinContent.SETFILTER("Lot No. Filter","Lot No. Filter");
        IF FromBinContent.FIND('-') THEN
          REPEAT
            FromBinContent.CALCFIELDS(Quantity,"Pick Qty.");
            InvNotToPick := (FromBinContent.Quantity - FromBinContent."Pick Qty.") - FromBinContent.CalcQtyAvailToPick(0);
            IF InvNotToPick > 0 THEN
              ItemInvNotToPick += InvNotToPick;
        UNTIL FromBinContent.NEXT = 0;
        EXIT(ItemInvNotToPick);
    end;

    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".


    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    //Unsupported feature: Property Deletion (Name) on "PlanningTransferShptQty(PROCEDURE 9).Sum(ReturnValue)".


    //Unsupported feature: Property Modification (Data type) on "PlanningTransferShptQty(PROCEDURE 9).Sum(ReturnValue)".


    //Unsupported feature: Deletion (VariableCollection) on "PlanningTransferShptQty(PROCEDURE 9).ReqLine(Variable 1000)".


    //Unsupported feature: Property Deletion (Name) on "PlanningReleaseQty(PROCEDURE 3).Sum(ReturnValue)".


    //Unsupported feature: Property Modification (Data type) on "PlanningReleaseQty(PROCEDURE 3).Sum(ReturnValue)".


    //Unsupported feature: Property Insertion (Length) on "PlanningReleaseQty(PROCEDURE 3).Sum(ReturnValue)".


    //Unsupported feature: Deletion (VariableCollection) on "PlanningReleaseQty(PROCEDURE 3).ReqLine(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "CalcSalesReturn(PROCEDURE 10).SalesLine(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "CalcPlanningWorksheetQty(PROCEDURE 29).RequisitionLine(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "CalcPurchReturn(PROCEDURE 12).PurchLine(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "CalcResvQtyOnPurchReturn(PROCEDURE 16).ReservationEntry(Variable 1000)".


    var
        InvSetup: Record "313";
        VATPostingSetup2: Record "325";

    var
        ItemAttributeManagement: Codeunit "7500";

    var
        SalesLine: Record "37";
        PurchLine: Record "39";
        ItemAttributeValueMapping: Record "7505";


    //Unsupported feature: Property Modification (TextConstString) on "Text7380(Variable 1058)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text7380 : ENU=If you change the %1, the %2 is calculated.\Do you still want to change the %1?;FRA=Si vous modifiez l'enregistrement %1, le %2 est calculé.\Souhaitez-vous modifier l'enregistrement %1?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text7380 : @@@=If you change the Phys Invt Counting Period Code, the Next Counting Start Date and Next Counting End Date are calculated.\Do you still want to change the Phys Invt Counting Period Code?;ENU=If you change the %1, the %2 and %3 are calculated.\Do you still want to change the %1?;FRA=Si vous modifiez le %1, la %2 et la %3 sont calculées.\Souhaitez-vous quand même modifier le %1 ?;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "CannotChangeFieldErr(Variable 1079)".

    //var
        //>>>> ORIGINAL VALUE:
        //CannotChangeFieldErr : @@@="%1 = field name, %2 = item table name, %3 = item No., %4 = table name";ENU=You cannot change the %1 field on %2 %3 because there exists at least one %4 then includes this item.;FRA=Vous ne pouvez pas modifier le champ %1 de %2 %3, car il existe au moins un %4 incluant cet article.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CannotChangeFieldErr : @@@="%1 = Field Caption, %2 = Item Table Name, %3 = Item No., %4 = Table Name";ENU=You cannot change the %1 field on %2 %3 because at least one %4 exists for this item.;FRA=Vous ne pouvez pas modifier le champ %1 de %2 %3, car il existe au moins un %4 pour cet article.;
        //Variable type has not been exported.

    var
        CannotDeleteItemIfProdBOMVersionExistsErr: Label 'You cannot delete %1 %2 because there are one or more certified production BOM version that include this item.', Comment='%1 - Tablecaption, %2 - No.';

    var
        LeadTimeMgt: Codeunit "5404";
        ApprovalsMgmt: Codeunit "1535";

    var
        OpenDocumentTrackingErr: Label 'You cannot change "Item Tracking Code" because there is at least one open document that includes this item with specified tracking: Source Type = %1, Document No. = %2.';
        SelectItemErr: Label 'You must select an existing item.';
        CreateNewItemTxt: Label 'Create a new item card for %1.', Comment='%1 is the name to be used to create the customer. ';
        ItemNotRegisteredTxt: Label 'This item is not registered. To continue, choose one of the following options:';
        SelectItemTxt: Label 'Select an existing item.';
        "-NSC1.01-": Integer;
        NaviSetup: Record "50004";
        "-- MIGNAV2013 --": ;
        CstG001: Label 'Vous n''avez pas l''autorisation d''''effectuer cette opération.';
}

