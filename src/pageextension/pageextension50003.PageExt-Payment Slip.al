pageextension 50003 pageextension50003 extends "Payment Slip"
{
    // //Modif LAB du 18/11/08
    // //desactivation de la fonction modification RIB
    layout
    {
        modify("Payment Journal Errors")
        {

            //Unsupported feature: Property Modification (SubPageLink) on ""Payment Journal Errors"(Control 1120008)".

            Caption = 'File Export Errors';
        }
        addafter("Control 1120033")
        {
            field("Partner Type"; "Partner Type")
            {
            }
        }
        addafter("Control 1120026")
        {
            field("N° Yooz Bordereau"; YoozNo_G)
            {
                Caption = 'N° Yooz Bordereau';
                Editable = false;
            }
        }
    }
    actions
    {


        //Unsupported feature: Code Modification on "SuggestVendorPayments(Action 1120032).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Status No." <> 0 THEN
          MESSAGE(Text003)
        ELSE
        #4..7
              CLEAR(CreateVendorPmtSuggestion);
            END ELSE
              MESSAGE(Text001);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..10

        // PBE 29/07/16
        FctYooz(TRUE);
        //
        */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on "SuggestCustomerPayments(Action 1120037).OnAction".

        //trigger (Variable: Customer)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "SuggestCustomerPayments(Action 1120037).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Status No." <> 0 THEN
          MESSAGE(Text003)
        ELSE
          IF PaymentClass.GET("Payment Class") THEN
            IF PaymentClass.Suggestions = PaymentClass.Suggestions::Customer THEN BEGIN
              CreateCustomerPmtSuggestion.SetGenPayLine(Rec);
              CreateCustomerPmtSuggestion.RUNMODAL;
              CLEAR(CreateCustomerPmtSuggestion);
            END ELSE
              MESSAGE(Text002);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
              Customer.SETRANGE("Partner Type","Partner Type");
              CreateCustomerPmtSuggestion.SETTABLEVIEW(Customer);
        #7..10
        */
        //end;


        //Unsupported feature: Code Modification on "Print(Action 1120002).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PaymentStep.SETRANGE("Action Type",PaymentStep."Action Type"::Report);
        PaymentMgt.ProcessPaymentSteps(Rec,PaymentStep);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.Lines.PAGE.MarkLines(TRUE);
        PaymentStep.SETRANGE("Action Type",PaymentStep."Action Type"::Report);
        PaymentMgt.ProcessPaymentSteps(Rec,PaymentStep);
        CurrPage.Lines.PAGE.MarkLines(FALSE);
        */
        //end;
        addafter("Action 1120050")
        {
            action("Export Nos. Yooz")
            {
                Caption = 'Export Numéros Yooz du bordereau';
                Image = Export1099;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    lPaymHeader: Record "10865";
                begin
                    lPaymHeader.RESET;
                    lPaymHeader.SETRANGE("No.", "No.");
                    XMLPORT.RUN(50022, TRUE, FALSE, lPaymHeader);
                end;
            }
        }
        addafter(Archive)
        {
            action("Mettre à jour numéros Yooz")
            {
                Caption = 'Mettre à jour numéros Yooz';
                Image = UpdateXML;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    FctYooz(TRUE);
                end;
            }
        }
    }

    var
        Customer: Record "18";


        //Unsupported feature: Property Modification (TextConstString) on "Text009(Variable 1120011)".

        //var
        //>>>> ORIGINAL VALUE:
        //Text009 : ENU=Do you wish to archive this document ?;FRA=Souhaitez-vous archiver ce document ?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text009 : ENU=Do you want to archive this document?;FRA=Souhaitez-vous archiver ce document ?;
        //Variable type has not been exported.

    var
        YoozNo_G: Text;


        //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

        //trigger OnAfterGetCurrRecord()
        //begin
        /*
        FctYoozNo;
        */
        //end;


        //Unsupported feature: Code Modification on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.Lines.PAGE.EDITABLE(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.Lines.PAGE.EDITABLE(TRUE);
        FctYoozNo;
        */
        //end;

    local procedure FctYoozNo()
    var
        YoozTable: Record "50018";
    begin
        YoozNo_G := '';
        YoozTable.RESET;
        YoozTable.SETRANGE("No.", "No.");
        IF YoozTable.FINDFIRST THEN
            REPEAT
                YoozNo_G := YoozNo_G + YoozTable."Applied Yooz No.";
            UNTIL YoozTable.NEXT = 0;
    end;
}

