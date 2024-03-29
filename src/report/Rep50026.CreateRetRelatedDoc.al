report 50026 "BC6_Create Ret.-Related Doc" //6697
{
    Caption = 'Create Ret.-Related Documents', Comment = 'FRA="Créer doc. associés retour"';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'FRA="Options"';
                    group("Return to Vendor")
                    {
                        Caption = 'Return to Vendor', Comment = 'FRA="Retour fournisseur"';
                        field(VendorNoF; VendorNo)
                        {
                            ApplicationArea = All;
                            Caption = 'Vendor No.', Comment = 'FRA="N° fournisseur"';
                            Lookup = true;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                IF PAGE.RUNMODAL(0, Vend) = ACTION::LookupOK THEN
                                    VendorNo := Vend."No.";
                            end;

                            trigger OnValidate()
                            begin
                                IF VendorNo <> '' THEN
                                    Vend.GET(VendorNo);
                            end;
                        }
                        field(CreatePurchRetOrder; CreatePRO)
                        {
                            ApplicationArea = All;
                            Caption = 'Create Purch. Ret. Order', Comment = 'FRA="Créer retour achat"';
                        }
                        field(CreatePurchaseOrder; CreatePO)
                        {
                            ApplicationArea = All;
                            Caption = 'Create Purchase Order', Comment = 'FRA="Créer commande achat"';
                        }
                    }
                    group(Replacement)
                    {
                        Caption = 'Replacement', Comment = 'FRA="Remplacement"';
                        field(CreateSalesOrder; CreateSO)
                        {
                            ApplicationArea = All;
                            Caption = 'Create Sales Order', Comment = 'FRA="Créer commande vente"';
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            CreatePRO := TRUE;
            CreatePO := FALSE;
            CreateSO := FALSE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        TempRetRelDoc.DELETEALL();

        CreateReturnOrderRelation();

        IF CreateSO THEN BEGIN
            IF G_ReturnOrderRelation."Sales Order No." <> '' THEN
                ERROR(ErrorSalesOrderExists);
            SOSalesHeader."Document Type" := SOSalesHeader."Document Type"::Order;
            CLEAR(CopyDocMgt);
            CopyDocMgt.SetProperties(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE);
            FunctionMgt.SetSkipTestCreditLimit(TRUE);
            CopyDocMgt.CopySalesDoc(DocType::"Return Order", SROSalesHeader."No.", SOSalesHeader);
            TempRetRelDoc."Entry No." := 3;
            TempRetRelDoc."Document Type" := TempRetRelDoc."Document Type"::"Sales Order";
            TempRetRelDoc."No." := SOSalesHeader."No.";
            TempRetRelDoc.INSERT();
            G_ReturnOrderRelation."Sales Order No." := SOSalesHeader."No.";
            G_ReturnOrderRelation.MODIFY();
        END;

        IF CreatePRO THEN BEGIN
            IF G_ReturnOrderRelation."Purchase Return Order" <> '' THEN
                ERROR(ErrorReturnPurchOrderExists);
            PROPurchHeader."Document Type" := PROPurchHeader."Document Type"::"Return Order";
            CLEAR(CopyDocMgt);
            CopyDocMgt.SetProperties(TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE);
            FunctionMgt.SetSkipTestCreditLimit(TRUE);
            CopyDocMgt.CopyFromSalesToPurchDoc(VendorNo, SROSalesHeader, PROPurchHeader);
            TempRetRelDoc."Entry No." := 1;
            TempRetRelDoc."Document Type" := TempRetRelDoc."Document Type"::"Purchase Return Order";
            TempRetRelDoc."No." := PROPurchHeader."No.";
            TempRetRelDoc.INSERT();
            G_ReturnOrderRelation."Purchase Return Order" := PROPurchHeader."No.";
            G_ReturnOrderRelation.MODIFY();
        END;

        IF CreatePO THEN BEGIN
            IF G_ReturnOrderRelation."Purchase Order No." <> '' THEN
                ERROR(ErrorPurchOrderExists);
            POPurchHeader."Document Type" := POPurchHeader."Document Type"::Order;
            CLEAR(CopyDocMgt);
            CopyDocMgt.SetProperties(TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE);
            FunctionMgt.SetSkipTestCreditLimit(TRUE);
            CopyDocMgt.CopyFromSalesToPurchDoc(VendorNo, SROSalesHeader, POPurchHeader);
            TempRetRelDoc."Entry No." := 2;
            TempRetRelDoc."Document Type" := TempRetRelDoc."Document Type"::"Purchase Order";
            TempRetRelDoc."No." := POPurchHeader."No.";
            TempRetRelDoc.INSERT();
            G_ReturnOrderRelation."Purchase Order No." := POPurchHeader."No.";
            G_ReturnOrderRelation.MODIFY();
        END;
    end;

    var
        G_ReturnOrderRelation: Record "BC6_Return Order Relation";
        POPurchHeader: Record "Purchase Header";
        PROPurchHeader: Record "Purchase Header";
        TempRetRelDoc: Record "Returns-Related Document" temporary;
        SOSalesHeader: Record "Sales Header";
        SROSalesHeader: Record "Sales Header";
        Vend: Record Vendor;
        FunctionMgt: Codeunit "BC6_Functions Mgt";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        CreatePO: Boolean;
        CreatePRO: Boolean;
        CreateSO: Boolean;
        VendorNo: Code[20];
        ErrorAlreadyExist: Label 'Unable to create related documents for sales return because they are already generated.\ Purchase return: %1 \ Purchase order: %2 \ Sales order: %3', Comment = 'FRA="Impossible de créer les documents associés pour le retour vente car ils sont déjà générés.\ Retour achat : %1 \ Commande achat : %2 \ Commande vente : %3"';
        ErrorPurchOrderExists: Label 'The associated Puchase order has already been generated. \ Please see the action View associated documents.', Comment = 'FRA="La commande achat associée est déjà générée.\Veuillez consulter l''action Affichage documents associés."';
        ErrorReturnPurchOrderExists: Label 'The associated Purchase Return has already been generated. \ Please see the action View associated documents.', Comment = 'FRA="Le retour ahat associé est déjà généré.\Veuillez consulter l''action Affichage documents associés."';
        ErrorSalesOrderExists: Label 'The associated sales order has already been generated. \ Please see the action View associated documents.', Comment = 'FRA="La commande vente associée est déjà générée.\Veuillez consulter l''action Affichage documents associés."';
        DocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo";

    procedure SetSalesHeader(NewSROSalesHeader: Record "Sales Header")
    begin
        SROSalesHeader := NewSROSalesHeader;
    end;

    procedure ShowDocuments()
    begin
        IF TempRetRelDoc.FINDFIRST() THEN
            PAGE.RUN(PAGE::"Returns-Related Documents", TempRetRelDoc);
    end;

    local procedure CreateReturnOrderRelation()
    begin
        G_ReturnOrderRelation.Init();
        IF CreateSO OR CreatePRO OR CreatePO THEN
            IF NOT G_ReturnOrderRelation.GET(SROSalesHeader."No.") THEN BEGIN
                G_ReturnOrderRelation."Sales Return Order" := SROSalesHeader."No.";
                G_ReturnOrderRelation.INSERT();
            END ELSE
                IF (G_ReturnOrderRelation."Sales Order No." <> '') AND (G_ReturnOrderRelation."Purchase Return Order" <> '') AND (G_ReturnOrderRelation."Purchase Order No." <> '') THEN
                    ERROR(ErrorAlreadyExist, G_ReturnOrderRelation."Purchase Return Order", G_ReturnOrderRelation."Purchase Order No.", G_ReturnOrderRelation."Sales Order No.");
    end;
}
