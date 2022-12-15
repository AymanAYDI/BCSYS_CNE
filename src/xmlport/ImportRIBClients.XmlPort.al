xmlport 50013 "Import R.I.B Clients"
{
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //>>CNE1.00
    // FE0021.001:FAFU 28/12/2006 : Reprise de données
    //                              - Creation
    // ------------------------------------------------------------------------

    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(customerbankaccount; Table287)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'CustomerBankAccount';
                textelement(customer)
                {
                    XmlName = 'customer';
                }
                textelement(code)
                {
                    XmlName = 'Code';
                }
                textelement(bankbranch)
                {
                    XmlName = 'bankbranch';
                }
                textelement(agency)
                {
                    XmlName = 'agency';
                }
                textelement(bankaccount)
                {
                    XmlName = 'bankaccount';
                }
                textelement(rib)
                {
                    XmlName = 'rib';
                }
                textelement(name)
                {
                    XmlName = 'Name';
                }
                textelement(name2)
                {
                    XmlName = 'name2';
                }

                trigger OnAfterInitRecord()
                begin

                    recCustBank.INIT;

                    customer := '';
                    Code := '';
                    bankbranch := '';
                    agency := '';
                    bankaccount := '';
                    rib := '';
                    //>>MIGRATION NAV 2013
                    IntGRIB := 0;
                    //<<MIGRATION NAV 2013
                    Name := '';
                    name2 := '';
                end;

                trigger OnBeforeInsertRecord()
                begin


                    //Customer No.,Code
                    recCustBank.VALIDATE("Customer No.", customer);
                    recCustBank.VALIDATE(Code, Code);
                    recCustBank.INSERT(TRUE);

                    IF bankbranch <> '' THEN
                        recCustBank.VALIDATE("Bank Branch No.", bankbranch);


                    IF agency <> '' THEN
                        recCustBank.VALIDATE("Agency Code", agency);


                    IF bankaccount <> '' THEN
                        recCustBank.VALIDATE("Bank Account No.", bankaccount);

                    //>>MIGRATION NAV 2013
                    //IF rib <> 0 THEN
                    //  recCustBank.VALIDATE("RIB Key", rib);

                    IF rib <> '' THEN
                        IF EVALUATE(IntGRIB, rib) THEN
                            recCustBank.VALIDATE("RIB Key", IntGRIB);
                    //<<MIGRATION NAV 2013

                    IF Name <> '' THEN
                        recCustBank.VALIDATE(Name, Name);


                    IF name2 <> '' THEN
                        recCustBank.VALIDATE("Name 2", name2);

                    recCustBank.MODIFY(TRUE);
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
        "--record--": Integer;
        recCustBank: Record "287";
        "- MIGNAV2013 -": Integer;
        IntGRIB: Integer;
}

