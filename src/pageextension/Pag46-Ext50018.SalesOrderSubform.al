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
            field("BC6_Dispensation No."; Rec."BC6_Dispensation No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Additional Discount %"; Rec."BC6_Additional Discount %")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Dispensed Purchase Cost"; Rec."BC6_Dispensed Purchase Cost")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Standard Net Price"; Rec."BC6_Standard Net Price")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Item Disc. Group"; Rec."BC6_Item Disc. Group")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Purchasing Code"; Rec."Purchasing Code")
            {
                ToolTip = 'Specifies the purchasing code for the item.', Comment = 'FRA="Spécifie le code achat pour l''article."';
                Visible = false;
                ApplicationArea = All;
            }
        }






        addafter("Unit of Measure Code")
        {
            field("BC6_Purchase cost"; Rec."BC6_Purchase cost")
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
                    Rec.ValidateIncreasePurchCost(IncrPurchCost);
                    UpdateIncreasedFields();
                end;
            }
            field("BC6_Public Price"; Rec."BC6_Public Price")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE Category Code"; Rec."BC6_DEEE Category Code")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Eco partner DEEE"; Rec."BC6_Eco partner DEEE")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_DEEE Unit Price"; Rec."BC6_DEEE Unit Price")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE VAT Amount"; Rec."BC6_DEEE VAT Amount")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_DEEE TTC Amount"; Rec."BC6_DEEE TTC Amount")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount (LCY)"; Rec."BC6_DEEE HT Amount (LCY)")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }


        addafter("Line Amount")
        {
            field("BC6_Profit %"; Rec."Profit %")
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
                    Rec.ValidateIncreaseProfit(IncrProfit, IncrPurchCost);
                    UpdateIncreasedFields();
                end;
            }

        }






        addafter("Line Discount %")
        {
            field("BC6_Discount unit price"; Rec."BC6_Discount unit price")
            {
                ApplicationArea = All;
            }
        }





        addafter("Qty. to Ship")
        {
            field("BC6_Pick Qty."; Rec."BC6_Pick Qty.")
            {
                ApplicationArea = All;
            }
        }



        addafter("Qty. Assigned")
        {
            field("BC6_Purchase Receipt Date"; Rec."BC6_Purchase Receipt Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Promised Purchase Receipt Date"; Rec."BC6_Prom. Purch. Receipt Date")
            {
                Editable = false;
                ApplicationArea = All;
            }

        }





        addafter("Shipment Date")
        {
            field("BC6_Invoiced Date (Expected)"; Rec."BC6_Invoiced Date (Expected)")
            {
                ApplicationArea = All;
            }
        }



        addafter("Shortcut Dimension 2 Code")
        {
            field("BC6_To Prepare"; Rec."BC6_To Prepare")
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
        }





        addafter(ShortcutDimCode8)
        {
            field("BC6_Purch. Document Type"; Rec."BC6_Purch. Document Type")
            {
                ApplicationArea = All;
            }
            field("BC6_Purch. Order No."; Rec."BC6_Purch. Order No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Purch. Line No."; Rec."BC6_Purch. Line No.")
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
        IF Rec.Type = Rec.Type::Item THEN BEGIN
            Rec.CalcIncreasePurchCost(IncrPurchCost);
            Rec.CalcIncreaseProfit(IncrProfit, IncrPurchCost);
        END ELSE BEGIN
            IncrPurchCost := 0;
            IncrProfit := 0;
        END;
    end;
}

