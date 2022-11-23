pageextension 50095 pageextension50095 extends "Sales Return Order Subform"
{
    layout
    {
        addafter("Control 2")
        {
            field("Purchase cost"; "Purchase cost")
            {
            }
        }
        addafter("Control 66")
        {
            field("Solution Code"; "Solution Code")
            {
            }
            field("Return Comment"; "Return Comment")
            {
                Visible = BooGSAVVisible;
            }
        }
        addafter("Control 48")
        {
            field("DEEE Category Code"; "DEEE Category Code")
            {
            }
            field("DEEE Unit Price"; "DEEE Unit Price")
            {
            }
            field("DEEE HT Amount"; "DEEE HT Amount")
            {
            }
        }
        addafter("Control 310")
        {
            field("Series No."; "Series No.")
            {
            }
        }
    }

    var
        "-BCSYS-": Integer;
        BooGSAVVisible: Boolean;


        //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

        //trigger OnAfterGetCurrRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF SalesHeader.GET("Document Type","Document No.") THEN;

        DocumentTotals.SalesUpdateTotalsControls(Rec,TotalSalesHeader,TotalSalesLine,RefreshMessageEnabled,
          TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,CurrPage.EDITABLE,VATAmount);

        TypeChosen := HasTypeToFillMandatotyFields;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6


        //>>BCSYS
        BooGSAVVisible := SalesHeader."Return Order Type" = SalesHeader."Return Order Type"::SAV;
        //<<BCSYS
        */
        //end;
}

