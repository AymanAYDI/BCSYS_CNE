pageextension 50004 pageextension50004 extends "Payment Slip Subform"
{
    // //Jx-AUD du 10/09/2013
    // //Mise en non éditable les champs Code établissement, Agence, Compte bancaire

    //Unsupported feature: Property Insertion (SourceTableView) on ""Payment Slip Subform"(Page 10869)".

    layout
    {
        addafter("Control 9")
        {
            field("Account Name"; "Account Name")
            {
            }
        }
        addafter("Control 1120001")
        {
            field("Direct Debit Mandate ID"; "Direct Debit Mandate ID")
            {
            }
            field("Pay Document Type"; "Pay Document Type")
            {
                Editable = false;
            }
            field("Pay Document No."; "Pay Document No.")
            {
                Editable = false;
            }
        }
    }


    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1120003)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=There is no line to modify;FRA=Il n'y a pas de ligne à modifier;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=There is no line to modify.;FRA=Il n'y a pas de ligne à modifier.;
    //Variable type has not been exported.

    var
        "Bank Account NameVisible": Boolean;


        //Unsupported feature: Code Modification on "OnInit".

        //trigger OnInit()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        BankAccountCodeVisible := TRUE;
        CreditAmountVisible := TRUE;
        DebitAmountVisible := TRUE;
        AmountVisible := TRUE;
        AcceptationCodeVisible := TRUE;
        RIBVisible := TRUE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        "Bank Account NameVisible" := TRUE;
        AcceptationCodeVisible := TRUE;
        RIBVisible := TRUE;
        */
        //end;

        //Unsupported feature: Property Deletion (Local) on "MarkLines(PROCEDURE 1120003)".


        //Unsupported feature: Move on "OnDelete(PROCEDURE 4).StatementLine(Variable 1120001)".

}

