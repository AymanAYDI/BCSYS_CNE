report 50747 "BC6_Invt. Pick2"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/InvtPick2.rdl';
    Caption = 'Picking List', Comment = 'FRA="Prélèvement stock"';

    dataset
    {
        dataitem(WhseActivityHeader; "Warehouse Activity Header")
        {
            DataItemTableView = SORTING(Type, "No.")
                                ORDER(Ascending)
                                WHERE(Type = CONST("Invt. Pick"));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Location Code", "No. Printed";
            column(WhseActivityHeader_Type; Type)
            {
            }
            column(WhseActivityHeader_No_; "No.")
            {
            }
            dataitem(Copy; Integer)
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = true;
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        ORDER(Ascending)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo__Alt_Picture_; CompanyInfo."BC6_Alt Picture")
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(ShipToAddr_4_; ShipToAddr[4])
                    {
                    }
                    column(BillToAddr_4_; BillToAddr[4])
                    {
                    }
                    column(ShipToAddr_3_; ShipToAddr[3])
                    {
                    }
                    column(BillToAddr_3_; BillToAddr[3])
                    {
                    }
                    column(ShipToAddr_2_; ShipToAddr[2])
                    {
                    }
                    column(BillToAddr_2_; BillToAddr[2])
                    {
                    }
                    column(ShipToAddr_1_; ShipToAddr[1])
                    {
                    }
                    column(BillToAddr_1_; BillToAddr[1])
                    {
                    }
                    column(WhseActivityHeader__No__; WhseActivityHeader."No.")
                    {
                    }
                    column(BarCodeNo; BarCodeNo)
                    {
                    }
                    column(InvtPickCheckTxt; InvtPickCheckTxt)
                    {
                    }
                    column(WhseActivityHeader__Destination_No__; WhseActivityHeader."Destination No.")
                    {
                    }
                    column(YourRef; YourRef)
                    {
                    }
                    column(WhseActivityHeader__Destination_Type_; WhseActivityHeader."Destination Type")
                    {
                    }
                    column(WhseActivityHeader__Source_No__; WhseActivityHeader."Source No.")
                    {
                    }
                    column(FORMAT_WhseActivityHeader__Source_Document__; FORMAT(WhseActivityHeader."Source Document"))
                    {
                    }
                    column(ShipmentMethodTxt; ShipmentMethodTxt)
                    {
                    }
                    column(WhseActivityHeader__Location_Code_; WhseActivityHeader."Location Code")
                    {
                    }
                    column(ShippingAgentTxt; ShippingAgentTxt)
                    {
                    }
                    column(FORMAT_TODAY_0_; FORMAT(TODAY, 0))
                    {
                    }
                    column("USERID"; USERID)
                    {
                    }
                    column(DeliveryDate; DeliveryDate)
                    {
                    }
                    column(OrderDate; OrderDate)
                    {
                    }
                    column(SalesPersonName; SalesPersonName)
                    {
                    }
                    column(CurrReport_PAGENO; CurrReport.PAGENO)
                    {
                    }
                    column(WhseActivityHeader__Sales_Counter_; WhseActivityHeader."BC6_Sales Counter")
                    {
                    }
                    column(WhseActivityHeader__Bin_Code_; WhseActivityHeader."BC6_Bin Code")
                    {
                    }
                    column(WhseActivityHeader__Destination_Name_; WhseActivityHeader."BC6_Destination Name")
                    {
                    }
                    column(WhseActivityHeader_Comments; WhseActivityHeader.BC6_Comments)
                    {
                    }
                    column(DataItem1000000002; STRSUBSTNO(Text032, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
                    {
                    }
                    column(STRSUBSTNO_Text006_CompanyInfo__Alt_Phone_No___CompanyInfo__Alt_Fax_No___CompanyInfo__Alt_E_Mail__; STRSUBSTNO(Text006, CompanyInfo."BC6_Alt Phone No.", CompanyInfo."BC6_Alt Fax No.", CompanyInfo."BC6_Alt E-Mail"))
                    {
                    }
                    column(DataItem1000000007; CompanyInfo."BC6_Alt Address" + ' ' + CompanyInfo."BC6_Alt Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."BC6_Alt Post Code", CompanyInfo."BC6_Alt City"))
                    {
                    }
                    column(STRSUBSTNO_Text006_CompanyInfo__Phone_No___CompanyInfo__Fax_No___CompanyInfo__E_Mail__; STRSUBSTNO(Text006, CompanyInfo."Phone No.", CompanyInfo."Fax No.", CompanyInfo."E-Mail"))
                    {
                    }
                    column(CompanyInfo_Address______CompanyInfo__Address_2______STRSUBSTNO___1__2__CompanyInfo__Post_Code__CompanyInfo_City_; CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."Post Code", CompanyInfo.City))
                    {
                    }
                    column(CompanyInfo__Alt_Name_; CompanyInfo."BC6_Alt Name")
                    {
                    }
                    column(CompanyInfo_Name; CompanyInfo.Name)
                    {
                    }
                    column(Inv__PickingCaption; Inv__PickingCaptionLbl)
                    {
                    }
                    column(Ship_To_AdressCaption; Ship_To_AdressCaptionLbl)
                    {
                    }
                    column(Bill_To_AdressCaption; Bill_To_AdressCaptionLbl)
                    {
                    }
                    column(WhseActivityHeader__No__Caption; WhseActivityHeader__No__CaptionLbl)
                    {
                    }
                    column(YourRefCaption; YourRefCaptionLbl)
                    {
                    }
                    column(WhseActivityHeader__Location_Code_Caption; WhseActivityHeader__Location_Code_CaptionLbl)
                    {
                    }
                    column(FORMAT_TODAY_0_Caption; FORMAT_TODAY_0_CaptionLbl)
                    {
                    }
                    column(USERIDCaption; USERIDCaptionLbl)
                    {
                    }
                    column(OrderDateCaption; OrderDateCaptionLbl)
                    {
                    }
                    column(DeliveryDateCaption; DeliveryDateCaptionLbl)
                    {
                    }
                    column(ShipmentMethodTxtCaption; ShipmentMethodTxtCaptionLbl)
                    {
                    }
                    column(ShippingAgentTxtCaption; ShippingAgentTxtCaptionLbl)
                    {
                    }
                    column(SalesPersonNameCaption; SalesPersonNameCaptionLbl)
                    {
                    }
                    column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                    {
                    }
                    column(WhseActivityHeader__Sales_Counter_Caption; WhseActivityHeader.FIELDCAPTION("BC6_Sales Counter"))
                    {
                    }
                    column(WhseActivityHeader__Bin_Code_Caption; WhseActivityHeader.FIELDCAPTION("BC6_Bin Code"))
                    {
                    }
                    column(WhseActivityHeader__Destination_Name_Caption; WhseActivityHeader__Destination_Name_CaptionLbl)
                    {
                    }
                    column(WhseActivityHeader_CommentsCaption; WhseActivityHeader_CommentsCaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(WhseActLine; "Warehouse Activity Line")
                    {
                        DataItemLink = "Activity Type" = FIELD(Type),
                                       "No." = FIELD("No.");
                        DataItemLinkReference = WhseActivityHeader;
                        DataItemTableView = SORTING("Activity Type", "No.", "Line No.");
                        column(WhseActLine__Bin_Code_; "Bin Code")
                        {
                        }
                        column(BinDescription; BinDescription)
                        {
                        }
                        column(WhseActLine__Item_No__; "Item No.")
                        {
                        }
                        column(WhseActLine_Description; Description)
                        {
                        }
                        column(QtyToPick; QtyToPick)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(WhseActLine__Bin_Code__Control1000000008; "Bin Code")
                        {
                        }
                        column(QtyToHandle; QtyToHandle)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(QtyToHandle_Control1000000039; QtyToHandle)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(QtyToPick_Control1000000055; QtyToPick)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(WhseActLine__Item_No___Control1000000057; "Item No.")
                        {
                        }
                        column(WhseActLine_Description_Control1000000058; Description)
                        {
                        }
                        column(GrossWeight; GrossWeight)
                        {
                        }
                        column(EAN13BarTxt; EAN13BarTxt)
                        {
                        }
                        column(EAN13Txt; EAN13Txt)
                        {
                        }
                        column(WhseActLine_Description_Control1000000064; Description)
                        {
                        }
                        column(QtyToPick_Control1000000033; QtyToPick)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(RemainingQty; RemainingQty)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(QtyToHandle_Control1000000042; QtyToHandle)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(GrossWeight_Control1000000020; GrossWeight)
                        {
                        }
                        column(WhseActLine__Item_No___Control1000000065; "Item No.")
                        {
                        }
                        column(RemainingQty_Control1000000047; RemainingQty)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(QtyToHandle_Control1000000050; QtyToHandle)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(QtyToPick_Control1000000051; QtyToPick)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(GrossWeight_Control1000000052; GrossWeight)
                        {
                        }
                        column(RemainingQtyCaption; RemainingQtyCaptionLbl)
                        {
                        }
                        column(WhseActLine_DescriptionCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(WhseActLine__Item_No__Caption; FIELDCAPTION("Item No."))
                        {
                        }
                        column(QtyToPickCaption; QtyToPickCaptionLbl)
                        {
                        }
                        column(WhseActLine__Bin_Code__Control1000000008Caption; FIELDCAPTION("Bin Code"))
                        {
                        }
                        column(QtyToHandleCaption; QtyToHandleCaptionLbl)
                        {
                        }
                        column(Gross_WeightCaption; Gross_WeightCaptionLbl)
                        {
                        }
                        column(Items_To_PickCaption; Items_To_PickCaptionLbl)
                        {
                        }
                        column(TOTALCaption; TOTALCaptionLbl)
                        {
                        }
                        column(WhseActLine_Activity_Type; "Activity Type")
                        {
                        }
                        column(WhseActLine_No_; "No.")
                        {
                        }
                        column(WhseActLine_Line_No_; "Line No.")
                        {
                        }
                        dataitem(EmptyLine; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                ORDER(Ascending);
                            column(EmptyLine_Number; Number)
                            {
                            }

                            trigger OnPreDataItem()
                            begin
                                CurrReport.BREAK;
                                SETRANGE(Number, 1, EmptyLines);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Quantity = 0 THEN
                                CurrReport.SKIP;

                            CLEAR(UnitCode);
                            CLEAR(DueDate);
                            CLEAR(RemainingQty);
                            CLEAR(QtyToPick);
                            CLEAR(Item);
                            Item.GET("Item No.");
                            // UnitCode := Item."Base Unit of Measure";
                            UnitCode := "Unit of Measure Code";
                            // QtyToPick := "Qty. (Base)";
                            QtyToPick := Quantity;
                            // QtyToHandle := "Qty. to Handle (Base)";
                            QtyToHandle := "Qty. to Handle";
                            // NetWeight := Item."Net Weight" * "Qty. (Base)";
                            // GrossWeight := Item."Gross Weight" * "Qty. (Base)";
                            CLEAR(Bin);
                            CLEAR(BinDescription);
                            IF Bin.GET("Location Code", "Bin Code") THEN
                                BinDescription := Bin.Description;

                            //>> 19.03.2012 PT17
                            GetLocation("Location Code");
                            IF ("Bin Code" = Location."Receipt Bin Code") THEN BEGIN
                                CLEAR(BarcodeMngt);
                                EAN13Bar := '';
                                EAN13Txt := '';
                                EAN13BarTxt := '';
                                CLEAR(DistInt);
                                EAN13Bar := COPYSTR(FunctionsMgt.GetItemEAN13Code("Item No."), 1, MAXSTRLEN(EAN13Bar));
                                IF (EAN13Bar <> '') THEN
                                    EAN13BarTxt := BarcodeMngt.EncodeBarcodeEAN13(EAN13Bar, EAN13Txt);
                            END;

                            CASE "Source Document" OF
                                "Source Document"::"Sales Order":
                                    BEGIN
                                        // Sales Line
                                        SalesLine.GET(WhseActLine."Source Subtype", WhseActLine."Source No.", WhseActLine."Source Line No.");
                                        IF NOT TmpSalesLine.GET(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.") THEN BEGIN
                                            TmpSalesLine.INIT;
                                            TmpSalesLine := SalesLine;
                                            TmpSalesLine.INSERT;
                                            RemainingQty := SalesLine."Outstanding Quantity";
                                        END;

                                        DueDate := SalesLine."Shipment Date";
                                        // RemainingQty := SalesLine."Outstanding Qty. (Base)";
                                        NetWeight := SalesLine."Net Weight" * QtyToPick;
                                        GrossWeight := SalesLine."Gross Weight" * QtyToPick;
                                    END;
                                "Source Document"::"Outbound Transfer":
                                    BEGIN
                                        // Transfer Line
                                        TransferLine.GET(WhseActLine."Source No.", WhseActLine."Source Line No.");
                                        "Due Date" := TransferLine."Shipment Date";
                                        // RemainingQty := TransferLine."Outstanding Qty. (Base)";
                                        RemainingQty := TransferLine."Outstanding Quantity";
                                        NetWeight := TransferLine."Net Weight" * QtyToPick;
                                        GrossWeight := TransferLine."Gross Weight" * QtyToPick;
                                    END;
                                "Source Document"::"Purchase Return Order":
                                    BEGIN
                                        // Return Line
                                        ReturnLine.GET(WhseActLine."Source Subtype", WhseActLine."Source No.", WhseActLine."Source Line No.");
                                        // "Due Date" := ReturnLine."Shipment Date";
                                        // RemainingQty := ReturnLine."Outstanding Qty. (Base)";
                                        RemainingQty := ReturnLine."Outstanding Quantity";
                                        NetWeight := ReturnLine."Net Weight" * QtyToPick;
                                        GrossWeight := ReturnLine."Gross Weight" * QtyToPick;
                                    END;

                            END;
                        end;

                        trigger OnPostDataItem()
                        begin
                            //
                            TmpSalesLine2.RESET;
                            TmpSalesLine2.DELETEALL;
                            CASE "Source Document" OF
                                "Source Document"::"Sales Order":
                                    BEGIN

                                        WhseActLine2.RESET;
                                        WhseActLine2.COPY(WhseActLine);
                                        WhseActLine2.SETRANGE("Source Type", 37);
                                        WhseActLine2.SETRANGE("Source Subtype", 1);
                                        WhseActLine2.SETRANGE("Source Document", WhseActLine2."Source Document"::"Sales Order");

                                        // Sales Line
                                        SalesLine.RESET;
                                        SalesLine.SETRANGE("Document Type", WhseActLine."Source Subtype");
                                        SalesLine.SETRANGE("Document No.", WhseActLine."Source No.");
                                        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                                        IF SalesLine.FINDSET(FALSE, FALSE) THEN
                                            REPEAT
                                                CLEAR(RemainingQty2);
                                                CLEAR(QtyToPick2);
                                                IF NOT TmpSalesLine.GET(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.") THEN BEGIN
                                                    RemainingQty2 := SalesLine."Outstanding Quantity";
                                                END ELSE BEGIN
                                                    WhseActLine2.SETRANGE("Source No.", SalesLine."Document No.");
                                                    WhseActLine2.SETRANGE("Source Line No.", SalesLine."Line No.");
                                                    IF WhseActLine2.FINDSET(FALSE, FALSE) THEN
                                                        REPEAT
                                                            QtyToPick2 += WhseActLine2.Quantity;
                                                        UNTIL WhseActLine2.NEXT = 0;
                                                    RemainingQty2 := SalesLine."Outstanding Quantity" - QtyToPick2;
                                                END;

                                                IF (RemainingQty2 > 0) THEN BEGIN
                                                    TmpSalesLine2.INIT;
                                                    TmpSalesLine2 := SalesLine;
                                                    TmpSalesLine2."Outstanding Quantity" := RemainingQty2;
                                                    TmpSalesLine2.INSERT;
                                                END;

                                            UNTIL SalesLine.NEXT = 0;
                                    END;
                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CASE SortingMethod OF
                                SortingMethod::Item:
                                    SETCURRENTKEY("Activity Type", "No.", "Item No.", "Variant Code", "Action Type", "Bin Code");
                                SortingMethod::Bin:
                                    SETCURRENTKEY("Activity Type", "No.", "Action Type", "Bin Code");
                            END;
                            SETRANGE("Activity Type", "Activity Type"::"Invt. Pick");
                            CurrReport.CREATETOTALS(QtyToPick, QtyToHandle, RemainingQty, NetWeight, GrossWeight);

                            TmpSalesLine.RESET;
                            TmpSalesLine.DELETEALL;
                        end;
                    }
                    dataitem(OutStockLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            ORDER(Ascending);
                        column(WhseActivityHeaderNo; WhseActivityHeaderNo)
                        {
                        }
                        column(TmpSalesLine2_Description; TmpSalesLine2.Description)
                        {
                        }
                        column(TmpSalesLine2__No__; TmpSalesLine2."No.")
                        {
                        }
                        column(RemainingQty_Control1000000113; RemainingQty)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(AvailableQty; AvailableQty)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(Out_StockCaption; Out_StockCaptionLbl)
                        {
                        }
                        column(Pick_NoCaption; Pick_NoCaptionLbl)
                        {
                        }
                        column(Available_QtyCaption; Available_QtyCaptionLbl)
                        {
                        }
                        column(OutStockLoop_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF (Number = 1) THEN
                                TmpSalesLine2.FINDFIRST ELSE
                                IF (TmpSalesLine2.NEXT = 0) THEN
                                    CurrReport.BREAK;

                            CLEAR(WhseActivityHeaderNo);
                            CLEAR(UnitCode);
                            CLEAR(DueDate);
                            CLEAR(RemainingQty);
                            CLEAR(QtyToPick);
                            CLEAR(AvailableQty);
                            CLEAR(Item);
                            IF TmpSalesLine2.Type = TmpSalesLine2.Type::Item THEN BEGIN
                                Item.GET(TmpSalesLine2."No.");

                                UnitCode := TmpSalesLine2."Unit of Measure Code";
                                RemainingQty := TmpSalesLine2."Outstanding Quantity";
                                NetWeight := TmpSalesLine2."Net Weight" * RemainingQty;
                                GrossWeight := TmpSalesLine2."Gross Weight" * RemainingQty;

                                //>>
                                WhseActLine3.SETRANGE("Source No.", TmpSalesLine2."Document No.");
                                WhseActLine3.SETRANGE("Source Line No.", TmpSalesLine2."Line No.");
                                IF WhseActLine3.FINDFIRST THEN
                                    //  REPEAT
                                    WhseActivityHeaderNo := WhseActLine3."No.";
                                // UNTIL WhseActLine3.NEXT = 0;
                                IF WhseActivityHeader."Location Code" <> '' THEN
                                    Item.SETRANGE("Location Filter", WhseActivityHeader."Location Code");
                                AvailableQty := Item.CalcQtyAvailToPick(0);
                                Item.SETRANGE("Location Filter");

                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowOutStock THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, TmpSalesLine2.COUNT);
                            CurrReport.CREATETOTALS(QtyToPick, QtyToHandle, RemainingQty, NetWeight, GrossWeight);

                            CASE WhseActivityHeader."Source Document" OF
                                WhseActivityHeader."Source Document"::"Sales Order":
                                    BEGIN
                                        WhseActLine3.RESET;
                                        WhseActLine3.SETRANGE("Source Type", 37);
                                        WhseActLine3.SETRANGE("Source Subtype", 1);
                                        WhseActLine3.SETRANGE("Source Document", WhseActLine2."Source Document"::"Sales Order");
                                    END;
                            END;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF (Number > 1) THEN
                        CopyText := Text001;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT (WhseActivityHeader."Source Document" IN
                       [WhseActivityHeader."Source Document"::"Sales Order",
                       WhseActivityHeader."Source Document"::"Outbound Transfer",
                       WhseActivityHeader."Source Document"::"Purchase Return Order"])
                       THEN
                    CurrReport.SKIP;

                // IF (WhseActivityHeader."Source Document" = WhseActivityHeader."Source Document"::"Sales Order") AND
                //   (WhseActivityHeader."Source No." = '') THEN
                //     CurrReport.SKIP;

                CLEAR(ExtDocNo);
                CLEAR(YourRef);
                CLEAR(FormatAddr);
                CLEAR(TransferHeader);
                CLEAR(TransferLine);
                CLEAR(SalesHeader);
                CLEAR(SalesLine);
                CLEAR(ReturnHeader);
                CLEAR(ReturnLine);
                CLEAR(BarcodeMngt);
                CLEAR(BarCodeNo);
                BarCodeNo := BarcodeMngt.EncodeBarcode39("No.");
                CLEAR(DeliveryDate);
                CLEAR(SalesPerson);
                CLEAR(SalesPersonName);
                CLEAR(ShippingAgent);
                CLEAR(ShippingAgentTxt);
                CLEAR(ShipmentMethod);
                CLEAR(ShipmentMethodTxt);
                CLEAR(Cust);
                CLEAR(InvtPickCheckTxt);

                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);
                CompanyInfo.CALCFIELDS("BC6_Alt Picture");

                GetLocation("Location Code");
                CASE WhseActivityHeader."Source Document" OF
                    WhseActivityHeader."Source Document"::"Sales Order":
                        BEGIN
                            IF NOT WhseActivityHeader."BC6_Sales Counter" THEN
                                SalesHeader.GET(WhseActivityHeader."Source Document", WhseActivityHeader."Source No.")
                            ELSE BEGIN
                                IF "Destination No." = '' THEN
                                    ERROR(Text002);

                                Cust.GET("Destination No.");
                                SalesHeader.INIT;
                                SalesHeader."Sell-to Customer No." := Cust."No.";
                                SalesHeader."Sell-to Customer Name" := Cust.Name;
                                SalesHeader."Sell-to Customer Name 2" := Cust."Name 2";
                                SalesHeader."Sell-to Address" := Cust.Address;
                                SalesHeader."Sell-to Address 2" := Cust."Address 2";
                                SalesHeader."Sell-to City" := Cust.City;
                                SalesHeader."Sell-to Contact" := Cust.Contact;
                            END;


                            // FormatAddr.Company(CompanyAddr,CompanyInfo);

                            OrderDate := SalesHeader."Order Date";
                            DeliveryDate := SalesHeader."Requested Delivery Date";
                            IF SalesHeader."Promised Delivery Date" <> 0D THEN
                                DeliveryDate := SalesHeader."Promised Delivery Date";
                            IF ShippingAgent.GET(SalesHeader."Shipping Agent Code") THEN;
                            ShippingAgentTxt := ShippingAgent.Name;
                            IF ShipmentMethod.GET(SalesHeader."Shipment Method Code") THEN
                                ShipmentMethodTxt := ShipmentMethod.Description;
                            IF SalesPerson.GET(SalesHeader."Salesperson Code") THEN
                                SalesPersonName := SalesPerson.Name;
                            ShipmentMethodTxt := ShipmentMethod.Description;
                            ExtDocNo := SalesHeader."External Document No.";
                            YourRef := "BC6_Your Reference";
                            IF NOT ShipmentMethod."BC6_To Make Available" THEN
                                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustToAddr, SalesHeader);
                            FormatAddr.SalesHeaderSellTo(BillToAddr, SalesHeader);
                        END;
                    WhseActivityHeader."Source Document"::"Outbound Transfer":
                        BEGIN
                            OrderDate := TransferHeader."Posting Date";
                            DeliveryDate := TransferHeader."Shipment Date";
                            TransferHeader.GET(WhseActivityHeader."Source No.");
                            ExtDocNo := TransferHeader."External Document No.";
                            FormatAddr.TransferHeaderTransferTo(ShipToAddr, TransferHeader);
                        END;
                    WhseActivityHeader."Source Document"::"Purchase Return Order":
                        BEGIN
                            ReturnHeader.GET(ReturnHeader."Document Type"::"Return Order", WhseActivityHeader."Source No.");
                            // ExtDocNo := ReturnHeader."External Document No.";
                            FormatAddr.PurchHeaderShipTo(ShipToAddr, ReturnHeader);
                        END;
                END;

                IF SortingMethod = SortingMethod::Item THEN
                    InvtPickCheckTxt := Text004;

                IF NOT CurrReport.PREVIEW THEN
                    WhseCountPrinted.RUN(WhseActivityHeader);
            end;
        }
    }
    trigger OnInitReport()
    begin
        // SortingMethod := SortingMethod::Bin;
        // BinDetailed := FALSE;
        // ShowOutStock := TRUE;
    end;

    var
        CompanyInfo: Record "Company Information";
        Location: Record Location;
        Cust: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TmpSalesLine: Record "Sales Line" temporary;
        TmpSalesLine2: Record "Sales Line" temporary;
        WhseActLine2: Record "Warehouse Activity Line";
        WhseActLine3: Record "Warehouse Activity Line";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        ReturnHeader: Record "Purchase Header";
        ReturnLine: Record "Purchase Line";
        Item: Record Item;
        FormatAddr: Codeunit "Format Address";
        WhseCountPrinted: Codeunit "Whse.-Printed";
        Counter: Integer;
        EmptyLines: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        NoOfCopies: Integer;
        ShipToAddr: array[8] of Text[50];
        Text001: Label 'Copie', Comment = 'FRA="Copie"';
        BillToAddr: array[8] of Text[50];
        CustToAddr: array[8] of Text[50];
        UnitCode: Code[10];
        DueDate: Date;
        RemainingQty: Decimal;
        RemainingQty2: Decimal;
        QtyToPick: Decimal;
        QtyToPick2: Decimal;
        QtyToHandle: Decimal;
        ExtDocNo: Code[20];
        YourRef: Text[30];
        BarCodeNo: Code[20];
        BarcodeMngt: Codeunit "BC6_Barcode Mngt AutoID";
        DeliveryDate: Date;
        OrderDate: Date;
        ShippingAgent: Record "Shipping Agent";
        ShipmentMethod: Record "Shipment Method";
        ShippingAgentTxt: Text[50];
        SalesPerson: Record "Salesperson/Purchaser";
        SalesPersonName: Text[50];
        ShipmentMethodTxt: Text[50];
        Text032: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - N°TVA : %5"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="TEL : %1 FAX : %2 / email : %3"';
        GrossWeight: Decimal;
        NetWeight: Decimal;
        SortingMethod: Option Item,Bin;
        BinDescription: Text[50];
        Bin: Record Bin;
        BinDetailed: Boolean;
        Text002: Label 'Vente comptoire, vous devez renseigner le n° du client ?', Comment = 'FRA="Vente comptoire, vous devez renseigner le n° du client ?"';
        WhseActivityHeaderNo: Code[20];
        ShowOutStock: Boolean;
        AvailableQty: Decimal;
        Text004: Label 'Check Invt. Pick', Comment = 'FRA="EDITION DE CONTROLE"';
        InvtPickCheckTxt: Text[250];
        DistInt: Codeunit "Dist. Integration";
        FunctionsMgt: Codeunit "BC6_Functions Mgt";
        EAN13Txt: Text[13];
        EAN13Bar: Text[13];
        EAN13BarTxt: Text[120];
        Inv__PickingCaptionLbl: Label 'Inv. Picking', Comment = 'FRA="Prélèvement stock"';
        Ship_To_AdressCaptionLbl: Label 'Ship-To Adress', Comment = 'FRA="Adresse de livraison"';
        Bill_To_AdressCaptionLbl: Label 'Bill-To Adress', Comment = 'FRA="Adresse de commande"';
        WhseActivityHeader__No__CaptionLbl: Label 'Inv. Picking', Comment = 'FRA="Prélèvement stock"';
        YourRefCaptionLbl: Label 'Your Reference', Comment = 'FRA="Votre référence"';
        WhseActivityHeader__Location_Code_CaptionLbl: Label 'Location Code', Comment = 'FRA="Code magasin"';
        FORMAT_TODAY_0_CaptionLbl: Label 'Print Date', Comment = 'FRA="Date imp."';
        USERIDCaptionLbl: Label 'User Code', Comment = 'FRA="Code utilisateur"';
        OrderDateCaptionLbl: Label 'Order Date', Comment = 'FRA="Date commande"';
        DeliveryDateCaptionLbl: Label 'Delivery Date', Comment = 'FRA="Date de livraison"';
        ShipmentMethodTxtCaptionLbl: Label 'Shipping condition', Comment = 'FRA="Condition de livraison"';
        ShippingAgentTxtCaptionLbl: Label 'Shipping Agent', Comment = 'FRA="Transporteur"';
        SalesPersonNameCaptionLbl: Label 'Sales Person', Comment = 'FRA="Vendeur"';
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        WhseActivityHeader__Destination_Name_CaptionLbl: Label 'Name', Comment = 'FRA="Nom"';
        WhseActivityHeader_CommentsCaptionLbl: Label 'Comments', Comment = 'FRA="Commentaires"';
        RemainingQtyCaptionLbl: Label 'Quantity To Ship', Comment = 'FRA="Quantité à expédier"';
        QtyToPickCaptionLbl: Label 'Qty', Comment = 'FRA="Quantité"';
        QtyToHandleCaptionLbl: Label 'Qty To Handle', Comment = 'FRA="Quantité à traiter"';
        Gross_WeightCaptionLbl: Label 'Gross Weight', Comment = 'FRA="Poids brut"';
        Items_To_PickCaptionLbl: Label 'Items To Pick', Comment = 'FRA="Références à prélever"';
        TOTALCaptionLbl: Label 'TOTAL', Comment = 'FRA="TOTAL"';
        Out_StockCaptionLbl: Label 'Out Stock', Comment = 'FRA="Références manquantes"';
        Pick_NoCaptionLbl: Label 'Pick No', Comment = 'FRA="N° prélèvement"';
        Available_QtyCaptionLbl: Label 'Available Qty', Comment = 'FRA="Quantité disponible"';

    procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN
            Location.INIT
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;

    procedure InitRequest(FromSortingMethod: Option Item,Bin; FromBinDetailed: Boolean; FromShowOutStock: Boolean)
    begin
        SortingMethod := FromSortingMethod;
        BinDetailed := FromBinDetailed;
        ShowOutStock := FromShowOutStock;
    end;
}

