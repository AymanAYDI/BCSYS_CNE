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


    var
        BooGAutoTextSpe: Boolean;


}
