tableextension 50038 "BC6_PurchaseHeader" extends "Purchase Header"
{
    LookupPageID = "Purchase List";
    fields
    {
        modify("Currency Code")
        {
            trigger OnAfterValidate()
            var
                TextG001: Label 'Warning, using foreign currency will generate wrong profit calculation.';

            begin
                IF "Currency Code" <> '' THEN
                    MESSAGE(TextG001);

            end;
        }
        modify("Reason Code")
        {
            trigger OnAfterValidate()
            var
                RecLReasonCode: Record "Reason Code";
                RecLPurchLine: Record "Purchase Line";
            begin
                IF xRec."Reason Code" <> Rec."Reason Code" THEN BEGIN
                    RecLPurchLine.SETRANGE("Document Type", "Document Type");
                    RecLPurchLine.SETRANGE("Document No.", "No.");
                    IF RecLPurchLine.FIND('-') THEN
                        REPEAT
                        //TODO: tabext 
                        // RecLPurchLine."DEEE Category Code" := RecLPurchLine."DEEE Category Code";
                        // RecLPurchLine.CalculateDEEE(Rec."Reason Code");
                        // RecLPurchLine.MODIFY;
                        UNTIL RecLPurchLine.NEXT = 0;
                END;
            end;
        }
        modify("Buy-from Vendor Name")
        {
            trigger OnBeforeValidate()
            begin
                //TODO: L'AJOUT UNE CONDITION DE TEST AVANT UNE LIGNE STD 
            end;
        }
        field(50000; "BC6_Affair No."; Code[20])
        {
            Caption = 'Affair No.';
            TableRelation = Job."No.";
        }
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            TableRelation = Vendor;
        }
        field(50010; BC6_ID; Code[50])
        {
            Description = 'AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents achats';
            Editable = false;
            //TODO
            // trigger OnLookup()
            // var
            //     RecLUserMgt: Codeunit 418;
            //     CodLUserID: Code[50];
            // begin
            //     CodLUserID := ID;
            //     RecLUserMgt.LookupUserID(CodLUserID);
            // end;
        }
        field(50020; "BC6_From Sales Module"; Boolean)
        {
            Caption = 'From Sales Module';
            Editable = false;
        }
        field(50021; "BC6_Buy-from Fax No."; Text[30])
        {
            Caption = 'Buy-from Fax No.';
            Description = 'FE005 SEBC 08/01/2007';
        }
        field(50022; "BC6_Buy-from E-Mail Address"; Text[50])
        {
            Description = 'FE005 MICO 12/02/2007';
        }
        field(50080; "BC6_Sales No. Order Lien"; Code[20])
        {
            Caption = 'Sales No. Order Lien';
            Description = 'CNEIC';
        }
        field(50090; "BC6_Last Related Info Date"; DateTime)
        {
            CalcFormula = Max("Purch. Comment Line"."BC6_Log Date" WHERE("Document Type" = FIELD("Document Type"),
                                                                      "No." = FIELD("No."),
                                                                      "BC6_Is Log" = CONST(true)));
            Caption = 'Last Related Info Date';
            FieldClass = FlowField;
        }
        field(50100; "BC6_Return Order Type"; Enum "BC6_Type Location")
        {
            Caption = 'Return Order Type';
            Description = 'BC6';

            trigger OnValidate()
            begin
                //TODO
                // UpdateSalesLineReturnType
            end;
        }
        field(50101; "BC6_Reminder Date"; Date)
        {
            Caption = 'Reminder Date';
        }
        field(50102; "BC6_Related Sales Return Order"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("BC6_Return Order Relation"."Sales Return Order" WHERE("Purchase Order No." = FIELD("No.")));
            Caption = 'N° retour vente associé';
            Editable = false;

        }
    }
    keys
    {
        key(Key10; "Document Date")
        {
        }
    }

    procedure "---NSC1.00---"()
    begin
    end;

    procedure UpdateIncoterm()
    begin
        IF RecGVendor.GET("Buy-from Vendor No.") THEN BEGIN
            "Transaction Type" := RecGVendor."BC6_Transaction Type";
            "Transaction Specification" := RecGVendor."BC6_Transaction Specification";
            "Transport Method" := RecGVendor."BC6_Transport Method";
            "Entry Point" := RecGVendor."BC6_Entry Point";
            Area := RecGVendor.BC6_Area;
        END;
    end;

    procedure "**NSC1.01**"()
    begin
    end;

    procedure ControleMinimMNTandQTE(): Boolean
    var
        MntTot: Decimal;
        QteTot: Decimal;
        Frs: Record Vendor;
        Msg: Text[150];
        TextControleMinima01: Label 'Total Purchase Amount %1, lower than minimum Purchase Amount %2. Do You want add freight charge?';
        RecLPurchaseLine: Record "Purchase Line";
        NumLigne: Integer;
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        PurchSetup.GET;
        IF NOT PurchSetup."BC6_Minima de cde" THEN
            EXIT(FALSE)
        ELSE BEGIN
            PurchSetup.TESTFIELD(PurchSetup.BC6_Type);
            PurchSetup.TESTFIELD(PurchSetup."BC6_No.");
        END;

        Frs.RESET;
        Frs.GET("Buy-from Vendor No.");

        CalcMntHTandMntTTCandQTE(MntTot, QteTot);

        Msg := '\';

        IF MntTot < Frs."BC6_Mini Amount" THEN BEGIN
            IF NOT Existfreightcharge THEN BEGIN
                IF NOT ExistFreightChargeSSAmount THEN BEGIN
                    Msg := Msg + TextControleMinima01;
                    IF HideValidationDialog THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Msg, TRUE, MntTot, Frs."BC6_Mini Amount", QteTot);
                    IF Confirmed THEN BEGIN
                        RecLPurchaseLine.RESET;
                        RecLPurchaseLine.SETRANGE(RecLPurchaseLine."Document Type", "Document Type");
                        RecLPurchaseLine.SETRANGE(RecLPurchaseLine."Document No.", "No.");
                        IF RecLPurchaseLine.FIND('+') THEN
                            NumLigne := RecLPurchaseLine."Line No." + 10000
                        ELSE
                            NumLigne := 10000;

                        RecLPurchaseLine.INIT;
                        RecLPurchaseLine.VALIDATE("Document Type", "Document Type");
                        RecLPurchaseLine.VALIDATE("Document No.", "No.");
                        RecLPurchaseLine.VALIDATE("Line No.", NumLigne);
                        RecLPurchaseLine.INSERT(TRUE);

                        RecLPurchaseLine.VALIDATE(Type, PurchSetup.BC6_Type);
                        RecLPurchaseLine.VALIDATE("No.", PurchSetup."BC6_No.");
                        RecLPurchaseLine.VALIDATE(Quantity, 1);
                        RecLPurchaseLine.VALIDATE("Location Code", "Location Code");
                        RecLPurchaseLine.VALIDATE("Direct Unit Cost", Frs."BC6_Freight Amount");
                        RecLPurchaseLine.MODIFY(TRUE);
                        IF RecLPurchaseLine."Direct Unit Cost" = 0 THEN
                            IF NOT HideValidationDialog THEN
                                MESSAGE('Merci d''indiquer un coût unitaire direct pour la ligne %1, N° %2.', PurchSetup.BC6_Type, PurchSetup."BC6_No.");
                    END;

                END
                ELSE BEGIN
                    IF NOT HideValidationDialog THEN
                        MESSAGE(TextG002, PurchSetup.BC6_Type, PurchSetup."BC6_No.");
                    EXIT(TRUE);
                END;
            END;
        END;

        EXIT(FALSE);
    end;

    procedure CalcMntHTandMntTTCandQTE(var MntTot: Decimal; var QteTot: Decimal)
    var
        PurchLine: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line" temporary;
        TotalPurchLine: Record "Purchase Line";
        TotalPurchLineLCY: Record "Purchase Line";
        Vend: Record Vendor;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        PurchSetup: Record "Purchases & Payables Setup";
        PurchPost: Codeunit "Purch.-Post";
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        VATAmount: Decimal;
        VATAmountText: Text[30];
        PrevNo: Code[20];
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
    begin
        CLEAR(PurchLine);
        CLEAR(TotalPurchLine);
        CLEAR(TotalPurchLineLCY);
        CLEAR(PurchPost);

        PurchPost.GetPurchLines(Rec, TempPurchLine, 0);
        CLEAR(PurchPost);
        //TODO
        // PurchPost.SumPurchLinesTemp(
        //   Rec, TempPurchLine, 0, TotalPurchLine, TotalPurchLineLCY, VATAmount, VATAmountText,
        //   TotalPurchLine."DEEE HT Amount", TotalPurchLine."DEEE VAT Amount", TotalPurchLine."DEEE TTC Amount",
        //   TotalPurchLine."DEEE HT Amount (LCY)");



        IF "Prices Including VAT" THEN BEGIN
            TotalAmount2 := TotalPurchLine.Amount;
            TotalAmount1 := TotalAmount2 + VATAmount;
            TotalPurchLine."Line Amount" := TotalAmount1 + TotalPurchLine."Inv. Discount Amount";
        END ELSE BEGIN
            TotalAmount1 := TotalPurchLine.Amount;
            TotalAmount2 := TotalPurchLine."Amount Including VAT";
        END;

        MntTot := TotalAmount1;
        QteTot := TotalPurchLine.Quantity;
        //FIN CALCMNTTOTAL SM 11/07/06 NCS1.01 [COMPLEMENT_ACHAT0206]  MAJ Montant Total HT Et Montant Total TTC de l'entête achat
    end;

    procedure Existfreightcharge(): Boolean
    var
        RecLSalesLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        PurchLine: Record "Purchase Line";
    begin
        IF PurchLinesExist THEN BEGIN
            REPEAT
                IF (PurchLine.Type = PurchSetup.BC6_Type)
                  AND (PurchLine."No." = PurchSetup."BC6_No.")
                  AND (PurchLine."Line Amount" <> 0) THEN
                    EXIT(TRUE);
            UNTIL PurchLine.NEXT = 0;
        END ELSE
            EXIT(FALSE);
    end;

    procedure UpdateBuyFromFax(CodContactNo: Code[20])
    var
        RecLContact: Record Contact;
    begin
        IF RecLContact.GET(CodContactNo) THEN
            "BC6_Buy-from Fax No." := RecLContact."Fax No."
        ELSE
            "BC6_Buy-from Fax No." := '';
    end;

    procedure UpdateBuyFromMail(CodContactNo: Code[20])
    var
        RecLContact: Record Contact;
    begin
        IF RecLContact.GET(CodContactNo) THEN
            "BC6_Buy-from E-Mail Address" := RecLContact."E-Mail"
        ELSE
            "BC6_Buy-from E-Mail Address" := '';
    end;

    procedure ExistFreightChargeSSAmount(): Boolean
    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchLine: record "Purchase Line";
    begin
        IF PurchLinesExist THEN BEGIN
            REPEAT
                IF (PurchLine.Type = PurchSetup.BC6_Type) AND (PurchLine."No." = PurchSetup."BC6_No.") THEN
                    //AND (PurchLine."Line Amount" <> 0)
                    EXIT(TRUE);
            UNTIL PurchLine.NEXT = 0;
        END ELSE
            EXIT(FALSE);
        //<<FE002.2 CASC
    end;

    procedure AddLogComment(_Qty: Decimal; _ReceiptType: Option Colis,Palette)
    var
        L_PurchCommentLine: Record "Purch. Comment Line";
        L_PurchCommentLine2: Record "Purch. Comment Line";
    begin
        IF _Qty = 0 THEN
            ERROR(Text50000);
        L_PurchCommentLine.INIT;
        L_PurchCommentLine."Document Type" := "Document Type";
        L_PurchCommentLine."No." := "No.";
        L_PurchCommentLine.Comment := FORMAT(_Qty) + ' ' + FORMAT(_ReceiptType);
        L_PurchCommentLine."BC6_Is Log" := TRUE;

        L_PurchCommentLine2.SETRANGE("Document Type", L_PurchCommentLine."Document Type");
        L_PurchCommentLine2.SETRANGE("No.", L_PurchCommentLine."No.");
        IF L_PurchCommentLine2.FINDLAST THEN
            L_PurchCommentLine."Line No." := L_PurchCommentLine2."Line No." + 10000
        ELSE
            L_PurchCommentLine."Line No." := 10000;

        L_PurchCommentLine.INSERT(TRUE);
    end;

    local procedure "---BCSYS---"()
    begin
    end;

    local procedure UpdateSalesLineReturnType()
    var
        L_PurchaseLine: Record "Purchase Line";
    begin
        IF "Document Type" <> "Document Type"::"Return Order" THEN
            EXIT;

        IF xRec."BC6_Return Order Type" <> Rec."BC6_Return Order Type" THEN
            L_PurchaseLine.RESET;
        L_PurchaseLine.SETRANGE("Document Type", "Document Type");
        L_PurchaseLine.SETRANGE("Document No.", "No.");
        //TODO // IF L_PurchaseLine.FINDFIRST THEN
        //   L_PurchaseLine.MODIFYALL("BC6_Return Order Type", "BC6_Return Order Type");
    end;


    var
        ConfirmChangeQst: Label 'Do you want to change %1?', Comment = '%1 = a Field Caption like Currency Code';
        YouCannotChangeFieldErr: Label 'You cannot change %1 because the order is associated with one or more sales orders.', Comment = '%1 - fieldcaption';
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        "---NSC1.01": Label '';

        TextG001: Label 'Warning, using foreign currency will generate wrong profit calculation.';
        TextG002: Label 'Thank to inform freight charge amount for line %1, No. %2';
        TextG003: Label 'Warning:This purchase order is linked to a sales order.';
        Text50000: Label 'Quantity cannot be 0.';
        "-BCSYS-": Integer;
        //TODO   // G_ReturnOrderMgt: Codeunit 50052;
        "-NSC1.00-": Integer;
        RecGVendor: Record Vendor;
        RecGParamNavi: Record "BC6_Navi+ Setup";
        RecGCommentLine: Record "Comment Line";
        FrmGLignesCommentaires: Page "Comment Sheet";
        Confirmed: Boolean;

}
