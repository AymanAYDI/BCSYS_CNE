pageextension 50092 pageextension50092 extends "Standard Cost Worksheet"
{
    actions
    {

        //Unsupported feature: Code Modification on "Action 83.OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CLEAR(RollUpStdCost);
        Item.SETRANGE("Costing Method",Item."Costing Method"::Standard);
        RollUpStdCost.SETTABLEVIEW(Item);
        RollUpStdCost.SetStdCostWksh(CurrWkshName);
        RollUpStdCost.RUNMODAL;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CLEAR(RollUpStdCost);
        Item.SETRANGE("Costing Method",Item."Costing Method"::Average);
        #3..5
        */
        //end;
    }
}

