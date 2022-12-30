pageextension 50045 "BC6_PostedSalesInvoices" extends "Posted Sales Invoices" //143
{
    layout
    {
        addafter("No.")
        {
            field("BC6_User ID"; "User ID")
            {
                Visible = BooGUserIDVisible;
            }
        }
        addafter("Amount")
        {
            field("BC6_DecGProfit%"; "DecGProfit%")
            {
                Caption = 'profit %', comment = 'FRA="% Marge"';
                Visible = BooGProfitpctVisible;
            }
            field(BC6_DecGPurchCost; DecGPurchCost)
            {
                Caption = 'Purchase Cost', comment = 'FRA="Coût d''achat"';
                Visible = BooGpurchasecostVisible;
            }
            field(BC6_DecGProfitAmount; DecGProfitAmount)
            {
                Caption = 'Profit Amount', comment = 'FRA="Montant Marge"';
                Visible = BooGProfitAmountVisible;
            }
        }
    }

    var
        RecGSalesSetup: Record "Sales & Receivables Setup";
        RecGSalesInvLine: Record "Sales Invoice Line";
        RecGUserSeup: Record "User Setup";
        [InDataSet]
        BooGProfitAmountVisible: Boolean;
        [InDataSet]
        BooGProfitpctVisible: Boolean;
        [InDataSet]
        BooGpurchasecostVisible: Boolean;
        [InDataSet]
        BooGUserIDVisible: Boolean;
        DecGAmountHT: Decimal;
        "DecGProfit%": Decimal;
        DecGProfitAmount: Decimal;
        DecGPurchCost: Decimal;

    trigger OnAfterGetRecord()
    var
    begin
        hideuser();
        calcprofit();
    end;

    trigger OnOpenPage()
    begin
        IF NOT FINDFIRST() THEN
            INIT();
        IF NOT RecGUserSeup.GET(USERID) THEN
            RecGUserSeup.INIT();
        IF RecGUserSeup."BC6_Limited User" THEN BEGIN
            FILTERGROUP(2);
            SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSeup."Salespers./Purch. Code" + '*');
            FILTERGROUP(0);
        END;
    end;

    procedure hideuser()
    var
        reclmembers: Record "Access Control";
    begin
        RecGSalesSetup.GET();
        RecGSalesSetup.TESTFIELD("BC6_allow Profit% to");
        reclmembers.SETRANGE("User Security ID", USERSECURITYID());

        reclmembers.SETRANGE(reclmembers."Role ID", RecGSalesSetup."BC6_allow Profit% to");
        IF reclmembers.FindFirst() THEN BEGIN

            BooGUserIDVisible := TRUE;
            BooGProfitpctVisible := TRUE;
            BooGpurchasecostVisible := TRUE;
            BooGProfitAmountVisible := TRUE;
        END
        ELSE BEGIN
            BooGUserIDVisible := FALSE;
            BooGProfitpctVisible := FALSE;
            BooGpurchasecostVisible := FALSE;
            BooGProfitAmountVisible := FALSE;
        END;
    end;

    procedure calcprofit()
    begin
        DecGPurchCost := 0;
        DecGAmountHT := 0;

        RecGSalesInvLine.RESET();
        RecGSalesInvLine.SETFILTER("Document No.", '%1', "No.");
        IF RecGSalesInvLine.FindFirst() THEN
            REPEAT
                DecGPurchCost += RecGSalesInvLine.Quantity * RecGSalesInvLine."BC6_Purchase Cost";
                DecGAmountHT += RecGSalesInvLine.Quantity * RecGSalesInvLine."BC6_Discount Unit Price";
            UNTIL RecGSalesInvLine.NEXT() = 0;

        DecGProfitAmount := DecGAmountHT - DecGPurchCost;

        IF DecGAmountHT <> 0 THEN
            "DecGProfit%" := 100 * DecGProfitAmount / DecGAmountHT
        ELSE
            "DecGProfit%" := 0;
    end;
}
