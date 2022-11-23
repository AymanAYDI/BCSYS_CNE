pageextension 50129 pageextension50129 extends "Sales Order List"
{

    //Unsupported feature: Property Modification (SourceTableView) on ""Sales Order List"(Page 9305)".

    layout
    {
        modify("Control 16")
        {
            Visible = false;
        }
        modify("Control 28")
        {
            Visible = false;
        }
        addafter("Control 5")
        {
            field(ID; ID)
            {
            }
            field("Your Reference"; "Your Reference")
            {
            }
            field("Affair No."; "Affair No.")
            {
            }
            field(Amount; Amount)
            {
            }
            field(Profit; DecGProfit)
            {
                Caption = 'Montant marge';
                Editable = false;
                Enabled = BooGVisible;
                Visible = BooGVisible;
            }
            field("Completely Shipped"; "Completely Shipped")
            {
            }
            field("Bin Code"; "Bin Code")
            {
            }
            field(ProfitPct; DecGProfitPct)
            {
                Caption = '%age marge';
                Editable = false;
                Enabled = BooGVisible;
                Visible = BooGVisible;
            }
            field("Purchase No. Order Lien"; "Purchase No. Order Lien")
            {
                Caption = 'Purchase No. Order Lien';
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on "Action 151.OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DocPrint.PrintSalesOrder(Rec,Usage::"Order Confirmation");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //BC6 - MM 100119 >>
        CheckIfReleased();
        //BC6 - MM 100119 <<
        DocPrint.PrintSalesOrder(Rec,Usage::"Order Confirmation");
        */
        //end;
        addafter(Post)
        {
            action(PostAndPrint)
            {
                Caption = 'Post and &Print';
                Ellipsis = true;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';

                trigger OnAction()
                begin
                    Post(CODEUNIT::"Sales-Post + Print");
                end;
            }
        }
    }

    var
        "- TDL.78 -": Integer;
        DecGProfit: Decimal;
        DecGProfitPct: Decimal;
        [InDataSet]
        BooGVisible: Boolean;
        [InDataSet]
        BooGEditSalesperson: Boolean;
        RecGUserSeup: Record "91";
        SalesSetup: Record "311";


        //Unsupported feature: Code Insertion on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //begin
        /*
        //>>TDL.78
        CalcProfit();
        //<<TDL.78
        */
        //end;


        //Unsupported feature: Code Modification on "OnOpenPage".

        //trigger OnOpenPage()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
          FILTERGROUP(0);
        END;

        SETRANGE("Date Filter",0D,WORKDATE - 1);

        JobQueueActive := SalesSetup.JobQueueActive;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsOfficeAddin := OfficeMgt.IsAvailable;

        CopySellToCustomerFilter;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13

        //>>TDL.78
        IsProfitVisible();
        //<<TDL.78

        IF NOT FINDFIRST THEN
          INIT;

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

    procedure "--- TDL.78 ---"()
    begin
    end;

    procedure IsProfitVisible()
    var
        RecLSalesSetup: Record "311";
        RecLAccessCtrl: Record "2000000053";
    begin
        RecLSalesSetup.GET;
        RecLSalesSetup.TESTFIELD("allow Profit% to");

        RecLAccessCtrl.RESET;
        RecLAccessCtrl.SETRANGE("User Name", USERID);
        RecLAccessCtrl.SETRANGE("Role ID", RecLSalesSetup."allow Profit% to");
        IF NOT RecLAccessCtrl.ISEMPTY THEN
            BooGVisible := TRUE;
    end;

    procedure CalcProfit()
    var
        RecLSalesLine: Record "37";
        DecLPurchCost: Decimal;
        DecLAmount: Decimal;
    begin
        IF BooGVisible THEN BEGIN
            DecLPurchCost := 0;
            DecLAmount := 0;

            RecLSalesLine.RESET;
            RecLSalesLine.SETRANGE("Document Type", "Document Type");
            RecLSalesLine.SETRANGE("Document No.", "No.");
            IF RecLSalesLine.FINDSET THEN
                REPEAT
                    DecLPurchCost += RecLSalesLine.Quantity * RecLSalesLine."Purchase cost";
                    DecLAmount += RecLSalesLine.Quantity * RecLSalesLine."Discount unit price";
                UNTIL RecLSalesLine.NEXT = 0;

            DecGProfit := DecLAmount - DecLPurchCost;

            IF DecLAmount <> 0 THEN
                DecGProfitPct := 100 * DecGProfit / DecLAmount
            ELSE
                DecGProfitPct := 0;
        END;
    end;

    procedure CheckIfReleased()
    var
        "--- FE033.001 ---": ;
        CstL0001: Label 'Your order isn''t released, Do You want release it ?';
        CstL0002: Label 'Aborted Operation';
    begin
        //>>FE033.001
        SalesSetup.GET;
        IF SalesSetup."Active Released Printing Order" THEN
            IF Status <> Status::Released THEN
                IF CONFIRM(CstL0001) THEN BEGIN
                    CODEUNIT.RUN(414, Rec);
                    COMMIT;
                END ELSE
                    ERROR(CstL0002);
        //<<FE033.001
    end;
}

