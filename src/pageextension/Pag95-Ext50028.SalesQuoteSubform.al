pageextension 50028 "BC6_SalesQuoteSubform" extends "Sales Quote Subform" //95
{
    layout
    {

        //Unsupported feature: Code Modification on "Control 4.OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        NoOnAfterValidate;

        IF xRec."No." <> '' THEN
          RedistributeTotalsOnAfterValidate;

        UpdateEditableOnRow;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7

        //BC6 - MM 060319 >>
        UpdateIncreasedFields;
        //BC6 - MM 060319 <<
        */
        //end;
        addafter("Location Code")
        {
            field("BC6_Bin Code"; "Bin Code")
            {
            }
        }
        addafter("Unit of Measure")
        {
            field("BC6_Item Disc. Group"; "BC6_Item Disc. Group")
            {
                Editable = false;
            }
            field("BC6_Dispensation No."; "BC6_Dispensation No.")
            {
                Editable = false;
            }
            field("BC6_Additional Discount %"; "BC6_Additional Discount %")
            {
                Editable = false;
            }
            field("BC6_Dispensed Purchase Cost"; "BC6_Dispensed Purchase Cost")
            {
                Editable = false;
            }
            field("BC6_Standard Net Price"; "BC6_Standard Net Price")
            {
                Editable = false;
            }
        }
        addafter("Unit Cost (LCY)")
        {
            field("BC6_Purchase cost"; "BC6_Purchase cost")
            {
                Caption = 'Real purchase cost';
                Visible = ShowRealProfit;

                trigger OnValidate()
                begin
                    UpdateIncreasedFields;
                end;
            }
            field("BC6_Increase Purchase cost"; IncrPurchCost)
            {
                Caption = 'Purchase cost', comment = 'FRA="Coùt d''achat"';

                trigger OnValidate()
                begin
                    ValidateIncreasePurchCost(IncrPurchCost);
                    UpdateIncreasedFields;
                end;
            }
        }
        addafter(PriceExists)
        {
            field("BC6_Public Price"; "BC6_Public Price")
            {
            }
        }
        addafter("Line Discount %")
        {
            field("BC6_Discount unit price"; "BC6_Discount unit price")
            {
            }
        }
        addafter("Line Discount Amount")
        {
            field("BC6_Profit %"; "Profit %")
            {
                Caption = 'Real profit %', comment = 'FRA="% marge sur vente réel"';
                Visible = ShowRealProfit;

                trigger OnValidate()
                begin
                    UpdateIncreasedFields;
                end;
            }
            field("BC6_Increase Profit %"; IncrProfit)
            {
                Caption = 'Profit %', comment = 'FRA="% marge sur vente"';

                trigger OnValidate()
                begin
                    ValidateIncreaseProfit(IncrProfit, IncrPurchCost);
                    UpdateIncreasedFields;
                end;
            }
        }
        addafter("Allow Item Charge Assignment")
        {
            field("BC6_Purchasing Code"; "Purchasing Code")
            {
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("BC6_DEEE Unit Price"; "BC6_DEEE Unit Price")
            {
            }
            field("BC6_DEEE HT Amount"; "BC6_DEEE HT Amount")
            {
            }
            field("BC6_DEEE Unit Price (LCY)"; "BC6_DEEE Unit Price (LCY)")
            {
            }
            field("BC6_DEEE VAT Amount"; "BC6_DEEE VAT Amount")
            {
            }
            field("BC6_DEEE TTC Amount"; "BC6_DEEE TTC Amount")
            {
            }
            field("BC6_DEEE HT Amount (LCY)"; "BC6_DEEE HT Amount (LCY)")
            {
            }
            field("BC6_Eco partner DEEE"; "BC6_Eco partner DEEE")
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

    local procedure UpdateIncreasedFields()
    begin
        IF Type = Type::Item THEN BEGIN
            CalcIncreasePurchCost(IncrPurchCost);
            CalcIncreaseProfit(IncrProfit, IncrPurchCost);
        END ELSE BEGIN
            IncrPurchCost := 0;
            IncrProfit := 0;
        END;
    end;
}

