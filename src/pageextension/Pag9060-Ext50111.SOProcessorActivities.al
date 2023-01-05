pageextension 50111 "BC6_SOProcessorActivities" extends "SO Processor Activities"//9060
{
    layout
    {
        addafter("Sales Credit Memos - Open")
        {
            field("BC6_Sales Return - Location"; Rec."BC6_Sales Return - Location")
            {
                DrillDownPageID = "BC6_LOC Sales Ret. Order List";
            }
            field("BC6_Sales Return - SAV"; Rec."BC6_Sales Return - SAV")
            {
                DrillDownPageID = "BC6_SAV Sales Ret. Order List";
            }
        }
    }
}

