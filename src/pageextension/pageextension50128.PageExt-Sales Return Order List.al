pageextension 50128 pageextension50128 extends "Sales Return Order List"
{

    //Unsupported feature: Property Insertion (InsertAllowed) on ""Sales Return Order List"(Page 9304)".


    //Unsupported feature: Property Insertion (DelayedInsert) on ""Sales Return Order List"(Page 9304)".

    layout
    {
        addafter("Control 5")
        {
            field(ID; ID)
            {
            }
            field("Your Reference"; "Your Reference")
            {
            }
            field("Affair No."; "Affair No.")
            {
            }
            field(Amount; Amount)
            {
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Insertion (VariableCollection) on "Action 48.OnAction".

        //trigger (Variable: L_SalesHeader)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Action 48.OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DocPrint.PrintSalesHeader(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>>BCSYS
        //old DocPrint.PrintSalesHeader(Rec);
        IF "Return Order Type" = "Return Order Type"::Location THEN
          DocPrint.PrintSalesHeader(Rec)
        ELSE BEGIN
          L_SalesHeader.RESET;
          L_SalesHeader.SETRANGE("Document Type","Document Type");
          L_SalesHeader.SETRANGE("No.","No.");
          REPORT.RUNMODAL(50060,TRUE,FALSE,L_SalesHeader);
        END;
        */
        //end;
    }

    var
        L_SalesHeader: Record "36";

    var
        RecGUserSeup: Record "91";


        //Unsupported feature: Code Modification on "OnOpenPage".

        //trigger OnOpenPage()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SetSecurityFilterOnRespCenter;

        JobQueueActive := SalesSetup.JobQueueActive;

        CopySellToCustomerFilter;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SetSecurityFilterOnRespCenter;

        //>>P24233_001 SOBI APA 02/02/17
        IF NOT RecGUserSeup.GET(USERID) THEN
           RecGUserSeup.INIT;
        IF RecGUserSeup."Limited User" THEN BEGIN
          FILTERGROUP(2);
          SETFILTER("Salesperson Filter",'*'+RecGUserSeup."Salespers./Purch. Code"+'*');
          FILTERGROUP(0);
        END;
        //<<P24233_001 SOBI APA 02/02/17
        #2..5
        */
        //end;
}

