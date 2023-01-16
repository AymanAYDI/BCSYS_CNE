pageextension 50028 "BC6_SalesQuoteSubform" extends "Sales Quote Subform" //95
{
    layout
    {
        addafter("Location Code")
        {
            field("BC6_Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure")
        {
            field("BC6_Item Disc. Group"; Rec."BC6_Item Disc. Group")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BC6_Dispensation No."; Rec."BC6_Dispensation No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BC6_Additional Discount %"; Rec."BC6_Additional Discount %")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BC6_Dispensed Purchase Cost"; Rec."BC6_Dispensed Purchase Cost")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("BC6_Standard Net Price"; Rec."BC6_Standard Net Price")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Unit Cost (LCY)")
        {
            field("BC6_Purchase cost"; Rec."BC6_Purchase cost")
            {
                ApplicationArea = All;
                Caption = 'Real purchase cost', Comment = 'FRA="Coût d''achat réel"';
                Visible = ShowRealProfit;

                trigger OnValidate()
                begin
                    UpdateIncreasedFields();
                end;
            }
            field("BC6_Increase Purchase cost"; IncrPurchCost)
            {
                ApplicationArea = All;
                Caption = 'Purchase cost', comment = 'FRA="Coût d''achat"';

                trigger OnValidate()
                begin
                    Rec.ValidateIncreasePurchCost(IncrPurchCost);
                    UpdateIncreasedFields();
                end;
            }
        }
        addafter(PriceExists)
        {
            field("BC6_Public Price"; Rec."BC6_Public Price")
            {
                ApplicationArea = All;
            }
        }
        addafter("Line Discount %")
        {
            field("BC6_Discount unit price"; Rec."BC6_Discount unit price")
            {
                ApplicationArea = All;
            }
        }
        addafter("Line Discount Amount")
        {
            field("BC6_Profit %"; Rec."Profit %")
            {
                ApplicationArea = All;
                Caption = 'Real profit %', comment = 'FRA="% marge sur vente réel"';
                Visible = ShowRealProfit;

                trigger OnValidate()
                begin
                    UpdateIncreasedFields();
                end;
            }
            field("BC6_Increase Profit %"; IncrProfit)
            {
                ApplicationArea = All;
                Caption = 'Profit %', comment = 'FRA="% marge sur vente"';

                trigger OnValidate()
                begin
                    Rec.ValidateIncreaseProfit(IncrProfit, IncrPurchCost);
                    UpdateIncreasedFields();
                end;
            }
        }
        addafter("Allow Item Charge Assignment")
        {
            field("BC6_Purchasing Code"; Rec."Purchasing Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("ShortcutDimCode8")
        {
            field("BC6_DEEE Unit Price"; Rec."BC6_DEEE Unit Price")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE Unit Price (LCY)"; Rec."BC6_DEEE Unit Price (LCY)")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE VAT Amount"; Rec."BC6_DEEE VAT Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE TTC Amount"; Rec."BC6_DEEE TTC Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount (LCY)"; Rec."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
            }
            field("BC6_Eco partner DEEE"; Rec."BC6_Eco partner DEEE")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        [InDataSet]
        ShowRealProfit: Boolean;
        IncrProfit: Decimal;
        IncrPurchCost: Decimal;

    trigger OnOpenPage()
    begin
        ShowRealProfit := FALSE;
        IF UserSetup.GET(USERID) THEN
            IF UserSetup."BC6_Aut. Real Sales Profit %" THEN
                ShowRealProfit := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IncrProfit := 0;
        IncrPurchCost := 0;
    end;

    trigger OnAfterGetRecord()
    var
    begin
        UpdateIncreasedFields();
    end;

    procedure UpdateIncreasedFields()
    begin
        IF Rec.Type = Rec.Type::Item THEN BEGIN
            Rec.CalcIncreasePurchCost(IncrPurchCost);
            Rec.CalcIncreaseProfit(IncrProfit, IncrPurchCost);
        END ELSE BEGIN
            IncrPurchCost := 0;
            IncrProfit := 0;
        END;
    end;
}
