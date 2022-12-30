pageextension 50018 "BC6_SalesOrderSubform" extends "Sales Order Subform" //46
{


    layout
    {

        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        addafter("No.")
        {
            field("BC6_Dispensation No."; "BC6_Dispensation No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Additional Discount %"; "BC6_Additional Discount %")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Dispensed Purchase Cost"; "BC6_Dispensed Purchase Cost")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Standard Net Price"; "BC6_Standard Net Price")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Item Disc. Group"; "BC6_Item Disc. Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Purchasing Code"; "Purchasing Code")
            {
                ToolTip = 'Specifies the purchasing code for the item.', Comment = 'FRA="Spécifie le code achat pour l''article."';
                Visible = false;
                ApplicationArea = All;
            }
        }






        addafter("Unit of Measure Code")
        {
            field("BC6_Purchase cost"; "BC6_Purchase cost")
            {
                Caption = 'Real purchase cost', Comment = 'FRA="Coût d''achat réel"';
                Visible = ShowRealProfit;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    UpdateIncreasedFields();
                end;
            }
            field("BC6_Increase Purchase cost"; IncrPurchCost)
            {
                Caption = 'Purchase cost', Comment = 'FRA="Coût d''achat"';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    ValidateIncreasePurchCost(IncrPurchCost);
                    UpdateIncreasedFields();
                end;
            }
            field("BC6_Public Price"; "BC6_Public Price")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE Category Code"; "BC6_DEEE Category Code")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Eco partner DEEE"; "BC6_Eco partner DEEE")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_DEEE Unit Price"; "BC6_DEEE Unit Price")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount"; "BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE VAT Amount"; "BC6_DEEE VAT Amount")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_DEEE TTC Amount"; "BC6_DEEE TTC Amount")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount (LCY)"; "BC6_DEEE HT Amount (LCY)")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }


        addafter("Line Amount")
        {
            field("BC6_Profit %"; "Profit %")
            {
                Caption = 'Real profit %', Comment = 'FRA="% marge sur vente réel"';
                Visible = ShowRealProfit;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    UpdateIncreasedFields();
                end;
            }
            field("BC6_Increase Profit %"; IncrProfit)
            {
                Caption = 'Profit %', Comment = 'FRA="% marge sur vente"';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    ValidateIncreaseProfit(IncrProfit, IncrPurchCost);
                    UpdateIncreasedFields();
                end;
            }

        }






        addafter("Line Discount %")
        {
            field("BC6_Discount unit price"; "BC6_Discount unit price")
            {
                ApplicationArea = All;
            }
        }





        addafter("Qty. to Ship")
        {
            field("BC6_Pick Qty."; "BC6_Pick Qty.")
            {
                ApplicationArea = All;
            }
        }



        addafter("Qty. Assigned")
        {
            field("BC6_Purchase Receipt Date"; "BC6_Purchase Receipt Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Promised Purchase Receipt Date"; "BC6_Prom. Purch. Receipt Date")
            {
                Editable = false;
                ApplicationArea = All;
            }

        }





        addafter("Shipment Date")
        {
            field("BC6_Invoiced Date (Expected)"; "BC6_Invoiced Date (Expected)")
            {
                ApplicationArea = All;
            }
        }



        addafter("Shortcut Dimension 2 Code")
        {
            field("BC6_To Prepare"; "BC6_To Prepare")
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
        }





        addafter(ShortcutDimCode8)
        {
            field("BC6_Purch. Document Type"; "BC6_Purch. Document Type")
            {
                ApplicationArea = All;
            }
            field("BC6_Purch. Order No."; "BC6_Purch. Order No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Purch. Line No."; "BC6_Purch. Line No.")
            {
                ApplicationArea = All;
            }
        }


    }

    trigger OnAfterGetRecord()
    begin
        UpdateIncreasedFields();

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

    trigger OnModifyRecord(): Boolean
    begin
        UpdateIncreasedFields()
    end;


    var
        UserSetup: Record "User Setup";
        ShowRealProfit: Boolean;
        IncrProfit: Decimal;
        IncrPurchCost: Decimal;


    procedure UpdateIncreasedFields()
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

