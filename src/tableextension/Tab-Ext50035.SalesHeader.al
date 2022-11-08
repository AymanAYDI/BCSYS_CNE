tableextension 50035 "BC6_SalesHeader" extends "Sales Header"
{
    LookupPageID = "Sales List";
    fields
    {
        modify("Bill-to Name")
        {
            trigger OnAfterValidate()
            var
                Customer: Record Customer;
            begin
                IF xRec."Bill-to Customer No." = '' then
                    if ShouldSearchForCustomerByName("Bill-to Customer No.") then
                        Validate("Bill-to Customer No.", Customer.GetCustNo("Bill-to Name"));

            end;
        }
        //TODO
        // modify("Your Reference")
        // {
        // trigger OnAfterValidate()
        // begin
        //     UpdateSalesShipment.UpdateYourRefOnSalesShpt(Rec);
        // end;
        // }
        modify("Shipment Method Code")
        {
            trigger OnAfterValidate()
            var
                WMSManagement: Codeunit "WMS Management";
                BinCode: Code[20];
                Bin: Record Bin;
                ShipmentMethodRec: Record "Shipment Method";

            begin
                IF ShipmentMethodRec.GET("Shipment Method Code") THEN
                    //TODO // IF ShipmentMethodRec."To Make Available" THEN BEGIN
                    IF (Bin.GET("Location Code", "BC6_Bin Code") AND
                           NOT (Bin."BC6_To Make Available")) OR ("BC6_Bin Code" = '') THEN BEGIN
                        //TODO  // WMSManagement.GetShipmentBin("Location Code", BinCode);
                        IF "BC6_Bin Code" <> BinCode THEN
                            VALIDATE("BC6_Bin Code", BinCode);
                    END ELSE BEGIN
                    END;
            end;
        }
        modify("Currency Code")
        {
            trigger OnAfterValidate()
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
                RecLSalesLine: Record "Sales Line";
            begin
                IF xRec."Reason Code" <> Rec."Reason Code" THEN BEGIN
                    RecLSalesLine.SETRANGE("Document Type", "Document Type");
                    RecLSalesLine.SETRANGE("Document No.", "No.");
                    IF RecLSalesLine.FIND('-') THEN
                        REPEAT
                            //TODO
                            // RecLSalesLine."DEEE Category Code" := RecLSalesLine."DEEE Category Code";
                            // RecLSalesLine.CalculateDEEE(Rec."Reason Code");
                            RecLSalesLine.MODIFY;
                        UNTIL RecLSalesLine.NEXT = 0;
                END;
            end;
        }
        modify("Sell-to Customer Name")
        {
            trigger OnAfterValidate()
            var
                Customer: Record Customer;
            begin
                IF xRec."Sell-to Customer Name" = '' THEN
                    if ShouldSearchForCustomerByName("Sell-to Customer No.") then
                        VALIDATE("Sell-to Customer No.", Customer.GetCustNo("Sell-to Customer Name"));
                GetShippingTime(FIELDNO("Sell-to Customer Name"));

                CopySellToAddress(CurrFieldNo);
            end;
        }
        modify("Sell-to Customer Name 2")
        {
            trigger OnAfterValidate()
            begin
                CopySellToAddress(CurrFieldNo);

            end;
        }
        modify("Sell-to Address")
        {
            trigger OnAfterValidate()
            begin
                CopySellToAddress(CurrFieldNo);
            end;
        }
        modify("Sell-to Address 2")
        {
            trigger OnAfterValidate()
            begin
                CopySellToAddress(CurrFieldNo);

            end;
        }
        modify("Sell-to Contact")
        {
            trigger OnAfterValidate()
            begin
                CopySellToAddress(CurrFieldNo);
            end;
        }
        modify("Sell-to Post Code")
        {
            trigger OnAfterValidate()
            begin
                CopySellToAddress(CurrFieldNo);
            end;
        }
        modify("Sell-to County")
        {
            trigger OnAfterValidate()
            begin
                CopySellToAddress(CurrFieldNo);
            end;
        }
        modify("Sell-to Country/Region Code")
        {
            trigger OnAfterValidate()
            begin
                CopySellToAddress(CurrFieldNo);
            end;
        }

        modify("Shipping Agent Code")
        {
            trigger OnBeforeValidate()
            begin
                IF (Status <> Status::Open) AND (xRec."Shipping Agent Code" <> "Shipping Agent Code")
          AND ("Document Type" = "Document Type"::Order)
                THEN BEGIN
                    CDUReleaseDoc.Reopen(Rec);
                    BoolReclose := TRUE;
                END;

            end;

            trigger OnAfterValidate()
            begin
                IF BoolReclose THEN BEGIN
                    CDUReleaseDoc.RUN(Rec);
                    BoolReclose := FALSE;
                END;

            end;
        }
        modify("Shipping Agent Service Code")
        {
            trigger OnBeforeValidate()
            begin
                IF (Status <> Status::Open) AND (xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code")
                AND ("Document Type" = "Document Type"::Order)
                THEN BEGIN
                    CDUReleaseDoc.Reopen(Rec);
                    BoolReclose := TRUE;
                END;
            end;

            trigger OnAfterValidate()
            begin
                IF BoolReclose THEN BEGIN
                    CDUReleaseDoc.RUN(Rec);
                    BoolReclose := FALSE;
                END;

            end;
        }

        field(50000; "BC6_Cause filing"; Enum "BC6_Cause Filing")
        {
            Caption = 'Cause filing';
        }
        field(50001; "BC6_Purchaser Comments"; Text[50])
        {
            Caption = 'Purchaser Comments';
        }
        field(50002; "BC6_Warehouse Comments"; Text[50])
        {
            Caption = 'Warehouse Comments';
        }
        field(50003; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.';
            TableRelation = Customer;
        }
        field(50004; "BC6_Advance Payment"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            Caption = 'Advance Payment';
        }
        field(50005; "BC6_Affair No."; Code[20])
        {
            Caption = 'Affair No.';
            TableRelation = Job."No.";
            //TODO
            // trigger OnValidate()
            // begin
            //     UpdateSalesShipment.UpdateAffairNoOnSalesShpt(Rec);
            // end;
        }
        field(50010; BC6_ID; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            //TODO :COD418
            // trigger OnLookup()
            // var
            //     RecLUserMgt: Codeunit 418;
            //     CodLUserID: Code[50];
            // begin
            //     //>>MIGRATION NAV 2013
            //     CodLUserID := ID;
            //     RecLUserMgt.LookupUserID(CodLUserID);
            //     //<<MIGRATION NAV 2013
            // end;
        }
        field(50020; "BC6_Customer Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client';
            Enabled = false;
            TableRelation = "Customer Sales Profit Group";
        }
        field(50025; "BC6_Combine Shipments by Order"; Boolean)
        {
            Caption = 'Combine Shipment By Order';
        }
        field(50026; "BC6_Purchase cost"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."BC6_Purchase cost" WHERE("Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("No.")));
            Caption = 'Purchase Cost';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; "BC6_Copy Sell-to Address"; Boolean)
        {
            Caption = 'Copy Sell-to Address';
        }
        field(50030; "BC6_Sales LCY"; Decimal)
        {
            Caption = 'Ventes DS';
        }
        field(50031; "BC6_Profit LCY"; Decimal)
        {
            Caption = 'Marge DS';
            Editable = true;
        }
        field(50032; "BC6_% Profit"; Decimal)
        {
            Caption = '% de marge sur vente';
        }
        field(50033; BC6_Invoiced; Boolean)
        {
            Caption = 'Invoiced';
        }
        field(50040; "BC6_Prod. Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(50050; "BC6_Document description"; Text[50])
        {
            Caption = 'Document description';
        }
        field(50060; "BC6_Quote statut"; Enum "BC6_Quote statut")
        {
            Caption = 'Quote status';
        }
        field(50061; "BC6_Sell-to Fax No."; Text[30])
        {
            Caption = 'Sell-to Fax No.';
        }
        field(50062; "BC6_Sell-to E-Mail Address"; Text[50])
        {
            Caption = 'Sell-to E-Mail address';
        }
        field(50070; "BC6_Sales Counter"; Boolean)
        {
            Caption = 'Sales Counter';
        }
        field(50080; "BC6_Purchase No. Order Lien"; Code[20])
        {
            Caption = 'Purchase No. Order Lien';
            //TODO
            // trigger OnLookup()
            // var
            //     reclPurchHdr: Record 38;
            // begin
            //     //>>CNEIC : Le 07/08/15
            //     reclPurchHdr.SETRANGE("Document Type", reclPurchHdr."Document Type"::Order);
            //     reclPurchHdr.SETFILTER("No.","Purchase No. Order Lien");

            //     PAGE.RUNMODAL(PAGE::"Purchase Order", reclPurchHdr) ;
            //     //<<CNEIC : Le 07/08/15
            // end;
        }
        field(50100; "BC6_Salesperson Filter"; Text[250])
        {
            Caption = 'Salesperson Filter';
            Editable = false;
        }
        field(50110; "BC6_Mailing List Code"; Code[10])
        {
            Caption = 'Mailing List Code';
            TableRelation = "BC6_Mailing List";
        }
        field(50120; "BC6_Return Order Type"; Option)
        {
            Caption = 'Return Order Type';
            Description = 'BCSYS';
            OptionCaption = 'Location,SAV';
            OptionMembers = Location,SAV;

            trigger OnValidate()
            begin
                UpdateSalesLineReturnType
            end;
        }
        field(50403; "BC6_Bin Code"; Code[20])
        {

            trigger OnLookup()
            var
                WMSManagement: Codeunit "WMS Management";
                BinCode: Code[20];
            begin
                IF NOT ("Document Type" = "Document Type"::Order) THEN
                    EXIT;

                //TODO 
                //  BinCode := WMSManagement.BinLookUp2("Location Code", "BC6_Bin Code");

                IF BinCode <> '' THEN
                    VALIDATE("BC6_Bin Code", BinCode);
            end;

            trigger OnValidate()
            var
                Location: Record Location;
                WMSManagement: Codeunit "WMS Management";
            begin
                //>> C:FE09 Begin
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
        //TODO // key(Key15; "Document Type", "BC6_Combine Shipments by Order", "Combine Shipments", "Bill-to Customer No.", "Currency Code")
        // {
        // }
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
        //TODO
        // key(Key26; "Document Type", "Sell-to Customer No.", "BC6_Salesperson Filter", "Order Date", "No.")
        // {
        // }
    }

    local procedure CheckShipmentInfo(var SalesLine: Record "Sales Line"; BillTo: Boolean)
    begin
        IF "Document Type" = "Document Type"::Order THEN
            SalesLine.SETFILTER("Quantity Shipped", '<>0')
        ELSE
            IF "Document Type" = "Document Type"::Invoice THEN BEGIN
                IF NOT BillTo THEN
                    SalesLine.SETRANGE("Sell-to Customer No.", xRec."Sell-to Customer No.");
                SalesLine.SETFILTER("Shipment No.", '<>%1', '');
            END;

        IF SalesLine.FINDFIRST THEN
            IF "Document Type" = "Document Type"::Order THEN
                SalesLine.TESTFIELD("Quantity Shipped", 0)
            ELSE
                SalesLine.TESTFIELD("Shipment No.", '');
        SalesLine.SETRANGE("Shipment No.");
        SalesLine.SETRANGE("Quantity Shipped");
    end;

    local procedure CheckPrepmtInfo(var SalesLine: Record "Sales Line")
    begin
        IF "Document Type" = "Document Type"::Order THEN BEGIN
            SalesLine.SETFILTER("Prepmt. Amt. Inv.", '<>0');
            IF SalesLine.FIND('-') THEN
                SalesLine.TESTFIELD("Prepmt. Amt. Inv.", 0);
            SalesLine.SETRANGE("Prepmt. Amt. Inv.");
        END;
    end;

    local procedure CheckReturnInfo(var SalesLine: Record "Sales Line"; BillTo: Boolean)
    begin
        IF "Document Type" = "Document Type"::"Return Order" THEN
            SalesLine.SETFILTER("Return Qty. Received", '<>0')
        ELSE
            IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                IF NOT BillTo THEN
                    SalesLine.SETRANGE("Sell-to Customer No.", xRec."Sell-to Customer No.");
                SalesLine.SETFILTER("Return Receipt No.", '<>%1', '');
            END;

        IF SalesLine.FINDFIRST THEN
            IF "Document Type" = "Document Type"::"Return Order" THEN
                SalesLine.TESTFIELD("Return Qty. Received", 0)
            ELSE
                SalesLine.TESTFIELD("Return Receipt No.", '');
    end;

    local procedure UpdateSellToCustTemplateCode()
    var
        CustomerTemplate: Record "Customer Template";
        Contact: Record Contact;
    begin
        IF ("Document Type" = "Document Type"::Quote) AND ("Sell-to Customer No." = '') AND ("Sell-to Customer Template Code" = '') AND
           (GetFilterContNo = '')
        THEN BEGIN
            Contact.GET("Sell-to Contact No.");
            IF Contact.Type = Contact.Type::Person THEN
                Contact.GET(Contact."Company No.");
            IF NOT Contact.ContactToCustBusinessRelationExist THEN
                IF CONFIRM(SelectCustomerTemplateQst, FALSE) THEN BEGIN
                    COMMIT;
                    IF PAGE.RUNMODAL(0, CustomerTemplate) = ACTION::LookupOK THEN
                        VALIDATE("Sell-to Customer Template Code", CustomerTemplate.Code);
                END;
        END;
    end;

    local procedure GetFilterContNo(): Code[20]
    begin
        IF GETFILTER("Sell-to Contact No.") <> '' THEN
            IF GETRANGEMIN("Sell-to Contact No.") = GETRANGEMAX("Sell-to Contact No.") THEN
                EXIT(GETRANGEMAX("Sell-to Contact No."));
    end;

    local procedure CheckCreditLimitIfLineNotInsertedYet()
    begin
        IF "No." = '' THEN BEGIN
            HideCreditCheckDialogue := FALSE;
            CheckCreditMaxBeforeInsert;
            HideCreditCheckDialogue := TRUE;
        END;
    end;

    local procedure CollectParamsInBufferForCreateDimSet(var TempSalesLine: Record "Sales Line" temporary; SalesLine: Record "Sales Line")
    var
        GenPostingSetup: Record "General Posting Setup";
        DefaultDimension: Record "Default Dimension";
    begin
        TempSalesLine.SETRANGE("Gen. Bus. Posting Group", SalesLine."Gen. Bus. Posting Group");
        TempSalesLine.SETRANGE("Gen. Prod. Posting Group", SalesLine."Gen. Prod. Posting Group");
        IF NOT TempSalesLine.FINDFIRST THEN BEGIN
            GenPostingSetup.GET(SalesLine."Gen. Bus. Posting Group", SalesLine."Gen. Prod. Posting Group");
            GenPostingSetup.TESTFIELD("Sales Prepayments Account");
            DefaultDimension.SETRANGE("Table ID", DATABASE::"G/L Account");
            DefaultDimension.SETRANGE("No.", GenPostingSetup."Sales Prepayments Account");
            InsertTempSalesLineInBuffer(TempSalesLine, SalesLine, GenPostingSetup."Sales Prepayments Account", DefaultDimension.ISEMPTY);
        END ELSE
            IF NOT TempSalesLine.MARK THEN BEGIN
                TempSalesLine.SETRANGE("Job No.", SalesLine."Job No.");
                TempSalesLine.SETRANGE("Responsibility Center", SalesLine."Responsibility Center");
                IF TempSalesLine.ISEMPTY THEN
                    InsertTempSalesLineInBuffer(TempSalesLine, SalesLine, TempSalesLine."No.", FALSE);
            END;
    end;

    local procedure InsertTempSalesLineInBuffer(var TempSalesLine: Record "Sales Line" temporary; SalesLine: Record "Sales Line"; AccountNo: Code[20]; DefaultDimensionsNotExist: Boolean)
    begin
        TempSalesLine.INIT;
        TempSalesLine."Line No." := SalesLine."Line No.";
        TempSalesLine."No." := AccountNo;
        TempSalesLine."Job No." := SalesLine."Job No.";
        TempSalesLine."Responsibility Center" := SalesLine."Responsibility Center";
        TempSalesLine."Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        TempSalesLine."Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
        TempSalesLine.MARK := DefaultDimensionsNotExist;
        TempSalesLine.INSERT;
    end;

    local procedure TransferItemChargeAssgntSalesToTemp(var ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary)
    begin
        IF ItemChargeAssgntSales.FINDSET THEN BEGIN
            REPEAT
                TempItemChargeAssgntSales.INIT;
                TempItemChargeAssgntSales := ItemChargeAssgntSales;
                TempItemChargeAssgntSales.INSERT;
            UNTIL ItemChargeAssgntSales.NEXT = 0;
            ItemChargeAssgntSales.DELETEALL;
        END;
    end;

    local procedure CreateItemChargeAssgntSales(var ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; var TempSalesLine: Record "Sales Line" temporary; var TempInteger: Record Integer temporary)
    begin
        IF TempSalesLine.FINDSET THEN
            REPEAT
                TempItemChargeAssgntSales.SETRANGE("Document Line No.", TempSalesLine."Line No.");
                IF TempItemChargeAssgntSales.FINDSET THEN BEGIN
                    REPEAT
                        TempInteger.FINDFIRST;
                        ItemChargeAssgntSales.INIT;
                        ItemChargeAssgntSales := TempItemChargeAssgntSales;
                        ItemChargeAssgntSales."Document Line No." := TempInteger.Number;
                        ItemChargeAssgntSales.VALIDATE("Unit Cost", 0);
                        ItemChargeAssgntSales.INSERT;
                    UNTIL TempItemChargeAssgntSales.NEXT = 0;
                    TempInteger.DELETE;
                END;
            UNTIL TempSalesLine.NEXT = 0;
    end;


    local procedure CopySellToCustomerAddressFieldsFromSalesDocument(var Customer: Record Customer)
    begin
        Customer.Address := "Sell-to Address";
        Customer."Address 2" := "Sell-to Address 2";
        Customer.City := "Sell-to City";
        Customer.Contact := "Sell-to Contact";
        Customer."Country/Region Code" := "Sell-to Country/Region Code";
        Customer.County := "Sell-to County";
        Customer."Post Code" := "Sell-to Post Code";
        Customer.MODIFY(TRUE);
    end;

    local procedure CopyShipToCustomerAddressFieldsFromSalesDocument(var Customer: Record Customer)
    begin
        Customer.Address := "Ship-to Address";
        Customer."Address 2" := "Ship-to Address 2";
        Customer.City := "Ship-to City";
        Customer.Contact := "Ship-to Contact";
        Customer."Country/Region Code" := "Ship-to Country/Region Code";
        Customer.County := "Ship-to County";
        Customer."Post Code" := "Ship-to Post Code";
        Customer.MODIFY(TRUE);
    end;

    local procedure CopyBillToCustomerAddressFieldsFromSalesDocument(var Customer: Record Customer)
    begin
        Customer.Address := "Bill-to Address";
        Customer."Address 2" := "Bill-to Address 2";
        Customer.City := "Bill-to City";
        Customer.Contact := "Bill-to Contact";
        Customer."Country/Region Code" := "Bill-to Country/Region Code";
        Customer.County := "Bill-to County";
        Customer."Post Code" := "Bill-to Post Code";
        Customer.MODIFY(TRUE);
    end;

    local procedure UpdateShipToContact()
    begin
        IF NOT (CurrFieldNo IN [FIELDNO("Sell-to Contact"), FIELDNO("Sell-to Contact No.")]) THEN
            EXIT;

        IF IsCreditDocType THEN
            EXIT;

        VALIDATE("Ship-to Contact", "Sell-to Contact");
    end;




    local procedure SetShipToAddress(ShipToName: Text[50]; ShipToName2: Text[50]; ShipToAddress: Text[50]; ShipToAddress2: Text[50]; ShipToCity: Text[30]; ShipToPostCode: Code[20]; ShipToCounty: Text[30]; ShipToCountryRegionCode: Code[10])
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

    local procedure GetOpportunityEntryNo(): Integer
    var
        OpportunityEntry: Record "Opportunity Entry";
    begin
        IF OpportunityEntry.FINDLAST THEN
            EXIT(OpportunityEntry."Entry No." + 1);
        EXIT(1);
    end;

    local procedure GetOpportunityEntryEstimatedValue(): Decimal
    var
        OpportunityEntry: Record "Opportunity Entry";
    begin
        OpportunityEntry.SETRANGE("Opportunity No.", "Opportunity No.");
        IF OpportunityEntry.FINDLAST THEN
            EXIT(OpportunityEntry."Estimated Value (LCY)");
    end;


    procedure "---NSC1.00---"()
    begin
    end;

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
        RecLSalesLine: Record "Sales Line";
        RecLItem: Record Item;
        RecLPurchSetup: Record "Purchases & Payables Setup";
        CduLNoSeriesMgt: Codeunit NoSeriesManagement;
        TextL001: Label '%1 Purchase Quote already existfor vendor %3, the newest from %2 do you to create a new one ?';
        CduLCopyDocMgt: Codeunit "Copy Document Mgt.";
        RecLPurchLine: Record "Purchase Line";
        NextLineNo: Integer;
        CodLLastVendor: Code[20];
        RecLPurchquoteHeader2: Record "Purchase Header";
        RecLPurchquoteHeader: Record "Purchase Header";
        BooLCreate: Boolean;
        IntLnumberofQuote: Integer;
        TextL002: Label '%1 quote created';
        RecLSalesLine2: Record "Sales Line";
    begin
        RecLSalesLine.RESET;
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
                        RecLPurchquoteHeader2.RESET;
                        RecLPurchquoteHeader2.SETRANGE("Document Type", "Document Type"::Quote);
                        RecLPurchquoteHeader2.SETFILTER("Buy-from Vendor No.", RecLSalesLine."BC6_Buy-from Vendor No.");
                        IF RecLPurchquoteHeader2.FIND('+') THEN
                            IF NOT CONFIRM(TextL001, TRUE, RecLPurchquoteHeader2.COUNT, RecLPurchquoteHeader2."Document Date",
                            RecLPurchquoteHeader2."Buy-from Vendor Name") THEN
                                BooLCreate := FALSE;

                        IF BooLCreate THEN BEGIN
                            IntLnumberofQuote += 1;
                            RecLPurchquoteHeader.SetHideValidationDialog(TRUE);
                            RecLPurchquoteHeader.INIT;
                            RecLPurchquoteHeader."No." := '';
                            RecLPurchquoteHeader.VALIDATE("Document Date", WORKDATE);
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
                                    RecLPurchLine.INIT;
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

                                UNTIL RecLSalesLine2.NEXT = 0;
                            END;
                        END;
                    END;

            UNTIL RecLSalesLine.NEXT = 0;
            IF BooLCreate THEN BEGIN
                MESSAGE(TextL002, IntLnumberofQuote);
                PAGE.RUN(Page::"Purchase Quote", RecLPurchquoteHeader);
            END;
        END;

    end;

    PROCEDURE GetPstdDocLinesToRevere();
    VAR
        SalesPostedDocLines: Page "Posted Sales Document Lines";
        Cust: Record Customer;
    BEGIN
        GetCust("Sell-to Customer No.");
        SalesPostedDocLines.SetToSalesHeader(Rec);
        SalesPostedDocLines.SETRECORD(Cust);
        SalesPostedDocLines.LOOKUPMODE := TRUE;
        IF SalesPostedDocLines.RUNMODAL = ACTION::LookupOK THEN
            SalesPostedDocLines.CopyLineToDoc;

        CLEAR(SalesPostedDocLines);
    END;


    procedure verifyquotestatus(): Boolean
    var
        RecLQuotehdr: Record "Sales Header";
        RecLAccessControl: Record "Access Control";
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        RecLAccessControl.RESET;
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID);
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID);
        RecLAccessControl.SETRANGE("Role ID", 'SUPER');
        IF NOT RecLAccessControl.FINDFIRST AND ("Document Type" = "Document Type"::Quote) THEN begin
            SalesSetup.GET;
            SalesSetup.TESTFIELD(BC6_Nbr_Devis);
            SalesSetup.TESTFIELD(Période);
            RecLQuotehdr.SETRANGE("Document Type", RecLQuotehdr."Document Type"::Quote);
            RecLQuotehdr.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");
            RecLQuotehdr.SETRANGE("Document Date", CALCDATE('-' + FORMAT(SalesSetup.Période), WORKDATE), WORKDATE);
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

    local procedure "---BCSYS---"()
    begin
    end;

    local procedure UpdateSalesLineReturnType()
    var
        L_SalesLine: Record "Sales Line";
    begin
        IF "Document Type" <> "Document Type"::"Return Order" THEN
            EXIT;

        IF xRec."BC6_Return Order Type" <> Rec."BC6_Return Order Type" THEN
            L_SalesLine.RESET;
        L_SalesLine.SETRANGE("Document Type", "Document Type");
        L_SalesLine.SETRANGE("Document No.", "No.");
        IF L_SalesLine.FINDFIRST THEN
            L_SalesLine.MODIFYALL("BC6_Return Order Type", "BC6_Return Order Type");
    end;

    procedure IsDeleteFromReturn(NewIsDeleteFromReturnOrder: Boolean)
    begin
        IsDeleteFromReturnOrder := NewIsDeleteFromReturnOrder;
    end;



    var
        ShipToAddr: Record "Ship-to Address";

        WMSManagement: Codeunit "WMS Management";
        BinCode: Code[20];
        Bin: Record Bin;
        ShipmentMethodRec: Record "Shipment Method";


        GenJnlLine: Record "Gen. Journal Line";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        ApplyCustEntries: Page "Apply Customer Entries";

        BoolReclose: Boolean;
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";

        FrmGLignesCommentaires: Page "Comment Sheet";
        "---NSC1.01": label '';
        TextG001: Label 'Warning, using foreign currency will generate wrong profit calculation.';
        CDUReleaseDoc: Codeunit "Release Sales Document";
        TextG002: Label 'Update Bill-to address ?';
        TextG003: Label 'Warning: you have already placed this order purchase.';
        UpdateSalesShipment: Codeunit BC6_UpdateSalesShipment;
        //  G_ReturnOrderMgt: Codeunit 50052;
        "-BCSYS-": Integer;

        IsDeleteFromReturnOrder: Boolean;
        PostSalesDelete: Codeunit "PostSales-Delete";
        ArchiveManagement: Codeunit ArchiveManagement;

        ConfirmChangeQst: Label 'Do you want to change %1?', Comment = '%1 = a Field Caption like Currency Code';
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DeferralLineQst: Label 'Do you want to update the deferral schedules for the lines?';
        ShippingAdviceErr: Label 'This order must be a complete shipment.';
        PostedDocsToPrintCreatedMsg: Label 'One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.';
        SellToCustomerTxt: Label 'Sell-to Customer';
        BillToCustomerTxt: Label 'Bill-to Customer';
        DocumentNotPostedClosePageQst: Label 'The document has not been posted.\Are you sure you want to exit?';
        SelectCustomerTemplateQst: Label 'Do you want to select the customer template?';
        SelectNoSeriesAllowed: Boolean;
        "-NSC1.00-": Integer;
        RecGCustomer: Record Customer;
        RecGParamNavi: Record "BC6_Navi+ Setup";
        RecGCommentLine: Record "Comment Line";

}

