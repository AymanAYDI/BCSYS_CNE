report 50079 "Receptions non facturées"
{
    // 
    // TDL0121:JORE 05/12/2006 - Add vendor No. and Name
    // 
    // // Conversion of UnitPrice ( FCY ) into UnitPrice ( LCY )
    DefaultLayout = RDLC;
    RDLCLayout = './Receptionsnonfacturées.rdlc';


    dataset
    {
        dataitem(DataItem3042; Table121)
        {
            DataItemTableView = SORTING (Document No., Line No.)
                                WHERE (Qty. Rcd. Not Invoiced=FILTER(<>0));
            RequestFilterFields = "Document No.";
            column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PAGENO)
            {
            }
            column(USERID;USERID)
            {
            }
            column(Filtre;Filtre)
            {
            }
            column(Purch__Rcpt__Line__Buy_from_Vendor_No__;"Buy-from Vendor No.")
            {
            }
            column(Vendor_Name;Vendor.Name)
            {
            }
            column(Purch__Rcpt__Line__Document_No__;"Document No.")
            {
            }
            column(Purch__Rcpt__Line_Type;Type)
            {
            }
            column(Purch__Rcpt__Line__No__;"No.")
            {
            }
            column(Purch__Rcpt__Line__Posting_Group_;"Posting Group")
            {
            }
            column(Purch__Rcpt__Line_Description;Description)
            {
            }
            column(Purch__Rcpt__Line__Qty__Rcd__Not_Invoiced_;"Qty. Rcd. Not Invoiced")
            {
            }
            column(DecG_Unit_Price;DecG_Unit_Price)
            {
            }
            column(MtHT;MtHT)
            {
            }
            column(MtTVAFAR;MtTVAFAR)
            {
            }
            column(MtTTCFAR;MtTTCFAR)
            {
            }
            column(MtHtFAR;MtHtFAR)
            {
            }
            column(MtHT_Control1000000013;MtHT)
            {
            }
            column(MtTTCFAR_Control1000000034;MtTTCFAR)
            {
            }
            column(MtTVAFAR_Control1000000037;MtTVAFAR)
            {
            }
            column(MtHtFAR_Control1000000040;MtHtFAR)
            {
            }
            column(Recept_no_invoicedCaption;Recept_no_invoicedCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Purch__Rcpt__Line__Document_No__Caption;FIELDCAPTION("Document No."))
            {
            }
            column(Purch__Rcpt__Line_TypeCaption;FIELDCAPTION(Type))
            {
            }
            column(Purch__Rcpt__Line__No__Caption;FIELDCAPTION("No."))
            {
            }
            column(Purch__Rcpt__Line__Posting_Group_Caption;FIELDCAPTION("Posting Group"))
            {
            }
            column(Purch__Rcpt__Line_DescriptionCaption;FIELDCAPTION(Description))
            {
            }
            column(Purch__Rcpt__Line__Qty__Rcd__Not_Invoiced_Caption;FIELDCAPTION("Qty. Rcd. Not Invoiced"))
            {
            }
            column(Unit_Price___LCY_Caption;Unit_Price___LCY_CaptionLbl)
            {
            }
            column(MtHTCaption;MtHTCaptionLbl)
            {
            }
            column(MtTTCFARCaption;MtTTCFARCaptionLbl)
            {
            }
            column(MtTVAFARCaption;MtTVAFARCaptionLbl)
            {
            }
            column(MtHtFARCaption;MtHtFARCaptionLbl)
            {
            }
            column(Still_to_invoiceCaption;Still_to_invoiceCaptionLbl)
            {
            }
            column("Date_RéceptionCaption";Date_RéceptionCaptionLbl)
            {
            }
            column(Purch__Rcpt__Line__Buy_from_Vendor_No__Caption;FIELDCAPTION("Buy-from Vendor No."))
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            column(Purch__Rcpt__Line_Line_No_;"Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //>>MIGRATION NAV 2013
                //>>TDL0121:JORE 05/12/2006
                Vendor.GET("Purch. Rcpt. Line"."Buy-from Vendor No.");
                //<<TDL0121:JORE 05/12/2006
                //<<MIGRATION NAV 2013
                RecG_Purch_Rcpt_Header.RESET ;
                IF NOT RecG_Purch_Rcpt_Header.GET( "Document No.")
                THEN
                  BEGIN
                    MESSAGE ( 'Numéro du document à problème  : ' + FORMAT("Purch. Rcpt. Line"."Document No.") +' **********');
                    MESSAGE ( 'INCOHERENCE entre les entêtes et les les lignes de récéption Achat');
                    MESSAGE ( ' Il est impossible de poursuivre la préparation de l''Etat 50 079');
                    MESSAGE ( 'ARRET du report - Il est fortement suggéré de téléphoner à la Hot-Line Navision');
                    CurrReport.BREAK;
                  END;
                //                Continue si OK.  //

                IF RecG_Purch_Rcpt_Header."Currency Code" <>'' THEN
                  BEGIN
                    RecG_Currency.GET ( RecG_Purch_Rcpt_Header."Currency Code");
                    RecG_Currency.TESTFIELD("Unit-Amount Rounding Precision");
                    DecG_Unit_Price :=
                      ROUND (
                        RecG_Currency_Exchange_Rate.ExchangeAmtFCYToLCY
                        (
                        RecG_Purch_Rcpt_Header."Posting Date", RecG_Purch_Rcpt_Header."Currency Code",
                        "Unit Price (LCY)",RecG_Purch_Rcpt_Header."Currency Factor" ),
                        RecG_Currency."Unit-Amount Rounding Precision"
                        )
                  END ELSE
                  DecG_Unit_Price := "Unit Price (LCY)";

                MtHT:=Quantity * DecG_Unit_Price;
                MtHtFAR:="Qty. Rcd. Not Invoiced" * DecG_Unit_Price;
                IF "VAT %" <> 0 THEN
                MtTVAFAR:= "Qty. Rcd. Not Invoiced" * DecG_Unit_Price* "VAT %"/100
                ELSE
                MtTVAFAR:=0;
                MtTTCFAR:=MtHtFAR+MtTVAFAR;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Document No.");
                CurrReport.CREATETOTALS(MtHT,MtHtFAR,MtTVAFAR,MtTTCFAR);
                SETFILTER("Qty. Rcd. Not Invoiced",'<>0');
                Filtre:= GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        MtHtFAR: Decimal;
        MtTVAFAR: Decimal;
        MtTTCFAR: Decimal;
        Filtre: Text[200];
        MtHT: Decimal;
        Vendor: Record "23";
        TexG_User_Name: Text[30];
        RecG_Purch_Rcpt_Header: Record "120";
        RecG_Currency_Exchange_Rate: Record "330";
        RecG_Currency: Record "4";
        DecG_Unit_Price: Decimal;
        Recept_no_invoicedCaptionLbl: Label 'Recept no invoiced';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Unit_Price___LCY_CaptionLbl: Label ' Unit Price ( LCY)';
        MtHTCaptionLbl: Label 'Amount Excl. VAT';
        MtTTCFARCaptionLbl: Label 'Amount Incl. VAT';
        MtTVAFARCaptionLbl: Label 'VAT Amount';
        MtHtFARCaptionLbl: Label 'Amount Excl. VAT';
        Still_to_invoiceCaptionLbl: Label 'Still to invoice';
        "Date_RéceptionCaptionLbl": Label 'Date Réception';
        TotalCaptionLbl: Label 'Total';
}

