xmlport 50026 "BC6_Import Av. Orders"
{
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    Caption = 'Import Av. Orders';

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'Integers';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending);
                textelement(OrderNo)
                {
                }
                textelement(ExtNo)
                {
                }
                textelement(BinCode)
                {
                }

                trigger OnPreXmlItem()
                begin

                    OLDLocation.GET('CNE');
                    Location.GET('ACTI');
                    LocationCode := Location.Code;
                    TotalCounter := 0;
                    Counter := 0;
                end;

                trigger OnAfterInitRecord()
                begin

                    CLEAR(OrderNo);
                    TotalCounter += 1;
                end;

                trigger OnBeforeInsertRecord()
                begin

                    IF SalesOrder.GET(SalesOrder."Document Type"::Order, OrderNo) THEN BEGIN
                        SalesOrder.SetHideValidationDialog(TRUE);
                        IF SalesOrder.Status = SalesOrder.Status::Released THEN BEGIN

                            CLEAR(ReleaseSalesDoc);
                            ReleaseSalesDoc.Reopen(SalesOrder);
                        END;
                        SalesDocReleaseOk := TRUE;
                        SalesOrder.VALIDATE("External Document No.", ExtNo);
                        SalesOrder.VALIDATE("Location Code", LocationCode);
                        SalesOrder.VALIDATE("Shipment Method Code", 'ADI');
                        SalesOrder.VALIDATE("BC6_Bin Code", BinCode);
                        IF SalesOrder."Requested Delivery Date" = 0D THEN
                            SalesOrder.VALIDATE("Requested Delivery Date", WORKDATE());
                        SalesOrder.MODIFY();
                        Counter += 1;

                        SalesLine.RESET();
                        SalesLine.SETRANGE("Document Type", SalesOrder."Document Type");
                        SalesLine.SETRANGE("Document No.", SalesOrder."No.");
                        SalesLine.SetHideValidationDialog(TRUE);
                        IF SalesLine.FIND('-') THEN
                            REPEAT
                                SalesLine.CALCFIELDS("Reserved Quantity");
                                IF (SalesLine."Reserved Quantity" = 0) AND
                                   (SalesLine."Outstanding Quantity" > 0) AND
                                   (SalesLine."Qty. Shipped Not Invoiced" = 0) THEN BEGIN
                                    SalesLine.VALIDATE("Location Code", Location.Code);
                                    SalesLine.VALIDATE("Bin Code", SalesOrder."BC6_Bin Code");
                                    SalesLine.MODIFY();
                                END;
                            UNTIL SalesLine.NEXT() = 0;

                        IF SalesDocReleaseOk THEN BEGIN
                            CLEAR(ReleaseSalesDoc);
                            ReleaseSalesDoc.RUN(SalesOrder);
                        END;

                    END;
                end;
            }
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

    trigger OnPostXmlPort()
    begin
        MESSAGE(Text001, Counter, TotalCounter);
    end;

    var
        Location: Record Location;
        OLDLocation: Record Location;
        SalesOrder: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        SalesDocReleaseOk: Boolean;
        LocationCode: Code[20];
        Counter: Integer;
        TotalCounter: Integer;
        Text001: Label '%1 commandes à jour %2.', Comment = 'FRA="%1 commandes à jour %2."';
}

