xmlport 50031 "BC6_Import R.I.BClients"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Customer Bank Account Test"; "BC6_Customer Bank Account Test")
            {
                XmlName = 'CustomerBankAccountTest';
                fieldelement(CustomerNo; "Customer Bank Account Test"."Customer No.")
                {
                }
                fieldelement(Code; "Customer Bank Account Test".Code)
                {
                }
                fieldelement(BankBranchchNo; "Customer Bank Account Test"."Bank Branch No.")
                {
                }
                fieldelement(AgencyCode; "Customer Bank Account Test"."Agency Code")
                {
                }
                fieldelement(BankAccountNo; "Customer Bank Account Test"."Bank Account No.")
                {
                }
                fieldelement(RIBKey; "Customer Bank Account Test"."RIB Key")
                {
                }
                fieldelement(Name; "Customer Bank Account Test".Name)
                {
                }
                fieldelement(Name2; "Customer Bank Account Test"."Name 2")
                {
                }
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
}

