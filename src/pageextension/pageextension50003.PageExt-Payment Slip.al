pageextension 50003 pageextension50003 extends "Payment Slip"
{
    actions
    {
        addafter(SuggestVendorPayments)
        {
            action("Propose Pay-to vendor payments")
            {
                Caption = 'Propose Pay-to vendor payments';

                trigger OnAction()
                var
                    PaymentClass: Record "10860";
                    CreateVendorPmtSuggestion: Report "10862";
                begin
                    //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur]
                    IF "Status No." <> 0 THEN
                        MESSAGE(Text003)
                    ELSE
                        IF PaymentClass.GET("Payment Class") THEN
                            IF PaymentClass.Suggestions = PaymentClass.Suggestions::Vendor THEN BEGIN
                                //std CreateVendorPmtSuggestion.SetGenPayLine(Rec);
                                //std CreateVendorPmtSuggestion.RUNMODAL;
                                //std CLEAR(CreateVendorPmtSuggestion);
                                /*
                                RepLCreateVendorPmtSuggestion.SetGenPayLine(Rec);
                                RepLCreateVendorPmtSuggestion.RUNMODAL;
                                CLEAR(RepLCreateVendorPmtSuggestion);
                                */
                            END ELSE
                                MESSAGE(Text001);
                    //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur]

                end;
            }
            separator()
            {
            }
        }
        addafter(SuggestCustomerPayments)
        {
            action("Propose Pay-to customer payments")
            {
                Caption = 'Propose Pay-to customer payments';

                trigger OnAction()
                var
                    PaymentClass: Record "10860";
                    CreateCustomerPmtSuggestion: Report "10864";
                begin
                    //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur]
                    IF "Status No." <> 0 THEN
                        MESSAGE(Text003)
                    ELSE
                        IF PaymentClass.GET("Payment Class") THEN
                            IF PaymentClass.Suggestions = PaymentClass.Suggestions::Customer THEN BEGIN
                                //std CreateCustomerPmtSuggestion.SetGenPayLine(Rec);
                                //std CreateCustomerPmtSuggestion.RUNMODAL;
                                //std CLEAR(CreateCustomerPmtSuggestion);
                                /*
                                RepLCreateCustomerPmtSuggestio.SetGenPayLine(Rec);
                                RepLCreateCustomerPmtSuggestio.RUNMODAL;
                                CLEAR(RepLCreateCustomerPmtSuggestio);
                                */
                            END ELSE
                                MESSAGE(Text002);
                    //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur]

                end;
            }
        }
        addafter(Post)
        {
            action(Lettrer)
            {
                Caption = 'Lettrer';

                trigger OnAction()
                var
                    RecLPayLine: Record "10866";
                    CodLCustEntryApply: Codeunit "50002";
                    RecLApplyingCustLedgEntry: Record "21";
                    RecLApplyingVendLedgEntry: Record "25";
                    CodLVendEntryApply: Codeunit "50003";
                    IntLPos: Integer;
                    CodLNumDoc: Code[20];
                begin

                    //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout Menu pour lettrage manuel
                    RecLPayLine.RESET;
                    RecLPayLine.SETRANGE("No.", "No.");
                    IF RecLPayLine.FINDSET(FALSE, FALSE) THEN BEGIN
                        IntLPos := STRPOS(RecLPayLine."Document No.", '/');
                        IF IntLPos > 0 THEN
                            CodLNumDoc := COPYSTR(RecLPayLine."Document No.", 1, IntLPos - 1)
                        ELSE
                            CodLNumDoc := RecLPayLine."Document No.";

                        REPEAT
                            CASE RecLPayLine."Account Type" OF
                                RecLPayLine."Account Type"::Customer:
                                    BEGIN
                                        //Initialisation des ecritures à lettrer
                                        RecLApplyingCustLedgEntry.RESET;
                                        RecLApplyingCustLedgEntry.SETRANGE("Customer No.", RecLPayLine."Account No.");
                                        RecLApplyingCustLedgEntry.SETRANGE(Open, TRUE);
                                        RecLApplyingCustLedgEntry.SETRANGE("Document No.", CodLNumDoc);
                                        IF RecLApplyingCustLedgEntry.FINDFIRST THEN
                                            REPEAT
                                                CodLCustEntryApply.InitialisationLettrage(RecLApplyingCustLedgEntry);
                                            UNTIL RecLApplyingCustLedgEntry.NEXT = 0;

                                        //Lettrage des ecritures
                                        CodLCustEntryApply.Lettrage(RecLPayLine."Account No.");
                                    END;
                                RecLPayLine."Account Type"::Vendor:
                                    BEGIN
                                        //Initialisation des ecritures à lettrer
                                        RecLApplyingVendLedgEntry.RESET;
                                        RecLApplyingVendLedgEntry.SETRANGE("Vendor No.", RecLPayLine."Account No.");
                                        RecLApplyingVendLedgEntry.SETRANGE(Open, TRUE);
                                        RecLApplyingVendLedgEntry.SETRANGE("Document No.", CodLNumDoc);
                                        IF RecLApplyingVendLedgEntry.FINDFIRST THEN
                                            REPEAT
                                                CodLVendEntryApply.InitialisationLettrage(RecLApplyingVendLedgEntry);
                                            UNTIL RecLApplyingVendLedgEntry.NEXT = 0;

                                        //Lettrage des ecritures
                                        CodLVendEntryApply.Lettrage(RecLPayLine."Account No.");
                                    END;
                            END;

                        UNTIL RecLPayLine.NEXT = 0;
                    END;
                end;
            }
        }
    }
}

