tableextension 50008 "BC6_SalesHeader" extends "Sales Header" //36
{
    fields
    {
        field(50000; "BC6_Cause filing"; Enum "BC6_Cause Filing")
        {
            Caption = 'Cause filing', Comment = 'FRA="Cause archivage"';
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Purchaser Comments"; Text[50])
        {
            Caption = 'Purchaser Comments', Comment = 'FRA="Commentaires acheteur"';
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Warehouse Comments"; Text[50])
        {
            Caption = 'Warehouse Comments', Comment = 'FRA="Commentaires magasins"';
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.', Comment = 'FRA="Tiers payeur"';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Advance Payment"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            Caption = 'Advance Payment', Comment = 'FRA="Acompte payé"';
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Affair No."; Code[20])
        {
            Caption = 'Affair No.', Comment = 'FRA="N° Affaire"';
            TableRelation = Job."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateSalesShipment.UpdateAffairNoOnSalesShpt(Rec);
            end;
        }
        field(50010; BC6_ID; Code[50])
        {
            Caption = 'User ID', Comment = 'FRA="Code utilisateur"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_Cust. Sales Profit Group"; Code[10])
        {
            Caption = 'Customer Sales Profit Group', Comment = 'FRA="Goupe Marge Vente Client"';
            Enabled = false;
            TableRelation = "Customer Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50025; "BC6_Combine Shipments by Order"; Boolean)
        {
            Caption = 'Combine Shipment By Order', Comment = 'FRA="Regrouper BL par commande"';
            DataClassification = CustomerContent;
        }
        field(50026; "BC6_Purchase cost"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."BC6_Purchase cost" WHERE("Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("No.")));
            Caption = 'Purchase Cost', Comment = 'FRA="Coût d''achat"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; "BC6_Copy Sell-to Address"; Boolean)
        {
            Caption = 'Copy Sell-to Address', Comment = 'FRA="Copie adresse donneur d''ordre"';
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Sales LCY"; Decimal)
        {
            Caption = 'Sales LCY', Comment = 'FRA="Ventes DS"';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Profit LCY"; Decimal)
        {
            Caption = 'Profit LCY', Comment = 'FRA="Marge DS"';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(50032; "BC6_% Profit"; Decimal)
        {
            Caption = '% Profit', Comment = 'FRA="% de marge sur vente"';
            DataClassification = CustomerContent;
        }
        field(50033; BC6_Invoiced; Boolean)
        {
            Caption = 'Invoiced', Comment = 'FRA="Facturé"';
            DataClassification = CustomerContent;
        }
        field(50040; "BC6_Prod. Version No."; Integer)
        {
            Caption = 'Prod. Version No.', Comment = 'FRA="N° version"';
            DataClassification = CustomerContent;
        }
        field(50050; "BC6_Document description"; Text[50])
        {
            Caption = 'Document description', Comment = 'FRA="Libellé document"';
            DataClassification = CustomerContent;
        }
        field(50060; "BC6_Quote statut"; Enum "BC6_Quote statut")
        {
            Caption = 'Quote status', Comment = 'FRA="Statut devis"';
            DataClassification = CustomerContent;
        }
        field(50061; "BC6_Sell-to Fax No."; Text[30])
        {
            Caption = 'Sell-to Fax No.', Comment = 'FRA="N° télécopie donneur d''ordre"';
            DataClassification = CustomerContent;
        }
        field(50062; "BC6_Sell-to E-Mail Address"; Text[50])
        {
            Caption = 'Sell-to E-Mail address', Comment = 'FRA="Adresse mail donneur d''ordre"';
            DataClassification = CustomerContent;
        }
        field(50070; "BC6_Sales Counter"; Boolean)
        {
            Caption = 'Sales Counter', Comment = 'FRA="Vente comptoire"';
            DataClassification = CustomerContent;
        }
        field(50080; "BC6_Purchase No. Order Lien"; Code[20])
        {
            Caption = 'Purchase No. Order Lien', Comment = 'FRA="N° Commande Achat Lien"';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                reclPurchHdr: Record "Purchase Header";
            begin
                //>>CNEIC : Le 07/08/15
                reclPurchHdr.SETRANGE("Document Type", reclPurchHdr."Document Type"::Order);
                reclPurchHdr.SETFILTER("No.", "BC6_Purchase No. Order Lien");

                PAGE.RUNMODAL(PAGE::"Purchase Order", reclPurchHdr);
                //<<CNEIC : Le 07/08/15
            end;
        }
        field(50100; "BC6_Salesperson Filter"; Text[250])
        {
            Caption = 'Salesperson Filter', Comment = 'FRA="Filtre vendeur"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50110; "BC6_Mailing List Code"; Code[10])
        {
            Caption = 'Mailing List Code', Comment = 'FRA="Code liste de diffusion"';
            TableRelation = "BC6_Mailing List";
            DataClassification = CustomerContent;
        }
        field(50120; "BC6_Return Order Type"; Enum "BC6_Type Location")
        {
            Caption = 'Return Order Type', Comment = 'FRA="Type  retour vente"';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateSalesLineReturnType()
            end;
        }
        field(50403; "BC6_Bin Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bin Code';

            trigger OnLookup()
            var
                FonctionMgt: codeunit "BC6_Functions Mgt";
                BinCode: Code[20];

            begin
                IF NOT ("Document Type" = "Document Type"::Order) THEN
                    EXIT;

                BinCode := FonctionMgt.BinLookUp2("Location Code", "BC6_Bin Code");

                IF BinCode <> '' THEN
                    VALIDATE("BC6_Bin Code", BinCode);
            end;

            trigger OnValidate()
            var
                Location: Record Location;
                WMSManagement: Codeunit "WMS Management";
            begin
                IF NOT ("Document Type" = "Document Type"::Order) THEN
                    EXIT;

                IF "BC6_Bin Code" <> '' THEN BEGIN
                    TESTFIELD("Location Code");
                    Location.GET("Location Code");
                    Location.TESTFIELD("Bin Mandatory");
                    Location.TESTFIELD("Require Shipment", FALSE);
                    Location.TESTFIELD("Require Pick");
                END;

                IF xRec."BC6_Bin Code" <> "BC6_Bin Code" THEN BEGIN
                    UpdateSalesLines(FIELDCAPTION("BC6_Bin Code"), CurrFieldNo <> 0);
                END;
            end;
        }
    }
    keys
    {
        key(Key14; "Document Type", "Combine Shipments", "Bill-to Customer No.", "Currency Code", "EU 3-Party Trade", "Dimension Set ID")
        {
        }
        key(Key16; "Shipping Agent Code")
        {
        }
        key(Key17; "BC6_Affair No.")
        {
        }
        key(Key18; "Document Type", "External Document No.")
        {
        }
        key(Key19; Status, "Document Type", "Document Date")
        {
        }
        key(Key21; Status, "Document Type", "No.", "Sell-to Customer No.")
        {
        }
        key(Key20; "Document Type", "Document Date")
        {
        }
        key(Key22; "Order Date", "Document Type")
        {
        }
        key(Key23; Status, "Document Type", "Shipment Date", "No.")
        {
        }
        key(Key24; "Document Type", "Sell-to Customer No.", "Document Date", "No.")
        {
        }
        key(Key25; "Document Type", "Order Date", "No.")
        {
        }
    }

    //ces 2 procedures sont dupliqué du std car ils sont locales
    procedure CheckCrLimitCondition(): Boolean
    var
        RunCheck: Boolean;
    begin
        RunCheck := ("Document Type".AsInteger() <= "Document Type"::Invoice.AsInteger()) or ("Document Type" = "Document Type"::"Blanket Order");
        exit(RunCheck);
    end;

    procedure CheckCrLimit()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        BilltoCustomerNoChanged: Boolean;
        IsHandled: Boolean;
    begin
        SalesHeader := Rec;
        BilltoCustomerNoChanged := xRec."Bill-to Customer No." <> "Bill-to Customer No.";
        if GuiAllowed and
           (CurrFieldNo <> 0) and CheckCrLimitCondition() and SalesHeader.Find()
        then begin
            "Amount Including VAT" := 0;
            if "Document Type" = "Document Type"::Order then
                if BilltoCustomerNoChanged then begin
                    SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SetRange("Document No.", "No.");
                    SalesLine.CalcSums("Outstanding Amount", "Shipped Not Invoiced");
                    "Amount Including VAT" := SalesLine."Outstanding Amount" + SalesLine."Shipped Not Invoiced";
                end;
            IsHandled := false;
            if not IsHandled then
                CustCheckCreditLimit.SalesHeaderCheck(Rec);

            CalcFields("Amount Including VAT");
        end;
    end;
    ////////////////////////////////////////
    PROCEDURE InitFromSalesHeader();
    BEGIN
        IF RecGCustomer.GET("Bill-to Customer No.") THEN BEGIN
            "Transaction Type" := RecGCustomer."BC6_Transaction Type";
            "Transaction Specification" := RecGCustomer."BC6_Transaction Specification";
            "Transport Method" := RecGCustomer."BC6_Transport Method";
            "Exit Point" := RecGCustomer."BC6_Exit Point";
            Area := RecGCustomer.BC6_Area;
        END;
    END;

    procedure UpdateIncoterm()
    begin
        IF RecGCustomer.GET("Bill-to Customer No.") THEN BEGIN
            "Transaction Type" := RecGCustomer."BC6_Transaction Type";
            "Transaction Specification" := RecGCustomer."BC6_Transaction Specification";
            "Transport Method" := RecGCustomer."BC6_Transport Method";
            "Exit Point" := RecGCustomer."BC6_Exit Point";
            Area := RecGCustomer.BC6_Area;
        END;
    end;

    procedure CreatePurchaseQuote(RecLSalesHeader: Record "Sales Header")
    var
        RecLItem: Record Item;
        RecLPurchquoteHeader: Record "Purchase Header";
        RecLPurchquoteHeader2: Record "Purchase Header";
        RecLPurchLine: Record "Purchase Line";
        RecLPurchSetup: Record "Purchases & Payables Setup";
        RecLSalesLine: Record "Sales Line";
        RecLSalesLine2: Record "Sales Line";
        CduLCopyDocMgt: Codeunit "Copy Document Mgt.";
        CduLNoSeriesMgt: Codeunit NoSeriesManagement;
        BooLCreate: Boolean;
        CodLLastVendor: Code[20];
        IntLnumberofQuote: Integer;
        NextLineNo: Integer;
        TextL001: Label '%1 Purchase Quote already existfor vendor %3, the newest from %2 do you to create a new one ?', Comment = 'FRA="%1  demande(s) de prix éxiste déja pour le fournisseur %3 , La plus récente est du %2 voulez vous en créer une nouvelle ?"';
        TextL002: Label '%1 quote created', Comment = 'FRA="%1 demande(s) de prix créée(s)"';
    begin
        RecLSalesLine.RESET();
        RecLSalesLine.SETCURRENTKEY("Document Type", RecLSalesLine."BC6_Buy-from Vendor No.");
        RecLSalesLine.SETRANGE(RecLSalesLine."Document Type", RecLSalesHeader."Document Type");
        RecLSalesLine.SETRANGE(RecLSalesLine."Document No.", RecLSalesHeader."No.");
        RecLSalesLine.SETRANGE(RecLSalesLine.Type, RecLSalesLine.Type::Item);

        RecLSalesLine.SETFILTER("Special Order", '%1', FALSE);
        RecLSalesLine.SETFILTER("Drop Shipment", '%1', FALSE);

        RecLSalesLine2.COPYFILTERS(RecLSalesLine);
        IntLnumberofQuote := 0;

        IF RecLSalesLine.FIND('-') THEN BEGIN
            REPEAT
                IF RecLItem.GET(RecLSalesLine."No.") THEN
                    //Entete devis achat
                    IF CodLLastVendor <> RecLSalesLine."BC6_Buy-from Vendor No." THEN BEGIN
                        CodLLastVendor := RecLSalesLine."BC6_Buy-from Vendor No.";

                        BooLCreate := TRUE;
                        RecLPurchquoteHeader2.RESET();
                        RecLPurchquoteHeader2.SETRANGE("Document Type", "Document Type"::Quote);
                        RecLPurchquoteHeader2.SETFILTER("Buy-from Vendor No.", RecLSalesLine."BC6_Buy-from Vendor No.");
                        IF RecLPurchquoteHeader2.FIND('+') THEN
                            IF NOT CONFIRM(TextL001, TRUE, RecLPurchquoteHeader2.COUNT, RecLPurchquoteHeader2."Document Date",
                            RecLPurchquoteHeader2."Buy-from Vendor Name") THEN
                                BooLCreate := FALSE;

                        IF BooLCreate THEN BEGIN
                            IntLnumberofQuote += 1;
                            RecLPurchquoteHeader.SetHideValidationDialog(TRUE);
                            RecLPurchquoteHeader.INIT();
                            RecLPurchquoteHeader."No." := '';
                            RecLPurchquoteHeader.VALIDATE("Document Date", WORKDATE());
                            RecLPurchquoteHeader.VALIDATE("Buy-from Vendor No.", RecLItem."Vendor No.");
                            RecLPurchquoteHeader.VALIDATE("Your Reference", RecLSalesHeader."No.");
                            RecLPurchquoteHeader.VALIDATE("Sell-to Customer No.", RecLSalesHeader."Sell-to Customer No.");
                            RecLPurchquoteHeader.VALIDATE("Purchaser Code", RecLSalesHeader."Salesperson Code");
                            RecLPurchquoteHeader."BC6_From Sales Module" := TRUE;
                            RecLPurchquoteHeader.INSERT(TRUE);

                            NextLineNo := 10000;

                            RecLSalesLine2.SETFILTER("BC6_Buy-from Vendor No.", RecLPurchquoteHeader."Buy-from Vendor No.");
                            IF RecLSalesLine2.FIND('-') THEN BEGIN
                                REPEAT
                                    RecLPurchLine.INIT();
                                    RecLPurchLine.VALIDATE("Document Type", RecLPurchLine."Document Type"::Quote);
                                    RecLPurchLine.VALIDATE("Document No.", RecLPurchquoteHeader."No.");
                                    RecLPurchLine.VALIDATE("Line No.", NextLineNo);
                                    CduLCopyDocMgt.TransfldsFromSalesToPurchLine(RecLSalesLine2, RecLPurchLine);
                                    RecLPurchLine.VALIDATE("Purchasing Code", RecLSalesLine2."Purchasing Code");
                                    RecLPurchLine.VALIDATE("BC6_Sales No.", RecLSalesLine2."Document No.");
                                    RecLPurchLine.VALIDATE("BC6_Sales Line No.", RecLSalesLine2."Line No.");
                                    RecLPurchLine.VALIDATE("BC6_Sales Document Type", RecLSalesHeader."Document Type");
                                    RecLPurchLine.INSERT(TRUE);
                                    NextLineNo := NextLineNo + 10000;

                                    RecLSalesLine2.VALIDATE("BC6_Purch. Order No.", RecLPurchLine."Document No.");
                                    RecLSalesLine2.VALIDATE("BC6_Purch. Line No.", RecLPurchLine."Line No.");
                                    RecLSalesLine2.VALIDATE("BC6_Purch. Document Type", RecLPurchLine."Document Type");
                                    RecLSalesLine2.VALIDATE("BC6_Purchase cost", RecLPurchLine."BC6_Discount Direct Unit Cost");
                                    RecLSalesLine2.VALIDATE("BC6_Purchase Receipt Date", RecLPurchLine."Expected Receipt Date");
                                    RecLSalesLine2.MODIFY(TRUE);
                                UNTIL RecLSalesLine2.NEXT() = 0;
                            END;
                        END;
                    END;
            UNTIL RecLSalesLine.NEXT() = 0;
            IF BooLCreate THEN BEGIN
                MESSAGE(TextL002, IntLnumberofQuote);
                PAGE.RUN(Page::"Purchase Quote", RecLPurchquoteHeader);
            END;
        END;
    end;

    PROCEDURE GetPstdDocLinesToRevere();
    VAR
        Cust: Record Customer;
        SalesPostedDocLines: Page "Posted Sales Document Lines";
    BEGIN
        GetCust("Sell-to Customer No.");
        SalesPostedDocLines.SetToSalesHeader(Rec);
        SalesPostedDocLines.SETRECORD(Cust);
        SalesPostedDocLines.LOOKUPMODE := TRUE;
        IF SalesPostedDocLines.RUNMODAL() = ACTION::LookupOK THEN
            SalesPostedDocLines.CopyLineToDoc();

        CLEAR(SalesPostedDocLines);
    END;

    procedure verifyquotestatus(): Boolean
    var
        RecLAccessControl: Record "Access Control";
        SalesSetup: Record "Sales & Receivables Setup";
        RecLQuotehdr: Record "Sales Header";
    begin
        RecLAccessControl.RESET();
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID());
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID());
        RecLAccessControl.SETRANGE("Role ID", 'SUPER');
        IF NOT RecLAccessControl.FINDFIRST() AND ("Document Type" = "Document Type"::Quote) THEN begin
            SalesSetup.GET();
            SalesSetup.TESTFIELD(BC6_Nbr_Devis);
            SalesSetup.TESTFIELD(Période);
            RecLQuotehdr.SETRANGE("Document Type", RecLQuotehdr."Document Type"::Quote);
            RecLQuotehdr.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");
            RecLQuotehdr.SETRANGE("Document Date", CALCDATE('-' + FORMAT(SalesSetup.Période), WORKDATE()), WORKDATE());
            IF (RecLQuotehdr.COUNT <= SalesSetup.BC6_Nbr_Devis) OR ("BC6_Quote statut" = "BC6_Quote statut"::approved) THEN
                EXIT(TRUE)
            ELSE BEGIN
                "BC6_Quote statut" := "BC6_Quote statut"::locked;
                PAGE.RUN(PAGE::"BC6_Quote Blocked", Rec);
                EXIT(FALSE);
            END;
        END;

        EXIT(TRUE);
    end;

    PROCEDURE UpdateSellToFax(CodContactNo: Code[20]);

    var
        RecLContact: Record Contact;
    begin
        IF RecLContact.GET(CodContactNo) THEN
            "BC6_Sell-to Fax No." := RecLContact."Fax No."
        ELSE
            "BC6_Sell-to Fax No." := '';
    end;

    procedure UpdateSellToMail(CodContactNo: Code[20])
    var
        RecLContact: Record Contact;
    begin
        IF RecLContact.GET(CodContactNo) THEN
            "BC6_Sell-to E-Mail Address" := RecLContact."E-Mail"
        ELSE
            "BC6_Sell-to E-Mail Address" := '';
    end;

    procedure CopySellToAddress(var FromCurrFieldNo: Integer)
    begin
        IF (FromCurrFieldNo = 0) THEN
            EXIT;

        IF NOT ("BC6_Copy Sell-to Address") THEN
            EXIT;
        CASE FromCurrFieldNo OF
            FIELDNO("Sell-to Customer Name"):
                "Bill-to Name" := "Sell-to Customer Name";
            FIELDNO("Sell-to Customer Name 2"):
                "Bill-to Name 2" := "Sell-to Customer Name 2";
            FIELDNO("Sell-to Address"):
                "Bill-to Address" := "Sell-to Address";
            FIELDNO("Sell-to Address 2"):
                "Bill-to Address 2" := "Sell-to Address 2";
            FIELDNO("Sell-to City"):
                BEGIN
                    "Bill-to City" := "Sell-to City";
                    "Bill-to Post Code" := "Sell-to Post Code";
                    "Bill-to County" := "Sell-to County";
                    "Bill-to Country/Region Code" := "Sell-to Country/Region Code";
                END;
            FIELDNO("Sell-to Post Code"):
                BEGIN
                    "Bill-to Post Code" := "Sell-to Post Code";
                    "Bill-to City" := "Sell-to City";
                    "Bill-to County" := "Sell-to County";
                    "Bill-to Country/Region Code" := "Sell-to Country/Region Code";
                END;
            FIELDNO("Sell-to County"):
                "Bill-to County" := "Sell-to County";
            FIELDNO("Sell-to Contact"):
                "Bill-to Contact" := "Sell-to Contact";
        END;

        CASE FromCurrFieldNo OF
            FIELDNO("Sell-to Customer Name"):
                "Ship-to Name" := "Sell-to Customer Name";
            FIELDNO("Sell-to Customer Name 2"):
                "Ship-to Name 2" := "Sell-to Customer Name 2";
            FIELDNO("Sell-to Address"):
                "Ship-to Address" := "Sell-to Address";
            FIELDNO("Sell-to Address 2"):
                "Ship-to Address 2" := "Sell-to Address 2";
            FIELDNO("Sell-to City"):
                BEGIN
                    "Ship-to City" := "Sell-to City";
                    "Ship-to Post Code" := "Sell-to Post Code";
                    "Ship-to County" := "Sell-to County";
                    "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
                END;

            FIELDNO("Sell-to Post Code"):
                BEGIN
                    "Ship-to Post Code" := "Sell-to Post Code";
                    "Ship-to City" := "Sell-to City";
                    "Ship-to County" := "Sell-to County";
                    "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
                END;
            FIELDNO("Sell-to County"):
                "Ship-to County" := "Sell-to County";
            FIELDNO("Sell-to Contact"):
                "Ship-to Contact" := "Sell-to Contact";
        END;
    end;

    local procedure UpdateSalesLineReturnType()
    var
        L_SalesLine: Record "Sales Line";
    begin
        IF "Document Type" <> "Document Type"::"Return Order" THEN
            EXIT;

        IF xRec."BC6_Return Order Type" <> Rec."BC6_Return Order Type" THEN
            L_SalesLine.RESET();
        L_SalesLine.SETRANGE("Document Type", "Document Type");
        L_SalesLine.SETRANGE("Document No.", "No.");
        IF L_SalesLine.FINDFIRST() THEN
            L_SalesLine.MODIFYALL("BC6_Return Order Type", "BC6_Return Order Type");
    end;

    procedure IsDeleteFromReturn(NewIsDeleteFromReturnOrder: Boolean)
    begin
        IsDeleteFromReturnOrder := NewIsDeleteFromReturnOrder;
    end;

    var
        RecGParamNavi: Record "BC6_Navi+ Setup";
        Bin: Record Bin;
        RecGCommentLine: Record "Comment Line";
        RecGCustomer: Record Customer;
        GenJnlLine: Record "Gen. Journal Line";
        ShipmentMethodRec: Record "Shipment Method";
        ShipToAddr: Record "Ship-to Address";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        UpdateSalesShipment: Codeunit BC6_UpdateSalesShipment;
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        PostSalesDelete: Codeunit "PostSales-Delete";
        CDUReleaseDoc: Codeunit "Release Sales Document";

        WMSManagement: Codeunit "WMS Management";
        ApplyCustEntries: Page "Apply Customer Entries";

        FrmGLignesCommentaires: Page "Comment Sheet";
        BoolReclose: Boolean;
        IsDeleteFromReturnOrder: Boolean;
        SelectNoSeriesAllowed: Boolean;
        BinCode: Code[20];
        G_ReturnOrderMgt: Codeunit "BC6_Return Order Mgt.";
        "-BCSYS-": Integer;
        "-NSC1.00-": Integer;
        BillToCustomerTxt: Label 'Bill-to Customer', Comment = 'FRA="Client facturé"';
        ConfirmChangeQst: Label 'Do you want to change %1?', Comment = 'FRA="Souhaitez-vous modifier la valeur du champ %1 ?"';
        DeferralLineQst: Label 'Do you want to update the deferral schedules for the lines?', Comment = 'FRA="Souhaitez-vous mettre à jour les tableaux d''échelonnement pour les lignes ?"';
        DocumentNotPostedClosePageQst: Label 'The document has not been posted.\Are you sure you want to exit?', Comment = 'FRA="Le document n''a pas été validé.\Voulez-vous vraiment quitter ?"';
        SelectCustomerTemplateQst: Label 'Do you want to select the customer template?', Comment = 'FRA="Un ou plusieurs documents validés connexes ont été générés lors de la suppression pour éviter une discontinuité dans la souche de numéros de validation. Vous pouvez afficher ou imprimer les documents à partir de l''archive de document correspondant."';
        SellToCustomerTxt: Label 'Sell-to Customer', Comment = 'FRA="Donneur d''ordre"';
        ShippingAdviceErr: Label 'This order must be a complete shipment.', Comment = 'FRA="Cette commande doit faire l''objet d''une expédition totale."';
        TextG003: Label 'Warning: you have already placed this order purchase.', Comment = 'FRA="Attention : vous avez déjà passé cette commande en achat. "';
}
