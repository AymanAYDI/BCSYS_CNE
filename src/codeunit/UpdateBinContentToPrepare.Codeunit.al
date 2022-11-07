codeunit 50096 "Update Bin Content/To Prepare"
{

    trigger OnRun()
    begin
        UpdateToPrepare();
    end;

    var
        SalesLine: Record "37";
        Counter: Integer;
        BinContent: Record "7302";

    [Scope('Internal')]
    procedure UpdateToPrepare()
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        IF SalesLine.FIND('-') THEN
            REPEAT
                IF NOT SalesLine."To Prepare" THEN BEGIN
                    SalesLine."To Prepare" := TRUE;
                    SalesLine.MODIFY(FALSE);
                    Counter += 1;
                END;
            UNTIL SalesLine.NEXT = 0;

        MESSAGE('%1 ligne(s) commande vente traitée(s)', Counter);
    end;

    [Scope('Internal')]
    procedure InitBinContent()
    begin
        BinContent.RESET;
        BinContent.SETRANGE("Location Code", 'ACTI');
        IF BinContent.FIND('-') THEN
            REPEAT
                IF BinContent."Bin Code" = 'Z.Z.99.9' THEN BEGIN
                    BinContent.Default := FALSE;
                    BinContent.MODIFY(FALSE);
                END;
            UNTIL BinContent.NEXT = 0;
    end;
}

