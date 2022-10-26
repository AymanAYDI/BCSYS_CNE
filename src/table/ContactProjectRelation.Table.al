table 50009 "Contact Project Relation"
{
    // -----------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // -----------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 15/11/2007 : gestion des apples d'offres clients
    //   - Table created
    // 
    // //>>CNE1.01
    // FEP-ADVE-200706_18_A.001:MA 03/12/2007 : gestion des apples d'offres clients
    //                                          - Change field name "Project No." TO "Affair No."
    // 
    // //>>CNE2.05
    // FEP-ADVE-200706_18_A.001:LY 28/01/2008 : - Add Fields
    //                                            10 Company No.
    //                                            11 Type
    //                                          - Change Fields Input
    // 
    // 
    // //>>CNE3.01
    // FE-ADV_20080418_CNE_adjudic.001:NIRO 03/11/09 : - add field 12 Awarder
    // -----------------------------------------------------------------------------

    Caption = 'Contact Project Relation';
    PasteIsValid = true;

    fields
    {
        field(1; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            Description = 'CNE2.05';
            NotBlank = false;
            TableRelation = Contact.No.;

            trigger OnValidate()
            begin
                GetContact;
                
                "Contact Name" := RecGcontact.Name;
                "Phone No."    := RecGcontact."Phone No.";
                
                CALCFIELDS("Company No.",Type);
                
                //>>FEP-ADVE-200706_18_A.001:LY
                /*GetContactRelation;
                "Relation Type":= RecGCntBusinessRelation."Business Relation Code";
                "Relation Description" := RecGContactRelation.Description;*/
                
                IF GetContactRelation THEN
                BEGIN
                  "Relation Type":= RecGCntBusinessRelation."Business Relation Code";
                  "Relation Description" := RecGContactRelation.Description;
                END;
                //<<FEP-ADVE-200706_18_A.001:LY
                
                GetContactRelationType;
                "No." := RecGCntBusinessRelation."No.";
                "Link to table" := RecGCntBusinessRelation."Link to Table";

            end;
        }
        field(2;"Contact Name";Text[30])
        {
            Caption = 'Contact Name';
            Description = 'CNE1.00';
        }
        field(3;"Relation Type";Code[10])
        {
            Caption = 'Relation Type';
            Description = 'CNE1.00';
            TableRelation = "Contact Business Relation"."Business Relation Code" WHERE (Contact No.=FIELD(Company No.));

            trigger OnValidate()
            var
                RecLBusiRelation: Record "5053";
            begin
                //>>CNE2.05
                /*IF RecLBusiRelation.GET(RecLBusiRelation.Code,"Relation Type") THEN
                
                IF RecLBusiRelation.FIND('-') THEN
                  "Relation Description" := RecLBusiRelation.Description;
                 */
                //<<CNE2.05

            end;
        }
        field(4;"Relation Description";Text[30])
        {
            CalcFormula = Lookup("Business Relation".Description WHERE (Code=FIELD(Relation Type)));
            Caption = 'Relation Description';
            Description = 'CNE1.00';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                RecLBusiRelation: Record "5053";
            begin
            end;
        }
        field(5;"Phone No.";Text[30])
        {
            Caption = 'Phone No.';
            Description = 'CNE1.00';
        }
        field(6;"No.";Code[20])
        {
            Caption = 'No.';
            Description = 'CNE1.00';
            TableRelation = IF (Link to table=CONST(Customer)) Customer.No.
                            ELSE IF (Link to table=CONST(Vendor)) Vendor.No.;
        }
        field(7;"Affair No.";Code[20])
        {
            Caption = 'Affair No.';
            Description = 'CNE1.00';
            TableRelation = Job.No.;
        }
        field(8;"Link to table";Option)
        {
            Caption = 'Link to Table';
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ",Customer,Vendor;
        }
        field(10;"Company No.";Code[20])
        {
            CalcFormula = Lookup(Contact."Company No." WHERE (No.=FIELD(Contact No.)));
            Caption = 'Company No.';
            Description = 'CNE2.05';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Contact WHERE (Type=CONST(Company));

            trigger OnValidate()
            var
                Opp: Record "5092";
                OppEntry: Record "5093";
                Todo: Record "5080";
                InteractLogEntry: Record "5065";
                SegLine: Record "5077";
                SalesHeader: Record "36";
            begin
            end;
        }
        field(11;Type;Option)
        {
            CalcFormula = Lookup(Contact.Type WHERE (No.=FIELD(Contact No.)));
            Caption = 'Type';
            Description = 'CNE2.05';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Company,Person';
            OptionMembers = Company,Person;
        }
        field(12;Awarder;Boolean)
        {
            Caption = 'Awarder';
            Description = 'CNE3.01';

            trigger OnValidate()
            var
                RecLAffairStep: Record "50010";
            begin
            end;
        }
        field(50000;"Affair Responsible";Code[20])
        {
            CalcFormula = Lookup(Job."Affair Responsible" WHERE (No.=FIELD(Affair No.)));
            Caption = 'Affair Responsible';
            Description = 'CNE1.00';
            FieldClass = FlowField;
            TableRelation = "User Setup";
        }
        field(50001;Statut;Option)
        {
            CalcFormula = Lookup(Job.Statut WHERE (No.=FIELD(Affair No.)));
            Description = 'CNE1.00';
            FieldClass = FlowField;
            OptionCaption = 'Outstanding,Lost,Won';
            OptionMembers = Outstanding,Lost,Won;
        }
        field(50003;Blocked;Option)
        {
            CalcFormula = Lookup(Job.Blocked WHERE (No.=FIELD(Affair No.)));
            Caption = 'Blocked';
            Description = 'CNE1.00';
            FieldClass = FlowField;
            OptionCaption = ' ,Posting,All';
            OptionMembers = " ",Posting,All;
        }
        field(50004;"Contact City";Text[30])
        {
            CalcFormula = Lookup(Contact.City WHERE (No.=FIELD(Contact No.)));
            Caption = 'Ville';
            FieldClass = FlowField;
        }
        field(50005;"Contact Post Code";Code[20])
        {
            CalcFormula = Lookup(Contact."Post Code" WHERE (No.=FIELD(Contact No.)));
            Caption = 'Code postal';
            FieldClass = FlowField;
        }
        field(50006;"Affair Description";Text[50])
        {
            CalcFormula = Lookup(Job.Description WHERE (No.=FIELD(Affair No.)));
            Caption = 'Désignation';
            Description = 'SU';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Contact No.","Affair No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecGcontact: Record "5050";
        RecGCntBusinessRelation: Record "5054";
        RecGContactRelation: Record "5053";

    [Scope('Internal')]
    procedure GetContact()
    begin
        TESTFIELD("Contact No.");
        IF "Contact No." <> RecGcontact."No." THEN
          RecGcontact.GET("Contact No.");
    end;

    [Scope('Internal')]
    procedure GetContactRelation() BooFindRelation: Boolean
    begin
        BooFindRelation := FALSE;

        TESTFIELD("Contact No.");

        //>>FEP-ADVE-200706_18_A.001:LY
        RecGCntBusinessRelation.RESET;
        //<<FEP-ADVE-200706_18_A.001:LY

        IF "Company No." <> '' THEN
        BEGIN
          RecGCntBusinessRelation.SETFILTER("Contact No.","Company No.");
          IF RecGCntBusinessRelation.FIND('-') THEN
          BEGIN
            //>>FEP-ADVE-200706_18_A.001:LY
            RecGContactRelation.RESET;
            //<<FEP-ADVE-200706_18_A.001:LY
            RecGContactRelation.SETFILTER(Code,RecGCntBusinessRelation."Business Relation Code");
            BooFindRelation := RecGContactRelation.FIND('-');
          END;
        END;
    end;

    [Scope('Internal')]
    procedure GetContactRelationType()
    begin
        TESTFIELD("Contact No.");
        
        //>>CNE2.05
        RecGCntBusinessRelation.RESET;
        RecGCntBusinessRelation.SETFILTER("Contact No.","Contact No.");
        IF RecGCntBusinessRelation.FIND('-') THEN;
        
        /*RecGCntBusinessRelation.RESET;
        RecGCntBusinessRelation.SETFILTER("Contact No.","Company No.");
        RecGCntBusinessRelation.SETRANGE("Link to Table",RecGCntBusinessRelation."Link to Table"::Vendor);
        IF RecGCntBusinessRelation.FIND('-') THEN;
        BEGIN
          RecGCntBusinessRelation.RESET;
          RecGCntBusinessRelation.SETFILTER("Contact No.","Company No.");
          RecGCntBusinessRelation.SETRANGE("Link to Table",RecGCntBusinessRelation."Link to Table"::Customer);
        END;*/
        //<<CNE2.05

    end;
}

