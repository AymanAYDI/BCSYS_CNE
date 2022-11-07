pageextension 50030 pageextension50030 extends "Apply Vendor Entries"
{
    layout
    {
        addafter("Control 2")
        {
            field("Document Date"; "Document Date")
            {
                Editable = false;
            }
        }
        addafter("Control 10")
        {
            field("Yooz No."; "Yooz No.")
            {
            }
            field("Yooz Token link"; "Yooz Token link")
            {
                Editable = false;
                ExtendedDatatype = URL;
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 57".



        //Unsupported feature: Code Modification on "ActionSetAppliesToID(Action 32).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CalcType = CalcType::GenJnlLine) AND (ApplnType = ApplnType::"Applies-to Doc. No.") THEN
          ERROR(Text004);

        SetVendApplId;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF (CalcType = CalcType::GenJnlLine) AND (ApplnType = ApplnType::"Applies-to Doc. No.") THEN
          ERROR(CannotSetAppliesToIDErr);

        SetVendApplId;
        */
        //end;
    }

    var
        CannotSetAppliesToIDErr: Label 'You cannot set Applies-to ID while selecting Applies-to Doc. No.';

    var
        EarlierPostingDateErr: Label 'You cannot apply and post an entry to an entry with an earlier posting date.\\Instead, post the document of type %1 with the number %2 and then apply it to the document of type %3 with the number %4.';


        //Unsupported feature: Code Modification on "OnModifyRecord".

        //trigger OnModifyRecord(): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
        EXIT(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
        IF "Applies-to ID" <> xRec."Applies-to ID" THEN
          CalcApplnAmount;
        EXIT(FALSE);
        */
        //end;


        //Unsupported feature: Code Modification on "OnQueryClosePage".

        //trigger OnQueryClosePage(CloseAction: Action): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CloseAction = ACTION::LookupOK THEN
          LookupOKOnPush;
        IF ApplnType = ApplnType::"Applies-to Doc. No." THEN BEGIN
          IF OK AND (ApplyingVendLedgEntry."Posting Date" < "Posting Date") THEN BEGIN
            OK := FALSE;
            ERROR(
              Text006,ApplyingVendLedgEntry."Document Type",ApplyingVendLedgEntry."Document No.",
              "Document Type","Document No.");
          END;
          IF OK THEN BEGIN
        #11..22
          END;
          CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
              EarlierPostingDateErr,ApplyingVendLedgEntry."Document Type",ApplyingVendLedgEntry."Document No.",
        #8..25
        */
        //end;


        //Unsupported feature: Code Modification on "SetVendApplId(PROCEDURE 10)".

        //procedure SetVendApplId();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CalcType = CalcType::GenJnlLine) AND (ApplyingVendLedgEntry."Posting Date" < "Posting Date") THEN
          ERROR(
            Text006,ApplyingVendLedgEntry."Document Type",ApplyingVendLedgEntry."Document No.",
            "Document Type","Document No.");

        IF ApplyingVendLedgEntry."Entry No." <> 0 THEN
        #7..15

        ActionPerformed := VendLedgEntry."Applies-to ID" <> '';
        CalcApplnAmount;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF (CalcType = CalcType::GenJnlLine) AND (ApplyingVendLedgEntry."Posting Date" < "Posting Date") THEN
          ERROR(
            EarlierPostingDateErr,ApplyingVendLedgEntry."Document Type",ApplyingVendLedgEntry."Document No.",
        #4..18
        */
        //end;


        //Unsupported feature: Code Modification on "FindApplyingEntry(PROCEDURE 12)".

        //procedure FindApplyingEntry();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CalcType = CalcType::Direct THEN BEGIN
          VendEntryApplID := USERID;
          IF VendEntryApplID = '' THEN
        #4..13
          IF VendLedgEntry.FINDFIRST THEN BEGIN
            VendLedgEntry.CALCFIELDS(Amount,"Remaining Amount");
            ApplyingVendLedgEntry := VendLedgEntry;
            SETFILTER("Entry No.",'<> %1',VendLedgEntry."Entry No.");
            ApplyingAmount := VendLedgEntry."Remaining Amount";
            ApplnDate := VendLedgEntry."Posting Date";
            ApplnCurrencyCode := VendLedgEntry."Currency Code";
          END;
          CalcApplnAmount;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..16
            SETFILTER("Entry No.",'<>%1',VendLedgEntry."Entry No.");
        #18..23
        */
        //end;


        //Unsupported feature: Code Modification on "HandlChosenEntries(PROCEDURE 8)".

        //procedure HandlChosenEntries();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF AppliedVendLedgEntry.FINDSET(FALSE,FALSE) THEN BEGIN
          REPEAT
            AppliedVendLedgEntryTemp := AppliedVendLedgEntry;
            AppliedVendLedgEntryTemp.INSERT;
          UNTIL AppliedVendLedgEntry.NEXT = 0;
        END ELSE
          EXIT;

        FromZeroGenJnl := (CurrentAmount = 0) AND (Type = Type::GenJnlLine);

        REPEAT
          IF NOT FromZeroGenJnl THEN
            AppliedVendLedgEntryTemp.SETRANGE(Positive,CurrentAmount < 0);
          IF AppliedVendLedgEntryTemp.FINDFIRST THEN BEGIN
            AppliedVendLedgEntryTemp.CALCFIELDS("Remaining Amount");

            IF Type = Type::Direct THEN
              CalculateCurrency := ApplyingVendLedgEntry."Entry No." <> 0
            ELSE
              CalculateCurrency := TRUE;

            IF (CurrencyCode <> AppliedVendLedgEntryTemp."Currency Code") AND CalculateCurrency THEN BEGIN
              AppliedVendLedgEntryTemp."Remaining Amount" :=
                CurrExchRate.ExchangeAmount(
                  AppliedVendLedgEntryTemp."Remaining Amount",
                  AppliedVendLedgEntryTemp."Currency Code",
                  CurrencyCode,"Posting Date");
              AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible" :=
                CurrExchRate.ExchangeAmount(
                  AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible",
                  AppliedVendLedgEntryTemp."Currency Code",
                  CurrencyCode,"Posting Date");
              AppliedVendLedgEntryTemp."Amount to Apply" :=
                CurrExchRate.ExchangeAmount(
                  AppliedVendLedgEntryTemp."Amount to Apply",
                  AppliedVendLedgEntryTemp."Currency Code",
                  CurrencyCode,"Posting Date");
            END;

            CASE Type OF
              Type::Direct:
                CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscVend(VendLedgEntry,AppliedVendLedgEntryTemp,0,FALSE,FALSE);
              Type::GenJnlLine:
                CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(GenJnlLine2,AppliedVendLedgEntryTemp,0,FALSE)
              ELSE
                CanUseDisc := FALSE;
            END;

            IF CanUseDisc AND
               (ABS(AppliedVendLedgEntryTemp."Amount to Apply") >= ABS(AppliedVendLedgEntryTemp."Remaining Amount" -
                  AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible"))
            THEN BEGIN
              IF (ABS(CurrentAmount) > ABS(AppliedVendLedgEntryTemp."Remaining Amount" -
                    AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible"))
              THEN BEGIN
                PmtDiscAmount := PmtDiscAmount + AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
                CurrentAmount := CurrentAmount + AppliedVendLedgEntryTemp."Remaining Amount" -
                  AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
              END ELSE
                IF (ABS(CurrentAmount) = ABS(AppliedVendLedgEntryTemp."Remaining Amount" -
                      AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible"))
                THEN BEGIN
                  PmtDiscAmount := PmtDiscAmount + AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible" ;
                  CurrentAmount := CurrentAmount + AppliedVendLedgEntryTemp."Remaining Amount" -
                    AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
                  AppliedAmount := AppliedAmount + CorrectionAmount;
                END ELSE
                  IF FromZeroGenJnl THEN BEGIN
                    PmtDiscAmount := PmtDiscAmount + AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
                    CurrentAmount := CurrentAmount +
                      AppliedVendLedgEntryTemp."Remaining Amount" - AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
                  END ELSE BEGIN
                    PossiblePmtdisc := AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
                    IF (CurrentAmount + AppliedVendLedgEntryTemp."Remaining Amount" <= 0) <> (CurrentAmount <= 0) THEN BEGIN
                      PmtDiscAmount := PmtDiscAmount + PossiblePmtdisc;
                      AppliedAmount := AppliedAmount + CorrectionAmount;
                    END;
                CurrentAmount := CurrentAmount + AppliedVendLedgEntryTemp."Remaining Amount" -
                  AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
                  END;
            END ELSE BEGIN
              IF ((CurrentAmount + AppliedVendLedgEntryTemp."Amount to Apply") * CurrentAmount) >= 0 THEN
                AppliedAmount := AppliedAmount + CorrectionAmount;
              CurrentAmount := CurrentAmount + AppliedVendLedgEntryTemp."Amount to Apply";
            END;
          END ELSE BEGIN
            AppliedVendLedgEntryTemp.SETRANGE(Positive);
            AppliedVendLedgEntryTemp.FINDFIRST;
          END;

          IF OldPmtdisc <> PmtDiscAmount THEN
            AppliedAmount := AppliedAmount + AppliedVendLedgEntryTemp."Remaining Amount"
          ELSE
            AppliedAmount := AppliedAmount + AppliedVendLedgEntryTemp."Amount to Apply";
          OldPmtdisc := PmtDiscAmount;

          IF PossiblePmtdisc <> 0 THEN
            CorrectionAmount := AppliedVendLedgEntryTemp."Remaining Amount" - AppliedVendLedgEntryTemp."Amount to Apply"
          ELSE
            CorrectionAmount := 0;

          IF NOT DifferentCurrenciesInAppln THEN
            DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedVendLedgEntryTemp."Currency Code";

          AppliedVendLedgEntryTemp.DELETE;
          AppliedVendLedgEntryTemp.SETRANGE(Positive);

        UNTIL NOT AppliedVendLedgEntryTemp.FINDFIRST;
        CheckRounding;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..14
            ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,AppliedVendLedgEntryTemp,"Posting Date");
        #39..88
            ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,AppliedVendLedgEntryTemp,"Posting Date");
        #89..109
        */
        //end;

    procedure ExchangeAmountsOnLedgerEntry(Type: Option Direct,GenJnlLine,PurchHeader; CurrencyCode: Code[10]; var CalcVendLedgEntry: Record "25"; PostingDate: Date)
    var
        CalculateCurrency: Boolean;
    begin
        CalcVendLedgEntry.CALCFIELDS("Remaining Amount");

        IF Type = Type::Direct THEN
            CalculateCurrency := ApplyingVendLedgEntry."Entry No." <> 0
        ELSE
            CalculateCurrency := TRUE;

        IF (CurrencyCode <> CalcVendLedgEntry."Currency Code") AND CalculateCurrency THEN BEGIN
            CalcVendLedgEntry."Remaining Amount" :=
              CurrExchRate.ExchangeAmount(
                CalcVendLedgEntry."Remaining Amount",
                CalcVendLedgEntry."Currency Code",
                CurrencyCode, PostingDate);
            CalcVendLedgEntry."Remaining Pmt. Disc. Possible" :=
              CurrExchRate.ExchangeAmount(
                CalcVendLedgEntry."Remaining Pmt. Disc. Possible",
                CalcVendLedgEntry."Currency Code",
                CurrencyCode, PostingDate);
            CalcVendLedgEntry."Amount to Apply" :=
              CurrExchRate.ExchangeAmount(
                CalcVendLedgEntry."Amount to Apply",
                CalcVendLedgEntry."Currency Code",
                CurrencyCode, PostingDate);
        END;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "HandlChosenEntries(PROCEDURE 8).CalculateCurrency(Variable 1006)".

}

