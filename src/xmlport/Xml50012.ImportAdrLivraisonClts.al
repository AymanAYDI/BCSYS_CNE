xmlport 50012 "BC6_Import Adr. Livraison Clts"
{

    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;
    Caption = 'Import Adr. Livraison Clts';

    schema
    {
        textelement(Root)
        {
            tableelement(shiptoaddress; "Ship-to Address")
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'ShipToAddress';
                textelement(vcode)
                {
                    XmlName = 'vcode';
                    Width = 10;
                }
                textelement(vcustomer)
                {
                    XmlName = 'vcustomer';
                    Width = 20;
                }
                textelement(vname)
                {
                    XmlName = 'vname';
                    Width = 30;
                }
                textelement(vad)
                {
                    XmlName = 'vad';
                    Width = 30;
                }
                textelement(vad2)
                {
                    XmlName = 'vad2';
                    Width = 30;
                }
                textelement(vad3)
                {
                    XmlName = 'vad3';
                }
                textelement(vpostcode)
                {
                    XmlName = 'vpostcode';
                    Width = 30;
                }
                textelement(vcity)
                {
                    XmlName = 'vcity';
                    Width = 30;
                }
                textelement(vcountry)
                {
                    XmlName = 'vcountry';
                    Width = 10;
                }

                trigger OnAfterInitRecord()
                begin
                    recShipTo.INIT();

                    vcode := '';
                    vcustomer := '';
                    vname := '';
                    vname2 := '';
                    vad := '';
                    vad2 := '';
                    vad3 := '';
                    vpostcode := '';
                    vcity := '';
                    vcountry := '';
                end;

                trigger OnBeforeInsertRecord()
                var
                    CPLength: Integer;
                    i: Integer;
                begin
                    recShipTo.VALIDATE(Code, vcode);
                    recShipTo.VALIDATE("Customer No.", vcode);


                    recShipTo.INSERT(TRUE);

                    IF vname <> '' THEN
                        recShipTo.VALIDATE(Name, vname);

                    IF vname2 <> '' THEN
                        recShipTo.VALIDATE("Name 2", vname2);

                    IF vad <> '' THEN
                        recShipTo.VALIDATE(Address, vad);
                    IF vad2 <> '' THEN
                        recShipTo.VALIDATE("Address 2", vad2);

                    IF vad3 <> '' THEN
                        recShipTo.VALIDATE(County, vad3);

                    IF (vpostcode <> '') OR (vcity <> '') THEN BEGIN

                        IF STRLEN(vpostcode) < 5 THEN BEGIN
                            CPLength := STRLEN(vpostcode);
                            FOR i := 1 TO 5 - CPLength DO BEGIN
                                vpostcode := '0' + vpostcode;
                            END;
                        END;

                        recPostCode.RESET;
                        recPostCode.SETCURRENTKEY("Search City");
                        recPostCode.SETRANGE("Search City", UPPERCASE(vcity));
                        recPostCode.SETRANGE(Code, vpostcode);
                        IF NOT (recPostCode.FIND('-')) THEN BEGIN
                            recPostCode.INIT;

                            recPostCode.Code := vpostcode;
                            recPostCode.City := vcity;
                            recPostCode."Search City" := vcity;

                            recPostCode.VALIDATE(Code, vpostcode);
                            recPostCode.VALIDATE(City, vcity);
                            recPostCode.INSERT(TRUE);
                        END;

                        recShipTo."Post Code" := vpostcode;
                        recShipTo.City := vcity;

                    END;

                    IF vcountry <> '' THEN BEGIN
                        recShipTo.VALIDATE("Country/Region Code", vcountry);
                    END;


                    recShipTo.MODIFY(TRUE);
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

    var
        recPostCode: Record "Post Code";
        recShipTo: Record "Ship-to Address";
        "--records--": Integer;
        "--variables--": Integer;
        vname2: Text[30];
}

