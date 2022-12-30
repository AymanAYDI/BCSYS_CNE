xmlport 50024 "BC6_Import Bins"
{

    Caption = 'Import Bins', Comment = 'FRA="Import emplacements"';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'Integers';
                SourceTableView = SORTING(Number)
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
                        Bin.INIT();
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
        Bin: Record Bin;
        Location: Record Location;
        OLDLocation: Record Location;
        LocationCode: Code[20];
        Counter: Integer;
        TotalCounter: Integer;
        Text001: Label '%1 emplacements créés sur %2.';
        Text002: Label 'Stock %1';
}

