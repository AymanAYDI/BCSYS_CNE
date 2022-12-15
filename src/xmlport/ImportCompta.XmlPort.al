xmlport 53005 "Import Compta"
{
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //>>CNE1.00
    // FE0021.001:FAFU 28/12/2006 : Reprise de données
    //                              - Creation

    Caption = '<Import Compta>';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table81; Table81)
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
                    RecGGenJnlLine.INIT;
                    RecGGenJnlLine.VALIDATE("Journal Template Name", CodGJnlTemplName);
                    RecGGenJnlLine.VALIDATE("Journal Batch Name", CodGJnlBatchName);


                    RecGGenJnlLineTmp.INIT;
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
                    DecLDebit: Decimal;
                    DecLCred: Decimal;
                begin

                    IntGLineNo += 10000;
                    RecGGenJnlLine.VALIDATE("Journal Template Name", CodGJnlTemplName);
                    RecGGenJnlLine.VALIDATE("Journal Batch Name", CodGJnlBatchName);
                    RecGGenJnlLine.VALIDATE("Line No.", IntGLineNo);
                    RecGGenJnlLine.VALIDATE("Source Code", CodJournal);

                    EVALUATE(RecGGenJnlLine."Posting Date", DatDateCOmpta);
                    RecGGenJnlLine.VALIDATE("Posting Date");
                    RecGGenJnlLine.VALIDATE("Document No.", TxtDocNo);

                    CASE COPYSTR(TxtCmpt, 1, 3) OF
                        '411', '401':
                            BEGIN
                                RecGGenJnlLine.VALIDATE("Account Type", RecGGenJnlLine."Account Type"::"G/L Account");
                                RecGGenJnlLine.VALIDATE("Account No.", '471000');
                            END;
                        '512':
                            BEGIN

                                CASE TxtCmpt OF
                                    '512108':
                                        BEGIN
                                            RecGGenJnlLine.VALIDATE("Account Type", RecGGenJnlLine."Account Type"::"Bank Account");
                                            RecGGenJnlLine.VALIDATE("Account No.", 'SNVB');
                                        END;

                                    '512109':
                                        BEGIN
                                            RecGGenJnlLine.VALIDATE("Account Type", RecGGenJnlLine."Account Type"::"Bank Account");
                                            RecGGenJnlLine.VALIDATE("Account No.", 'BPC');
                                        END;

                                    ELSE BEGIN
                                            RecGGenJnlLine.VALIDATE("Account Type", RecGGenJnlLine."Account Type"::"G/L Account");
                                            RecGGenJnlLine.VALIDATE("Account No.", TxtCmpt);
                                        END;
                                END;

                            END;
                        ELSE BEGIN
                                RecGGenJnlLine.VALIDATE("Account Type", RecGGenJnlLine."Account Type"::"G/L Account");
                                RecGGenJnlLine.VALIDATE("Account No.", TxtCmpt);
                            END;
                    END;

                    RecGGenJnlLine.VALIDATE(Description, TxtDescr);

                    EVALUATE(DecLDebit, TxtDeb);
                    EVALUATE(DecLCred, TxtCred);

                    IF DecLDebit <> 0 THEN
                        RecGGenJnlLine.VALIDATE("Debit Amount", DecLDebit);

                    IF DecLCred <> 0 THEN
                        RecGGenJnlLine.VALIDATE("Credit Amount", DecLCred);

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
        TxtExercice: Text[30];
        TxtJournal: Text[30];
        CodGJnlBatchName: Code[10];
        CodGJnlTemplName: Code[10];
        RecGGenJnlLine: Record "81";
        RecGGenJnlLineTmp: Record "81";
        IntGLineNo: Integer;
        TxtGFileName: Text[250];
}

