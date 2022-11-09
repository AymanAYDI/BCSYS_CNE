pageextension 50097 pageextension50097 extends "Purchase Return Order Subform"
{
    layout
    {
        addafter("Control 82")
        {
            field("Solution Code"; "Solution Code")
            {
            }
            field("Return Comment"; "Return Comment")
            {
                Visible = BooGSAVVisible;
            }
        }
        addafter("Control 44")
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
        IF PurchHeader.GET("Document Type","Document No.") THEN;

        DocumentTotals.PurchaseUpdateTotalsControls(Rec,TotalPurchaseHeader,TotalPurchaseLine,RefreshMessageEnabled,
          TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,VATAmount);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4

        //>>BCSYS
        BooGSAVVisible := PurchHeader."Return Order Type" = PurchHeader."Return Order Type"::SAV;
        //<<BCSYS
        */
        //end;
}

