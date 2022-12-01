pageextension 50026 "BC6_ItemInvoicingFactBox" extends "Item Invoicing FactBox" //9089
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
                Caption = 'Real standard Cost';
                Visible = ShowRealProfit;
                ApplicationArea = Basic, Suite;
            }
            field(BC6_IncrStandardCost; IncrStandardCost) { }
            field("BC6_Unit Cost"; "Unit Cost")
            {
                Caption = 'Real Unit Cost';
                visible = ShowRealProfit;
                applicationArea = Basic, Suite;
            }
            field(BC6_IncrUnitCost; IncrUnitCost)
            {
                Caption = 'Unit Cost';
            }

        }
        addafter("Indirect Cost %")
        {
            field("BC6_Last Direct Cost"; "Last Direct Cost")
            {

                caption = 'Real Last Direct Cost';
                Visible = ShowRealProfit;
                ApplicationArea = Basic, Suite;
            }
            field(BC6_IncrLastDirectCost; IncrLastDirectCost)
            {
                Caption = 'Last Direct Cost';
            }
            field("BC6_Profit %"; "Profit %")
            {
                caption = 'Real Profit %';
                visible = ShowRealProfit;
            }
            field(BC6_IncrProfit; IncrProfit)
            {
                caption = 'Profit %';
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
        IncrStandardCost: Decimal;
        IncrUnitCost: Decimal;
        IncrLastDirectCost: Decimal;
        IncrProfit: Decimal;
        ShowRealProfit: Boolean;
}
