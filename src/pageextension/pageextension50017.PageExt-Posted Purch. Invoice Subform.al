pageextension 50017 pageextension50017 extends "Posted Purch. Invoice Subform"
{
    // ------------------------------------- V 1.2 ---------------------------------------
    // MODIF JX-XAD 23/03/2010
    // Ajout d'une fonction retournant l'enregistrement courant
    layout
    {
        addafter("Control 64")
        {
            field("Posting Group"; "Posting Group")
            {
            }
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
            }
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
            }
            field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            {
            }
        }
        addafter("Control 1")
        {
            group()
            {
                group()
                {
                    field("Invoice Discount Amount"; TotalPurchInvHeader."Invoice Discount Amount")
                    {
                        AutoFormatExpression = TotalPurchInvHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATCaption(TotalPurchInvHeader."Prices Including VAT");
                        Caption = 'Invoice Discount Amount';
                        Editable = false;
                    }
                }
                group()
                {
                    field("Total Amount Excl. VAT"; TotalPurchInvHeader.Amount)
                    {
                        AutoFormatExpression = TotalPurchInvHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(TotalPurchInvHeader."Currency Code");
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        AutoFormatExpression = TotalPurchInvHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(TotalPurchInvHeader."Currency Code");
                        Caption = 'Total VAT';
                        Editable = false;
                    }
                    field("Total Amount Incl. VAT"; TotalPurchInvHeader."Amount Including VAT")
                    {
                        AutoFormatExpression = TotalPurchInvHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(TotalPurchInvHeader."Currency Code");
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                }
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 1901314304".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 1907075804".

    }

    var
        TotalPurchInvHeader: Record "122";
        DocumentTotals: Codeunit "57";
        VATAmount: Decimal;


        //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

        //trigger OnAfterGetCurrRecord()
        //begin
        /*
        DocumentTotals.CalculatePostedPurchInvoiceTotals(TotalPurchInvHeader,VATAmount,Rec);
        */
        //end;

    procedure ReturnRecord(var Prec_PurchInvLine: Record "123")
    begin
        Prec_PurchInvLine := Rec;
    end;
}

