pageextension 50020 pageextension50020 extends "Posted Purch. Cr. Memo Subform"
{
    // MODIF JX-XAD 04/05/2010
    // Creation de la fonction ReturnRecord dans le cadre de la modification analytique
    layout
    {
        addafter("Control 1")
        {
            group()
            {
                group()
                {
                    field("Invoice Discount Amount"; TotalPurchCrMemoHdr."Invoice Discount Amount")
                    {
                        AutoFormatExpression = TotalPurchCrMemoHdr."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATCaption(TotalPurchCrMemoHdr."Prices Including VAT");
                        Caption = 'Invoice Discount Amount';
                        Editable = false;
                    }
                }
                group()
                {
                    field("Total Amount Excl. VAT"; TotalPurchCrMemoHdr.Amount)
                    {
                        AutoFormatExpression = TotalPurchCrMemoHdr."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(TotalPurchCrMemoHdr."Currency Code");
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        AutoFormatExpression = TotalPurchCrMemoHdr."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(TotalPurchCrMemoHdr."Currency Code");
                        Caption = 'Total VAT';
                        Editable = false;
                    }
                    field("Total Amount Incl. VAT"; TotalPurchCrMemoHdr."Amount Including VAT")
                    {
                        AutoFormatExpression = TotalPurchCrMemoHdr."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(TotalPurchCrMemoHdr."Currency Code");
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

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 1900295304".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 1901743204".

    }

    var
        TotalPurchCrMemoHdr: Record "124";
        DocumentTotals: Codeunit "57";
        VATAmount: Decimal;


        //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

        //trigger OnAfterGetCurrRecord()
        //begin
        /*
        DocumentTotals.CalculatePostedPurchCreditMemoTotals(TotalPurchCrMemoHdr,VATAmount,Rec);
        */
        //end;

    procedure ReturnRecord(var Prec_PurchCrMemoLine: Record "125")
    begin
        Prec_PurchCrMemoLine := Rec;
    end;
}

