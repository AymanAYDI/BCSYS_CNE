pageextension 50140 pageextension50140 extends "Sales Quote Subform"
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
        addafter("Control 24")
        {
            field("Bin Code"; "Bin Code")
            {
            }
        }
        addafter("Control 10")
        {
            field("Item Disc. Group"; "Item Disc. Group")
            {
                Editable = false;
            }
            field("Dispensation No."; "Dispensation No.")
            {
                Editable = false;
            }
            field("Additional Discount %"; "Additional Discount %")
            {
                Editable = false;
            }
            field("Dispensed Purchase Cost"; "Dispensed Purchase Cost")
            {
                Editable = false;
            }
            field("Standard Net Price"; "Standard Net Price")
            {
                Editable = false;
            }
        }
        addafter("Control 18")
        {
            field("Purchase cost"; "Purchase cost")
            {
                Caption = 'Real purchase cost';
                Visible = ShowRealProfit;

                trigger OnValidate()
                begin
                    //BCSYS - MM
                    UpdateIncreasedFields;
                    //FIN BCSYS - MM
                end;
            }
            field("Increase Purchase cost"; IncrPurchCost)
            {
                Caption = 'Purchase cost';

                trigger OnValidate()
                begin
                    ValidateIncreasePurchCost(IncrPurchCost);
                    //BC6 - MM 070319 >>
                    UpdateIncreasedFields;
                    //BC6 - MM 070319 <<
                end;
            }
        }
        addafter("Control 38")
        {
            field("Public Price"; "Public Price")
            {
            }
        }
        addafter("Control 16")
        {
            field("Discount unit price"; "Discount unit price")
            {
            }
        }
        addafter("Control 64")
        {
            field("Profit %"; "Profit %")
            {
                Caption = 'Real profit %';
                Visible = ShowRealProfit;

                trigger OnValidate()
                begin
                    //BCSYS - MM
                    UpdateIncreasedFields;
                    //FIN BCSYS - MM
                end;
            }
            field("Increase Profit %"; IncrProfit)
            {
                Caption = 'Profit %';

                trigger OnValidate()
                begin
                    ValidateIncreaseProfit(IncrProfit, IncrPurchCost);
                    //BC6 - MM 070319 >>
                    UpdateIncreasedFields;
                    //BC6 - MM 070319 <<
                end;
            }
        }
        addafter("Control 54")
        {
            field("Purchasing Code"; "Purchasing Code")
            {
            }
        }
        addafter("Control 310")
        {
            field("DEEE Unit Price"; "DEEE Unit Price")
            {
            }
            field("DEEE HT Amount"; "DEEE HT Amount")
            {
            }
            field("DEEE Unit Price (LCY)"; "DEEE Unit Price (LCY)")
            {
            }
            field("DEEE VAT Amount"; "DEEE VAT Amount")
            {
            }
            field("DEEE TTC Amount"; "DEEE TTC Amount")
            {
            }
            field("DEEE HT Amount (LCY)"; "DEEE HT Amount (LCY)")
            {
            }
            field("Eco partner DEEE"; "Eco partner DEEE")
            {
            }
        }
    }

    var
        IncrPurchCost: Decimal;
        IncrProfit: Decimal;
        [InDataSet]
        ShowRealProfit: Boolean;
        UserSetup: Record "91";


        //Unsupported feature: Code Modification on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);

        //BCSYS - MM
        UpdateIncreasedFields;
        //FIN BCSYS - MM
        */
        //end;


        //Unsupported feature: Code Insertion on "OnModifyRecord".

        //trigger OnModifyRecord(): Boolean
        //begin
        /*
        //BC6 - MM 070319 >>
        UpdateIncreasedFields;
        //BC6 - MM 070319 <<
        */
        //end;


        //Unsupported feature: Code Modification on "OnNewRecord".

        //trigger OnNewRecord(BelowxRec: Boolean)
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ApplicationAreaSetup.IsFoundationEnabled THEN
          Type := Type::Item
        ELSE
          InitType;

        CLEAR(ShortcutDimCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6

        //BC6 - MM 060319 >>
        IncrProfit := 0;
        IncrPurchCost := 0;
        //BC6 - MM 060319 <<
        */
        //end;


        //Unsupported feature: Code Insertion on "OnOpenPage".

        //trigger OnOpenPage()
        //begin
        /*
        //BC6>>
        ShowRealProfit := FALSE;
        IF UserSetup.GET(USERID) THEN
          IF UserSetup."Aut. Real Sales Profit %" THEN
            ShowRealProfit := TRUE;
        //BC6<<
        */
        //end;

    local procedure UpdateIncreasedFields()
    begin
        //BC6>>
        IF Type = Type::Item THEN BEGIN
            CalcIncreasePurchCost(IncrPurchCost);
            CalcIncreaseProfit(IncrProfit, IncrPurchCost);
        END ELSE BEGIN
            IncrPurchCost := 0;
            IncrProfit := 0;
        END;
    end;
}

