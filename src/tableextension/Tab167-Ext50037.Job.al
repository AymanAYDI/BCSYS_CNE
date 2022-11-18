tableextension 50037 "BC6_Job" extends Job //167
{
    fields
    {
        field(50000; "BC6_Affair Responsible"; Code[20])
        {
            Caption = 'Affair Responsible', comment = 'FRA="Chargé d''affaire"';
            DataClassification = CustomerContent;

        }
        field(50001; BC6_Statut; Enum BC6_Statut)
        {
            Caption = 'Status', comment = 'FRA="Statut"';
            DataClassification = CustomerContent;
        }
        field(50002; BC6_Address; Text[30])
        {
            Caption = 'Address', comment = 'FRA="Adresse"';
            DataClassification = CustomerContent;

        }
        field(50003; "BC6_Address 2"; Text[30])
        {
            Caption = 'Address', comment = 'FRA="Adresse 2"';
            DataClassification = CustomerContent;

        }
        field(50004; "BC6_Post Code"; Code[20])
        {
            Caption = 'Post Code', comment = 'FRA="Code postale"';

            TableRelation = "Post Code".Code;
            DataClassification = CustomerContent;

            trigger OnValidate()

            var
                PostCode: Record "Post Code";

                TxtLCounty: Text[30];
            begin
                PostCode.ValidatePostCode(BC6_City, "BC6_Post Code", TxtLCounty, BC6_Country, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50005; BC6_City; Text[30])
        {
            Caption = 'City', comment = 'FRA="Ville"';
            DataClassification = CustomerContent;

        }
        field(50006; BC6_Country; Code[20])
        {
            Caption = 'Country', comment = 'FRA="Pays"';

            TableRelation = "Country/Region".Code;
            DataClassification = CustomerContent;
        }
        field(50010; BC6_Awarder; Boolean)
        {
            CalcFormula = Lookup("BC6_Contact Project Relation".Awarder WHERE("Affair No." = FIELD("No."),
                                                                           Awarder = CONST(true)));
            Caption = 'Awarder', comment = 'FRA="Adjudicataire"';
            FieldClass = FlowField;

        }
        field(50011; "BC6_Awarder Contact Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("BC6_Contact Project Relation"."Contact Name" WHERE("Affair No." = FIELD("No."),
                                                                                  Awarder = CONST(true)));
            Caption = 'Awarder Contact Name', comment = 'FRA="Nom contact adjudicataire"';

        }
    }
    keys
    {
    }

    procedure CurrencyCheck()
    begin
        IF ("Invoice Currency Code" <> "Currency Code") AND ("Invoice Currency Code" <> '') AND ("Currency Code" <> '') THEN
            ERROR(DifferentCurrenciesErr);
    end;

    var
        DifferentCurrenciesErr: Label 'You cannot plan and invoice a job in different currencies.', comment = 'FRA="Vous ne pouvez pas planifier et facturer un projet dans des devises différentes."';
}

