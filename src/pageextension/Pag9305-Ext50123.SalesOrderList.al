pageextension 50123 "BC6_SalesOrderList" extends "Sales Order List" //9305
{

    //Unsupported feature: Property Modification (SourceTableView) on ""Sales Order List"(Page 9305)". TODO:

    layout
    {
        addafter("Job Queue Status")
        {
            field(BC6_ID; Rec.ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; "Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
                ApplicationArea = All;
            }
            field(BC6_Amount; Amount)
            {
                ApplicationArea = All;
            }
            field(BC6_Profit; DecGProfit)
            {
                Caption = 'Montant marge';
                Editable = false;
                Enabled = BooGVisible;
                Visible = BooGVisible;
                ApplicationArea = All;
            }
            field("BC6_Completely Shipped"; "Completely Shipped")
            {
                ApplicationArea = All;
            }
            field("BC6_Bin Code"; "BC6_Bin Code")
            {
                ApplicationArea = All;
            }
            field(BC6_ProfitPct; DecGProfitPct)
            {
                Caption = '%age marge';
                Editable = false;
                Enabled = BooGVisible;
                Visible = BooGVisible;
                ApplicationArea = All;
            }
            field("BC6_Purchase No. Order Lien"; "BC6_Purchase No. Order Lien")
            {
                Caption = 'Purchase No. Order Lien', Comment = 'FRA="Nø Commande Achat Lien"';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;

        }
        addfirst(Action3)
        {
            action("BC6_Create Inventor&y Put-away/Pick2")
            {
                AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                ApplicationArea = Warehouse;
                Caption = 'Create Inventor&y Put-away/Pick', Comment = 'FRA="Créer prélèv./rangement stoc&k"';
                Ellipsis = true;
                Image = CreateInventoryPickup;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Create an inventory put-away or inventory pick to handle items on the document according to a basic warehouse configuration that does not require warehouse receipt or shipment documents.';

                trigger OnAction()
                var
                    FunctionMgt: Codeunit "BC6_Functions Mgt";

                begin
                    FunctionMgt.CreateInvtPutAwayPick();

                    if not Find('=><') then
                        Init();
                end;
            }
        }

        addafter(Post)
        {
            action(BC6_PostAndPrint)
            {
                Caption = 'Post and &Print', Comment = 'FRA="Valider et i&mprimer"';
                Ellipsis = true;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PostDocument(CODEUNIT::"Sales-Post + Print");
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
        RecGUserSeup: Record "User Setup";
        SalesSetup: Record "Sales & Receivables Setup";

    trigger OnOpenPage()
    begin
        IsProfitVisible();

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

    trigger OnAfterGetRecord()
    begin
        CalcProfit();
    end;

    local procedure PostDocument(PostingCodeunitID: Integer)
    var
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        SendToPosting(PostingCodeunitID);

        CurrPage.Update(false);
    end;


    procedure IsProfitVisible()
    var
        RecLSalesSetup: Record "Sales & Receivables Setup";
        RecLAccessCtrl: Record "Access Control";
    begin
        RecLSalesSetup.GET();
        RecLSalesSetup.TESTFIELD("BC6_allow Profit% to");

        RecLAccessCtrl.RESET();
        RecLAccessCtrl.SETRANGE("User Name", USERID);
        RecLAccessCtrl.SETRANGE("Role ID", RecLSalesSetup."BC6_allow Profit% to");
        IF NOT RecLAccessCtrl.ISEMPTY THEN
            BooGVisible := TRUE;
    end;

    procedure CalcProfit()
    var
        RecLSalesLine: Record "Sales Line";
        DecLPurchCost: Decimal;
        DecLAmount: Decimal;
    begin
        IF BooGVisible THEN BEGIN
            DecLPurchCost := 0;
            DecLAmount := 0;

            RecLSalesLine.RESET();
            RecLSalesLine.SETRANGE("Document Type", "Document Type");
            RecLSalesLine.SETRANGE("Document No.", "No.");
            IF RecLSalesLine.FINDSET() THEN
                REPEAT
                    DecLPurchCost += RecLSalesLine.Quantity * RecLSalesLine."BC6_Purchase cost";
                    DecLAmount += RecLSalesLine.Quantity * RecLSalesLine."BC6_Discount unit price";
                UNTIL RecLSalesLine.NEXT() = 0;

            DecGProfit := DecLAmount - DecLPurchCost;

            IF DecLAmount <> 0 THEN
                DecGProfitPct := 100 * DecGProfit / DecLAmount
            ELSE
                DecGProfitPct := 0;
        END;
    end;

    procedure CheckIfReleased()
    var
        CstL0001: Label 'Your order isn''t released, Do You want release it ?', Comment = 'FRA="Votre commande n''est pas lanc‚e, souhaitez-vous la lancer ?"';
        CstL0002: Label 'Aborted Operation', Comment = 'FRA="Op‚ration interrompue"';
    begin
        SalesSetup.GET();
        IF SalesSetup."BC6_Acti. Releas. Print. Order" THEN
            IF Status <> Status::Released THEN
                IF CONFIRM(CstL0001) THEN BEGIN
                    CODEUNIT.RUN(Codeunit::"Release Sales Document", Rec);
                    COMMIT();
                END ELSE
                    ERROR(CstL0002);
    end;
}

