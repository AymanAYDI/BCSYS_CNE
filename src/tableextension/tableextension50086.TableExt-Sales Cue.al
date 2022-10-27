tableextension 50086 tableextension50086 extends "Sales Cue"
{
    // ---------------------------------------------------------------
    //  Prodware - www.prodware.fr
    // ---------------------------------------------------------------
    // 
    // //>>CNE7.01
    // //>>P24233_001 SOBI APA 02/02/17
    //                     Add Field 50000..50007
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on ""Sales Quotes - Open"(Field 2)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Sales Orders - Open"(Field 3)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Sales Orders - Open"(Field 3)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Ready to Ship"(Field 4)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Ready to Ship"(Field 4)".


        //Unsupported feature: Property Modification (CalcFormula) on "Delayed(Field 5)".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Delayed(Field 5)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Sales Return Orders - Open"(Field 6)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Sales Return Orders - Open"(Field 6)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Sales Credit Memos - Open"(Field 7)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Partially Shipped"(Field 8)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Partially Shipped"(Field 8)".

        modify("Date Filter2")
        {
            Caption = 'Date Filter 2';
        }
        field(9; "Average Days Delayed"; Decimal)
        {
            AccessByPermission = TableData 110 = R;
            Caption = 'Average Days Delayed';
            DecimalPlaces = 1 : 1;
            Editable = false;
        }
        field(10; "Sales Inv. - Pending Doc.Exch."; Integer)
        {
            CalcFormula = Count ("Sales Invoice Header" WHERE (Document Exchange Status=FILTER(Sent to Document Exchange Service|Delivery Failed)));
            Caption = 'Sales Invoices - Pending Document Exchange';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12;"Sales CrM. - Pending Doc.Exch.";Integer)
        {
            CalcFormula = Count("Sales Cr.Memo Header" WHERE (Document Exchange Status=FILTER(Sent to Document Exchange Service|Delivery Failed)));
            Caption = 'Sales Credit Memos - Pending Document Exchange';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000;"Salesperson Filter";Text[250])
        {
            Caption = 'Responsibility Center Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50001;"Sales Quotes Salesperson-Open";Integer)
        {
            CalcFormula = Count("Sales Header" WHERE (Document Type=FILTER(Quote),
                                                      Status=FILTER(Open),
                                                      Responsibility Center=FIELD(Responsibility Center Filter),
                                                      Salesperson Filter=FIELD(Salesperson Filter)));
            Caption = 'Sales Quotes - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002;"Sales Orders Salesperson- Open";Integer)
        {
            CalcFormula = Count("Sales Header" WHERE (Document Type=FILTER(Order),
                                                      Status=FILTER(Open),
                                                      Responsibility Center=FIELD(Responsibility Center Filter),
                                                      Salesperson Filter=FILTER(Salesperson Filter)));
            Caption = 'Sales Orders - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003;"Ready to Ship Salesperson";Integer)
        {
            CalcFormula = Count("Sales Header" WHERE (Document Type=FILTER(Order),
                                                      Status=FILTER(Released),
                                                      Ship=FILTER(No),
                                                      Shipment Date=FIELD(Date Filter2),
                                                      Responsibility Center=FIELD(Responsibility Center Filter),
                                                      Salesperson Filter=FIELD(Salesperson Filter)));
            Caption = 'Ready to Ship';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004;"Delayed Salesperson";Integer)
        {
            CalcFormula = Count("Sales Header" WHERE (Document Type=FILTER(Order),
                                                      Status=FILTER(Released),
                                                      Shipment Date=FIELD(Date Filter),
                                                      Responsibility Center=FIELD(Responsibility Center Filter),
                                                      Salesperson Filter=FIELD(Salesperson Filter)));
            Caption = 'Delayed';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005;"Sales Return Orders Salesperso";Integer)
        {
            CalcFormula = Count("Sales Header" WHERE (Document Type=FILTER(Return Order),
                                                      Status=FILTER(Open),
                                                      Responsibility Center=FIELD(Responsibility Center Filter),
                                                      Salesperson Filter=FIELD(Salesperson Filter)));
            Caption = 'Sales Return Orders - All';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007;"Partially Shipped Salesperson";Integer)
        {
            CalcFormula = Count("Sales Header" WHERE (Document Type=FILTER(Order),
                                                      Status=FILTER(Released),
                                                      Ship=FILTER(Yes),
                                                      Completely Shipped=FILTER(No),
                                                      Shipment Date=FIELD(Date Filter2),
                                                      Responsibility Center=FIELD(Responsibility Center Filter),
                                                      Salesperson Filter=FIELD(Salesperson Filter)));
            Caption = 'Partially Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008;"Sales Return - Location";Integer)
        {
            CalcFormula = Count("Sales Header" WHERE (Document Type=FILTER(Return Order),
                                                      Return Order Type=FILTER(Location),
                                                      Status=FILTER(Open),
                                                      Responsibility Center=FIELD(Responsibility Center Filter)));
            Caption = 'Retours vente - Magasin';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009;"Sales Return - SAV";Integer)
        {
            CalcFormula = Count("Sales Header" WHERE (Document Type=FILTER(Return Order),
                                                      Return Order Type=FILTER(SAV),
                                                      Status=FILTER(Open),
                                                      Responsibility Center=FIELD(Responsibility Center Filter)));
            Caption = 'Retours vente - SAV';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    procedure CalculateAverageDaysDelayed() AverageDays: Decimal
    var
        SalesHeader: Record "36";
        SumDelayDays: Integer;
        CountDelayedInvoices: Integer;
    begin
        FilterOrders(SalesHeader,FIELDNO(Delayed));
        IF SalesHeader.FINDSET THEN BEGIN
          REPEAT
            SumDelayDays += MaximumDelayAmongLines(SalesHeader);
            CountDelayedInvoices += 1;
          UNTIL SalesHeader.NEXT = 0;
          AverageDays := SumDelayDays / CountDelayedInvoices;
        END;
    end;

    local procedure MaximumDelayAmongLines(SalesHeader: Record "36") MaxDelay: Integer
    var
        SalesLine: Record "37";
    begin
        MaxDelay := 0;
        SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.",SalesHeader."No.");
        SalesLine.SETFILTER("Shipment Date",'<%1&<>%2',WORKDATE,0D);
        IF SalesLine.FINDSET THEN
          REPEAT
            IF WORKDATE - SalesLine."Shipment Date" > MaxDelay THEN
              MaxDelay := WORKDATE - SalesLine."Shipment Date";
          UNTIL SalesLine.NEXT = 0;
    end;

    procedure CountOrders(FieldNumber: Integer): Integer
    var
        CountSalesOrders: Query "9060";
    begin
        CountSalesOrders.SETRANGE(Status,CountSalesOrders.Status::Released);
        CountSalesOrders.SETRANGE(Completely_Shipped,FALSE);
        FILTERGROUP(2);
        CountSalesOrders.SETFILTER(Responsibility_Center,GETFILTER("Responsibility Center Filter"));
        FILTERGROUP(0);

        CASE FieldNumber OF
          FIELDNO("Ready to Ship"):
            BEGIN
              CountSalesOrders.SETRANGE(Ship);
              CountSalesOrders.SETFILTER(Shipment_Date,GETFILTER("Date Filter2"));
            END;
          FIELDNO("Partially Shipped"):
            BEGIN
              CountSalesOrders.SETRANGE(Shipped,TRUE);
              CountSalesOrders.SETFILTER(Shipment_Date,GETFILTER("Date Filter2"));
            END;
          FIELDNO(Delayed):
            BEGIN
              CountSalesOrders.SETRANGE(Ship);
              CountSalesOrders.SETFILTER(Date_Filter,GETFILTER("Date Filter"));
              CountSalesOrders.SETRANGE(Late_Order_Shipping,TRUE);
            END;
        END;
        CountSalesOrders.OPEN;
        CountSalesOrders.READ;
        EXIT(CountSalesOrders.Count_Orders);
    end;

    local procedure FilterOrders(var SalesHeader: Record "36";FieldNumber: Integer)
    begin
        SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE(Status,SalesHeader.Status::Released);
        SalesHeader.SETRANGE("Completely Shipped",FALSE);
        CASE FieldNumber OF
          FIELDNO("Ready to Ship"):
            BEGIN
              SalesHeader.SETRANGE(Ship);
              SalesHeader.SETFILTER("Shipment Date",GETFILTER("Date Filter2"));
            END;
          FIELDNO("Partially Shipped"):
            BEGIN
              SalesHeader.SETRANGE(Shipped,TRUE);
              SalesHeader.SETFILTER("Shipment Date",GETFILTER("Date Filter2"));
            END;
          FIELDNO(Delayed):
            BEGIN
              SalesHeader.SETRANGE(Ship);
              SalesHeader.SETFILTER("Date Filter",GETFILTER("Date Filter"));
              SalesHeader.SETRANGE("Late Order Shipping",TRUE);
            END;
        END;
        FILTERGROUP(2);
        SalesHeader.SETFILTER("Responsibility Center",GETFILTER("Responsibility Center Filter"));
        FILTERGROUP(0);
    end;

    procedure ShowOrders(FieldNumber: Integer)
    var
        SalesHeader: Record "36";
    begin
        FilterOrders(SalesHeader,FieldNumber);
        PAGE.RUN(PAGE::"Sales Order List",SalesHeader);
    end;
}

