codeunit 50096 "BC6_Upd Bin Content/To Prepare"
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
        if SalesLine.FIND('-') then
            repeat
                if not SalesLine."BC6_To Prepare" then begin
                    SalesLine."BC6_To Prepare" := true;
                    SalesLine.MODIFY(false);
                    Counter += 1;
                end;
            until SalesLine.NEXT() = 0;

        MESSAGE('%1 ligne(s) commande vente traitée(s)', Counter);
    end;

    procedure InitBinContent()
    begin
        BinContent.RESET();
        BinContent.SETRANGE("Location Code", 'ACTI');
        if BinContent.FIND('-') then
            repeat
                if BinContent."Bin Code" = 'Z.Z.99.9' then begin
                    BinContent.Default := false;
                    BinContent.MODIFY(false);
                end;
            until BinContent.NEXT() = 0;
    end;
}
