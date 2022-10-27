tableextension 50087 tableextension50087 extends "Purchase Cue"
{
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on ""To Send or Confirm"(Field 2)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Upcoming Orders"(Field 3)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Upcoming Orders"(Field 3)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Outstanding Purchase Orders"(Field 4)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outstanding Purchase Orders"(Field 4)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Purchase Return Orders - All"(Field 5)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Purchase Return Orders - All"(Field 5)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Not Invoiced"(Field 6)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Not Invoiced"(Field 6)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Partially Invoiced"(Field 7)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Partially Invoiced"(Field 7)".

        field(50010; "Purchase Return - Location"; Integer)
        {
            CalcFormula = Count ("Purchase Header" WHERE (Document Type=FILTER(Return Order),
                                                         Return Order Type=FILTER(Location),
                                                         Status=FILTER(Open),
                                                         Responsibility Center=FIELD(Responsibility Center Filter)));
            Caption = 'Retours achat - Magasin';
            Description = 'BCSYS';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011;"Purchase Return - SAV";Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE (Document Type=FILTER(Return Order),
                                                         Return Order Type=FILTER(SAV),
                                                         Status=FILTER(Open),
                                                         Responsibility Center=FIELD(Responsibility Center Filter)));
            Caption = 'Retours achat - SAV';
            Description = 'BCSYS';
            FieldClass = FlowField;
        }
    }

    procedure CountOrders(FieldNumber: Integer): Integer
    var
        CountPurchOrders: Query "9063";
    begin
        CASE FieldNumber OF
          FIELDNO("Outstanding Purchase Orders"):
            BEGIN
              CountPurchOrders.SETRANGE(Status,CountPurchOrders.Status::Released);
              CountPurchOrders.SETRANGE(Completely_Received,FALSE);
              CountPurchOrders.SETRANGE(Invoice);
            END;
          FIELDNO("Not Invoiced"):
            BEGIN
              CountPurchOrders.SETRANGE(Status);
              CountPurchOrders.SETRANGE(Completely_Received,TRUE);
              CountPurchOrders.SETRANGE(Invoice,FALSE);
            END;
          FIELDNO("Partially Invoiced"):
            BEGIN
              CountPurchOrders.SETRANGE(Status);
              CountPurchOrders.SETRANGE(Completely_Received,TRUE);
              CountPurchOrders.SETRANGE(Invoice,TRUE);
            END;
        END;
        FILTERGROUP(2);
        CountPurchOrders.SETFILTER(Responsibility_Center,GETFILTER("Responsibility Center Filter"));
        FILTERGROUP(0);
        CountPurchOrders.OPEN;
        CountPurchOrders.READ;
        EXIT(CountPurchOrders.Count_Orders);
    end;

    procedure ShowOrders(FieldNumber: Integer)
    var
        PurchHeader: Record "38";
    begin
        PurchHeader.SETRANGE("Document Type",PurchHeader."Document Type"::Order);
        CASE FieldNumber OF
          FIELDNO("Outstanding Purchase Orders"):
            BEGIN
              PurchHeader.SETRANGE(Status,PurchHeader.Status::Released);
              PurchHeader.SETRANGE("Completely Received",FALSE);
              PurchHeader.SETRANGE(Invoice);
            END;
          FIELDNO("Not Invoiced"):
            BEGIN
              PurchHeader.SETRANGE(Status);
              PurchHeader.SETRANGE("Completely Received",TRUE);
              PurchHeader.SETRANGE(Invoice,FALSE);
            END;
          FIELDNO("Partially Invoiced"):
            BEGIN
              PurchHeader.SETRANGE(Status);
              PurchHeader.SETRANGE("Completely Received",TRUE);
              PurchHeader.SETRANGE(Invoice,TRUE);
            END;
        END;
        FILTERGROUP(2);
        PurchHeader.SETFILTER("Responsibility Center",GETFILTER("Responsibility Center Filter"));
        FILTERGROUP(0);
        PAGE.RUN(PAGE::"Purchase Order List",PurchHeader);
    end;
}

