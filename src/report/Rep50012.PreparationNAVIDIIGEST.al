report 50012 "BC6_Preparation NAVIDIIGEST"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/PreparationNAVIDIIGEST.rdl';

    Caption = 'Check of preparation', Comment = 'FRA="Bon de préparation"';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Order', Comment = 'FRA="Commande vente"';
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = true;
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    PrintOnlyIfDetail = true;
                    column(CompanyInfo_Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo__Alt_Picture_; CompanyInfo1."BC6_Alt Picture")
                    {
                    }
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(ShipToAddr_1_; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddr_2_; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr_3_; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr_4_; ShipToAddr[4])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(ShipToAddr_5_; ShipToAddr[5])
                    {
                    }
                    column(Sales_Header___Your_Reference_; "Sales Header"."Your Reference")
                    {
                    }
                    column(Sales_Header___VAT_Registration_No__; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(ShipmentDate; ShipmentDate)
                    {
                    }
                    column(Sales_Header___Document_Date_; "Sales Header"."Document Date")
                    {
                    }
                    column(PrestaTrans_Description; PrestaTrans.Description)
                    {
                    }
                    column(Sales_Header___Sell_to_Customer_No__; "Sales Header"."Sell-to Customer No.")
                    {
                    }
                    column(Sales_Header___No__; "Sales Header"."No.")
                    {
                    }
                    column(ModeTransport; ModeTransport)
                    {
                    }
                    column(ShipToAddr_6_; ShipToAddr[6])
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(Sales_Header___Shipping_Advice_; "Sales Header"."Shipping Advice")
                    {
                    }
                    column(ShipmentMethod_Description; ShipmentMethod.Description)
                    {
                    }
                    column(N_______Sales_Header___No__; 'N° ' + "Sales Header"."No.")
                    {
                    }
                    column("USERID"; USERID)
                    {
                    }
                    column(Sales_Header___External_Document_No__; "Sales Header"."External Document No.")
                    {
                    }
                    column(STRSUBSTNO_Text006_CompanyInfo__Alt_Phone_No___CompanyInfo__Alt_Fax_No___CompanyInfo__Alt_E_Mail__; STRSUBSTNO(Text006, CompanyInfo."BC6_Alt Phone No.", CompanyInfo."BC6_Alt Fax No.", CompanyInfo."BC6_Alt E-Mail"))
                    {
                    }
                    column(DataItem1000000036; CompanyInfo."BC6_Alt Address" + ' ' + CompanyInfo."BC6_Alt Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."BC6_Alt Post Code", CompanyInfo."BC6_Alt City"))
                    {
                    }
                    column(CompanyInfo__Alt_Name_; CompanyInfo."BC6_Alt Name")
                    {
                    }
                    column(STRSUBSTNO_Text006_CompanyInfo__Phone_No___CompanyInfo__Fax_No___CompanyInfo__E_Mail__; STRSUBSTNO(Text006, CompanyInfo."Phone No.", CompanyInfo."Fax No.", CompanyInfo."E-Mail"))
                    {
                    }
                    column(CompanyInfo_Address______CompanyInfo__Address_2______STRSUBSTNO___1__2__CompanyInfo__Post_Code__CompanyInfo_City_; CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."Post Code", CompanyInfo.City))
                    {
                    }
                    column(CompanyInfo_Name; CompanyInfo.Name)
                    {
                    }
                    column(DataItem1000000064; STRSUBSTNO(Text032, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
                    {
                    }
                    column(Shipment_departementCaption; Shipment_departementCaptionLbl)
                    {
                    }
                    column(ReferenceCaption; ReferenceCaptionLbl)
                    {
                    }
                    column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(ShipmentCaption; ShipmentCaptionLbl)
                    {
                    }
                    column(DateCaption; DateCaptionLbl)
                    {
                    }
                    column(Order_NumberCaption; Order_NumberCaptionLbl)
                    {
                    }
                    column(Customer_NumberCaption; Customer_NumberCaptionLbl)
                    {
                    }
                    column(Shipping_ServiceCaption; Shipping_ServiceCaptionLbl)
                    {
                    }
                    column(bill_DepartementCaption; bill_DepartementCaptionLbl)
                    {
                    }
                    column(Preparation_OrderCaption; Preparation_OrderCaptionLbl)
                    {
                    }
                    column(ShippingCaption; ShippingCaptionLbl)
                    {
                    }
                    column(Sales_Header___Shipping_Advice_Caption; "Sales Header".FIELDCAPTION("Shipping Advice"))
                    {
                    }
                    column(Shipping_conditionCaption; Shipping_conditionCaptionLbl)
                    {
                    }
                    column(UserCaption; UserCaptionLbl)
                    {
                    }
                    column(Sales_Header___External_Document_No__Caption; "Sales Header".FIELDCAPTION("External Document No."))
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    dataitem(TraitementTexteClient; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(TraitementTexteClient_Number; Number)
                        {
                        }
                        dataitem(TexteClient; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(StandardSalesLine_Description; StandardSalesLine.Description)
                            {
                            }
                            column(TexteClient_Number; Number)
                            {
                            }
                            column(Edition; Edition)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Edition2 THEN BEGIN
                                    IF Number = 1 THEN
                                        StandardSalesLine.FIND('-')
                                    ELSE BEGIN
                                        StandardSalesLine.NEXT;
                                    END;
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT Edition THEN CurrReport.BREAK;
                                StandardSalesLine.RESET;
                                StandardSalesLine.SETRANGE(StandardSalesLine."Standard Sales Code", StandardCustomerSalesCode.Code);
                                Edition2 := TRUE;
                                IF StandardSalesLine.COUNT <> 0 THEN
                                    TexteClient.SETRANGE(Number, 1, StandardSalesLine.COUNT)
                                ELSE
                                    Edition2 := FALSE;
                                IF NOT Edition2 THEN CurrReport.BREAK;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF NOT Edition THEN CurrReport.BREAK;
                            IF Number = 1 THEN
                                StandardCustomerSalesCode.FIND('-')
                            ELSE
                                StandardCustomerSalesCode.NEXT;
                        end;

                        trigger OnPreDataItem()
                        begin

                            StandardCustomerSalesCode.RESET;
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode.BC6_TextautoReport, TRUE);
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode."Customer No.", "Sales Header"."Sell-to Customer No.");
                            Edition := TRUE;
                            IF StandardCustomerSalesCode.COUNT <> 0 THEN
                                TraitementTexteClient.SETRANGE(Number, 1, StandardCustomerSalesCode.COUNT)
                            ELSE
                                Edition := FALSE;
                        end;
                    }
                    dataitem(Instruction; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(Preparation_and_shipping_instructions__Caption; Preparation_and_shipping_instructions__CaptionLbl)
                        {
                        }
                        column(Instruction_Number; Number)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            //>>MIGRATION NAV 2013

                            SalesCommentLine.RESET;
                            SalesCommentLine.SETRANGE("Document Type", "Sales Header"."Document Type");
                            SalesCommentLine.SETRANGE("No.", "Sales Header"."No.");

                            //<<MIGRATION NAV 2013
                        end;
                    }
                    dataitem(DataItem8541; "Sales Comment Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.");
                        column(Sales_Comment_Line_Comment; Comment)
                        {
                        }
                        column(Sales_Comment_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Sales_Comment_Line_No_; "No.")
                        {
                        }
                        column(Sales_Comment_Line_Document_Line_No_; "Document Line No.")
                        {
                        }
                        column(Sales_Comment_Line_Line_No_; "Line No.")
                        {
                        }
                        column(FlagSaleCommentLine; FlagSaleCommentLine)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            FlagSaleCommentLine := TRUE;
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                        PrintOnlyIfDetail = false;
                        column(Sales_Line__Sales_Line___Outstanding_Quantity_; "Sales Line"."Outstanding Quantity")
                        {
                        }
                        column(Sales_Line__Sales_Line___Quantity_Shipped_; "Sales Line"."Quantity Shipped")
                        {
                        }
                        column(Sales_Line__Sales_Line__Quantity; "Sales Line".Quantity)
                        {
                        }
                        column(Sales_Line__Sales_Line__Description; "Sales Line".Description)
                        {
                        }
                        column(Sales_Line__Sales_Line___No__; "Sales Line"."No.")
                        {
                        }
                        column(ItemInventory; ItemInventory)
                        {
                            DecimalPlaces = 0 : 0;
                        }
                        column(item__Shelf_No__; item."Shelf No.")
                        {
                        }
                        column(Sales_Line__Sales_Line__Description_Control1000000133; "Sales Line".Description)
                        {
                        }
                        column(STRSUBSTNO_FORMAT__Sales_Line___Qty__to_Ship___Gross_Weight___; STRSUBSTNO(FORMAT("Sales Line"."Qty. to Ship" * "Gross Weight")))
                        {
                        }
                        column(EAN13BarTxt; EAN13BarTxt)
                        {
                        }
                        column(NetWeight; NetWeight)
                        {
                        }
                        column(GrossWeight; GrossWeight)
                        {
                        }
                        column(To_prepareCaption; To_prepareCaptionLbl)
                        {
                        }
                        column(DeliveredCaption; DeliveredCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(OrderCaption; OrderCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(ItemCaption; ItemCaptionLbl)
                        {
                        }
                        column(Shelf_No_Caption; Shelf_No_CaptionLbl)
                        {
                        }
                        column(InventoryCaption; InventoryCaptionLbl)
                        {
                        }
                        column(NextCaption; NextCaptionLbl)
                        {
                        }
                        column(ItemCaption_Control1000000067; ItemCaption_Control1000000067Lbl)
                        {
                        }
                        column(To_prepareCaption_Control1000000096; To_prepareCaption_Control1000000096Lbl)
                        {
                        }
                        column(DeliveredCaption_Control1000000110; DeliveredCaption_Control1000000110Lbl)
                        {
                        }
                        column(QuantityCaption_Control1000000118; QuantityCaption_Control1000000118Lbl)
                        {
                        }
                        column(OrderCaption_Control1000000119; OrderCaption_Control1000000119Lbl)
                        {
                        }
                        column(DescriptionCaption_Control1000000121; DescriptionCaption_Control1000000121Lbl)
                        {
                        }
                        column(Shelf_No_Caption_Control1000000123; Shelf_No_Caption_Control1000000123Lbl)
                        {
                        }
                        column(InventoryCaption_Control1000000126; InventoryCaption_Control1000000126Lbl)
                        {
                        }
                        column(Gross_WeightCaption; Gross_WeightCaptionLbl)
                        {
                        }
                        column(To_be_continuedCaption; To_be_continuedCaptionLbl)
                        {
                        }
                        column(Net_WeightCaption; Net_WeightCaptionLbl)
                        {
                        }
                        column(GrossWeightCaption; GrossWeightCaptionLbl)
                        {
                        }
                        column(Sales_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Sales_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Line_Line_No_; "Line No.")
                        {
                        }
                        column(SalesLineType; FORMAT("Sales Line".Type, 0, 9))
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //                                     PRM
                            IF "Gross Weight" <> 0 THEN BEGIN
                                tempcalc := "Qty. to Ship" * "Gross Weight";
                                GrossWeight := GrossWeight + (tempcalc);
                                tempcalc := "Qty. to Ship" * "Net Weight";
                                NetWeight := NetWeight + (tempcalc);
                            END;
                            //                                     PRM

                            //STOCK SL 06/10/06 Ajout de la colonne stock
                            ItemInventory := 0;
                            item.RESET;
                            IF item.GET("No.") THEN BEGIN
                                item.SETRANGE("Location Filter", "Location Code");
                                item.CALCFIELDS(Inventory);
                                ItemInventory := item.Inventory;
                            END;
                            //Fin STOCK SL 06/10/06 Ajout de la colonne stock

                            //>>FEP-ACHAT-200706_18_A.001
                            IF (BooGRespectLinesPrep) AND NOT ("Sales Line"."BC6_To Prepare") THEN
                                CurrReport.SKIP;
                            //<<FEP-ACHAT-200706_18_A.001

                            CASE Type OF
                                Type::Item:
                                    BEGIN
                                        IF (Quantity <> 0) THEN BEGIN
                                            EAN13Bar := '';
                                            EAN13Txt := '';
                                            EAN13BarTxt := '';
                                            CLEAR(DistInt);
                                            EAN13Bar := COPYSTR(FunctionsMgt.GetItemEAN13Code("No."), 1, MAXSTRLEN(EAN13Bar));
                                            IF EAN13Bar <> '' THEN BEGIN
                                                CLEAR(ConvertAutoIDEAN13);
                                                EAN13BarTxt := ConvertAutoIDEAN13.EncodeBarcodeEAN13(EAN13Bar, EAN13Txt);
                                            END;
                                        END;
                                    END;
                            END;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    VATAmountLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.SETRANGE("Line No.", 0, SalesLine."Line No.");

                    //   PRM

                    MoreLines := SalesLine.FIND('+');

                    //QUANTITE SL 14/09/06 NSC1.05
                    //WHILE MoreLines AND (SalesLine."Qty. to Ship" = 0)
                    WHILE MoreLines AND (SalesLine."Outstanding Quantity" = 0)
                    //Fin QUANTITE SL 14/09/06 NSC1.05
                    DO
                        MoreLines := SalesLine.NEXT(-1) <> 0;
                    IF NOT MoreLines THEN
                        CurrReport.BREAK;
                    //  PRM


                    IF Number > 1 THEN
                        CopyText := Text003;
                    OutputNo += 1;
                    CurrReport.PAGENO := 1;
                    GrossWeight := 0;
                    NetWeight := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCountPrinted.RUN("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 0;

                    //CST Si Nbre de Copies est renseigner, on écrase le Nbre de copies du type de commande.
                    IF NoOfCopies <> 0 THEN
                        NoOfLoops := NoOfCopies;

                    CopyText := '';
                    IF NoOfLoops > 0 THEN
                        SETRANGE(Number, 1, NoOfLoops)
                    ELSE
                        SETRANGE(Number, 0, 0);

                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //                 PRM l'édition ne doit pas se faire dans la langue du client....
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                //PRM debut pour avoir les infos société
                CompanyInfo.GET;
                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                    Pays := Country.Name;

                //PRM fin


                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    CompanyInfo.GET;
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;

                //NATURE_COMMANDE SL 14/09/06 NSC1.05  Ajout de l'interlocuteur principal basé sur axe analytique 1
                GLSetup.GET;
                PrincipalContact := '';
                //>>MIGRATION NAV 2013
                /*
                IF DocDimension.GET(DATABASE::"Sales Header","Document Type","No.",0,GLSetup."Global Dimension 1 Code") THEN BEGIN
                  PrincipalContact := DocDimension."Dimension Value Code";
                  IF DimensionValue.GET(DocDimension."Dimension Code",DocDimension."Dimension Value Code") THEN
                    PrincContactName := DimensionValue.Name;
                END;
                */
                //<<MIGRATION NAV 2013

                ShipmentDate := 0D;
                IF "Promised Delivery Date" <> 0D THEN
                    ShipmentDate := "Promised Delivery Date"
                ELSE
                    IF "Requested Delivery Date" <> 0D THEN
                        ShipmentDate := "Requested Delivery Date";
                //Fin NATURE_COMMANDE SL 14/09/06 NSC1.05  Ajout de l'interlocuteur principal basé sur axe analytique 1



                //TECSO 08/12/03 CST : Lecture des mode de règlement (Payment Methode)
                ModeDePayment := '';
                IF PaymentMethod.GET("Sales Header"."Payment Method Code") THEN
                    ModeDePayment := PaymentMethod.Description;
                IF "Salesperson Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;

                END;
                //TECSO 09/12/03 CST : Ajout du N° de Document externe dans le libellé de "Votre reference"
                IF ("Your Reference" = '') AND ("External Document No." = '') THEN
                    //ReferenceText := ''
                    VotreRef := ''
                ELSE BEGIN
                    //TECSO CST S ReferenceText := FIELDCAPTION("Your Reference");
                    //ReferenceText := 'Votre Référence :';
                    //TECSO CST A Ajout de concaténation du N° de document externe avec le "Your reference"
                    VotreRef := "External Document No." + '  ' + "Your Reference";
                END;

                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                END;

                //TECSO 06/01/2004 CST : Adresse à imprimer = adresse de commande et non pas adresse de Facturation
                //FormatAddr.SalesHeaderBillTo(CustAddr,"Sales Header");
                FormatAddr.SalesHeaderSellTo(CustAddr, "Sales Header");
                //Fin

                // SDU Lecture Mode transport
                ModeTransport := '';
                IF ShippingAgent.GET("Sales Header"."Shipping Agent Code") THEN
                    ModeTransport := ShippingAgent.Name;


                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                IF "Sales Header"."Shipping Agent Service Code" = '' THEN
                    PrestaTrans.INIT
                ELSE
                    PrestaTrans.GET("Sales Header"."Shipping Agent Code", "Sales Header"."Shipping Agent Service Code");


                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;
                //                                           PRM
                customer.GET("Sell-to Customer No.");

                IF NOT CurrReport.PREVIEW THEN BEGIN

                    //ARCHIVAGE SL 06/10/06 Ne pas archiver la commande
                    /*
                    IF ArchiveDocument THEN
                      ArchiveManagement.StoreSalesDocument("Sales Header",LogInteraction);

                    IF LogInteraction THEN BEGIN
                      CALCFIELDS("No. of Archived Versions");
                      IF "Bill-to Contact No." <> '' THEN
                        SegManagement.LogDocument(
                          3,"No.","Doc. No. Occurrence",
                          "No. of Archived Versions",DATABASE::Contact,"Bill-to Contact No."
                          ,"Salesperson Code","Campaign No.","Posting Description","Opportunity No.")
                      ELSE
                        SegManagement.LogDocument(
                          3,"No.","Doc. No. Occurrence",
                          "No. of Archived Versions",DATABASE::Customer,"Bill-to Customer No.",
                          "Salesperson Code","Campaign No.","Posting Description","Opportunity No.");
                    END;
                    */
                    //Fin ARCHIVAGE SL 06/10/06 Ne pas archiver la commande
                END;

                //>>FEP-ACHAT-200706_18_A.001
                RecGSalesLine.RESET;
                RecGSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                RecGSalesLine.SETRANGE(RecGSalesLine."Document Type", "Sales Header"."Document Type");
                RecGSalesLine.SETRANGE(RecGSalesLine."Document No.", "Sales Header"."No.");
                RecGSalesLine.SETRANGE(RecGSalesLine."BC6_To Prepare", TRUE);
                IF NOT RecGSalesLine.FIND('-') THEN
                    CurrReport.SKIP;
                //<<FEP-ACHAT-200706_18_A.001

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                    }
                    field(BooGRespectLinesPrep; BooGRespectLinesPrep)
                    {
                        Caption = 'Respect Lines To Prepare', Comment = 'FRA="Respecter lignes à préparer"';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                        Visible = false;
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';
                        Enabled = BooGEnableArchiveDocument;
                        Visible = false;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = BooGEnableLogInteraction;
                        Visible = false;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //>>MIGRATION NAV 2013

            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';

            BooGEnableArchiveDocument := ArchiveDocument;
            BooGEnableLogInteraction := LogInteraction;
            //RequestOptionsForm.ArchiveDocument.ENABLED(ArchiveDocument);
            //RequestOptionsForm.LogInteraction.ENABLED(LogInteraction);

            //<<MIGRATION NAV 2013
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;

        //>>MIGRATION NAV 2013
        CompanyInfo1.GET;
        CompanyInfo1.CALCFIELDS(Picture);
        CompanyInfo1.CALCFIELDS("BC6_Alt Picture");
        //<<MIGRATION NAV 2013
    end;

    var
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Order Confirmation %1', Comment = 'FRA="Confirmation de commande %1"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="TEL : %1 FAX : %2 / email : %3"';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        VATAmountLine: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        DocDim1: Record "Dimension Set Entry";
        DocDim2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        PrestaTrans: Record "Shipping Agent Services";
        ShippingAgent: Record "Shipping Agent";
        ModeTransport: Text[30];
        Country: Record "Country/Region";
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[50];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        [InDataSet]
        BooGEnableArchiveDocument: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        BooGEnableLogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        Text008: Label 'de commande', Comment = 'FRA="de commande"';
        CompteurDeLigne: Integer;
        PaymentMethod: Record "Payment Method";
        ModeDePayment: Text[30];
        VotreRef: Text[200];
        PrixNet: Decimal;
        Text10: Text[200];
        Text20: Text[200];
        Text30: Text[200];
        Text40: Text[200];
        Text50: Text[200];
        TmpNamereport: Text[30];
        Text016: Label 'INVOICE DEPARTMENT', Comment = 'FRA="SERVICE FACTURATION"';
        Text030: Label '%1 - %2 - %3 %4', Comment = 'FRA="%1 - %2 - %3 %4"';
        Text032: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - N°TVA : %5"';
        LangueLig01: Text[10];
        LangueLig10: Text[10];
        LangueLig20: Text[10];
        LangueLig30: Text[10];
        LangueLig40: Text[10];
        LangueLig50: Text[10];
        TablesDiverses: Record "BC6_Various Tables";
        Langue: Text[10];
        ListeTable: Text[10];
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        customer: Record Customer;
        TempGencod: Text[30];
        ItemCrossReference: Record "Item Cross Reference";
        CrossrefNo: Text[20];
        item: Record Item;
        templibelledouanier: Text[30];
        tempcalc: Decimal;
        GrossWeight: Decimal;
        NetWeight: Decimal;
        FlagSaleCommentLine: Boolean;
        StandardCustomerSalesCode: Record "Standard Customer Sales Code";
        StandardSalesLine: Record "Standard Sales Line";
        FlagText: Boolean;
        Edition: Boolean;
        Edition2: Boolean;
        Pays: Text[30];
        "--NSC1.01--": Integer;
        EditerToutesLignes: Boolean;
        SalesCommentLine: Record "Sales Comment Line";
        "--NSC1.10--": Integer;
        PrincipalContact: Code[10];
        DocDimension: Record "Dimension Set Entry";
        DimensionValue: Record "Dimension Value";
        PrincContactName: Text[50];
        ShipmentDate: Date;
        "--NSC1.11--": Integer;
        ItemInventory: Decimal;
        "-FEP-ACHAT-200706_18_A -": Integer;
        BooGRespectLinesPrep: Boolean;
        RecGSalesLine: Record "Sales Line";
        EAN13BarTxt: Text[120];
        EAN13Txt: Text[13];
        EAN13Bar: Text[13];
        DistInt: Codeunit "Dist. Integration";
        FunctionsMgt: Codeunit "BC6_Functions Mgt";
        ConvertAutoIDEAN13: Codeunit "BC6_Barcode Mngt AutoID";
        Shipment_departementCaptionLbl: Label 'Shipment departement', Comment = 'FRA="Adresse de livraison"';
        ReferenceCaptionLbl: Label 'Reference', Comment = 'FRA="Référence"';
        VAT_Registration_No__CaptionLbl: Label '<VAT Registration No.>', Comment = 'FRA="N° TVA :"';
        ShipmentCaptionLbl: Label 'Shipment', Comment = 'FRA="Livraison"';
        DateCaptionLbl: Label 'Date', Comment = 'FRA="Date"';
        Order_NumberCaptionLbl: Label 'Order Number', Comment = 'FRA="N° de Commande"';
        Customer_NumberCaptionLbl: Label 'Customer Number', Comment = 'FRA="Code Client"';
        Shipping_ServiceCaptionLbl: Label 'Shipping Service', Comment = 'FRA="Prestation Transport"';
        bill_DepartementCaptionLbl: Label 'bill Departement', Comment = 'FRA="Adresse de Facturation"';
        Preparation_OrderCaptionLbl: Label 'Preparation Order', Comment = 'FRA="Bon de préparation"';
        ShippingCaptionLbl: Label 'Shipping', Comment = 'FRA="Transporteur"';
        Shipping_conditionCaptionLbl: Label 'Shipping condition', Comment = 'FRA="Condition de livraison"';
        UserCaptionLbl: Label 'User', Comment = 'FRA="Utilisateur"';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions', Comment = 'FRA="Analytique en-tête"';
        Preparation_and_shipping_instructions__CaptionLbl: Label 'Preparation and shipping instructions :', Comment = 'FRA="Instructions de préparation et livraison"';
        To_prepareCaptionLbl: Label 'To prepare', Comment = 'FRA="A servir"';
        DeliveredCaptionLbl: Label 'Delivered', Comment = 'FRA="Livrée"';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        OrderCaptionLbl: Label 'Order', Comment = 'FRA="Cdée"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Description"';
        ItemCaptionLbl: Label 'Item', Comment = 'FRA="Référence"';
        Shelf_No_CaptionLbl: Label 'Shelf No.', Comment = 'FRA="N° emplacement"';
        InventoryCaptionLbl: Label 'Inventory', Comment = 'FRA="Stock"';
        NextCaptionLbl: Label 'Next', Comment = 'FRA="Suite"';
        ItemCaption_Control1000000067Lbl: Label 'Item', Comment = 'FRA="Référence"';
        To_prepareCaption_Control1000000096Lbl: Label 'To prepare', Comment = 'FRA="A servir"';
        DeliveredCaption_Control1000000110Lbl: Label 'Delivered', Comment = 'FRA="Livrée"';
        QuantityCaption_Control1000000118Lbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        OrderCaption_Control1000000119Lbl: Label 'Order', Comment = 'FRA="Cdée"';
        DescriptionCaption_Control1000000121Lbl: Label 'Description', Comment = 'FRA="Description"';
        Shelf_No_Caption_Control1000000123Lbl: Label 'Shelf No.', Comment = 'FRA="N° emplacement"';
        InventoryCaption_Control1000000126Lbl: Label 'Inventory', Comment = 'FRA="Stock"';
        Gross_WeightCaptionLbl: Label 'Gross Weight', Comment = 'FRA="Poids brut"';
        To_be_continuedCaptionLbl: Label 'To be continued', Comment = 'FRA="A Suivre"';
        Net_WeightCaptionLbl: Label 'Net Weight', Comment = 'FRA="Poids net"';
        GrossWeightCaptionLbl: Label 'Gross Weight', Comment = 'FRA="Poids brut"';
        "-MIGNAV2013-": Integer;
        OutputNo: Integer;
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
}

