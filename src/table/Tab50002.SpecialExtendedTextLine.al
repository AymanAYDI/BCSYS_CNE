table 50002 "BC6_Special Extended Text Line"
{
    Caption = 'Special Extended Text Line';
    //   TODO: Page  // LookupPageID = 50005;

    fields
    {
        field(1; "Table Name"; Option)
        {
            Caption = 'Table Name';
            OptionCaption = 'Customer,vendor';
            OptionMembers = Customer,Vendor;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = IF ("Table Name" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Table Name" = CONST(Vendor)) Vendor."No.";
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Item."No.";
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(6; "Text"; Text[50])
        {
            Caption = 'Text';
        }
    }

    keys
    {
        key(Key1; "Table Name", "Code", "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

