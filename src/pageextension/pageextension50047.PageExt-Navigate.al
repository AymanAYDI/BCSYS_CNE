pageextension 50047 pageextension50047 extends Navigate
{
    var
        "-DEEE-": Integer;
        GRecEntry: Record "50008";


        //Unsupported feature: Code Modification on "FindRecords(PROCEDURE 2)".

        //procedure FindRecords();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Window.OPEN(Text002);
        RESET;
        DELETEALL;
        "Entry No." := 0;
        FindIncomingDocumentRecords;
        IF SalesShptHeader.READPERMISSION THEN BEGIN
          SalesShptHeader.RESET;
          SalesShptHeader.SETFILTER("No.",DocNoFilter);
          SalesShptHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Sales Shipment Header",0,Text005,SalesShptHeader.COUNT);
        END;
        IF SalesInvHeader.READPERMISSION THEN BEGIN
          SalesInvHeader.RESET;
          SalesInvHeader.SETFILTER("No.",DocNoFilter);
          SalesInvHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Sales Invoice Header",0,Text003,SalesInvHeader.COUNT);
        END;
        IF ReturnRcptHeader.READPERMISSION THEN BEGIN
          ReturnRcptHeader.RESET;
          ReturnRcptHeader.SETFILTER("No.",DocNoFilter);
          ReturnRcptHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Return Receipt Header",0,Text017,ReturnRcptHeader.COUNT);
        END;
        IF SalesCrMemoHeader.READPERMISSION THEN BEGIN
          SalesCrMemoHeader.RESET;
          SalesCrMemoHeader.SETFILTER("No.",DocNoFilter);
          SalesCrMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Sales Cr.Memo Header",0,Text004,SalesCrMemoHeader.COUNT);
        END;
        IF ServShptHeader.READPERMISSION THEN BEGIN
          ServShptHeader.RESET;
          ServShptHeader.SETFILTER("No.",DocNoFilter);
          ServShptHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Service Shipment Header",0,sText005,ServShptHeader.COUNT);
        END;
        IF ServInvHeader.READPERMISSION THEN BEGIN
          ServInvHeader.RESET;
          ServInvHeader.SETFILTER("No.",DocNoFilter);
          ServInvHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Service Invoice Header",0,sText003,ServInvHeader.COUNT);
        END;
        IF ServCrMemoHeader.READPERMISSION THEN BEGIN
          ServCrMemoHeader.RESET;
          ServCrMemoHeader.SETFILTER("No.",DocNoFilter);
          ServCrMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Service Cr.Memo Header",0,sText004,ServCrMemoHeader.COUNT);
        END;
        IF IssuedReminderHeader.READPERMISSION THEN BEGIN
          IssuedReminderHeader.RESET;
          IssuedReminderHeader.SETFILTER("No.",DocNoFilter);
          IssuedReminderHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Issued Reminder Header",0,Text006,IssuedReminderHeader.COUNT);
        END;
        IF IssuedFinChrgMemoHeader.READPERMISSION THEN BEGIN
          IssuedFinChrgMemoHeader.RESET;
          IssuedFinChrgMemoHeader.SETFILTER("No.",DocNoFilter);
          IssuedFinChrgMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Issued Fin. Charge Memo Header",0,Text007,
            IssuedFinChrgMemoHeader.COUNT);
        END;
        IF PurchRcptHeader.READPERMISSION THEN BEGIN
          PurchRcptHeader.RESET;
          PurchRcptHeader.SETFILTER("No.",DocNoFilter);
          PurchRcptHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Purch. Rcpt. Header",0,Text010,PurchRcptHeader.COUNT);
        END;
        IF PurchInvHeader.READPERMISSION THEN BEGIN
          PurchInvHeader.RESET;
          PurchInvHeader.SETFILTER("No.",DocNoFilter);
          PurchInvHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Purch. Inv. Header",0,Text008,PurchInvHeader.COUNT);
        END;
        IF ReturnShptHeader.READPERMISSION THEN BEGIN
          ReturnShptHeader.RESET;
          ReturnShptHeader.SETFILTER("No.",DocNoFilter);
          ReturnShptHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Return Shipment Header",0,Text018,ReturnShptHeader.COUNT);
        END;
        IF PurchCrMemoHeader.READPERMISSION THEN BEGIN
          PurchCrMemoHeader.RESET;
          PurchCrMemoHeader.SETFILTER("No.",DocNoFilter);
          PurchCrMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Purch. Cr. Memo Hdr.",0,Text009,PurchCrMemoHeader.COUNT);
        END;
        IF ProductionOrderHeader.READPERMISSION THEN BEGIN
          ProductionOrderHeader.RESET;
          ProductionOrderHeader.SETRANGE(
            Status,
            ProductionOrderHeader.Status::Released,
            ProductionOrderHeader.Status::Finished);
          ProductionOrderHeader.SETFILTER("No.",DocNoFilter);
          InsertIntoDocEntry(
            DATABASE::"Production Order",0,Text99000000,ProductionOrderHeader.COUNT);
        END;
        IF PostedAssemblyHeader.READPERMISSION THEN BEGIN
          PostedAssemblyHeader.RESET;
          PostedAssemblyHeader.SETFILTER("No.",DocNoFilter);
          InsertIntoDocEntry(
            DATABASE::"Posted Assembly Header",0,Text025,PostedAssemblyHeader.COUNT);
        END;
        IF TransShptHeader.READPERMISSION THEN BEGIN
          TransShptHeader.RESET;
          TransShptHeader.SETFILTER("No.",DocNoFilter);
          TransShptHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Transfer Shipment Header",0,Text019,TransShptHeader.COUNT);
        END;
        IF TransRcptHeader.READPERMISSION THEN BEGIN
          TransRcptHeader.RESET;
          TransRcptHeader.SETFILTER("No.",DocNoFilter);
          TransRcptHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Transfer Receipt Header",0,Text020,TransRcptHeader.COUNT);
        END;
        IF PostedWhseShptLine.READPERMISSION THEN BEGIN
          PostedWhseShptLine.RESET;
          PostedWhseShptLine.SETCURRENTKEY("Posted Source No.","Posting Date");
          PostedWhseShptLine.SETFILTER("Posted Source No.",DocNoFilter);
          PostedWhseShptLine.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Posted Whse. Shipment Line",0,
            PostedWhseShptLine.TABLECAPTION,PostedWhseShptLine.COUNT);
        END;
        IF PostedWhseRcptLine.READPERMISSION THEN BEGIN
          PostedWhseRcptLine.RESET;
          PostedWhseRcptLine.SETCURRENTKEY("Posted Source No.","Posting Date");
          PostedWhseRcptLine.SETFILTER("Posted Source No.",DocNoFilter);
          PostedWhseRcptLine.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Posted Whse. Receipt Line",0,
            PostedWhseRcptLine.TABLECAPTION,PostedWhseRcptLine.COUNT);
        END;
        IF GLEntry.READPERMISSION THEN BEGIN
          GLEntry.RESET;
          GLEntry.SETCURRENTKEY("Document No.","Posting Date");
          GLEntry.SETFILTER("Document No.",DocNoFilter);
          GLEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"G/L Entry",0,GLEntry.TABLECAPTION,GLEntry.COUNT);
        END;
        IF VATEntry.READPERMISSION THEN BEGIN
          VATEntry.RESET;
          VATEntry.SETCURRENTKEY("Document No.","Posting Date");
          VATEntry.SETFILTER("Document No.",DocNoFilter);
          VATEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"VAT Entry",0,VATEntry.TABLECAPTION,VATEntry.COUNT);
        END;
        IF CustLedgEntry.READPERMISSION THEN BEGIN
          CustLedgEntry.RESET;
          CustLedgEntry.SETCURRENTKEY("Document No.");
          CustLedgEntry.SETFILTER("Document No.",DocNoFilter);
          CustLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Cust. Ledger Entry",0,CustLedgEntry.TABLECAPTION,CustLedgEntry.COUNT);
        END;
        IF DtldCustLedgEntry.READPERMISSION THEN BEGIN
          DtldCustLedgEntry.RESET;
          DtldCustLedgEntry.SETCURRENTKEY("Document No.");
          DtldCustLedgEntry.SETFILTER("Document No.",DocNoFilter);
          DtldCustLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Detailed Cust. Ledg. Entry",0,DtldCustLedgEntry.TABLECAPTION,DtldCustLedgEntry.COUNT);
        END;
        IF ReminderEntry.READPERMISSION THEN BEGIN
          ReminderEntry.RESET;
          ReminderEntry.SETCURRENTKEY(Type,"No.");
          ReminderEntry.SETFILTER("No.",DocNoFilter);
          ReminderEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Reminder/Fin. Charge Entry",0,ReminderEntry.TABLECAPTION,ReminderEntry.COUNT);
        END;
        IF VendLedgEntry.READPERMISSION THEN BEGIN
          VendLedgEntry.RESET;
          VendLedgEntry.SETCURRENTKEY("Document No.");
          VendLedgEntry.SETFILTER("Document No.",DocNoFilter);
          VendLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Vendor Ledger Entry",0,VendLedgEntry.TABLECAPTION,VendLedgEntry.COUNT);
        END;
        IF DtldVendLedgEntry.READPERMISSION THEN BEGIN
          DtldVendLedgEntry.RESET;
          DtldVendLedgEntry.SETCURRENTKEY("Document No.");
          DtldVendLedgEntry.SETFILTER("Document No.",DocNoFilter);
          DtldVendLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Detailed Vendor Ledg. Entry",0,DtldVendLedgEntry.TABLECAPTION,DtldVendLedgEntry.COUNT);
        END;
        IF ItemLedgEntry.READPERMISSION THEN BEGIN
          ItemLedgEntry.RESET;
          ItemLedgEntry.SETCURRENTKEY("Document No.");
          ItemLedgEntry.SETFILTER("Document No.",DocNoFilter);
          ItemLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Item Ledger Entry",0,ItemLedgEntry.TABLECAPTION,ItemLedgEntry.COUNT);
        END;
        IF ValueEntry.READPERMISSION THEN BEGIN
          ValueEntry.RESET;
          ValueEntry.SETCURRENTKEY("Document No.");
          ValueEntry.SETFILTER("Document No.",DocNoFilter);
          ValueEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Value Entry",0,ValueEntry.TABLECAPTION,ValueEntry.COUNT);
        END;
        IF PhysInvtLedgEntry.READPERMISSION THEN BEGIN
          PhysInvtLedgEntry.RESET;
          PhysInvtLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
          PhysInvtLedgEntry.SETFILTER("Document No.",DocNoFilter);
          PhysInvtLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Phys. Inventory Ledger Entry",0,PhysInvtLedgEntry.TABLECAPTION,PhysInvtLedgEntry.COUNT);
        END;
        IF ResLedgEntry.READPERMISSION THEN BEGIN
          ResLedgEntry.RESET;
          ResLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
          ResLedgEntry.SETFILTER("Document No.",DocNoFilter);
          ResLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Res. Ledger Entry",0,ResLedgEntry.TABLECAPTION,ResLedgEntry.COUNT);
        END;
        FindJobRecords;
        IF BankAccLedgEntry.READPERMISSION THEN BEGIN
          BankAccLedgEntry.RESET;
          BankAccLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
          BankAccLedgEntry.SETFILTER("Document No.",DocNoFilter);
          BankAccLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Bank Account Ledger Entry",0,BankAccLedgEntry.TABLECAPTION,BankAccLedgEntry.COUNT);
        END;
        IF CheckLedgEntry.READPERMISSION THEN BEGIN
          CheckLedgEntry.RESET;
          CheckLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
          CheckLedgEntry.SETFILTER("Document No.",DocNoFilter);
          CheckLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Check Ledger Entry",0,CheckLedgEntry.TABLECAPTION,CheckLedgEntry.COUNT);
        END;
        IF FALedgEntry.READPERMISSION THEN BEGIN
          FALedgEntry.RESET;
          FALedgEntry.SETCURRENTKEY("Document No.","Posting Date");
          FALedgEntry.SETFILTER("Document No.",DocNoFilter);
          FALedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"FA Ledger Entry",0,FALedgEntry.TABLECAPTION,FALedgEntry.COUNT);
        END;
        IF MaintenanceLedgEntry.READPERMISSION THEN BEGIN
          MaintenanceLedgEntry.RESET;
          MaintenanceLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
          MaintenanceLedgEntry.SETFILTER("Document No.",DocNoFilter);
          MaintenanceLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Maintenance Ledger Entry",0,MaintenanceLedgEntry.TABLECAPTION,MaintenanceLedgEntry.COUNT);
        END;
        IF InsuranceCovLedgEntry.READPERMISSION THEN BEGIN
          InsuranceCovLedgEntry.RESET;
          InsuranceCovLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
          InsuranceCovLedgEntry.SETFILTER("Document No.",DocNoFilter);
          InsuranceCovLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Ins. Coverage Ledger Entry",0,InsuranceCovLedgEntry.TABLECAPTION,InsuranceCovLedgEntry.COUNT);
        END;
        IF CapacityLedgEntry.READPERMISSION THEN BEGIN
          CapacityLedgEntry.RESET;
          CapacityLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
          CapacityLedgEntry.SETFILTER("Document No.",DocNoFilter);
          CapacityLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Capacity Ledger Entry",0,CapacityLedgEntry.TABLECAPTION,CapacityLedgEntry.COUNT);
        END;
        IF WhseEntry.READPERMISSION THEN BEGIN
          WhseEntry.RESET;
          WhseEntry.SETCURRENTKEY("Reference No.","Registering Date");
          WhseEntry.SETFILTER("Reference No.",DocNoFilter);
          WhseEntry.SETFILTER("Registering Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Warehouse Entry",0,WhseEntry.TABLECAPTION,WhseEntry.COUNT);
        END;

        IF ServLedgerEntry.READPERMISSION THEN BEGIN
          ServLedgerEntry.RESET;
          ServLedgerEntry.SETCURRENTKEY("Document No.","Posting Date");
          ServLedgerEntry.SETFILTER("Document No.",DocNoFilter);
          ServLedgerEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Service Ledger Entry",0,ServLedgerEntry.TABLECAPTION,ServLedgerEntry.COUNT);
        END;
        IF WarrantyLedgerEntry.READPERMISSION THEN BEGIN
          WarrantyLedgerEntry.RESET;
          WarrantyLedgerEntry.SETCURRENTKEY("Document No.","Posting Date");
          WarrantyLedgerEntry.SETFILTER("Document No.",DocNoFilter);
          WarrantyLedgerEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Warranty Ledger Entry",0,WarrantyLedgerEntry.TABLECAPTION,WarrantyLedgerEntry.COUNT);
        END;

        IF CostEntry.READPERMISSION THEN BEGIN
          CostEntry.RESET;
          CostEntry.SETCURRENTKEY("Document No.","Posting Date");
          CostEntry.SETFILTER("Document No.",DocNoFilter);
          CostEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Cost Entry",0,CostEntry.TABLECAPTION,CostEntry.COUNT);
        END;

        IF PaymentHeader.READPERMISSION THEN BEGIN
          PaymentHeader.RESET;
          PaymentHeader.SETCURRENTKEY("Posting Date");
          PaymentHeader.SETFILTER("No.",DocNoFilter);
          PaymentHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Payment Header",0,PaymentHeader.TABLECAPTION,PaymentHeader.COUNT);
        END;
        IF PaymentLine.READPERMISSION THEN BEGIN
          PaymentLine.RESET;
          PaymentLine.SETCURRENTKEY("Posting Date");
          PaymentLine.SETFILTER("Document No.",DocNoFilter);
          PaymentLine.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Payment Line",0,PaymentLine.TABLECAPTION,PaymentLine.COUNT);
        END;
        IF PaymentHeaderArchive.READPERMISSION THEN BEGIN
          PaymentHeaderArchive.RESET;
          PaymentHeaderArchive.SETCURRENTKEY("Posting Date");
          PaymentHeaderArchive.SETFILTER("No.",DocNoFilter);
          PaymentHeaderArchive.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Payment Header Archive",0,PaymentHeaderArchive.TABLECAPTION,PaymentHeaderArchive.COUNT);
        END;
        IF PaymentLineArchive.READPERMISSION THEN BEGIN
          PaymentLineArchive.RESET;
          PaymentLineArchive.SETCURRENTKEY("Posting Date");
          PaymentLineArchive.SETFILTER("Document No.",DocNoFilter);
          PaymentLineArchive.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Payment Line Archive",0,PaymentLineArchive.TABLECAPTION,PaymentLineArchive.COUNT);
        END;

        OnAfterNavigateFindRecords(Rec,DocNoFilter,PostingDateFilter);
        DocExists := FINDFIRST;

        SetSource(0D,'','',0,'');
        IF DocExists THEN BEGIN
          IF (NoOfRecords(DATABASE::"Cust. Ledger Entry") + NoOfRecords(DATABASE::"Vendor Ledger Entry") <= 1) AND
             (NoOfRecords(DATABASE::"Sales Invoice Header") + NoOfRecords(DATABASE::"Sales Cr.Memo Header") +
              NoOfRecords(DATABASE::"Sales Shipment Header") + NoOfRecords(DATABASE::"Issued Reminder Header") +
              NoOfRecords(DATABASE::"Issued Fin. Charge Memo Header") + NoOfRecords(DATABASE::"Purch. Inv. Header") +
              NoOfRecords(DATABASE::"Return Shipment Header") + NoOfRecords(DATABASE::"Return Receipt Header") +
              NoOfRecords(DATABASE::"Purch. Cr. Memo Hdr.") + NoOfRecords(DATABASE::"Purch. Rcpt. Header") +
              NoOfRecords(DATABASE::"Service Invoice Header") + NoOfRecords(DATABASE::"Service Cr.Memo Header") +
              NoOfRecords(DATABASE::"Service Shipment Header") +
              NoOfRecords(DATABASE::"Transfer Shipment Header") + NoOfRecords(DATABASE::"Transfer Receipt Header") <= 1)
          THEN BEGIN
            // Service Management
            IF NoOfRecords(DATABASE::"Service Ledger Entry") = 1 THEN BEGIN
              ServLedgerEntry.FINDFIRST;
              IF ServLedgerEntry.Type = ServLedgerEntry.Type::"Service Contract" THEN
                SetSource(
                  ServLedgerEntry."Posting Date",FORMAT(ServLedgerEntry."Document Type"),ServLedgerEntry."Document No.",
                  2,ServLedgerEntry."Service Contract No.")
              ELSE
                SetSource(
                  ServLedgerEntry."Posting Date",FORMAT(ServLedgerEntry."Document Type"),ServLedgerEntry."Document No.",
                  2,ServLedgerEntry."Service Order No.")
            END;
            IF NoOfRecords(DATABASE::"Warranty Ledger Entry") = 1 THEN BEGIN
              WarrantyLedgerEntry.FINDFIRST;
              SetSource(
                WarrantyLedgerEntry."Posting Date",'',WarrantyLedgerEntry."Document No.",
                2,WarrantyLedgerEntry."Service Order No.")
            END;

            // Sales
            IF NoOfRecords(DATABASE::"Cust. Ledger Entry") = 1 THEN BEGIN
              CustLedgEntry.FINDFIRST;
              SetSource(
                CustLedgEntry."Posting Date",FORMAT(CustLedgEntry."Document Type"),CustLedgEntry."Document No.",
                1,CustLedgEntry."Customer No.");
            END;
            IF NoOfRecords(DATABASE::"Detailed Cust. Ledg. Entry") = 1 THEN BEGIN
              DtldCustLedgEntry.FINDFIRST;
              SetSource(
                DtldCustLedgEntry."Posting Date",FORMAT(DtldCustLedgEntry."Document Type"),DtldCustLedgEntry."Document No.",
                1,DtldCustLedgEntry."Customer No.");
            END;
            IF NoOfRecords(DATABASE::"Sales Invoice Header") = 1 THEN BEGIN
              SalesInvHeader.FINDFIRST;
              SetSource(
                SalesInvHeader."Posting Date",FORMAT("Table Name"),SalesInvHeader."No.",
                1,SalesInvHeader."Bill-to Customer No.");
            END;
            IF NoOfRecords(DATABASE::"Sales Cr.Memo Header") = 1 THEN BEGIN
              SalesCrMemoHeader.FINDFIRST;
              SetSource(
                SalesCrMemoHeader."Posting Date",FORMAT("Table Name"),SalesCrMemoHeader."No.",
                1,SalesCrMemoHeader."Bill-to Customer No.");
            END;
            IF NoOfRecords(DATABASE::"Return Receipt Header") = 1 THEN BEGIN
              ReturnRcptHeader.FINDFIRST;
              SetSource(
                ReturnRcptHeader."Posting Date",FORMAT("Table Name"),ReturnRcptHeader."No.",
                1,ReturnRcptHeader."Sell-to Customer No.");
            END;
            IF NoOfRecords(DATABASE::"Sales Shipment Header") = 1 THEN BEGIN
              SalesShptHeader.FINDFIRST;
              SetSource(
                SalesShptHeader."Posting Date",FORMAT("Table Name"),SalesShptHeader."No.",
                1,SalesShptHeader."Sell-to Customer No.");
            END;
            IF NoOfRecords(DATABASE::"Posted Whse. Shipment Line") = 1 THEN BEGIN
              PostedWhseShptLine.FINDFIRST;
              SetSource(
                PostedWhseShptLine."Posting Date",FORMAT("Table Name"),PostedWhseShptLine."No.",
                1,PostedWhseShptLine."Destination No.");
            END;
            IF NoOfRecords(DATABASE::"Issued Reminder Header") = 1 THEN BEGIN
              IssuedReminderHeader.FINDFIRST;
              SetSource(
                IssuedReminderHeader."Posting Date",FORMAT("Table Name"),IssuedReminderHeader."No.",
                1,IssuedReminderHeader."Customer No.");
            END;
            IF NoOfRecords(DATABASE::"Issued Fin. Charge Memo Header") = 1 THEN BEGIN
              IssuedFinChrgMemoHeader.FINDFIRST;
              SetSource(
                IssuedFinChrgMemoHeader."Posting Date",FORMAT("Table Name"),IssuedFinChrgMemoHeader."No.",
                1,IssuedFinChrgMemoHeader."Customer No.");
            END;

            IF NoOfRecords(DATABASE::"Service Invoice Header") = 1 THEN BEGIN
              ServInvHeader.FINDFIRST;
              SetSource(
                ServInvHeader."Posting Date",FORMAT("Table Name"),ServInvHeader."No.",
                1,ServInvHeader."Bill-to Customer No.");
            END;
            IF NoOfRecords(DATABASE::"Service Cr.Memo Header") = 1 THEN BEGIN
              ServCrMemoHeader.FINDFIRST;
              SetSource(
                ServCrMemoHeader."Posting Date",FORMAT("Table Name"),ServCrMemoHeader."No.",
                1,ServCrMemoHeader."Bill-to Customer No.");
            END;
            IF NoOfRecords(DATABASE::"Service Shipment Header") = 1 THEN BEGIN
              ServShptHeader.FINDFIRST;
              SetSource(
                ServShptHeader."Posting Date",FORMAT("Table Name"),ServShptHeader."No.",
                1,ServShptHeader."Customer No.");
            END;

            // Purchase
            IF NoOfRecords(DATABASE::"Vendor Ledger Entry") = 1 THEN BEGIN
              VendLedgEntry.FINDFIRST;
              SetSource(
                VendLedgEntry."Posting Date",FORMAT(VendLedgEntry."Document Type"),VendLedgEntry."Document No.",
                2,VendLedgEntry."Vendor No.");
            END;
            IF NoOfRecords(DATABASE::"Detailed Vendor Ledg. Entry") = 1 THEN BEGIN
              DtldVendLedgEntry.FINDFIRST;
              SetSource(
                DtldVendLedgEntry."Posting Date",FORMAT(DtldVendLedgEntry."Document Type"),DtldVendLedgEntry."Document No.",
                2,DtldVendLedgEntry."Vendor No.");
            END;
            IF NoOfRecords(DATABASE::"Purch. Inv. Header") = 1 THEN BEGIN
              PurchInvHeader.FINDFIRST;
              SetSource(
                PurchInvHeader."Posting Date",FORMAT("Table Name"),PurchInvHeader."No.",
                2,PurchInvHeader."Pay-to Vendor No.");
            END;
            IF NoOfRecords(DATABASE::"Purch. Cr. Memo Hdr.") = 1 THEN BEGIN
              PurchCrMemoHeader.FINDFIRST;
              SetSource(
                PurchCrMemoHeader."Posting Date",FORMAT("Table Name"),PurchCrMemoHeader."No.",
                2,PurchCrMemoHeader."Pay-to Vendor No.");
            END;
            IF NoOfRecords(DATABASE::"Return Shipment Header") = 1 THEN BEGIN
              ReturnShptHeader.FINDFIRST;
              SetSource(
                ReturnShptHeader."Posting Date",FORMAT("Table Name"),ReturnShptHeader."No.",
                2,ReturnShptHeader."Buy-from Vendor No.");
            END;
            IF NoOfRecords(DATABASE::"Purch. Rcpt. Header") = 1 THEN BEGIN
              PurchRcptHeader.FINDFIRST;
              SetSource(
                PurchRcptHeader."Posting Date",FORMAT("Table Name"),PurchRcptHeader."No.",
                2,PurchRcptHeader."Buy-from Vendor No.");
            END;
            IF NoOfRecords(DATABASE::"Posted Whse. Shipment Line") = 1 THEN BEGIN
              PostedWhseShptLine.FINDFIRST;
              SetSource(
                PostedWhseShptLine."Posting Date",FORMAT("Table Name"),PostedWhseShptLine."No.",
                1,PostedWhseShptLine."Destination No.");
            END;
          END ELSE BEGIN
            IF DocNoFilter <> '' THEN
              IF PostingDateFilter = '' THEN
                MESSAGE(Text011)
              ELSE
                MESSAGE(Text012);
          END;
        END ELSE
          IF PostingDateFilter = '' THEN
            MESSAGE(Text013)
          ELSE
            MESSAGE(Text014);

        IF UpdateForm THEN
          UpdateFormAfterFindRecords;
        Window.CLOSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..209

        //JNP DEEE
        IF GRecEntry.READPERMISSION THEN BEGIN
          GRecEntry.RESET;
          GRecEntry.SETCURRENTKEY("Document No.","Posting Date");
          GRecEntry.SETFILTER("Document No.",DocNoFilter);
          GRecEntry.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"DEEE Ledger Entry",0,GRecEntry.TABLECAPTION,GRecEntry.COUNT);
        END;
        //FIN JNP DEEE

        #210..518
        */
        //end;


        //Unsupported feature: Code Modification on "ShowRecords(PROCEDURE 6)".

        //procedure ShowRecords();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ItemTrackingSearch THEN
          ItemTrackingNavigateMgt.Show("Table ID")
        ELSE
          CASE "Table ID" OF
            DATABASE::"Incoming Document":
              PAGE.RUN(PAGE::"Incoming Document",IncomingDocument);
            DATABASE::"Sales Header":
              ShowSalesHeaderRecords;
            DATABASE::"Sales Invoice Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Sales Invoice",SalesInvHeader)
              ELSE
                PAGE.RUN(PAGE::"Posted Sales Invoices",SalesInvHeader);
            DATABASE::"Sales Cr.Memo Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Sales Credit Memo",SalesCrMemoHeader)
              ELSE
                PAGE.RUN(PAGE::"Posted Sales Credit Memos",SalesCrMemoHeader);
            DATABASE::"Return Receipt Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Return Receipt",ReturnRcptHeader)
              ELSE
                PAGE.RUN(0,ReturnRcptHeader);
            DATABASE::"Sales Shipment Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Sales Shipment",SalesShptHeader)
              ELSE
                PAGE.RUN(0,SalesShptHeader);
            DATABASE::"Issued Reminder Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Issued Reminder",IssuedReminderHeader)
              ELSE
                PAGE.RUN(0,IssuedReminderHeader);
            DATABASE::"Issued Fin. Charge Memo Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Issued Finance Charge Memo",IssuedFinChrgMemoHeader)
              ELSE
                PAGE.RUN(0,IssuedFinChrgMemoHeader);
            DATABASE::"Purch. Inv. Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Purchase Invoice",PurchInvHeader)
              ELSE
                PAGE.RUN(PAGE::"Posted Purchase Invoices",PurchInvHeader);
            DATABASE::"Purch. Cr. Memo Hdr.":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Purchase Credit Memo",PurchCrMemoHeader)
              ELSE
                PAGE.RUN(PAGE::"Posted Purchase Credit Memos",PurchCrMemoHeader);
            DATABASE::"Return Shipment Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Return Shipment",ReturnShptHeader)
              ELSE
                PAGE.RUN(0,ReturnShptHeader);
            DATABASE::"Purch. Rcpt. Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Purchase Receipt",PurchRcptHeader)
              ELSE
                PAGE.RUN(0,PurchRcptHeader);
            DATABASE::"Production Order":
              PAGE.RUN(0,ProductionOrderHeader);
            DATABASE::"Posted Assembly Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Assembly Order",PostedAssemblyHeader)
              ELSE
                PAGE.RUN(0,PostedAssemblyHeader);
            DATABASE::"Transfer Shipment Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Transfer Shipment",TransShptHeader)
              ELSE
                PAGE.RUN(0,TransShptHeader);
            DATABASE::"Transfer Receipt Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Transfer Receipt",TransRcptHeader)
              ELSE
                PAGE.RUN(0,TransRcptHeader);
            DATABASE::"Posted Whse. Shipment Line":
              PAGE.RUN(0,PostedWhseShptLine);
            DATABASE::"Posted Whse. Receipt Line":
              PAGE.RUN(0,PostedWhseRcptLine);
            DATABASE::"G/L Entry":
              PAGE.RUN(0,GLEntry);
            DATABASE::"VAT Entry":
              PAGE.RUN(0,VATEntry);
            DATABASE::"Detailed Cust. Ledg. Entry":
              PAGE.RUN(0,DtldCustLedgEntry);
            DATABASE::"Cust. Ledger Entry":
              PAGE.RUN(0,CustLedgEntry);
            DATABASE::"Reminder/Fin. Charge Entry":
              PAGE.RUN(0,ReminderEntry);
            DATABASE::"Vendor Ledger Entry":
              PAGE.RUN(0,VendLedgEntry);
            DATABASE::"Detailed Vendor Ledg. Entry":
              PAGE.RUN(0,DtldVendLedgEntry);
            DATABASE::"Item Ledger Entry":
              PAGE.RUN(0,ItemLedgEntry);
            DATABASE::"Value Entry":
              PAGE.RUN(0,ValueEntry);
            DATABASE::"Phys. Inventory Ledger Entry":
              PAGE.RUN(0,PhysInvtLedgEntry);
            DATABASE::"Res. Ledger Entry":
              PAGE.RUN(0,ResLedgEntry);
            DATABASE::"Job Ledger Entry":
              PAGE.RUN(0,JobLedgEntry);
            DATABASE::"Job WIP Entry":
              PAGE.RUN(0,JobWIPEntry);
            DATABASE::"Job WIP G/L Entry":
              PAGE.RUN(0,JobWIPGLEntry);
            DATABASE::"Bank Account Ledger Entry":
              PAGE.RUN(0,BankAccLedgEntry);
            DATABASE::"Check Ledger Entry":
              PAGE.RUN(0,CheckLedgEntry);
            DATABASE::"FA Ledger Entry":
              PAGE.RUN(0,FALedgEntry);
            DATABASE::"Maintenance Ledger Entry":
              PAGE.RUN(0,MaintenanceLedgEntry);
            DATABASE::"Ins. Coverage Ledger Entry":
              PAGE.RUN(0,InsuranceCovLedgEntry);
            DATABASE::"Capacity Ledger Entry":
              PAGE.RUN(0,CapacityLedgEntry);
            DATABASE::"Warehouse Entry":
              PAGE.RUN(0,WhseEntry);
            DATABASE::"Service Header":
              ShowServiceHeaderRecords;
            DATABASE::"Service Invoice Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Service Invoice",ServInvHeader)
              ELSE
                PAGE.RUN(0,ServInvHeader);
            DATABASE::"Service Cr.Memo Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Service Credit Memo",ServCrMemoHeader)
              ELSE
                PAGE.RUN(0,ServCrMemoHeader);
            DATABASE::"Service Shipment Header":
              IF "No. of Records" = 1 THEN
                PAGE.RUN(PAGE::"Posted Service Shipment",ServShptHeader)
              ELSE
                PAGE.RUN(0,ServShptHeader);
            DATABASE::"Service Ledger Entry":
              PAGE.RUN(0,ServLedgerEntry);
            DATABASE::"Warranty Ledger Entry":
              PAGE.RUN(0,WarrantyLedgerEntry);
            DATABASE::"Cost Entry":
              PAGE.RUN(0,CostEntry);
            DATABASE::"Payment Header":
              PAGE.RUN(0,PaymentHeader);
            DATABASE::"Payment Line":
              PAGE.RUN(0,PaymentLine);
            DATABASE::"Payment Header Archive":
              PAGE.RUN(0,PaymentHeaderArchive);
            DATABASE::"Payment Line Archive":
              PAGE.RUN(0,PaymentLineArchive)
          END;

        OnAfterNavigateShowRecords("Table ID",DocNoFilter,PostingDateFilter,ItemTrackingSearch);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..95

            //JNP DEEE
            DATABASE::"DEEE Ledger Entry":
              PAGE.RUN(0,GRecEntry);
            //FIN JNP DEEE

        #96..155
        */
        //end;
}

