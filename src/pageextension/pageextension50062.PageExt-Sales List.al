pageextension 50062 pageextension50062 extends "Sales List"
{
    layout
    {
        addfirst("Control 1")
        {
            field("Order Date"; "Order Date")
            {
            }
        }
        addafter("Control 17")
        {
            field("Your Reference"; "Your Reference")
            {
            }
            field("Requested Delivery Date"; "Requested Delivery Date")
            {
            }
            field("Promised Delivery Date"; "Promised Delivery Date")
            {
            }
            field(Ship; Ship)
            {
                Caption = 'Ship';
            }
            field(Invoice; Invoice)
            {
                Caption = 'Invoice';
            }
            field(ID; ID)
            {
                Visible = BooGID;
            }
        }
        addafter("Control 123")
        {
            field("Bin Code"; "Bin Code")
            {
            }
        }
        addafter("Control 99")
        {
            field(purchcost; DecGPurchCost)
            {
                Caption = 'Purchase Cost';
                Visible = BooGPurchcost;
            }
            field(profitamount; DecGProfitAmount)
            {
                Caption = 'Profit Amount';
                Visible = BooGProfitamount;
            }
            field(profitpct; "DecGProfit%")
            {
                Caption = 'Profit %';
                Visible = BooGProfitpct;
            }
        }
        addafter("Control 5")
        {
            field("Amount Including VAT"; "Amount Including VAT")
            {
            }
        }
    }

    var
        "- MIGNAV2013 -": Integer;
        "DecGProfit%": Decimal;
        DecGProfitAmount: Decimal;
        DecGPurchCost: Decimal;
        RecGSalesLine: Record "37";
        DecGAmountHT: Decimal;
        RecGSalesSetup: Record "311";
        [InDataSet]
        BooGID: Boolean;
        [InDataSet]
        BooGPurchcost: Boolean;
        BooGProfitamount: Boolean;
        BooGProfitpct: Boolean;


        //Unsupported feature: Code Insertion on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //begin
        /*
        //>>FE019
        hideuser;
        calcprofit;
        //<<FE019
        */
        //end;

    procedure "----NSC1,0---"()
    begin
    end;

    procedure hideuser()
    var
        RecLAccessControl: Record "2000000053";
    begin
        //>>FE019 point todo 48
        RecGSalesSetup.GET;
        RecGSalesSetup.TESTFIELD("allow Profit% to");
        //<<FE019 point todo 48
        //>>MIGRATION NAV 2013
        //OLD
        /*
        reclmembers.SETRANGE(reclmembers."User ID",USERID) ;
        //>>FE019 point todo 48
        //reclmembers.SETRANGE(reclmembers."Role ID",'SUPER') ;
        reclmembers.SETRANGE(reclmembers."Role ID",RecGSalesSetup."allow Profit% to") ;
        //<<FE019 point todo 48
        IF reclmembers.FIND('-') THEN BEGIN
          CurrForm.ID.VISIBLE(TRUE);
          CurrForm.purchcost.VISIBLE(TRUE);
          CurrForm.profitamount.VISIBLE(TRUE);
          CurrForm.profitpct.VISIBLE(TRUE);
        END
        ELSE
        BEGIN
          CurrForm.ID.VISIBLE(FALSE);
          CurrForm.purchcost.VISIBLE(FALSE);
          CurrForm.profitamount.VISIBLE(FALSE);
          CurrForm.profitpct.VISIBLE(FALSE);
        END;
        */
        //NEW
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID);
        RecLAccessControl.SETRANGE("Role ID", RecGSalesSetup."allow Profit% to");
        IF RecLAccessControl.FINDFIRST THEN BEGIN
            BooGID := TRUE;
            BooGPurchcost := TRUE;
            BooGProfitamount := TRUE;
            BooGProfitpct := TRUE;
        END
        ELSE BEGIN
            BooGID := FALSE;
            BooGPurchcost := FALSE;
            BooGProfitamount := FALSE;
            BooGProfitpct := FALSE;
        END;
        //<<MIGRATION NAV 2013

    end;

    procedure calcprofit()
    begin
        //CALCFIELDS("Purchase cost");

        DecGPurchCost := 0;
        DecGAmountHT := 0;

        RecGSalesLine.RESET;
        RecGSalesLine.SETFILTER("Document Type", '%1', "Document Type");
        RecGSalesLine.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");
        RecGSalesLine.SETFILTER("Document No.", '%1', "No.");
        IF RecGSalesLine.FIND('-') THEN
            REPEAT
                DecGPurchCost += RecGSalesLine.Quantity * RecGSalesLine."Purchase cost";
                DecGAmountHT += RecGSalesLine.Quantity * RecGSalesLine."Discount unit price";
            UNTIL RecGSalesLine.NEXT = 0;

        DecGProfitAmount := DecGAmountHT - DecGPurchCost;

        IF DecGAmountHT <> 0 THEN
            "DecGProfit%" := 100 * DecGProfitAmount / DecGAmountHT
        ELSE
            "DecGProfit%" := 0;
    end;
}

