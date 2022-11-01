tableextension 50038 "BC6_PurchaseHeader" extends "Purchase Header"
{
    LookupPageID = 53;
    fields
    {
        modify("Pay-to Name")
        {
            TableRelation = Vendor;

            //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Pay-to Name"(Field 5)".

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
            CalcFormula = Max("Purch. Comment Line"."Log Date" WHERE("Document Type" = FIELD("Document Type"),
                                                                      "No." = FIELD("No."),
                                                                      "Is Log" = CONST(true)));
            Caption = 'Last Related Info Date';
            FieldClass = FlowField;
        }
        field(50100; "BC6_Return Order Type"; Enum "BC6_Type Location")
        {
            Caption = 'Return Order Type';
            Description = 'BC6';

            trigger OnValidate()
            begin
                UpdateSalesLineReturnType
            end;
        }
        field(50101; "BC6_Reminder Date"; Date)
        {
            Caption = 'Reminder Date';
            Description = 'BC6';
        }
        field(50102; "BC6_Related Sales Return Order"; Code[20])
        {
            CalcFormula = Lookup("Return Order Relation"."Sales Return Order" WHERE(Purchase Order No.=FIELD(No.)));
            Caption = 'N° retour vente associé';
            Description = 'BC6';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                SalesHeader: Record "36";
            begin
            end;
        }
    }
    keys
    {
        key(Key1;"Document Date")
        {
        }
    }

    local procedure InitInsert()
    var
        NoSeries: Record "308";
    begin
        IF "No." = '' THEN BEGIN
          TestNoSeries;
          NoSeries.GET(GetNoSeriesCode);
          IF (NOT NoSeries."Default Nos.") AND SelectNoSeriesAllowed AND NoSeriesMgt.IsSeriesSelected THEN
            NoSeriesMgt.SetSeries("No.")
          ELSE
            NoSeriesMgt.InitSeries(NoSeries.Code,xRec."No. Series","Posting Date","No.","No. Series");
        END;

        InitRecord;
    end;

    local procedure SkipInitialization(): Boolean
    begin
        IF "No." = '' THEN
          EXIT(FALSE);

        IF "Buy-from Vendor No." = '' THEN
          EXIT(FALSE);

        IF xRec."Document Type" <> "Document Type" THEN
          EXIT(FALSE);

        IF GETFILTER("Buy-from Vendor No.") <> '' THEN
          IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
            IF "Buy-from Vendor No." = GETRANGEMIN("Buy-from Vendor No.") THEN
              EXIT(FALSE);

        EXIT(TRUE);
    end;

    local procedure InitNoSeries()
    begin
        IF xRec."Receiving No." <> '' THEN BEGIN
          "Receiving No. Series" := xRec."Receiving No. Series";
          "Receiving No." := xRec."Receiving No.";
        END;
        IF xRec."Posting No." <> '' THEN BEGIN
          "Posting No. Series" := xRec."Posting No. Series";
          "Posting No." := xRec."Posting No.";
        END;
        IF xRec."Return Shipment No." <> '' THEN BEGIN
          "Return Shipment No. Series" := xRec."Return Shipment No. Series";
          "Return Shipment No." := xRec."Return Shipment No.";
        END;
        IF xRec."Prepayment No." <> '' THEN BEGIN
          "Prepayment No. Series" := xRec."Prepayment No. Series";
          "Prepayment No." := xRec."Prepayment No.";
        END;
        IF xRec."Prepmt. Cr. Memo No." <> '' THEN BEGIN
          "Prepmt. Cr. Memo No. Series" := xRec."Prepmt. Cr. Memo No. Series";
          "Prepmt. Cr. Memo No." := xRec."Prepmt. Cr. Memo No.";
        END;
    end;

    local procedure TransferSavedFields(var DestinationPurchaseLine: Record "39";var SourcePurchaseLine: Record "39")
    begin
        DestinationPurchaseLine.VALIDATE("Unit of Measure Code",SourcePurchaseLine."Unit of Measure Code");
        DestinationPurchaseLine.VALIDATE("Variant Code",SourcePurchaseLine."Variant Code");
        DestinationPurchaseLine."Prod. Order No." := SourcePurchaseLine."Prod. Order No.";
        IF DestinationPurchaseLine."Prod. Order No." <> '' THEN BEGIN
          DestinationPurchaseLine.Description := SourcePurchaseLine.Description;
          DestinationPurchaseLine.VALIDATE("VAT Prod. Posting Group",SourcePurchaseLine."VAT Prod. Posting Group");
          DestinationPurchaseLine.VALIDATE("Gen. Prod. Posting Group",SourcePurchaseLine."Gen. Prod. Posting Group");
          DestinationPurchaseLine.VALIDATE("Expected Receipt Date",SourcePurchaseLine."Expected Receipt Date");
          DestinationPurchaseLine.VALIDATE("Requested Receipt Date",SourcePurchaseLine."Requested Receipt Date");
          DestinationPurchaseLine.VALIDATE("Qty. per Unit of Measure",SourcePurchaseLine."Qty. per Unit of Measure");
        END;
        IF (SourcePurchaseLine."Job No." <> '') AND (SourcePurchaseLine."Job Task No." <> '') THEN BEGIN
          DestinationPurchaseLine.VALIDATE("Job No.",SourcePurchaseLine."Job No.");
          DestinationPurchaseLine.VALIDATE("Job Task No.",SourcePurchaseLine."Job Task No.");
          DestinationPurchaseLine."Job Line Type" := SourcePurchaseLine."Job Line Type";
        END;
        IF SourcePurchaseLine.Quantity <> 0 THEN
          DestinationPurchaseLine.VALIDATE(Quantity,SourcePurchaseLine.Quantity);
        IF ("Currency Code" = xRec."Currency Code") AND (PurchLine."Direct Unit Cost" = 0) THEN
          DestinationPurchaseLine.VALIDATE("Direct Unit Cost",SourcePurchaseLine."Direct Unit Cost");
        DestinationPurchaseLine."Routing No." := SourcePurchaseLine."Routing No.";
        DestinationPurchaseLine."Routing Reference No." := SourcePurchaseLine."Routing Reference No.";
        DestinationPurchaseLine."Operation No." := SourcePurchaseLine."Operation No.";
        DestinationPurchaseLine."Work Center No." := SourcePurchaseLine."Work Center No.";
        DestinationPurchaseLine."Prod. Order Line No." := SourcePurchaseLine."Prod. Order Line No.";
        DestinationPurchaseLine."Overhead Rate" := SourcePurchaseLine."Overhead Rate";
    end;

    local procedure TransferSavedFieldsDropShipment(var DestinationPurchaseLine: Record "39";var SourcePurchaseLine: Record "39")
    var
        SalesLine: Record 37;
        CopyDocMgt: Codeunit 6620;
    begin
        SalesLine.GET(SalesLine."Document Type"::Order,
          SourcePurchaseLine."Sales Order No.",
          SourcePurchaseLine."Sales Order Line No.");
        CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine,DestinationPurchaseLine);
        DestinationPurchaseLine."Drop Shipment" := SourcePurchaseLine."Drop Shipment";
        DestinationPurchaseLine."Purchasing Code" := SalesLine."Purchasing Code";
        DestinationPurchaseLine."Sales Order No." := SourcePurchaseLine."Sales Order No.";
        DestinationPurchaseLine."Sales Order Line No." := SourcePurchaseLine."Sales Order Line No.";
        EVALUATE(DestinationPurchaseLine."Inbound Whse. Handling Time",'<0D>');
        DestinationPurchaseLine.VALIDATE("Inbound Whse. Handling Time");
        SalesLine.VALIDATE("Unit Cost (LCY)",DestinationPurchaseLine."Unit Cost (LCY)");
        SalesLine."Purchase Order No." := DestinationPurchaseLine."Document No.";
        SalesLine."Purch. Order Line No." := DestinationPurchaseLine."Line No.";
        SalesLine.MODIFY;
    end;

    local procedure TransferSavedFieldsSpecialOrder(var DestinationPurchaseLine: Record "39";var SourcePurchaseLine: Record "39")
    var
        SalesLine: Record 37;
        CopyDocMgt: Codeunit 6620;
    begin
        SalesLine.GET(SalesLine."Document Type"::Order,
          SourcePurchaseLine."Special Order Sales No.",
          SourcePurchaseLine."Special Order Sales Line No.");
        CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine,DestinationPurchaseLine);
        DestinationPurchaseLine."Special Order" := SourcePurchaseLine."Special Order";
        DestinationPurchaseLine."Purchasing Code" := SalesLine."Purchasing Code";
        DestinationPurchaseLine."Special Order Sales No." := SourcePurchaseLine."Special Order Sales No.";
        DestinationPurchaseLine."Special Order Sales Line No." := SourcePurchaseLine."Special Order Sales Line No.";
        //>>MIGRATION NAV 2013
        //>>ACHATS BRRI 01.08.2006 COR001 [15] Correction perte du lien vers commande vente
        DestinationPurchaseLine."Special Order"  :=  SourcePurchaseLine."Special Order Sales Line No." <>0 ;
        //<<ACHATS BRRI 01.08.2006 COR001 [15] Correction perte du lien vers commande vente
        //<<MIGRATION NAV 2013


        DestinationPurchaseLine.VALIDATE("Unit of Measure Code",SourcePurchaseLine."Unit of Measure Code");
        IF SourcePurchaseLine.Quantity <> 0 THEN
          DestinationPurchaseLine.VALIDATE(Quantity,SourcePurchaseLine.Quantity);

        SalesLine.VALIDATE("Unit Cost (LCY)",DestinationPurchaseLine."Unit Cost (LCY)");
        SalesLine."Special Order Purchase No." := DestinationPurchaseLine."Document No.";
        SalesLine."Special Order Purch. Line No." := DestinationPurchaseLine."Line No.";
        SalesLine.MODIFY;
    end;

    local procedure CheckReceiptInfo(var PurchLine: Record "39";PayTo: Boolean)
    begin
        IF "Document Type" = "Document Type"::Order THEN
          PurchLine.SETFILTER("Quantity Received",'<>0')
        ELSE
          IF "Document Type" = "Document Type"::Invoice THEN BEGIN
            IF NOT PayTo THEN
              PurchLine.SETRANGE("Buy-from Vendor No.",xRec."Buy-from Vendor No.");
            PurchLine.SETFILTER("Receipt No.",'<>%1','');
          END;

        IF PurchLine.FINDFIRST THEN
          IF "Document Type" = "Document Type"::Order THEN
            PurchLine.TESTFIELD("Quantity Received",0)
          ELSE
            PurchLine.TESTFIELD("Receipt No.",'');
        PurchLine.SETRANGE("Receipt No.");
        PurchLine.SETRANGE("Quantity Received");
        IF NOT PayTo THEN
          PurchLine.SETRANGE("Buy-from Vendor No.");
    end;

    local procedure CheckPrepmtInfo(var PurchLine: Record "39")
    begin
        IF "Document Type" = "Document Type"::Order THEN BEGIN
          PurchLine.SETFILTER("Prepmt. Amt. Inv.",'<>0');
          IF PurchLine.FIND('-') THEN
            PurchLine.TESTFIELD("Prepmt. Amt. Inv.",0);
          PurchLine.SETRANGE("Prepmt. Amt. Inv.");
        END;
    end;

    local procedure CheckReturnInfo(var PurchLine: Record "39";PayTo: Boolean)
    begin
        IF "Document Type" = "Document Type"::"Return Order" THEN
          PurchLine.SETFILTER("Return Qty. Shipped",'<>0')
        ELSE
          IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
            IF NOT PayTo THEN
              PurchLine.SETRANGE("Buy-from Vendor No.",xRec."Buy-from Vendor No.");
            PurchLine.SETFILTER("Return Shipment No.",'<>%1','');
          END;

        IF PurchLine.FINDFIRST THEN
          IF "Document Type" = "Document Type"::"Return Order" THEN
            PurchLine.TESTFIELD("Return Qty. Shipped",0)
          ELSE
            PurchLine.TESTFIELD("Return Shipment No.",'');
    end;

    local procedure VerifyReceivedShippedItemLineDimChange(var ReceivedShippedItemLineDimChangeConfirmed: Boolean)
    begin
        IF PurchLine.IsReceivedShippedItemDimChanged THEN
          IF NOT ReceivedShippedItemLineDimChangeConfirmed THEN
            ReceivedShippedItemLineDimChangeConfirmed := PurchLine.ConfirmReceivedShippedItemDimChange;
    end;

    local procedure CheckDropShipmentLineExists()
    var
        SalesShipmentLine: Record "111";
    begin
        SalesShipmentLine.SETRANGE("Purchase Order No.","No.");
        SalesShipmentLine.SETRANGE("Drop Shipment",TRUE);
        IF NOT SalesShipmentLine.ISEMPTY THEN
          ERROR(YouCannotChangeFieldErr,FIELDCAPTION("Buy-from Vendor No."));
    end;

    procedure InvoicedLineExists(): Boolean
    var
        PurchLine: Record "39";
    begin
        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        PurchLine.SETFILTER(Type,'<>%1',PurchLine.Type::" ");
        PurchLine.SETFILTER("Quantity Invoiced",'<>%1',0);
        EXIT(NOT PurchLine.ISEMPTY);
    end;

    procedure HasShipToAddress(): Boolean
    begin
        CASE TRUE OF
          "Ship-to Address" <> '':
            EXIT(TRUE);
          "Ship-to Address 2" <> '':
            EXIT(TRUE);
          "Ship-to City" <> '':
            EXIT(TRUE);
          "Ship-to Country/Region Code" <> '':
            EXIT(TRUE);
          "Ship-to County" <> '':
            EXIT(TRUE);
          "Ship-to Post Code" <> '':
            EXIT(TRUE);
          "Ship-to Contact" <> '':
            EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;

    procedure HasPayToAddress(): Boolean
    begin
        CASE TRUE OF
          "Pay-to Address" <> '':
            EXIT(TRUE);
          "Pay-to Address 2" <> '':
            EXIT(TRUE);
          "Pay-to City" <> '':
            EXIT(TRUE);
          "Pay-to Country/Region Code" <> '':
            EXIT(TRUE);
          "Pay-to County" <> '':
            EXIT(TRUE);
          "Pay-to Post Code" <> '':
            EXIT(TRUE);
          "Pay-to Contact" <> '':
            EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;

    local procedure CopyBuyFromVendorAddressFieldsFromVendor(var BuyFromVendor: Record "23")
    begin
        IF BuyFromVendorIsReplaced OR ShouldCopyAddressFromBuyFromVendor(BuyFromVendor) THEN BEGIN
          "Buy-from Address" := BuyFromVendor.Address;
          "Buy-from Address 2" := BuyFromVendor."Address 2";
          "Buy-from City" := BuyFromVendor.City;
          "Buy-from Post Code" := BuyFromVendor."Post Code";
          "Buy-from County" := BuyFromVendor.County;
          "Buy-from Country/Region Code" := BuyFromVendor."Country/Region Code";
        END;
    end;

    local procedure CopyShipToVendorAddressFieldsFromVendor(var BuyFromVendor: Record "23")
    begin
        IF BuyFromVendorIsReplaced OR ShouldCopyAddressFromBuyFromVendor(BuyFromVendor) THEN BEGIN
          "Ship-to Address" := BuyFromVendor.Address;
          "Ship-to Address 2" := BuyFromVendor."Address 2";
          "Ship-to City" := BuyFromVendor.City;
          "Ship-to Post Code" := BuyFromVendor."Post Code";
          "Ship-to County" := BuyFromVendor.County;
          VALIDATE("Ship-to Country/Region Code",BuyFromVendor."Country/Region Code");
        END;
    end;

    local procedure CopyPayToVendorAddressFieldsFromVendor(var PayToVendor: Record "23")
    begin
        IF PayToVendorIsReplaced OR ShouldCopyAddressFromPayToVendor(PayToVendor) THEN BEGIN
          "Pay-to Address" := PayToVendor.Address;
          "Pay-to Address 2" := PayToVendor."Address 2";
          "Pay-to City" := PayToVendor.City;
          "Pay-to Post Code" := PayToVendor."Post Code";
          "Pay-to County" := PayToVendor.County;
          "Pay-to Country/Region Code" := PayToVendor."Country/Region Code";
        END;
    end;

    local procedure SetShipToAddress(ShipToName: Text[50];ShipToName2: Text[50];ShipToAddress: Text[50];ShipToAddress2: Text[50];ShipToCity: Text[30];ShipToPostCode: Code[20];ShipToCounty: Text[30];ShipToCountryRegionCode: Code[10])
    begin
        "Ship-to Name" := ShipToName;
        "Ship-to Name 2" := ShipToName2;
        "Ship-to Address" := ShipToAddress;
        "Ship-to Address 2" := ShipToAddress2;
        "Ship-to City" := ShipToCity;
        "Ship-to Post Code" := ShipToPostCode;
        "Ship-to County" := ShipToCounty;
        "Ship-to Country/Region Code" := ShipToCountryRegionCode;
    end;

    local procedure ShouldCopyAddressFromBuyFromVendor(BuyFromVendor: Record "23"): Boolean
    begin
        EXIT((NOT HasBuyFromAddress) AND BuyFromVendor.HasAddress);
    end;

    local procedure ShouldCopyAddressFromPayToVendor(PayToVendor: Record "23"): Boolean
    begin
        EXIT((NOT HasPayToAddress) AND PayToVendor.HasAddress);
    end;

    local procedure BuyFromVendorIsReplaced(): Boolean
    begin
        EXIT((xRec."Buy-from Vendor No." <> '') AND (xRec."Buy-from Vendor No." <> "Buy-from Vendor No."));
    end;

    local procedure PayToVendorIsReplaced(): Boolean
    begin
        EXIT((xRec."Pay-to Vendor No." <> '') AND (xRec."Pay-to Vendor No." <> "Pay-to Vendor No."));
    end;

    local procedure UpdatePayToAddressFromBuyFromAddress(FieldNumber: Integer)
    begin
        IF ("Order Address Code" = '') AND PayToAddressEqualsOldBuyFromAddress THEN
          CASE FieldNumber OF
            FIELDNO("Pay-to Address"):
              IF xRec."Buy-from Address" = "Pay-to Address" THEN
                "Pay-to Address" := "Buy-from Address";
            FIELDNO("Pay-to Address 2"):
              IF xRec."Buy-from Address 2" = "Pay-to Address 2" THEN
                "Pay-to Address 2" := "Buy-from Address 2";
            FIELDNO("Pay-to City"), FIELDNO("Pay-to Post Code"):
              BEGIN
                IF xRec."Buy-from City" = "Pay-to City" THEN
                  "Pay-to City" := "Buy-from City";
                IF xRec."Buy-from Post Code" = "Pay-to Post Code" THEN
                  "Pay-to Post Code" := "Buy-from Post Code";
                IF xRec."Buy-from County" = "Pay-to County" THEN
                  "Pay-to County" := "Buy-from County";
                IF xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code" THEN
                  "Pay-to Country/Region Code" := "Buy-from Country/Region Code";
              END;
            FIELDNO("Pay-to County"):
              IF xRec."Buy-from County" = "Pay-to County" THEN
                "Pay-to County" := "Buy-from County";
            FIELDNO("Pay-to Country/Region Code"):
              IF  xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code" THEN
                "Pay-to Country/Region Code" := "Buy-from Country/Region Code";
          END;
    end;

    local procedure PayToAddressEqualsOldBuyFromAddress(): Boolean
    begin
        IF (xRec."Buy-from Address" = "Pay-to Address") AND
           (xRec."Buy-from Address 2" = "Pay-to Address 2") AND
           (xRec."Buy-from City" = "Pay-to City") AND
           (xRec."Buy-from County" = "Pay-to County") AND
           (xRec."Buy-from Post Code" = "Pay-to Post Code") AND
           (xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code")
        THEN
          EXIT(TRUE);
    end;

    procedure ConfirmCloseUnposted(): Boolean
    var
        InstructionMgt: Codeunit "1330";
    begin
        //BC6>>
        EXIT(TRUE);
        //BC6<<
        IF PurchLinesExist THEN
          EXIT(InstructionMgt.ShowConfirm(DocumentNotPostedClosePageQst,InstructionMgt.QueryPostOnCloseCode));
        EXIT(TRUE)
    end;

    procedure InitFromPurchHeader(SourcePurchHeader: Record "38")
    begin
        "Document Date" := SourcePurchHeader."Document Date";
        "Expected Receipt Date" := SourcePurchHeader."Expected Receipt Date";
        "Shortcut Dimension 1 Code" := SourcePurchHeader."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := SourcePurchHeader."Shortcut Dimension 2 Code";
        "Dimension Set ID" := SourcePurchHeader."Dimension Set ID";
        "Location Code" := SourcePurchHeader."Location Code";
        SetShipToAddress(
          SourcePurchHeader."Ship-to Name",SourcePurchHeader."Ship-to Name 2",SourcePurchHeader."Ship-to Address",
          SourcePurchHeader."Ship-to Address 2",SourcePurchHeader."Ship-to City",SourcePurchHeader."Ship-to Post Code",
          SourcePurchHeader."Ship-to County",SourcePurchHeader."Ship-to Country/Region Code");
        "Ship-to Contact" := SourcePurchHeader."Ship-to Contact";
    end;

    local procedure InitFromVendor(VendorNo: Code[20];VendorCaption: Text): Boolean
    begin
        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        IF VendorNo = '' THEN BEGIN
          IF NOT PurchLine.ISEMPTY THEN
            ERROR(Text005,VendorCaption);
          INIT;
          PurchSetup.GET;
          "No. Series" := xRec."No. Series";
          InitRecord;
          InitNoSeries;
          EXIT(TRUE);
        END;
    end;

    local procedure InitFromContact(ContactNo: Code[20];VendorNo: Code[20];ContactCaption: Text): Boolean
    begin
        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        IF (ContactNo = '') AND (VendorNo = '') THEN BEGIN
          IF NOT PurchLine.ISEMPTY THEN
            ERROR(Text005,ContactCaption);
          INIT;
          PurchSetup.GET;
          "No. Series" := xRec."No. Series";
          InitRecord;
          InitNoSeries;
          EXIT(TRUE);
        END;
    end;

    local procedure LookupContact(VendorNo: Code[20];ContactNo: Code[20];var Contact: Record "5050")
    var
        ContactBusinessRelation: Record "5054";
    begin
        ContactBusinessRelation.SETCURRENTKEY("Link to Table","No.");
        ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Vendor);
        ContactBusinessRelation.SETRANGE("No.",VendorNo);
        IF ContactBusinessRelation.FINDFIRST THEN
          Contact.SETRANGE("Company No.",ContactBusinessRelation."Contact No.")
        ELSE
          Contact.SETRANGE("Company No.",'');
        IF ContactNo <> '' THEN
          IF Contact.GET(ContactNo) THEN ;
    end;

    procedure SendRecords()
    var
        DocumentSendingProfile: Record "60";
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.SendVendorRecords(
          DummyReportSelections.Usage::"P.Order",Rec,DocTxt,"Buy-from Vendor No.","No.",
          FIELDNO("Buy-from Vendor No."),FIELDNO("No."));
    end;

    procedure PrintRecords(ShowRequestForm: Boolean)
    var
        DocumentSendingProfile: Record "60";
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.TrySendToPrinterVendor(
          DummyReportSelections.Usage::"P.Order",Rec,"Buy-from Vendor No.",ShowRequestForm);
    end;

    procedure SendProfile(var DocumentSendingProfile: Record "60")
    var
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.SendVendor(
          DummyReportSelections.Usage::"P.Order",Rec,"No.","Buy-from Vendor No.",
          DocTxt,FIELDNO("Buy-from Vendor No."),FIELDNO("No."));
    end;

    procedure BatchConfirmUpdateDeferralDate(var BatchConfirm: Option " ",Skip,Update;ReplacePostingDate: Boolean;PostingDateReq: Date)
    begin
        IF (NOT ReplacePostingDate) OR (PostingDateReq = "Posting Date") OR (BatchConfirm = BatchConfirm::Skip) THEN
          EXIT;

        IF NOT DeferralHeadersExist THEN
          EXIT;

        "Posting Date" := PostingDateReq;
        CASE BatchConfirm OF
          BatchConfirm::" ":
            BEGIN
              ConfirmUpdateDeferralDate;
              IF Confirmed THEN
                BatchConfirm := BatchConfirm::Update
              ELSE
                BatchConfirm := BatchConfirm::Skip;
            END;
          BatchConfirm::Update:
            UpdatePurchLines(PurchLine.FIELDCAPTION("Deferral Code"),FALSE);
        END;
        COMMIT;
    end;

    procedure "---NSC1.00---"()
    begin
    end;

    procedure UpdateIncoterm()
    begin
        IF RecGVendor.GET("Buy-from Vendor No.")THEN BEGIN
           "Transaction Type" := RecGVendor."Transaction Type";
           "Transaction Specification" := RecGVendor."Transaction Specification";
           "Transport Method" := RecGVendor."Transport Method";
           "Entry Point" := RecGVendor."Entry Point";
           Area := RecGVendor.Area;
        END;
    end;

    procedure "**NSC1.01**"()
    begin
    end;

    procedure ControleMinimMNTandQTE(): Boolean
    var
        MntTot: Decimal;
        QteTot: Decimal;
        Frs: Record "23";
        Msg: Text[150];
        TextControleMinima01: Label 'Total Purchase Amount %1, lower than minimum Purchase Amount %2. Do You want add freight charge?';
        RecLPurchaseLine: Record "39";
        NumLigne: Integer;
        TxtL001: ;
    begin
        //CONTROLEMINIMA SM 11/10/06 NCS1.01 [FE02] Contrôle Minima MNT et QTE
        PurchSetup.GET;
        IF NOT PurchSetup."Minima de cde" THEN
          EXIT(FALSE)
        ELSE BEGIN
          PurchSetup.TESTFIELD(PurchSetup.Type) ;
          PurchSetup.TESTFIELD(PurchSetup."No.") ;
        END ;

        Frs.RESET;
        Frs.GET("Buy-from Vendor No.");

        CalcMntHTandMntTTCandQTE(MntTot,QteTot);

        Msg :='\';

        IF MntTot < Frs."Mini Amount" THEN BEGIN
          IF NOT Existfreightcharge THEN BEGIN
          //>>FE002.2 CASC
            IF NOT ExistFreightChargeSSAmount THEN
            BEGIN
          //<<FE002.2 CASC
              Msg :=Msg + TextControleMinima01;
              //IF NOT CONFIRM(Msg,TRUE,MntTot,Frs."Mini Amount",QteTot) THEN
                //EXIT(TRUE)
              //ELSE BEGIN
              //>> PROD 26.05.2011
              IF HideValidationDialog THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Msg,TRUE,MntTot,Frs."Mini Amount",QteTot);
              IF Confirmed  THEN
              BEGIN
                RecLPurchaseLine.RESET ;
                RecLPurchaseLine.SETRANGE(RecLPurchaseLine."Document Type","Document Type") ;
                RecLPurchaseLine.SETRANGE(RecLPurchaseLine."Document No.","No.") ;
                IF RecLPurchaseLine.FIND('+') THEN
                  NumLigne := RecLPurchaseLine."Line No." + 10000
                ELSE
                  NumLigne := 10000 ;

                RecLPurchaseLine.INIT ;
                RecLPurchaseLine.VALIDATE("Document Type","Document Type") ;
                RecLPurchaseLine.VALIDATE("Document No.","No.") ;
                RecLPurchaseLine.VALIDATE("Line No.",NumLigne) ;
                RecLPurchaseLine.INSERT(TRUE) ;

                RecLPurchaseLine.VALIDATE(Type,PurchSetup.Type) ;
                RecLPurchaseLine.VALIDATE("No.",PurchSetup."No.") ;
                RecLPurchaseLine.VALIDATE(Quantity,1) ;
                //>>FE002.3
                RecLPurchaseLine.VALIDATE("Location Code", "Location Code");
                RecLPurchaseLine.VALIDATE("Direct Unit Cost", Frs."Freight Amount");
                //<<FE002.3
                RecLPurchaseLine.MODIFY(TRUE) ;
                //>>FE002.3

                IF RecLPurchaseLine."Direct Unit Cost" = 0 THEN
                //<<FE002.3
                //>> PROD 26.05.2011
                IF NOT HideValidationDialog THEN
                  MESSAGE('Merci d''indiquer un coût unitaire direct pour la ligne %1, N° %2.',PurchSetup.Type,PurchSetup."No.") ;
                //EXIT(TRUE) ;
              END;

            END
            //>>FE002.2 CASC
            ELSE
            BEGIN
              //>> PROD 26.05.2011
              IF NOT HideValidationDialog THEN
                MESSAGE(TextG002,PurchSetup.Type,PurchSetup."No.");
              EXIT(TRUE);
            END;
            //<<FE002.2 CASC
          END;
        END;

        EXIT(FALSE);
        //CONTROLEMINIMA SM 11/10/06 NCS1.01 [FE02] Contrôle Minima MNT et QTE
    end;

    procedure CalcMntHTandMntTTCandQTE(var MntTot: Decimal;var QteTot: Decimal)
    var
        PurchLine: Record "39";
        TempPurchLine: Record "39" temporary;
        TotalPurchLine: Record "39";
        TotalPurchLineLCY: Record "39";
        Vend: Record "23";
        TempVATAmountLine: Record "290" temporary;
        PurchSetup: Record "312";
        PurchPost: Codeunit "90";
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        VATAmount: Decimal;
        VATAmountText: Text[30];
        PrevNo: Code[20];
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
    begin
        //CALCMNTTOTAL SM 11/07/06 NCS1.01 [COMPLEMENT_ACHAT0206]  MAJ Montant Total HT Et Montant Total TTC de l'entête achat
        CLEAR(PurchLine);
        CLEAR(TotalPurchLine);
        CLEAR(TotalPurchLineLCY);
        CLEAR(PurchPost);

        PurchPost.GetPurchLines(Rec,TempPurchLine,0);
        CLEAR(PurchPost);

        //>>DEEE1.00
        //PurchPost.SumPurchLinesTemp(
        //  Rec,TempPurchLine,0,TotalPurchLine,TotalPurchLineLCY,VATAmount,VATAmountText);
        PurchPost.SumPurchLinesTemp(
          Rec,TempPurchLine,0,TotalPurchLine,TotalPurchLineLCY,VATAmount,VATAmountText,
          TotalPurchLine."DEEE HT Amount",TotalPurchLine."DEEE VAT Amount",TotalPurchLine."DEEE TTC Amount",
          TotalPurchLine."DEEE HT Amount (LCY)");
        //>>FIN DEEE1.00


        IF "Prices Including VAT" THEN BEGIN
          TotalAmount2 := TotalPurchLine.Amount;
          TotalAmount1 := TotalAmount2 + VATAmount;
          TotalPurchLine."Line Amount" := TotalAmount1 + TotalPurchLine."Inv. Discount Amount";
        END ELSE BEGIN
          TotalAmount1 := TotalPurchLine.Amount;
          TotalAmount2 := TotalPurchLine."Amount Including VAT";
        END;

        MntTot := TotalAmount1 ;
        QteTot := TotalPurchLine.Quantity;
        //FIN CALCMNTTOTAL SM 11/07/06 NCS1.01 [COMPLEMENT_ACHAT0206]  MAJ Montant Total HT Et Montant Total TTC de l'entête achat
    end;

    procedure Existfreightcharge(): Boolean
    var
        RecLSalesLine: Record "39";
    begin
        IF PurchLinesExist THEN BEGIN
          REPEAT
            IF (PurchLine.Type = PurchSetup.Type)
              AND (PurchLine."No." = PurchSetup."No." )
              AND (PurchLine."Line Amount" <> 0) THEN
                EXIT(TRUE);
          UNTIL PurchLine.NEXT = 0;
        END ELSE
          EXIT(FALSE);
    end;

    procedure UpdateBuyFromFax(CodContactNo: Code[20])
    var
        RecLContact: Record "5050";
    begin
        //>>FE005
        IF RecLContact.GET(CodContactNo) THEN
          "Buy-from Fax No." := RecLContact."Fax No."
        ELSE
          "Buy-from Fax No." := '';
        //<<FE005
    end;

    procedure UpdateBuyFromMail(CodContactNo: Code[20])
    var
        RecLContact: Record "5050";
    begin
        //>>FE005
        IF RecLContact.GET(CodContactNo) THEN
          "Buy-from E-Mail Address" := RecLContact."E-Mail"
        ELSE
          "Buy-from E-Mail Address" := '';
        //<<FE005
    end;

    procedure ExistFreightChargeSSAmount(): Boolean
    begin
        //>>FE002.2 CASC
        IF PurchLinesExist THEN BEGIN
          REPEAT
            IF (PurchLine.Type = PurchSetup.Type) AND (PurchLine."No." = PurchSetup."No." ) THEN
              //AND (PurchLine."Line Amount" <> 0)
                EXIT(TRUE);
          UNTIL PurchLine.NEXT = 0;
        END ELSE
          EXIT(FALSE);
        //<<FE002.2 CASC
    end;

    procedure AddLogComment(_Qty: Decimal;_ReceiptType: Option Colis,Palette)
    var
        L_PurchCommentLine: Record "43";
        L_PurchCommentLine2: Record "43";
    begin
        IF _Qty = 0 THEN
          ERROR(Text50000);
        L_PurchCommentLine.INIT;
        L_PurchCommentLine."Document Type" := "Document Type";
        L_PurchCommentLine."No." := "No.";
        L_PurchCommentLine.Comment := FORMAT(_Qty) + ' ' + FORMAT(_ReceiptType);
        L_PurchCommentLine."Is Log" := TRUE;

        L_PurchCommentLine2.SETRANGE("Document Type",L_PurchCommentLine."Document Type");
        L_PurchCommentLine2.SETRANGE("No.",L_PurchCommentLine."No.");
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
        L_PurchaseLine: Record "39";
    begin
        IF "Document Type" <> "Document Type"::"Return Order" THEN
          EXIT;

        IF xRec."Return Order Type" <> Rec."Return Order Type" THEN
          L_PurchaseLine.RESET;
          L_PurchaseLine.SETRANGE("Document Type","Document Type");
          L_PurchaseLine.SETRANGE("Document No.","No.");
          IF L_PurchaseLine.FINDFIRST THEN
              L_PurchaseLine.MODIFYALL("Return Order Type","Return Order Type");
    end;

    //Unsupported feature: Deletion (VariableCollection) on "RecreatePurchLines(PROCEDURE 4).PurchLineTmp(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "RecreatePurchLines(PROCEDURE 4).SalesLine(Variable 1007)".


    //Unsupported feature: Deletion (VariableCollection) on "RecreatePurchLines(PROCEDURE 4).CopyDocMgt(Variable 1008)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdatePurchLines(PROCEDURE 15).UpdateConfirmed(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "HandleItemTrackingDeletion(PROCEDURE 36).ReservEntry(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "HandleItemTrackingDeletion(PROCEDURE 36).ReservEntry2(Variable 1001)".


    //Unsupported feature: Property Insertion (Temporary) on "ClearItemAssgntPurchFilter(PROCEDURE 22).TempItemChargeAssgntPurch(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "IsApprovedForPosting(PROCEDURE 50).SalesHeader(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "IsApprovedForPostingBatch(PROCEDURE 51).SalesHeader(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "CheckDropShptAddressDetails(PROCEDURE 79).SalesHeader(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "ZeroAmountInLines(PROCEDURE 35).PurchLine(Variable 1001)".


    var
        ShipToAddr: Record "222";

    var
        SkipJobCurrFactorUpdate: Boolean;

    var
        GenJnlLine: Record "81";
        GenJnlApply: Codeunit "225";
        ApplyVendEntries: Page "233";

    var
        VendEntrySetApplID: Codeunit "111";

    var
        PostPurchDelete: Codeunit "364";
        ArchiveManagement: Codeunit "5063";


    //Unsupported feature: Property Modification (TextConstString) on "Text009(Variable 1009)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU="Deleting this document will cause a gap in the number series for receipts. ";FRA="La suppression de ce document va provoquer une discontinuité dans la souche réception. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for receipts. An empty receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des réceptions. Une réception vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text012(Variable 1012)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU="Deleting this document will cause a gap in the number series for posted invoices. ";FRA="La suppression de ce document va provoquer une discontinuité dans la souche fact. enregistrées. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des factures enregistrées. Une facture enregistrée vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text014(Variable 1014)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU="Deleting this document will cause a gap in the number series for posted credit memos. ";FRA="La suppression de ce document va provoquer une discontinuité dans la souche avoirs enregistrés. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche d'avoirs enregistrés. Un avoir enregistré vide %1 va être créé pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text029(Variable 1028)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text029 : ENU="Deleting this document will cause a gap in the number series for return shipments. ";FRA="La suppression de ce document va provoquer une discontinuité dans la souche expédition retour. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text029 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for return shipments. An empty return shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des expéditions retour. Une expédition retour vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text045(Variable 1086)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text045 : ENU="Deleting this document will cause a gap in the number series for prepayment invoices. ";FRA="La suppression de ce document va provoquer une discontinuité dans la souche factures acompte. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text045 : ENU=Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des factures d'acompte. Une facture d'acompte vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text046(Variable 1087)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text046 : ENU=An empty prepayment invoice %1 will be created to fill this gap in the number series.\\;FRA=Une facture acompte vide %1 va être créée pour éviter cette discontinuité dans les numéros.\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text046 : ENU=Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des avoirs acompte. Un avoir acompte vide %1 va être créé pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text050(Variable 1067)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text050 : ENU=Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\;FRA=Il existe des réservations pour cette commande. Ces réservations seront annulées si cette modification entraîne un conflit de dates.\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text050 : ENU=Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\Do you want to continue?;FRA=Il existe des réservations pour cette commande. Ces réservations seront annulées si cette modification entraîne un conflit de dates.\\Voulez-vous continuer ?;
    //Variable type has not been exported.

    var
        ConfirmChangeQst: Label 'Do you want to change %1?', Comment = '%1 = a Field Caption like Currency Code';

    var
        YouCannotChangeFieldErr: Label 'You cannot change %1 because the order is associated with one or more sales orders.', Comment = '%1 - fieldcaption';

    var
        ApprovalsMgmt: Codeunit "1535";

    var
        LeadTimeMgt: Codeunit "5404";

    var
        DeferralLineQst: Label 'You have changed the %1 on the purchase header, do you want to update the deferral schedules for the lines with this date?', Comment = '%1=The posting date on the document.';

    var
        PostedDocsToPrintCreatedMsg: Label 'One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.';
        BuyFromVendorTxt: Label 'Buy-from Vendor';
        PayToVendorTxt: Label 'Pay-to Vendor';
        DocumentNotPostedClosePageQst: Label 'The document has not been posted.\Are you sure you want to exit?';
        DocTxt: Label 'Purchase Order';
        SelectNoSeriesAllowed: Boolean;
        "-NSC1.00-": Integer;
        RecGVendor: Record "23";
        RecGParamNavi: Record "50004";
        RecGCommentLine: Record "97";
        FrmGLignesCommentaires: Page "124";
        "---NSC1.01": ;
        TextG001: Label 'Warning, using foreign currency will generate wrong profit calculation.';
        TextG002: Label 'Thank to inform freight charge amount for line %1, No. %2';
        TextG003: Label 'Warning:This purchase order is linked to a sales order.';
        Text50000: Label 'Quantity cannot be 0.';
        "-BCSYS-": Integer;
        G_ReturnOrderMgt: Codeunit "50052";
}

