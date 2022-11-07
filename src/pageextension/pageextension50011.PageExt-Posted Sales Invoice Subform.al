pageextension 50011 pageextension50011 extends "Posted Sales Invoice Subform"
{
    //  //MODIF JX-AUD du 05/04/2011 Traitement des axes analytiques
    // 
    //  //MODIF JX-AUD du 24/05/2011 Modification des axes analytiques pour document enregistré
    layout
    {
        addafter("Control 70")
        {
            field("Axe 0"; Gtext_Axe0)
            {
                CaptionClass = Gtext_ColAxe0;
                Caption = 'Axe 0';
                MultiLine = true;
                Visible = "Axe 0Visible";
            }
            field("Axe 1"; Gtext_Axe1)
            {
                CaptionClass = Gtext_ColAxe1;
                Caption = 'Axe 1';
                MultiLine = true;
                Visible = "Axe 1Visible";
            }
            field("Axe 2"; Gtext_Axe2)
            {
                CaptionClass = Gtext_ColAxe2;
                Caption = 'Axe 2';
                MultiLine = true;
                Visible = "Axe 2Visible";
            }
            field("Axe 3"; Gtext_Axe3)
            {
                CaptionClass = Gtext_ColAxe3;
                Caption = 'Axe 3';
                MultiLine = true;
                Visible = "Axe 3Visible";
            }
            field("Axe 4"; Gtext_Axe4)
            {
                CaptionClass = Gtext_ColAxe4;
                Caption = 'Axe 4';
                MultiLine = true;
                Visible = "Axe 4Visible";
            }
            field("Axe 5"; Gtext_Axe5)
            {
                CaptionClass = Gtext_ColAxe5;
                Caption = 'Axe 5';
                MultiLine = true;
                Visible = "Axe 5Visible";
            }
            group()
            {
                group()
                {
                    field("Invoice Discount Amount"; TotalSalesInvoiceHeader."Invoice Discount Amount")
                    {
                        AutoFormatExpression = TotalSalesInvoiceHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATCaption(TotalSalesInvoiceHeader."Prices Including VAT");
                        Caption = 'Invoice Discount Amount';
                        Editable = false;
                    }
                }
                group()
                {
                    field("Total Amount Excl. VAT"; TotalSalesInvoiceHeader.Amount)
                    {
                        AutoFormatExpression = TotalSalesInvoiceHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(TotalSalesInvoiceHeader."Currency Code");
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        AutoFormatExpression = TotalSalesInvoiceHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(TotalSalesInvoiceHeader."Currency Code");
                        Caption = 'Total VAT';
                        Editable = false;
                    }
                    field("Total Amount Incl. VAT"; TotalSalesInvoiceHeader."Amount Including VAT")
                    {
                        AutoFormatExpression = TotalSalesInvoiceHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(TotalSalesInvoiceHeader."Currency Code");
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

    }

    var
        Gtext_Axe0: Text[30];
        Gtext_Axe1: Text[30];
        Gtext_Axe2: Text[30];
        Gtext_Axe3: Text[30];
        Gtext_Axe4: Text[30];
        Gtext_Axe5: Text[30];
        Gcode_Axe1: Code[20];
        Gcode_Axe2: Code[20];
        Gcode_Axe3: Code[20];
        Gcode_Axe4: Code[20];
        Gcode_Axe5: Code[20];
        Gcode_Axe6: Code[20];
        Grecord_GeneralLedgerSetup: Record "98";
        Gtext_ColAxe0: Text[30];
        Gtext_ColAxe1: Text[30];
        Gtext_ColAxe2: Text[30];
        Gtext_ColAxe3: Text[30];
        Gtext_ColAxe4: Text[30];
        Gtext_ColAxe5: Text[30];
        Grec_Dimension: Record "348";
        [InDataSet]
        "Axe 0Visible": Boolean;
        [InDataSet]
        "Axe 1Visible": Boolean;
        [InDataSet]
        "Axe 2Visible": Boolean;
        [InDataSet]
        "Axe 3Visible": Boolean;
        [InDataSet]
        "Axe 4Visible": Boolean;
        [InDataSet]
        "Axe 5Visible": Boolean;
        TotalSalesInvoiceHeader: Record "112";
        DocumentTotals: Codeunit "57";
        VATAmount: Decimal;
        Grec_DimSetEntry: Record "480";


        //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

        //trigger OnAfterGetCurrRecord()
        //begin
        /*
        DocumentTotals.CalculatePostedSalesInvoiceTotals(TotalSalesInvoiceHeader,VATAmount,Rec);
        */
        //end;


        //Unsupported feature: Code Insertion on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //begin
        /*
        //DEBUT MODIF JX-AUD du 05/04/2011
        IF Grec_DimSetEntry.GET("Dimension Set ID", Gcode_Axe1) THEN
          Gtext_Axe0 := Grec_DimSetEntry."Dimension Value Code"
        ELSE
          Gtext_Axe0 :='';

        IF Grec_DimSetEntry.GET("Dimension Set ID", Gcode_Axe2) THEN
          Gtext_Axe1 := Grec_DimSetEntry."Dimension Value Code"
        ELSE
          Gtext_Axe1 :='';

        IF Grec_DimSetEntry.GET("Dimension Set ID", Gcode_Axe3) THEN
          Gtext_Axe2 := Grec_DimSetEntry."Dimension Value Code"
        ELSE
          Gtext_Axe2 :='';

        IF Grec_DimSetEntry.GET("Dimension Set ID", Gcode_Axe4) THEN
          Gtext_Axe3 := Grec_DimSetEntry."Dimension Value Code"
        ELSE
          Gtext_Axe3 :='';

        IF Grec_DimSetEntry.GET("Dimension Set ID", Gcode_Axe5) THEN
          Gtext_Axe4 := Grec_DimSetEntry."Dimension Value Code"
        ELSE
          Gtext_Axe4 :='';

        IF Grec_DimSetEntry.GET("Dimension Set ID", Gcode_Axe6) THEN
          Gtext_Axe5 := Grec_DimSetEntry."Dimension Value Code"
        ELSE
          Gtext_Axe5 :='';

        //FIN MODIF JX-AUD du 05/04/2011
        */
        //end;


        //Unsupported feature: Code Insertion on "OnInit".

        //trigger OnInit()
        //Parameters and return type have not been exported.
        //begin
        /*
        "Axe 5Visible" := TRUE;
        "Axe 4Visible" := TRUE;
        "Axe 3Visible" := TRUE;
        "Axe 2Visible" := TRUE;
        "Axe 1Visible" := TRUE;
        "Axe 0Visible" := TRUE;
        */
        //end;


        //Unsupported feature: Code Insertion on "OnOpenPage".

        //trigger OnOpenPage()
        //begin
        /*
        //MODIF JX-AUD du 05/04/2011
        "Axe 0Visible" := TRUE;
        "Axe 1Visible" := TRUE;
        "Axe 2Visible" := TRUE;
        "Axe 3Visible" := TRUE;
        "Axe 4Visible" := TRUE;
        "Axe 5Visible" := TRUE;

        IF Grecord_GeneralLedgerSetup.FIND('-') THEN BEGIN

          Gcode_Axe1 := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
          IF Grec_Dimension.GET(Gcode_Axe1) THEN Gtext_ColAxe0 := Grec_Dimension."Code Caption" ELSE "Axe 0Visible" := FALSE;

          Gcode_Axe2 := Grecord_GeneralLedgerSetup."Shortcut Dimension 4 Code";
          IF Grec_Dimension.GET(Gcode_Axe2) THEN Gtext_ColAxe1 := Grec_Dimension."Code Caption" ELSE "Axe 1Visible" := FALSE;

          Gcode_Axe3 := Grecord_GeneralLedgerSetup."Shortcut Dimension 5 Code";
          IF Grec_Dimension.GET(Gcode_Axe3) THEN Gtext_ColAxe2 := Grec_Dimension."Code Caption" ELSE "Axe 2Visible" := FALSE;

          Gcode_Axe4 := Grecord_GeneralLedgerSetup."Shortcut Dimension 6 Code";
          IF Grec_Dimension.GET(Gcode_Axe4) THEN Gtext_ColAxe3 := Grec_Dimension."Code Caption" ELSE "Axe 3Visible" := FALSE;

          Gcode_Axe5 := Grecord_GeneralLedgerSetup."Shortcut Dimension 7 Code";
          IF Grec_Dimension.GET(Gcode_Axe5) THEN Gtext_ColAxe4 := Grec_Dimension."Code Caption" ELSE "Axe 4Visible" := FALSE;

          Gcode_Axe6 := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
          IF Grec_Dimension.GET(Gcode_Axe6) THEN Gtext_ColAxe5 := Grec_Dimension."Code Caption" ELSE "Axe 5Visible" := FALSE;

        END;
         //MODIF JX-AUD du 05/04/2011
        */
        //end;

    procedure ReturnRecord(var Prec_SalesInvLine: Record "113")
    begin
        //MODIF JX-AUD du 24/05/2011
        Prec_SalesInvLine := Rec;
        //Fin MODIF JX-AUD du 24/05/2011
    end;
}

