codeunit 50099 "TEMP TOOLS 2"
{
    Permissions = TableData 112 = rimd,
                  TableData 121 = rimd;

    trigger OnRun()
    var
        PurchaseLine: Record "39";
        SalesInvoiceHeader: Record "112";
        OrderAPIRecordTracking: Record "50074";
        PurchaseHeader: Record "38";
        PurchaseHeader2: Record "38";
        JSONRequestslog: Record "50073";
        PurchRcptLine: Record "121";
        LineNo: Integer;
        ACONo: Code[20];
        PurchRcptNo: Code[20];
    begin
        //SalesInvoiceHeader.GET('0555691');
        //SalesInvoiceHeader."Order No." := 'VCO22607';
        //SalesInvoiceHeader.MODIFY;
        /*
        OrderAPIRecordTracking.SETRANGE("ACO Date",0D);
        OrderAPIRecordTracking.MODIFYALL("Sent Deal",TRUE);
        PurchaseHeader.SETRANGE("Order Date",0D);
        IF  NOT PurchaseHeader.ISEMPTY THEN
        BEGIN
          PurchaseHeader.FINDSET;
          REPEAT
            PurchaseHeader2.GET(PurchaseHeader."Document Type",PurchaseHeader."No.");
            PurchaseHeader2."Order Date" := PurchaseHeader2."Posting Date";
            PurchaseHeader2.MODIFY;
          UNTIL PurchaseHeader.NEXT = 0 ;
        END;
        */
        //JSONRequestslog.SETRANGE(Error,TRUE);
        /*
        PurchRcptLine.GET('ARE58864',30000);
        PurchRcptLine.DELETE(TRUE);
        */
        /*
        //LineNo := 40000;
        ACONo := 'ACO-38681';
        PurchRcptNo := 'ARE61865';
        
        PurchRcptLine.SETRANGE("No.",PurchRcptNo);
        PurchRcptLine.SETFILTER(Quantity,'<>%1',0);
        PurchRcptLine.FINDSET;
        REPEAT
          PurchaseLine.GET(PurchaseLine."Document Type"::Order,ACONo,PurchRcptLine."Line No.");
        
          PurchaseLine."Quantity Invoiced" += PurchRcptLine.Quantity;
          PurchaseLine."Qty. Received (Base)"+= PurchRcptLine.Quantity;
        
          PurchaseLine."Qty. Invoiced (Base)"+= PurchRcptLine.Quantity;
          PurchaseLine."Quantity Received" += PurchRcptLine.Quantity;
        
          PurchaseLine."Outstanding Quantity" := PurchaseLine.Quantity - PurchaseLine."Quantity Received";
          PurchaseLine."Outstanding Qty. (Base)" := PurchaseLine.Quantity - PurchaseLine."Quantity Received";
        
          PurchaseLine.InitOutstandingAmount();
          PurchaseLine.MODIFY;
        UNTIL PurchRcptLine.NEXT = 0;
        MESSAGE('OK');
        */

    end;
}

