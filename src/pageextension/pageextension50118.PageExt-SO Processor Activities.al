pageextension 50118 pageextension50118 extends "SO Processor Activities"
{
    layout
    {
        addafter("Control 21")
        {
            field("Sales Return - Location"; "Sales Return - Location")
            {
                DrillDownPageID = "LOC Sales Return Order List";
            }
            field("Sales Return - SAV"; "Sales Return - SAV")
            {
                DrillDownPageID = "SAV Sales Return Order List";
            }
        }
    }
}

