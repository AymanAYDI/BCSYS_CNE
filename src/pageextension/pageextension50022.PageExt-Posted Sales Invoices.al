pageextension 50022 pageextension50022 extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Control 2")
        {
            field("User ID"; "User ID")
            {
                Visible = BooGUserIDVisible;
            }
        }
        addafter("Control 13")
        {
            field("DecGProfit%"; "DecGProfit%")
            {
                Caption = 'profit %';
                Visible = BooGProfitpctVisible;
            }
            field(DecGPurchCost; DecGPurchCost)
            {
                Caption = 'Purchase Cost';
                Visible = BooGpurchasecostVisible;
            }
            field(DecGProfitAmount; DecGProfitAmount)
            {
                Caption = 'Profit Amount';
                Visible = BooGProfitAmountVisible;
            }
        }
    }

    var
        "-MIGNAV2013-": Integer;
        SalesInvHeader: Record "112";
        "DecGProfit%": Decimal;
        DecGProfitAmount: Decimal;
        DecGPurchCost: Decimal;
        RecGSalesInvLine: Record "113";
        DecGAmountHT: Decimal;
        RecGSalesSetup: Record "311";
        [InDataSet]
        BooGUserIDVisible: Boolean;
        [InDataSet]
        BooGProfitpctVisible: Boolean;
        [InDataSet]
        BooGpurchasecostVisible: Boolean;
        [InDataSet]
        BooGProfitAmountVisible: Boolean;
        RecGUserSeup: Record "91";


        //Unsupported feature: Code Modification on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DocExchStatusStyle := GetDocExchStatusStyle;

        SalesInvoiceHeader.COPYFILTERS(Rec);
        SalesInvoiceHeader.SETFILTER("Document Exchange Status",'<>%1',"Document Exchange Status"::"Not Sent");
        DocExchStatusVisible := NOT SalesInvoiceHeader.ISEMPTY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5

        //>>MIGRATION NAV 2013
        //>>FE019
        hideuser;
        calcprofit;
        //<<FE019
        //<<MIGRATION NAV 2013
        */
        //end;


        //Unsupported feature: Code Modification on "OnOpenPage".

        //trigger OnOpenPage()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SetSecurityFilterOnRespCenter;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsOfficeAddin := OfficeMgt.IsAvailable;
        IsFoundationEnabled := ApplicationAreaSetup.IsFoundationEnabled;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        //>>MIGRATION CNE 2013
        IF NOT FINDFIRST THEN
          INIT;
        //<<MIGRATION CNE 2013

        //>>P24233_001 SOBI APA 02/02/17
        IF NOT RecGUserSeup.GET(USERID) THEN
           RecGUserSeup.INIT;
        IF RecGUserSeup."Limited User" THEN BEGIN
          FILTERGROUP(2);
          SETFILTER("Salesperson Filter",'*'+RecGUserSeup."Salespers./Purch. Code"+'*');
          FILTERGROUP(0);
        END;
        //<<P24233_001 SOBI APA 02/02/17
        */
        //end;

    procedure "---MIGNAV2013---"()
    begin
    end;

    procedure hideuser()
    var
        reclmembers: Record "2000000053";
    begin
        //>>FE019 point todo 48
        RecGSalesSetup.GET;
        RecGSalesSetup.TESTFIELD("allow Profit% to");
        //<<FE019 point todo 48

        //<<MIGRATION NAV 2013
        //OLD: reclmembers.SETRANGE(reclmembers."User ID",USERID) ;
        reclmembers.SETRANGE("User Security ID", USERSECURITYID);
        //<<MIGRATION NAV 2013

        //>>FE019 point todo 48
        //reclmembers.SETRANGE(reclmembers."Role ID",'SUPER') ;
        reclmembers.SETRANGE(reclmembers."Role ID", RecGSalesSetup."allow Profit% to");
        //<<FE019 point todo 48
        IF reclmembers.FIND('-') THEN BEGIN

            //>>MIGRATION NAV 2013
            //CurrForm."User ID".VISIBLE(TRUE);
            //CurrForm.Profitpct.VISIBLE(TRUE);
            //CurrForm.purchasecost.VISIBLE(TRUE);
            //CurrForm.ProfitAmount.VISIBLE(TRUE);
            BooGUserIDVisible := TRUE;
            BooGProfitpctVisible := TRUE;
            BooGpurchasecostVisible := TRUE;
            BooGProfitAmountVisible := TRUE;
            //<<MIGRATION NAV 2013

        END
        ELSE BEGIN
            //>>MIGRATION NAV 2013
            //CurrForm."User ID".VISIBLE(FALSE);
            //CurrForm.Profitpct.VISIBLE(FALSE);
            //CurrForm.purchasecost.VISIBLE(FALSE);
            //CurrForm.ProfitAmount.VISIBLE(FALSE);
            BooGUserIDVisible := FALSE;
            BooGProfitpctVisible := FALSE;
            BooGpurchasecostVisible := FALSE;
            BooGProfitAmountVisible := FALSE;
            //<<MIGRATION NAV 2013

        END;
    end;

    procedure calcprofit()
    begin
        //CALCFIELDS("Purchase cost");
        DecGPurchCost := 0;
        DecGAmountHT := 0;

        RecGSalesInvLine.RESET;
        //>>FE019 TDL 80 SEDU 08/03/2007
        //RecGSalesInvLine.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");
        //<<FE019 TDL 80 SEDU 08/03/2007

        RecGSalesInvLine.SETFILTER("Document No.", '%1', "No.");
        IF RecGSalesInvLine.FIND('-') THEN
            REPEAT
                DecGPurchCost += RecGSalesInvLine.Quantity * RecGSalesInvLine."Purchase Cost";
                DecGAmountHT += RecGSalesInvLine.Quantity * RecGSalesInvLine."Discount Unit Price";
            UNTIL RecGSalesInvLine.NEXT = 0;

        DecGProfitAmount := DecGAmountHT - DecGPurchCost;

        IF DecGAmountHT <> 0 THEN
            "DecGProfit%" := 100 * DecGProfitAmount / DecGAmountHT
        ELSE
            "DecGProfit%" := 0;
    end;
}

