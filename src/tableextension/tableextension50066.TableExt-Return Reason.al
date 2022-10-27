tableextension 50066 tableextension50066 extends "Return Reason"
{
    LookupPageID = 6635;
    DrillDownPageID = 6635;
    fields
    {

        //Unsupported feature: Property Insertion (NotBlank) on "Code(Field 1)".

        modify(Description)
        {
            Caption = 'Description';
        }
        field(50000; Type; Option)
        {
            Caption = 'Type';
            Description = 'BCSYS';
            OptionCaption = 'Location,SAV';
            OptionMembers = Location,SAV;
        }
    }
}

