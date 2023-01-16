xmlport 50013 "BC6_Import R.I.B Clients"
{
    Caption = 'Import R.I.B Clients';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(customerbankaccount; "Customer Bank Account")
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

                    recCustBank.INIT();

                    customer := '';
                    Code := '';
                    bankbranch := '';
                    agency := '';
                    bankaccount := '';
                    rib := '';
                    IntGRIB := 0;
                    Name := '';
                    name2 := '';
                end;

                trigger OnBeforeInsertRecord()
                begin

                    recCustBank.VALIDATE("Customer No.", customer);
                    recCustBank.VALIDATE(Code, Code);
                    recCustBank.INSERT(TRUE);

                    IF bankbranch <> '' THEN
                        recCustBank.VALIDATE("Bank Branch No.", bankbranch);

                    IF agency <> '' THEN
                        recCustBank.VALIDATE("Agency Code", agency);

                    IF bankaccount <> '' THEN
                        recCustBank.VALIDATE("Bank Account No.", bankaccount);
                    IF rib <> '' THEN
                        IF EVALUATE(IntGRIB, rib) THEN
                            recCustBank.VALIDATE("RIB Key", IntGRIB);

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
        recCustBank: Record "Customer Bank Account";
        IntGRIB: Integer;
}
