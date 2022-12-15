xmlport 53006 "Import Stock"
{
    Caption = '<Import Stock>';
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table83; Table83)
            {
                XmlName = 'ItemJournalLine';
                textelement(ref)
                {
                    XmlName = 'Ref';
                }
                textelement(qte)
                {
                    XmlName = 'Qte';
                }

                trigger OnPreXmlItem()
                begin
                    IntGLineNo := 0;
                end;

                trigger OnAfterInsertRecord()
                begin
                    IF EVALUATE(DecGQte, Qte) THEN;
                    IF (TabArt.GET(Ref)) AND (DecGQte <> 0) THEN BEGIN
                        IntGLineNo += 10000;

                        "Item Journal Line".VALIDATE("Line No.", IntGLineNo);
                        "Item Journal Line".VALIDATE("Posting Date", WORKDATE);
                        "Item Journal Line".VALIDATE("Entry Type", "Item Journal Line"."Entry Type"::"Positive Adjmt.");
                        "Item Journal Line".VALIDATE("Document No.", 'INIT');
                        "Item Journal Line".VALIDATE("Item No.", Ref);
                        "Item Journal Line".VALIDATE("Location Code", 'CNE');
                        IF EVALUATE(DecGQte, Qte) THEN;
                        "Item Journal Line".VALIDATE(Quantity, DecGQte);

                        "Item Journal Line".INSERT;

                    END;
                end;

                trigger OnBeforeInsertRecord()
                begin

                    "Item Journal Line".INIT;
                    "Item Journal Line".VALIDATE("Journal Template Name", 'ARTICLE');
                    "Item Journal Line".VALIDATE("Journal Batch Name", 'DEFAUT');

                    Ref := '';
                    Qte := '';
                    DecGQte := 0;
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
        IntGLineNo: Integer;
        TabArt: Record "27";
        DecGQte: Decimal;
}

