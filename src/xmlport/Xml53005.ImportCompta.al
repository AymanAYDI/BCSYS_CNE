xmlport 53005 "BC6_Import Compta"
{

    Caption = 'Import Compta';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                AutoSave = false;
                XmlName = 'GenJournalLine';
                textelement(codjournal)
                {
                    XmlName = 'CodJournal';
                }
                textelement(datdatecompta)
                {
                    XmlName = 'DatDateCOmpta';
                }
                textelement(txtdocno)
                {
                    XmlName = 'TxtDocNo';
                }
                textelement(txtdescr)
                {
                    XmlName = 'TxtDescr';
                }
                textelement(txtcmpt)
                {
                    XmlName = 'TxtCmpt';
                }
                textelement(txtaux)
                {
                    XmlName = 'TxtAux';
                }
                textelement(txtdeb)
                {
                    XmlName = 'TxtDeb';
                }
                textelement(txtcred)
                {
                    XmlName = 'TxtCred';
                }

                trigger OnPreXmlItem()
                begin
                    IntGLineNo := 0;
                end;

                trigger OnAfterInitRecord()
                begin
                    RecGGenJnlLine.INIT();
                    RecGGenJnlLine.VALIDATE("Journal Template Name", CodGJnlTemplName);
                    RecGGenJnlLine.VALIDATE("Journal Batch Name", CodGJnlBatchName);


                    RecGGenJnlLineTmp.INIT();
                    RecGGenJnlLineTmp.VALIDATE("Journal Template Name", CodGJnlTemplName);
                    RecGGenJnlLineTmp.VALIDATE("Journal Batch Name", CodGJnlBatchName);

                    RecGGenJnlLine.SetUpNewLine(RecGGenJnlLineTmp, 0, FALSE);

                    TxtExercice := '';
                    CodJournal := '';
                    TxtJournal := '';
                    DatDateCOmpta := '';
                    TxtDocNo := '';
                    TxtDescr := '';
                    TxtCmpt := '';
                    TxtAux := '';
                    TxtDeb := '';
                    TxtCred := '';
                end;

                trigger OnBeforeInsertRecord()
                var
                    DecLCred: Decimal;
                    DecLDebit: Decimal;
                begin

                    IntGLineNo += 10000;
                    RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Journal Template Name", CodGJnlTemplName);
                    RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Journal Batch Name", CodGJnlBatchName);
                    RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Line No.", IntGLineNo);
                    RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Source Code", CodJournal);

                    EVALUATE(RecGGenJnlLine."Posting Date", DatDateCOmpta);
                    RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Posting Date");
                    RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Document No.", TxtDocNo);

                    CASE COPYSTR(TxtCmpt, 1, 3) OF
                        '411', '401':
                            BEGIN
                                RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Account Type", RecGGenJnlLine."Account Type"::"G/L Account");
                                RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Account No.", '471000');
                            END;
                        '512':


                            CASE TxtCmpt OF
                                '512108':
                                    BEGIN
                                        RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Account Type", RecGGenJnlLine."Account Type"::"Bank Account");
                                        RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Account No.", 'SNVB');
                                    END;

                                '512109':
                                    BEGIN
                                        RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Account Type", RecGGenJnlLine."Account Type"::"Bank Account");
                                        RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Account No.", 'BPC');
                                    END;

                                ELSE BEGIN
                                    RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Account Type", RecGGenJnlLine."Account Type"::"G/L Account");
                                    RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Account No.", TxtCmpt);
                                END;
                            END;
                        ELSE BEGIN
                            RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Account Type", RecGGenJnlLine."Account Type"::"G/L Account");
                            RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Account No.", TxtCmpt);
                        END;
                    END;

                    RecGGenJnlLine.VALIDATE(RecGGenJnlLine.Description, TxtDescr);

                    EVALUATE(DecLDebit, TxtDeb);
                    EVALUATE(DecLCred, TxtCred);

                    IF DecLDebit <> 0 THEN
                        RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Debit Amount", DecLDebit);

                    IF DecLCred <> 0 THEN
                        RecGGenJnlLine.VALIDATE(RecGGenJnlLine."Credit Amount", DecLCred);

                    IF NOT (RecGGenJnlLine.Amount = 0) THEN
                        RecGGenJnlLine.INSERT(TRUE);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(CodGJnlTemplName; CodGJnlTemplName)
                {
                    Caption = 'Journal Template Name';
                }
                field(CodGJnlBatchName; CodGJnlBatchName)
                {
                    Caption = 'Journal Batch Name';
                }
                field(TxtGFileName; TxtGFileName)
                {
                    Caption = 'File Name';

                    trigger OnAssistEdit()
                    begin
                        currXMLport.FILENAME := TxtGFileName;
                    end;
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    begin
        currXMLport.FILENAME := TxtGFileName;
    end;

    var
        RecGGenJnlLine: Record "Gen. Journal Line";
        RecGGenJnlLineTmp: Record "Gen. Journal Line";
        CodGJnlBatchName: Code[10];
        CodGJnlTemplName: Code[10];
        IntGLineNo: Integer;
        TxtExercice: Text[30];
        TxtJournal: Text[30];
        TxtGFileName: Text[250];
}

