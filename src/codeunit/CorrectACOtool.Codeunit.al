codeunit 50060 "Correct ACO tool"
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
        /*
        
        PurchRcptNo := 'ARE61098';
        
        PurchRcptLine.SETRANGE("Document No.",PurchRcptNo);
        PurchRcptLine.SETFILTER(Quantity,'=%1',0);
        PurchRcptLine.FINDSET;
        REPEAT
        */
        ACONo := 'ACO-37719';
        PurchaseLine.GET(PurchaseLine."Document Type"::Order, ACONo, 20000);

        //PurchaseLine."Quantity Invoiced"   := 0;
        //PurchaseLine."Qty. Invoiced (Base)" := 0;
        //PurchaseLine.VALIDATE("Qty. to Receive",0);



        PurchaseLine."Quantity Received" := 0;//PurchRcptLine.Quantity;
        PurchaseLine."Qty. Received (Base)" := 0;// PurchRcptLine.Quantity;

        PurchaseLine."Quantity Invoiced" := 0;//PurchRcptLine.Quantity;
        PurchaseLine."Qty. Invoiced (Base)" := 0;//PurchRcptLine.Quantity;


        PurchaseLine."Outstanding Quantity" := PurchaseLine.Quantity;//- PurchaseLine."Quantity Received";
        PurchaseLine."Outstanding Qty. (Base)" := PurchaseLine.Quantity;//- PurchaseLine."Quantity Received";

        //PurchaseLine."Outstanding Quantity" := 0;
        // PurchaseLine."Outstanding Qty. (Base)" := 0;



        PurchaseLine.InitOutstandingAmount();
        PurchaseLine.MODIFY;

        //UNTIL PurchRcptLine.NEXT = 0;
        MESSAGE('OK');

    end;
}

