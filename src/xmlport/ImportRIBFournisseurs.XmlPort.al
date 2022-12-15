xmlport 50015 "Import R.I.B Fournisseurs"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //>>CNE1.00
    // FE0021.001:FAFU 28/12/2006 : Reprise de données
    //                              - Creation

    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table288; Table288)
            {
                AutoSave = false;
                XmlName = 'VendorBankAccount';
                textelement(vendor)
                {
                }
                textelement(Code)
                {
                }
                textelement(bankbranch)
                {
                }
                textelement(agency)
                {
                }
                textelement(bankaccount)
                {
                }
                textelement(rib)
                {
                }
                textelement(Name)
                {
                }
                textelement(name2)
                {
                }

                trigger OnAfterInitRecord()
                begin


                    recVendBank.INIT;

                    vendor := '';
                    Code := '';
                    bankbranch := '';
                    agency := '';
                    bankaccount := '';
                    IntGrib := 0;
                    rib := FORMAT(IntGrib);
                    Name := '';
                    name2 := '';
                end;

                trigger OnBeforeInsertRecord()
                begin

                    //Vendor No.,Code
                    recVendBank.VALIDATE("Vendor No.", vendor);
                    recVendBank.VALIDATE(Code, Code);
                    recVendBank.INSERT(TRUE);

                    IF EVALUATE(IntGrib, rib) THEN;
                    IF bankbranch <> '' THEN
                        recVendBank.VALIDATE("Bank Branch No.", bankbranch);


                    IF agency <> '' THEN
                        recVendBank.VALIDATE("Agency Code", agency);


                    IF bankaccount <> '' THEN
                        recVendBank.VALIDATE("Bank Account No.", bankaccount);


                    IF IntGrib <> 0 THEN
                        recVendBank.VALIDATE("RIB Key", IntGrib);


                    IF Name <> '' THEN
                        recVendBank.VALIDATE(Name, Name);


                    IF name2 <> '' THEN
                        recVendBank.VALIDATE("Name 2", name2);

                    recVendBank.MODIFY(TRUE);
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
        recVendBank: Record "288";
        IntGrib: Integer;
}

