tableextension 50015 tableextension50015 extends "Salesperson/Purchaser"
{
    // 
    // //>>SU
    // TI367107 TO:06/04/2017 Ajout champ "Grouping code"
    LookupPageID = 14;
    fields
    {
        modify("E-Mail")
        {
            Caption = 'Email';
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Next To-do Date"(Field 5054)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Opportunities"(Field 5055)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Estimated Value (LCY)"(Field 5056)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Calcd. Current Value (LCY)"(Field 5057)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Interactions"(Field 5059)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Cost (LCY)"(Field 5060)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Duration (Min.)"(Field 5061)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Avg. Estimated Value (LCY)"(Field 5068)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Avg.Calcd. Current Value (LCY)"(Field 5069)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Opportunity Entry Exists"(Field 5082)".


        //Unsupported feature: Property Modification (CalcFormula) on ""To-do Entry Exists"(Field 5083)".

        modify("Search E-Mail")
        {
            Caption = 'Search Email';
        }
        modify("E-Mail 2")
        {
            Caption = 'Email 2';
        }
        field(140; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(50000; "Grouping Code"; Text[100])
        {
            Caption = 'Grouping Code';
            Description = 'TI367107';
        }
    }

    //Unsupported feature: Variable Insertion (Variable: TempSegmentLine) (VariableCollection) on "CreateInteraction(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "CreateInteraction(PROCEDURE 10)".

    //procedure CreateInteraction();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SegmentLine.CreateInteractionFromSalesPurc(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TempSegmentLine.CreateInteractionFromSalesPurc(Rec);
    */
    //end;

    //Unsupported feature: Property Insertion (Local) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    //Unsupported feature: Deletion (VariableCollection) on "CreateInteraction(PROCEDURE 10).SegmentLine(Variable 1000)".

}

