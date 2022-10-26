table 99007 "Customer Bank Account Test"
{
    Caption = 'Customer Bank Account';
    DataCaptionFields = "Customer No.", "Code", Name;
    DrillDownPageID = 424;
    LookupPageID = 424;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(5; "Name 2"; Text[30])
        {
            Caption = 'Name 2';
        }
        field(6; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(7; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(8; City; Text[30])
        {
            Caption = 'City';
        }
        field(9; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(10; Contact; Text[30])
        {
            Caption = 'Contact';
        }
        field(11; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(12; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(13; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
        }
        field(14; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(15; "Transit No."; Text[20])
        {
            Caption = 'Transit No.';
        }
        field(16; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(17; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = Country/Region;
        }
        field(18;County;Text[30])
        {
            Caption = 'County';
        }
        field(19;"Fax No.";Text[30])
        {
            Caption = 'Fax No.';
        }
        field(20;"Telex Answer Back";Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(21;"Language Code";Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(22;"E-Mail";Text[80])
        {
            Caption = 'E-Mail';
        }
        field(23;"Home Page";Text[80])
        {
            Caption = 'Home Page';
        }
        field(24;IBAN;Code[50])
        {
            Caption = 'IBAN';

            trigger OnValidate()
            var
                CompanyInfo: Record "79";
            begin
            end;
        }
        field(25;"SWIFT Code";Code[20])
        {
            Caption = 'SWIFT Code';
        }
        field(10851;"Agency Code";Text[20])
        {
            Caption = 'Agency Code';
        }
        field(10852;"RIB Key";Integer)
        {
            Caption = 'RIB Key';
        }
        field(10853;"RIB Checked";Boolean)
        {
            Caption = 'RIB Checked';
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Customer No.","Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "225";
        RIBKey: Codeunit "10801";
}

