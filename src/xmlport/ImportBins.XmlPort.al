xmlport 50024 "Import Bins"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // ------------------------------------------------------------------------

    Caption = 'Import Bins';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table2000000026; Table2000000026)
            {
                XmlName = 'Integers';
                SourceTableView = SORTING (Field1)
                                  ORDER(Ascending);
                textelement(BinCode)
                {
                }
                textelement(BinDes)
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

                    CLEAR(BinCode);
                    CLEAR(BinDes);
                    TotalCounter += 1;
                end;

                trigger OnBeforeInsertRecord()
                begin

                    IF NOT Bin.GET(LocationCode, BinCode) THEN BEGIN
                        Bin.INIT;
                        Bin."Location Code" := Location.Code;
                        Bin.Code := BinCode;
                        IF BinDes <> '' THEN
                            Bin.Description := BinDes
                        ELSE
                            Bin.Description := STRSUBSTNO(Text002, BinCode);
                        Bin.INSERT(TRUE);
                        Counter += 1;
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
        Bin: Record "7354";
        Location: Record "14";
        OLDLocation: Record "14";
        LocationCode: Code[20];
        Counter: Integer;
        TotalCounter: Integer;
        Text001: Label '%1 emplacements créés sur %2.';
        Text002: Label 'Stock %1';
}

