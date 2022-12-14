report 50012 "Preparation NAVIDIIGEST"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //MODIFICATION    SM 30/06/06 NSC1.02 [M0344] modification des reports en fonction du Client Worms
    // //VERSIONNING     FG 13/09/06 NSC1.04
    // //QUANTITE        SL 14/09/06 NSC1.05 Utilisation de la quantité restante plutôt que de la quantité à expédier pour
    //                                       gérer les magasins ou non
    // //POIDS           SL 28/09/06 NSC1.09 Debug sur les lignes de poids
    // //NATURE_COMMANDE SL 04/10/06 NSC1.10 Ajout du libellé de l'interlocuteur principal basé sur axe analytique 1
    //                                       Edition de la date de livraison demandée ou confirmée
    // //ARCHIVAGE       SL 06/10/06         Ne pas archiver la commande
    // //STOCK           SL 06/10/06         Ajout de la colonne stock
    // //DESIGN          SD 12/10/06 NSC1.12 Maquettage
    // 
    // //>>CNE1.00
    // FEP-ACHAT-200706_18_A:MA 08/11/2007 : Achats groupés
    //                                       - Add Option "Respect Lines To Prepare" to Request Form
    //                                       - Add code to display only Lines To Prepare
    // 
    // FEP-ACHAT-200706_18_A.001:GR 08/11/2007 : Achats groupés
    //                                           - Correct problem of printing information twice
    DefaultLayout = RDLC;
    RDLCLayout = './PreparationNAVIDIIGEST.rdlc';

    Caption = 'Check of preparation';

    dataset
    {
        dataitem(DataItem6640; Table36)
        {
            DataItemTableView = WHERE(Document Type=CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Order';
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = true;
                dataitem(PageLoop; Table2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    PrintOnlyIfDetail = true;
                    column(CompanyInfo_Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo__Alt_Picture_; CompanyInfo1."Alt Picture")
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
                    column(USERID; USERID)
                    {
                    }
                    column(Sales_Header___External_Document_No__; "Sales Header"."External Document No.")
                    {
                    }
                    column(STRSUBSTNO_Text006_CompanyInfo__Alt_Phone_No___CompanyInfo__Alt_Fax_No___CompanyInfo__Alt_E_Mail__; STRSUBSTNO(Text006, CompanyInfo."Alt Phone No.", CompanyInfo."Alt Fax No.", CompanyInfo."Alt E-Mail"))
                    {
                    }
                    column(DataItem1000000036; CompanyInfo."Alt Address" + ' ' + CompanyInfo."Alt Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."Alt Post Code", CompanyInfo."Alt City"))
                    {
                    }
                    column(CompanyInfo__Alt_Name_; CompanyInfo."Alt Name")
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
                    dataitem(TraitementTexteClient; Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(TraitementTexteClient_Number; Number)
                        {
                        }
                        dataitem(TexteClient; Table2000000026)
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
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode.TextautoReport, TRUE);
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode."Customer No.", "Sales Header"."Sell-to Customer No.");
                            Edition := TRUE;
                            IF StandardCustomerSalesCode.COUNT <> 0 THEN
                                TraitementTexteClient.SETRANGE(Number, 1, StandardCustomerSalesCode.COUNT)
                            ELSE
                                Edition := FALSE;
                        end;
                    }
                    dataitem(Instruction; Table2000000026)
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
                    dataitem(DataItem8541; Table44)
                    {
                        DataItemLink = Document Type=FIELD(Document Type),
                                       No.=FIELD(No.);
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING(Document Type,No.,Document Line No.,Line No.);
                        column(Sales_Comment_Line_Comment;Comment)
                        {
                        }
                        column(Sales_Comment_Line_Document_Type;"Document Type")
                        {
                        }
                        column(Sales_Comment_Line_No_;"No.")
                        {
                        }
                        column(Sales_Comment_Line_Document_Line_No_;"Document Line No.")
                        {
                        }
                        column(Sales_Comment_Line_Line_No_;"Line No.")
                        {
                        }
                        column(FlagSaleCommentLine;FlagSaleCommentLine)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            FlagSaleCommentLine:=TRUE;
                        end;
                    }
                    dataitem(DataItem2844;Table37)
                    {
                        DataItemLink = Document Type=FIELD(Document Type),
                                       Document No.=FIELD(No.);
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING(Document Type,Document No.,Line No.);
                        PrintOnlyIfDetail = false;
                        column(Sales_Line__Sales_Line___Outstanding_Quantity_;"Sales Line"."Outstanding Quantity")
                        {
                        }
                        column(Sales_Line__Sales_Line___Quantity_Shipped_;"Sales Line"."Quantity Shipped")
                        {
                        }
                        column(Sales_Line__Sales_Line__Quantity;"Sales Line".Quantity)
                        {
                        }
                        column(Sales_Line__Sales_Line__Description;"Sales Line".Description)
                        {
                        }
                        column(Sales_Line__Sales_Line___No__;"Sales Line"."No.")
                        {
                        }
                        column(ItemInventory;ItemInventory)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(item__Shelf_No__;item."Shelf No.")
                        {
                        }
                        column(Sales_Line__Sales_Line__Description_Control1000000133;"Sales Line".Description)
                        {
                        }
                        column(STRSUBSTNO_FORMAT__Sales_Line___Qty__to_Ship___Gross_Weight___;STRSUBSTNO(FORMAT("Sales Line"."Qty. to Ship"*"Gross Weight")))
                        {
                        }
                        column(EAN13BarTxt;EAN13BarTxt)
                        {
                        }
                        column(NetWeight;NetWeight)
                        {
                        }
                        column(GrossWeight;GrossWeight)
                        {
                        }
                        column(To_prepareCaption;To_prepareCaptionLbl)
                        {
                        }
                        column(DeliveredCaption;DeliveredCaptionLbl)
                        {
                        }
                        column(QuantityCaption;QuantityCaptionLbl)
                        {
                        }
                        column(OrderCaption;OrderCaptionLbl)
                        {
                        }
                        column(DescriptionCaption;DescriptionCaptionLbl)
                        {
                        }
                        column(ItemCaption;ItemCaptionLbl)
                        {
                        }
                        column(Shelf_No_Caption;Shelf_No_CaptionLbl)
                        {
                        }
                        column(InventoryCaption;InventoryCaptionLbl)
                        {
                        }
                        column(NextCaption;NextCaptionLbl)
                        {
                        }
                        column(ItemCaption_Control1000000067;ItemCaption_Control1000000067Lbl)
                        {
                        }
                        column(To_prepareCaption_Control1000000096;To_prepareCaption_Control1000000096Lbl)
                        {
                        }
                        column(DeliveredCaption_Control1000000110;DeliveredCaption_Control1000000110Lbl)
                        {
                        }
                        column(QuantityCaption_Control1000000118;QuantityCaption_Control1000000118Lbl)
                        {
                        }
                        column(OrderCaption_Control1000000119;OrderCaption_Control1000000119Lbl)
                        {
                        }
                        column(DescriptionCaption_Control1000000121;DescriptionCaption_Control1000000121Lbl)
                        {
                        }
                        column(Shelf_No_Caption_Control1000000123;Shelf_No_Caption_Control1000000123Lbl)
                        {
                        }
                        column(InventoryCaption_Control1000000126;InventoryCaption_Control1000000126Lbl)
                        {
                        }
                        column(Gross_WeightCaption;Gross_WeightCaptionLbl)
                        {
                        }
                        column(To_be_continuedCaption;To_be_continuedCaptionLbl)
                        {
                        }
                        column(Net_WeightCaption;Net_WeightCaptionLbl)
                        {
                        }
                        column(GrossWeightCaption;GrossWeightCaptionLbl)
                        {
                        }
                        column(Sales_Line_Document_Type;"Document Type")
                        {
                        }
                        column(Sales_Line_Document_No_;"Document No.")
                        {
                        }
                        column(Sales_Line_Line_No_;"Line No.")
                        {
                        }
                        column(SalesLineType;FORMAT("Sales Line".Type,0,9))
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //                                     PRM
                            IF "Gross Weight" <> 0 THEN BEGIN
                              tempcalc := "Qty. to Ship"*"Gross Weight";
                              GrossWeight := GrossWeight + (tempcalc);
                              tempcalc := "Qty. to Ship"*"Net Weight";
                              NetWeight := NetWeight + (tempcalc);
                            END;
                            //                                     PRM

                            //STOCK SL 06/10/06 Ajout de la colonne stock
                            ItemInventory := 0;
                            item.RESET ;
                            IF item.GET("No.") THEN BEGIN
                              item.SETRANGE("Location Filter","Location Code");
                              item.CALCFIELDS(Inventory);
                              ItemInventory := item.Inventory;
                            END;
                            //Fin STOCK SL 06/10/06 Ajout de la colonne stock

                            //>>FEP-ACHAT-200706_18_A.001
                            IF (BooGRespectLinesPrep) AND NOT ("Sales Line"."To Prepare") THEN
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
                                  EAN13Bar := COPYSTR(DistInt.GetItemEAN13Code("No."),1,MAXSTRLEN(EAN13Bar));
                                  IF EAN13Bar <> '' THEN
                                    BEGIN
                                      CLEAR(ConvertAutoIDEAN13);
                                      EAN13BarTxt := ConvertAutoIDEAN13.EncodeBarcodeEAN13(EAN13Bar,EAN13Txt);
                                  END;
                                  END;
                              END;
                            END;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "80";
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    VATAmountLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header",SalesLine,0);
                    SalesLine.SETRANGE("Line No.",0,SalesLine."Line No.");

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
                    IF NoOfLoops >0 THEN
                      SETRANGE(Number,1,NoOfLoops)
                    ELSE
                    SETRANGE(Number,0,0);

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
                  Pays:= Country.Name;
                
                //PRM fin
                
                
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                  CompanyInfo.GET;
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
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
                ELSE IF "Requested Delivery Date" <> 0D THEN
                  ShipmentDate := "Requested Delivery Date";
                //Fin NATURE_COMMANDE SL 14/09/06 NSC1.05  Ajout de l'interlocuteur principal basé sur axe analytique 1
                
                
                
                //TECSO 08/12/03 CST : Lecture des mode de règlement (Payment Methode)
                ModeDePayment:= '';
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
                IF ("Your Reference" = '') AND ("External Document No." = '' ) THEN
                  //ReferenceText := ''
                  VotreRef := ''
                ELSE
                  BEGIN
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
                  TotalText := STRSUBSTNO(Text001,GLSetup."LCY Code");
                  TotalInclVATText := STRSUBSTNO(Text002,GLSetup."LCY Code");
                  TotalExclVATText := STRSUBSTNO(Text006,GLSetup."LCY Code");
                END ELSE BEGIN
                  TotalText := STRSUBSTNO(Text001,"Currency Code");
                  TotalInclVATText := STRSUBSTNO(Text002,"Currency Code");
                  TotalExclVATText := STRSUBSTNO(Text006,"Currency Code");
                END;
                
                //TECSO 06/01/2004 CST : Adresse à imprimer = adresse de commande et non pas adresse de Facturation
                //FormatAddr.SalesHeaderBillTo(CustAddr,"Sales Header");
                FormatAddr.SalesHeaderSellTo(CustAddr,"Sales Header");
                //Fin
                
                // SDU Lecture Mode transport
                ModeTransport:='';
                IF ShippingAgent.GET("Sales Header"."Shipping Agent Code") THEN
                   ModeTransport:=ShippingAgent.Name;
                
                
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
                  PrestaTrans.GET("Sales Header"."Shipping Agent Code","Sales Header"."Shipping Agent Service Code");
                
                
                FormatAddr.SalesHeaderShipTo(ShipToAddr,CustAddr,"Sales Header");
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
                RecGSalesLine.SETCURRENTKEY("Document Type","Document No.","Line No.");
                RecGSalesLine.SETRANGE(RecGSalesLine."Document Type","Sales Header"."Document Type");
                RecGSalesLine.SETRANGE(RecGSalesLine."Document No.","Sales Header"."No.");
                RecGSalesLine.SETRANGE(RecGSalesLine."To Prepare",TRUE);
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
                    field(NoOfCopies;NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(BooGRespectLinesPrep;BooGRespectLinesPrep)
                    {
                        Caption = 'Respect Lines To Prepare';
                    }
                    field(ShowInternalInfo;ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                        Visible = false;
                    }
                    field(ArchiveDocument;ArchiveDocument)
                    {
                        Caption = 'Archive Document';
                        Enabled = BooGEnableArchiveDocument;
                        Visible = false;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        Caption = 'Log Interaction';
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
            BooGEnableLogInteraction  := LogInteraction ;
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
        CompanyInfo1.CALCFIELDS("Alt Picture");
        //<<MIGRATION NAV 2013
    end;

    var
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Order Confirmation %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 Excl. VAT"';
        GLSetup: Record "98";
        ShipmentMethod: Record "10";
        PaymentTerms: Record "3";
        SalesPurchPerson: Record "13";
        CompanyInfo: Record "79";
        VATAmountLine: Record "290" temporary;
        SalesLine: Record "37" temporary;
        DocDim1: Record "480";
        DocDim2: Record "480";
        RespCenter: Record "5714";
        Language: Record "8";
        SalesCountPrinted: Codeunit "313";
        FormatAddr: Codeunit "365";
        SegManagement: Codeunit "5051";
        ArchiveManagement: Codeunit "5063";
        PrestaTrans: Record "5790";
        ShippingAgent: Record "291";
        ModeTransport: Text[30];
        Country: Record "9";
        CustAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
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
        Text008: Label 'de commande';
        CompteurDeLigne: Integer;
        PaymentMethod: Record "289";
        ModeDePayment: Text[30];
        VotreRef: Text[200];
        PrixNet: Decimal;
        Text10: Text[200];
        Text20: Text[200];
        Text30: Text[200];
        Text40: Text[200];
        Text50: Text[200];
        TmpNamereport: Text[30];
        Text016: Label 'INVOICE DEPARTMENT';
        Text030: Label '%1 - %2 - %3 %4';
        Text032: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5';
        LangueLig01: Text[10];
        LangueLig10: Text[10];
        LangueLig20: Text[10];
        LangueLig30: Text[10];
        LangueLig40: Text[10];
        LangueLig50: Text[10];
        TablesDiverses: Record "50001";
        Langue: Text[10];
        ListeTable: Text[10];
        Text000: Label 'Salesperson';
        customer: Record "18";
        TempGencod: Text[30];
        ItemCrossReference: Record "5717";
        CrossrefNo: Text[20];
        item: Record "27";
        templibelledouanier: Text[30];
        tempcalc: Decimal;
        GrossWeight: Decimal;
        NetWeight: Decimal;
        FlagSaleCommentLine: Boolean;
        StandardCustomerSalesCode: Record "172";
        StandardSalesLine: Record "171";
        FlagText: Boolean;
        Edition: Boolean;
        Edition2: Boolean;
        Pays: Text[30];
        "--NSC1.01--": Integer;
        EditerToutesLignes: Boolean;
        SalesCommentLine: Record "44";
        "--NSC1.10--": Integer;
        PrincipalContact: Code[10];
        DocDimension: Record "480";
        DimensionValue: Record "349";
        PrincContactName: Text[50];
        ShipmentDate: Date;
        "--NSC1.11--": Integer;
        ItemInventory: Decimal;
        "-FEP-ACHAT-200706_18_A -": Integer;
        BooGRespectLinesPrep: Boolean;
        RecGSalesLine: Record "37";
        EAN13BarTxt: Text[120];
        EAN13Txt: Text[13];
        EAN13Bar: Text[13];
        DistInt: Codeunit "5702";
        ConvertAutoIDEAN13: Codeunit "50099";
        Shipment_departementCaptionLbl: Label 'Shipment departement';
        ReferenceCaptionLbl: Label 'Reference';
        VAT_Registration_No__CaptionLbl: Label '<VAT Registration No.>';
        ShipmentCaptionLbl: Label 'Shipment';
        DateCaptionLbl: Label 'Date';
        Order_NumberCaptionLbl: Label 'Order Number';
        Customer_NumberCaptionLbl: Label 'Customer Number';
        Shipping_ServiceCaptionLbl: Label 'Shipping Service';
        bill_DepartementCaptionLbl: Label 'bill Departement';
        Preparation_OrderCaptionLbl: Label 'Preparation Order';
        ShippingCaptionLbl: Label 'Shipping';
        Shipping_conditionCaptionLbl: Label 'Shipping condition';
        UserCaptionLbl: Label 'User';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Preparation_and_shipping_instructions__CaptionLbl: Label 'Preparation and shipping instructions :';
        To_prepareCaptionLbl: Label 'To prepare';
        DeliveredCaptionLbl: Label 'Delivered';
        QuantityCaptionLbl: Label 'Quantity';
        OrderCaptionLbl: Label 'Order';
        DescriptionCaptionLbl: Label 'Description';
        ItemCaptionLbl: Label 'Item';
        Shelf_No_CaptionLbl: Label 'Shelf No.';
        InventoryCaptionLbl: Label 'Inventory';
        NextCaptionLbl: Label 'Next';
        ItemCaption_Control1000000067Lbl: Label 'Item';
        To_prepareCaption_Control1000000096Lbl: Label 'To prepare';
        DeliveredCaption_Control1000000110Lbl: Label 'Delivered';
        QuantityCaption_Control1000000118Lbl: Label 'Quantity';
        OrderCaption_Control1000000119Lbl: Label 'Order';
        DescriptionCaption_Control1000000121Lbl: Label 'Description';
        Shelf_No_Caption_Control1000000123Lbl: Label 'Shelf No.';
        InventoryCaption_Control1000000126Lbl: Label 'Inventory';
        Gross_WeightCaptionLbl: Label 'Gross Weight';
        To_be_continuedCaptionLbl: Label 'To be continued';
        Net_WeightCaptionLbl: Label 'Net Weight';
        GrossWeightCaptionLbl: Label 'Gross Weight';
        "-MIGNAV2013-": Integer;
        OutputNo: Integer;
        CompanyInfo1: Record "79";
        CompanyInfo2: Record "79";
}

