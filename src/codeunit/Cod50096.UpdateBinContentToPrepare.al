codeunit 50096 "Update Bin Content/To Prepare"
{

    trigger OnRun()
    begin
        UpdateToPrepare();
    end;

    var
        BinContent: Record "Bin Content";
        SalesLine: Record "Sales Line";
        Counter: Integer;

    procedure UpdateToPrepare()
    begin
        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        IF SalesLine.FIND('-') THEN
            REPEAT
                IF NOT SalesLine."BC6_To Prepare" THEN BEGIN
                    SalesLine."BC6_To Prepare" := TRUE;
                    SalesLine.MODIFY(FALSE);
                    Counter += 1;
                END;
            UNTIL SalesLine.NEXT() = 0;

        MESSAGE('%1 ligne(s) commande vente traitée(s)', Counter);
    end;


    procedure InitBinContent()
    begin
        BinContent.RESET();
        BinContent.SETRANGE("Location Code", 'ACTI');
        IF BinContent.FIND('-') THEN
            REPEAT
                IF BinContent."Bin Code" = 'Z.Z.99.9' THEN BEGIN
                    BinContent.Default := FALSE;
                    BinContent.MODIFY(FALSE);
                END;
            UNTIL BinContent.NEXT() = 0;
    end;
}

