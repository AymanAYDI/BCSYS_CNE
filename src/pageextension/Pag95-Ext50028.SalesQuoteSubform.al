pageextension 50028 "BC6_SalesQuoteSubform" extends "Sales Quote Subform" //95
{
    layout
    {


        addafter("Location Code")
        {
            field("BC6_Bin Code"; Rec."Bin Code")
            {
            }
        }
        addafter("Unit of Measure")
        {
            field("BC6_Item Disc. Group"; Rec."BC6_Item Disc. Group")
            {
                Editable = false;
            }
            field("BC6_Dispensation No."; Rec."BC6_Dispensation No.")
            {
                Editable = false;
            }
            field("BC6_Additional Discount %"; Rec."BC6_Additional Discount %")
            {
                Editable = false;
            }
            field("BC6_Dispensed Purchase Cost"; Rec."BC6_Dispensed Purchase Cost")
            {
                Editable = false;
            }
            field("BC6_Standard Net Price"; Rec."BC6_Standard Net Price")
            {
                Editable = false;
            }
        }
        addafter("Unit Cost (LCY)")
        {
            field("BC6_Purchase cost"; Rec."BC6_Purchase cost")
            {
                Caption = 'Real purchase cost', Comment = 'FRA="Coût d''achat réel"';
                Visible = ShowRealProfit;

                trigger OnValidate()
                begin
                    UpdateIncreasedFields();
                end;
            }
            field("BC6_Increase Purchase cost"; IncrPurchCost)
            {
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
            }
        }
        addafter("Line Discount %")
        {
            field("BC6_Discount unit price"; Rec."BC6_Discount unit price")
            {
            }
        }
        addafter("Line Discount Amount")
        {
            field("BC6_Profit %"; Rec."Profit %")
            {
                Caption = 'Real profit %', comment = 'FRA="% marge sur vente réel"';
                Visible = ShowRealProfit;

                trigger OnValidate()
                begin
                    UpdateIncreasedFields();
                end;
            }
            field("BC6_Increase Profit %"; IncrProfit)
            {
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
            }
        }
        addafter("ShortcutDimCode8")
        {
            field("BC6_DEEE Unit Price"; Rec."BC6_DEEE Unit Price")
            {
            }
            field("BC6_DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
            {
            }
            field("BC6_DEEE Unit Price (LCY)"; Rec."BC6_DEEE Unit Price (LCY)")
            {
            }
            field("BC6_DEEE VAT Amount"; Rec."BC6_DEEE VAT Amount")
            {
            }
            field("BC6_DEEE TTC Amount"; Rec."BC6_DEEE TTC Amount")
            {
            }
            field("BC6_DEEE HT Amount (LCY)"; Rec."BC6_DEEE HT Amount (LCY)")
            {
            }
            field("BC6_Eco partner DEEE"; Rec."BC6_Eco partner DEEE")
            {
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

