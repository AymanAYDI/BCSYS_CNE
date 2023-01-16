xmlport 50012 "BC6_Import Adr. Livraison Clts"
{
    Caption = 'Import Adr. Livraison Clts';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

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
                    Width = 10;
                    XmlName = 'vcode';
                }
                textelement(vcustomer)
                {
                    Width = 20;
                    XmlName = 'vcustomer';
                }
                textelement(vname)
                {
                    Width = 30;
                    XmlName = 'vname';
                }
                textelement(vad)
                {
                    Width = 30;
                    XmlName = 'vad';
                }
                textelement(vad2)
                {
                    Width = 30;
                    XmlName = 'vad2';
                }
                textelement(vad3)
                {
                    XmlName = 'vad3';
                }
                textelement(vpostcode)
                {
                    Width = 30;
                    XmlName = 'vpostcode';
                }
                textelement(vcity)
                {
                    Width = 30;
                    XmlName = 'vcity';
                }
                textelement(vcountry)
                {
                    Width = 10;
                    XmlName = 'vcountry';
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
                            FOR i := 1 TO 5 - CPLength DO
                                vpostcode := '0' + vpostcode;
                        END;

                        recPostCode.RESET();
                        recPostCode.SETCURRENTKEY("Search City");
                        recPostCode.SETRANGE("Search City", UPPERCASE(vcity));
                        recPostCode.SETRANGE(Code, vpostcode);
                        IF NOT (recPostCode.FIND('-')) THEN BEGIN
                            recPostCode.INIT();

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

                    IF vcountry <> '' THEN
                        recShipTo.VALIDATE("Country/Region Code", vcountry);

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
        vname2: Text[30];
}
