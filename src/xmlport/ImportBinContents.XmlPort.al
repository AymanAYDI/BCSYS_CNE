xmlport 50025 "Import Bin Contents"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // ------------------------------------------------------------------------

    Caption = 'Import Bin Contents';
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
                textelement(ItemNo)
                {
                }

                trigger OnPreXmlItem()
                begin

                    OLDLocation.GET('CNE');
                    Location.GET('CNE2');
                    LocationCode := Location.Code;
                    TotalCounter := 0;
                    Counter := 0;
                    DefBinContent.RESET;
                end;

                trigger OnAfterInitRecord()
                begin

                    CLEAR(BinCode);
                    CLEAR(ItemNo);
                    TotalCounter += 1;
                end;

                trigger OnBeforeInsertRecord()
                begin

                    CLEAR(Item);
                    Item.GET(ItemNo);

                    CLEAR(Bin);
                    Bin.GET(LocationCode, BinCode);

                    DefBinContent.SETRANGE("Location Code", LocationCode);
                    DefBinContent.SETRANGE("Item No.", ItemNo);
                    DefBinContent.SETRANGE("Unit of Measure Code", Item."Base Unit of Measure");
                    DefBinContent.SETRANGE(Default, TRUE);
                    DefBinContentOk := DefBinContent.FINDFIRST;

                    // IF NOT Bin.GET(LocationCode,BinCode) THEN
                    //  BEGIN
                    //    Bin.INIT;
                    //    Bin."Location Code" := Location.Code;
                    //    Bin.Code := BinCode;
                    //    Bin.Description := 'ERROR';
                    //    Bin.INSERT(TRUE);
                    // END;

                    CLEAR(BinContent);
                    IF NOT BinContent.GET(LocationCode, BinCode, ItemNo, '', Item."Base Unit of Measure") THEN BEGIN
                        BinContent.INIT;
                        BinContent."Location Code" := Location.Code;
                        BinContent.VALIDATE("Bin Code", BinCode);
                        BinContent.VALIDATE("Item No.", ItemNo);
                        BinContent.Default := NOT DefBinContentOk;
                        BinContent.Fixed := TRUE;
                        BinContent."Unit of Measure Code" := Item."Base Unit of Measure";
                        BinContent.INSERT(TRUE);
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
        Item: Record "27";
        Bin: Record "7354";
        BinContent: Record "7302";
        DefBinContent: Record "7302";
        Location: Record "14";
        OLDLocation: Record "14";
        LocationCode: Code[20];
        Counter: Integer;
        TotalCounter: Integer;
        DefBinContentOk: Boolean;
        Text001: Label '%1 contenus emplacements créés sur %2.';
}

