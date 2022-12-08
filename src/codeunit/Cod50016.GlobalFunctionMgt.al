codeunit 50016 "BC6_GlobalFunctionMgt"
{
    SingleInstance = true;


    procedure SetAutoTextSpe(pAutoTextSpe: Boolean)
    begin
        BooGAutoTextSpe := pAutoTextSpe;
    end;

    procedure GetAutoTextSpe(): Boolean
    begin
        exit(BooGAutoTextSpe);
    end;

    procedure SetGDecMntTTCDEEE(pDecMntTTCDEEE: Decimal)
    begin
        GDecMntTTCDEEE := pDecMntTTCDEEE;
    end;

    procedure GetGDecMntTTCDEEE(): Decimal
    begin
        exit(GDecMntTTCDEEE);
    end;

    var
        BooGAutoTextSpe: Boolean;
        GDecMntTTCDEEE: Decimal;
        GDecMntHTDEEE:Decimal;
}
