tableextension 50038 "BC6_PurchaseHeader" extends "Purchase Header" //38
{
    LookupPageID = "Purchase List";
    fields
    {
        field(50000; "BC6_Affair No."; Code[20])
        {
            Caption = 'Affair No.', comment = 'FRA="N° Affaire"';
            TableRelation = Job."No.";
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', comment = 'FRA="Tiers payeur"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50010; BC6_ID; Code[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
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
            Caption = 'From Sales Module', comment = 'FRA="Depuis Module Vente"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Buy-from Fax No."; Text[30])
        {
            Caption = 'Buy-from Fax No.', comment = 'FRA="N° télécopie preneur d''ordre"';
            DataClassification = CustomerContent;
        }
        field(50022; "BC6_Buy-from E-Mail Address"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50080; "BC6_Sales No. Order Lien"; Code[20])
        {
            Caption = 'Sales No. Order Lien', comment = 'FRA="N° Commande Vente Lien Lien"';
            DataClassification = CustomerContent;
        }
        field(50090; "BC6_Last Related Info Date"; DateTime)
        {
            CalcFormula = Max("Purch. Comment Line"."BC6_Log Date" WHERE("Document Type" = FIELD("Document Type"),
                                                                      "No." = FIELD("No."),
                                                                      "BC6_Is Log" = CONST(true)));
            Caption = 'Last Related Info Date', comment = 'FRA="Date dernière info connexe"';
            FieldClass = FlowField;
        }
        field(50100; "BC6_Return Order Type"; Enum "BC6_Type Location")
        {
            Caption = 'Return Order Type', comment = 'FRA="Type  retour achat"';
            Description = 'BC6';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateSalesLineReturnType
            end;
        }
        field(50101; "BC6_Reminder Date"; Date)
        {
            Caption = 'Reminder Date', comment = 'FRA="Date de relance"';
            DataClassification = CustomerContent;
        }
        field(50102; "BC6_Related Sales Return Order"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("BC6_Return Order Relation"."Sales Return Order" WHERE("Purchase Order No." = FIELD("No.")));
            Caption = 'Related Sales Return Order', comment = 'FRA="N° retour vente associé"';
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
        RecLPurchaseLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        Frs: Record Vendor;
        MntTot: Decimal;
        QteTot: Decimal;
        NumLigne: Integer;
        TextControleMinima01: Label 'Total Purchase Amount %1, lower than minimum Purchase Amount %2. Do You want add freight charge?';
        Msg: Text[150];
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
        PurchSetup: Record "Purchases & Payables Setup";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        Vend: Record Vendor;
        PurchPost: Codeunit "Purch.-Post";
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        PrevNo: Code[20];
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        VATAmount: Decimal;
        VATAmountText: Text[30];
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
        //   TotalPurchLine."BC6_DEEE HT Amount", TotalPurchLine."BC6_DEEE VAT Amount", TotalPurchLine."BC6_DEEE TTC Amount",
        //   TotalPurchLine."BC6_DEEE HT Amount (LCY)");



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
    end;

    procedure Existfreightcharge(): Boolean
    var
        PurchLine: Record "Purchase Line";
        RecLSalesLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
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
        PurchLine: record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        IF PurchLinesExist THEN BEGIN
            REPEAT
                IF (PurchLine.Type = PurchSetup.BC6_Type) AND (PurchLine."No." = PurchSetup."BC6_No.") THEN
                    EXIT(TRUE);
            UNTIL PurchLine.NEXT = 0;
        END ELSE
            EXIT(FALSE);
    end;

    procedure AddLogComment(_Qty: Decimal; _ReceiptType: Enum BC6_ReceiptType)
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
        IF L_PurchaseLine.FINDFIRST THEN
            L_PurchaseLine.MODIFYALL("BC6_Return Order Type", "BC6_Return Order Type");
    end;


    var
        RecGParamNavi: Record "BC6_Navi+ Setup";
        RecGCommentLine: Record "Comment Line";
        RecGVendor: Record Vendor;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        G_ReturnOrderMgt: Codeunit "BC6_Return Order Mgt.";
        FrmGLignesCommentaires: Page "Comment Sheet";
        Confirmed: Boolean;
        "-BCSYS-": Integer;
        "-NSC1.00-": Integer;
        "---NSC1.01": Label '';
        ConfirmChangeQst: Label 'Do you want to change %1?';
        Text50000: Label 'Quantity cannot be 0.';

        TextG001: Label 'Warning, using foreign currency will generate wrong profit calculation.';
        TextG002: Label 'Thank to inform freight charge amount for line %1, No. %2';
        TextG003: Label 'Warning:This purchase order is linked to a sales order.';
        YouCannotChangeFieldErr: Label 'You cannot change %1 because the order is associated with one or more sales orders.', Comment = '%1 - fieldcaption';

}
