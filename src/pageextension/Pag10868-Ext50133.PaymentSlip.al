pageextension 50133 "BC6_PaymentSlip" extends "Payment Slip" //10868
{
    actions
    {
        addafter(SuggestVendorPayments)
        {
            action("BC6_Propose Pay-to vendor payments")
            {
                Caption = 'Propose Pay-to vendor payments';
                ApplicationArea = All;

                trigger OnAction()
                var
                    PaymentClass: Record "Payment Class";
                    Text001: label 'This payment class does not authorize vendor suggestions.', comment = 'FRA="Ce type de règlement n''autorise pas les propositions fournisseur."';
                    Text003: label 'You cannot suggest payments on a posted header.', comment = 'FRA="Vous n''êtes pas autorisé à faire des propositions de paiement sur un bordereau validé."';
                begin
                    IF "Status No." <> 0 THEN
                        MESSAGE(Text003)
                    ELSE
                        IF PaymentClass.GET("Payment Class") THEN
                            IF PaymentClass.Suggestions = PaymentClass.Suggestions::Vendor THEN BEGIN
                            END ELSE
                                MESSAGE(Text001);
                end;
            }
            separator(Sep)
            {
            }
        }
        addafter(SuggestCustomerPayments)
        {
            action("BC6_Propose Pay-to customer payments")
            {
                Caption = 'Propose Pay-to customer payments';
                ApplicationArea = All;

                trigger OnAction()
                var
                    PaymentClass: Record "Payment Class";
                    Text002: label 'This payment class does not authorize customer suggestions.', comment = 'FRA="Ce type de règlement n''autorise pas les propositions client."';
                    Text003: label 'You cannot suggest payments on a posted header.', comment = 'FRA="Vous n''êtes pas autorisé à faire des propositions de paiement sur un bordereau validé."';

                begin
                    IF "Status No." <> 0 THEN
                        MESSAGE(Text003)
                    ELSE
                        IF PaymentClass.GET("Payment Class") THEN
                            IF PaymentClass.Suggestions = PaymentClass.Suggestions::Customer THEN BEGIN
                            END ELSE
                                MESSAGE(Text002);
                end;
            }
        }
        addafter(Post)
        {
            action(BC6_Lettrer)
            {
                Caption = 'Lettrer';
                ApplicationArea = All;

                trigger OnAction()
                var

                    RecLApplyingCustLedgEntry: Record "Cust. Ledger Entry";
                    RecLApplyingVendLedgEntry: Record "Vendor Ledger Entry";
                    RecLPayLine: Record "Payment Line";
                    CodLNumDoc: Text;
                    //TODO
                    CodLCustEntryApply: Codeunit "BC6_Reconstitue lettrage CLI";
                    CodLVendEntryApply: Codeunit "BC6_Reconstitue lettrage FOU";
                    IntLPos: Integer;
                begin

                    RecLPayLine.RESET();
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
                                        RecLApplyingCustLedgEntry.RESET();
                                        RecLApplyingCustLedgEntry.SETRANGE("Customer No.", RecLPayLine."Account No.");
                                        RecLApplyingCustLedgEntry.SETRANGE(Open, TRUE);
                                        RecLApplyingCustLedgEntry.SETRANGE("Document No.", CodLNumDoc);
                                        //TODO : missing codeunit
                                        // IF RecLApplyingCustLedgEntry.FINDFIRST THEN
                                        //     REPEAT
                                        //         CodLCustEntryApply.InitialisationLettrage(RecLApplyingCustLedgEntry);
                                        //     UNTIL RecLApplyingCustLedgEntry.NEXT = 0;

                                        // CodLCustEntryApply.Lettrage(RecLPayLine."Account No.");
                                    END;
                                RecLPayLine."Account Type"::Vendor:
                                    BEGIN
                                        //Initialisation des ecritures à lettrer
                                        RecLApplyingVendLedgEntry.RESET();
                                        RecLApplyingVendLedgEntry.SETRANGE("Vendor No.", RecLPayLine."Account No.");
                                        RecLApplyingVendLedgEntry.SETRANGE(Open, TRUE);
                                        RecLApplyingVendLedgEntry.SETRANGE("Document No.", CodLNumDoc);

                                        //TODO: missing codeunit
                                        // IF RecLApplyingVendLedgEntry.FINDFIRST THEN
                                        // REPEAT
                                        //     CodLVendEntryApply.InitialisationLettrage(RecLApplyingVendLedgEntry);
                                        // UNTIL RecLApplyingVendLedgEntry.NEXT = 0;

                                        // CodLVendEntryApply.Lettrage(RecLPayLine."Account No.");
                                    END;
                            END;
                        UNTIL RecLPayLine.NEXT() = 0;
                    END;
                end;
            }
        }
    }
}
