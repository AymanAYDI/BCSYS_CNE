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
            field("BC6_Standard Cost"; Rec."Standard Cost")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Real standard Cost', Comment = 'FRA="Coût standard réel"';
                Visible = ShowRealProfit;
            }
            field(BC6_IncrStandardCost; IncrStandardCost)
            {
                ApplicationArea = All;
                Caption = 'Real Unit Cost', Comment = 'FRA="Coût standard"';
            }
            field("BC6_Unit Cost"; Rec."Unit Cost")
            {
                applicationArea = Basic, Suite;
                Caption = 'Real Unit Cost', Comment = 'FRA="Coût unitaire réel"';
                visible = ShowRealProfit;
            }
            field(BC6_IncrUnitCost; IncrUnitCost)
            {
                ApplicationArea = All;
                Caption = 'Unit Cost', Comment = 'FRA="Coût unitaire"';
            }
        }
        addafter("Indirect Cost %")
        {
            field("BC6_Last Direct Cost"; Rec."Last Direct Cost")
            {
                ApplicationArea = Basic, Suite;
                caption = 'Real Last Direct Cost', Comment = 'FRA="Dernier coût direct réel"';
                Visible = ShowRealProfit;
            }
            field(BC6_IncrLastDirectCost; IncrLastDirectCost)
            {
                ApplicationArea = All;
                Caption = 'Last Direct Cost', Comment = 'FRA="Dernier coût direct"';
            }
            field("BC6_Profit %"; Rec."Profit %")
            {
                ApplicationArea = All;
                caption = 'Real Profit %', Comment = 'FRA="% marge sur vente réel"';
                visible = ShowRealProfit;
            }
            field(BC6_IncrProfit; IncrProfit)
            {
                ApplicationArea = All;
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
        IncrStandardCost := ROUND(Rec."Standard Cost" + (Rec."Standard Cost" * Rec."BC6_Cost Increase Coeff %" / 100));
        IncrUnitCost := ROUND(Rec."Unit Cost" + (Rec."Unit Cost" * Rec."BC6_Cost Increase Coeff %" / 100));
        IncrLastDirectCost := ROUND(Rec."Last Direct Cost" + (Rec."Last Direct Cost" * Rec."BC6_Cost Increase Coeff %" / 100));
        IF Rec."Unit Price" <> 0 THEN
            IncrProfit := 100 * (1 - (IncrStandardCost / Rec."Unit Price"))
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
