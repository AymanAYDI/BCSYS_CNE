pageextension 50115 "BC6_ItemInvoicingFactBox" extends "Item Invoicing FactBox" //9089
{
    layout
    {
        modify("Standard Cost")
        {
            visible = false;
        }
        modify("Unit Cost")
        {
            visible = false;
        }
        modify("Last Direct Cost")
        {
            visible = false;
        }
        modify("Profit %")
        {
            Visible = false;
        }
        addafter("Cost is Posted to G/L")
        {
            field("BC6_Standard Cost"; "Standard Cost")
            {
                Caption = 'Real standard Cost', Comment = 'FRA="Coût standard réel"';
                Visible = ShowRealProfit;
                ApplicationArea = Basic, Suite;
            }
            field(BC6_IncrStandardCost; IncrStandardCost)
            {
                Caption = 'Real Unit Cost', Comment = 'FRA="Coût standard"';
            }
            field("BC6_Unit Cost"; "Unit Cost")
            {
                Caption = 'Real Unit Cost', Comment = 'FRA="Coût unitaire réel"';
                visible = ShowRealProfit;
                applicationArea = Basic, Suite;
            }
            field(BC6_IncrUnitCost; IncrUnitCost)
            {
                Caption = 'Unit Cost', Comment = 'FRA="Coût unitaire"';
            }

        }
        addafter("Indirect Cost %")
        {
            field("BC6_Last Direct Cost"; "Last Direct Cost")
            {

                caption = 'Real Last Direct Cost', Comment = 'FRA="Dernier coût direct réel"';
                Visible = ShowRealProfit;
                ApplicationArea = Basic, Suite;
            }
            field(BC6_IncrLastDirectCost; IncrLastDirectCost)
            {
                Caption = 'Last Direct Cost', Comment = 'FRA="Dernier coût direct"';
            }
            field("BC6_Profit %"; "Profit %")
            {
                caption = 'Real Profit %', Comment = 'FRA="% marge sur vente réel"';
                visible = ShowRealProfit;
            }
            field(BC6_IncrProfit; IncrProfit)
            {
                caption = 'Profit %', Comment = 'FRA="% marge sur vente"';
            }

        }
    }
    trigger OnOpenPage()
    begin
        IF UserSetup.GET(USERID) THEN
            IF UserSetup."BC6_Aut. Real Sales Profit %" THEN
                ShowRealProfit := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        IncrStandardCost := ROUND("Standard Cost" + ("Standard Cost" * "BC6_Cost Increase Coeff %" / 100));
        IncrUnitCost := ROUND("Unit Cost" + ("Unit Cost" * "BC6_Cost Increase Coeff %" / 100));
        IncrLastDirectCost := ROUND("Last Direct Cost" + ("Last Direct Cost" * "BC6_Cost Increase Coeff %" / 100));
        IF "Unit Price" <> 0 THEN
            IncrProfit := 100 * (1 - (IncrStandardCost / "Unit Price"))
        ELSE
            IncrProfit := 0;
    end;

    VAR
        UserSetup: Record "User Setup";
        ShowRealProfit: Boolean;
        IncrLastDirectCost: Decimal;
        IncrProfit: Decimal;
        IncrStandardCost: Decimal;
        IncrUnitCost: Decimal;
}
