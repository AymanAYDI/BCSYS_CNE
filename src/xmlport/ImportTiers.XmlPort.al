xmlport 53007 "Import Tiers"
{
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //>>CNE1.00
    // FE0021.001:BRRI 02/01/2007 : Reprise de données
    //                              - Creation

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
                SourceTableView = SORTING (Field1, Field51, Field2);
                textelement(codjournal)
                {
                    XmlName = 'CodJournal';
                }
                textelement(txtcmpt)
                {
                    XmlName = 'TxtCmpt';
                }
                textelement(accountno)
                {
                    XmlName = 'AccountNo';
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
                textelement(txtdeb)
                {
                    XmlName = 'TxtDeb';
                }
                textelement(txtcred)
                {
                    XmlName = 'TxtCred';
                }
                textelement(datdateech)
                {
                    XmlName = 'DatDateEch';
                }
                textelement(txtpaytermcode)
                {
                    XmlName = 'TxtPayTermCode';
                }

                trigger OnPreXmlItem()
                begin

                    TypeBalAccountNo := TypeBalAccountNo::"G/L Account";
                    BalAccountNo := '471000';

                    IntGLineNo := DeleteGenJnlLine;
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

                    CodJournal := '';
                    TxtCmpt := '';
                    DatDateCOmpta := '';
                    TxtDocNo := '';
                    TxtDescr := '';
                    TxtDeb := '';
                    TxtCred := '';

                    DatDateEch := '';
                    TxtPayTermCode := '';
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
                        '411':
                            BEGIN
                                RecGGenJnlLine.VALIDATE("Account Type", RecGGenJnlLine."Account Type"::Customer);
                                TestTier('Customer', AccountNo);
                                RecGGenJnlLine.VALIDATE("Account No.", AccountNo);
                            END;
                        '401':
                            BEGIN
                                RecGGenJnlLine.VALIDATE("Account Type", RecGGenJnlLine."Account Type"::Vendor);
                                TestTier('Vendor', AccountNo);
                                RecGGenJnlLine.VALIDATE("Account No.", AccountNo);
                            END;
                        ELSE
                            ERROR(STRSUBSTNO(TextError001, TxtCmpt));
                    END;

                    RecGGenJnlLine.VALIDATE(Description, TxtDescr);

                    EVALUATE(DecLDebit, TxtDeb);
                    EVALUATE(DecLCred, TxtCred);

                    IF DecLDebit <> 0 THEN
                        RecGGenJnlLine.VALIDATE("Debit Amount", DecLDebit);

                    IF DecLCred <> 0 THEN
                        RecGGenJnlLine.VALIDATE("Credit Amount", DecLCred);

                    IF TxtPayTermCode <> '' THEN
                        RecGGenJnlLine."Payment Terms Code" := TxtPayTermCode;

                    RecGGenJnlLine.VALIDATE("Bal. Account Type", TypeBalAccountNo);
                    RecGGenJnlLine.VALIDATE("Bal. Account No.", BalAccountNo);

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
                    TableRelation = "Gen. Journal Template";
                }
                field(CodGJnlBatchName; CodGJnlBatchName)
                {
                    Caption = 'Journal Batch Name';

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        RecGJnlBatchName.RESET;
                        RecGJnlBatchName.SETRANGE(RecGJnlBatchName."Journal Template Name", CodGJnlTemplName);
                        RecGJnlBatchName.FILTERGROUP(2);
                        FormJnlBatchName.SETTABLEVIEW(RecGJnlBatchName);

                        IF PAGE.RUNMODAL(251, RecGJnlBatchName, RecGJnlBatchName.Name) = ACTION::LookupOK THEN
                            CodGJnlBatchName := RecGJnlBatchName.Name;
                    end;
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
        CodGJnlBatchName: Code[10];
        CodGJnlTemplName: Code[10];
        RecGGenJnlLine: Record "81";
        RecGGenJnlLineTmp: Record "81";
        IntGLineNo: Integer;
        TxtGFileName: Text[250];
        "--": Integer;
        FormJnlBatchName: Page "251";
        RecGJnlBatchName: Record "232";
        TypeBalAccountNo: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        BalAccountNo: Code[20];
        TextError001: Label 'Account %1 do not exist !!';

    [Scope('Internal')]
    procedure DeleteGenJnlLine(): Integer
    var
        RecLGenJnlLine: Record "81";
        TextConfirm001: Label 'There are alreday Entries in Gen. Jnl Line %1 - %2. Do you want to delete them before the new import ?';
    begin
        RecLGenJnlLine.RESET;
        RecLGenJnlLine.SETRANGE("Journal Template Name", CodGJnlTemplName);
        RecLGenJnlLine.SETRANGE("Journal Batch Name", CodGJnlBatchName);
        IF RecLGenJnlLine.FINDFIRST THEN
            IF CONFIRM(STRSUBSTNO(TextConfirm001, CodGJnlTemplName, CodGJnlBatchName)) THEN
                RecLGenJnlLine.DELETEALL;

        RecLGenJnlLine.RESET;
        RecLGenJnlLine.SETRANGE("Journal Template Name", CodGJnlTemplName);
        RecLGenJnlLine.SETRANGE("Journal Batch Name", CodGJnlBatchName);
        IF RecLGenJnlLine.FINDLAST THEN
            EXIT(RecLGenJnlLine."Line No.")
        ELSE
            EXIT(0);
    end;

    [Scope('Internal')]
    procedure TestTier(TypeTier: Text[30]; CodLAccountNo: Code[20])
    var
        RecLCustomer: Record "18";
        RecLVendor: Record "23";
    begin
        IF TypeTier = 'Customer' THEN
            IF NOT RecLCustomer.GET(CodLAccountNo) THEN BEGIN
                RecLCustomer.INIT;
                RecLCustomer."No." := CodLAccountNo;
                RecLCustomer.Name := 'Créé par Dataport Import Tiers';
                RecLCustomer.INSERT(TRUE);
            END;
        IF TypeTier = 'Vendor' THEN
            IF NOT RecLVendor.GET(CodLAccountNo) THEN BEGIN
                RecLVendor.INIT;
                RecLVendor."No." := CodLAccountNo;
                RecLVendor.Name := 'Créé par Dataport Import Tiers';
                RecLVendor.INSERT(TRUE);
            END;
        COMMIT;
    end;
}

