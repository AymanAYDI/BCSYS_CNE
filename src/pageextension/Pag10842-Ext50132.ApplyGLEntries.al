pageextension 50132 "BC6_ApplyGLEntries" extends "Apply G/L Entries" //10842
{ //TODO
    actions
    {

        //Unsupported feature: Code Modification on "SetAppliesToID(Action 1120010).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CLEAR(GLEntry);
        GLEntry.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(GLEntry);

        GLEntry.LOCKTABLE;
        GLEntry.SETRANGE(Letter,'');
        IF GLEntry.FIND('-') THEN BEGIN
          // Make Applies-to ID
          IF GLEntry."Applies-to ID" <> '' THEN
            EntryApplID := ''
          ELSE
            // EntryApplID := AppliesToID;
            IF EntryApplID = '' THEN BEGIN
              EntryApplID := USERID;
              IF EntryApplID = '' THEN
                EntryApplID := '***';
            END;

          // Set Applies-to ID
          REPEAT
            // GLEntry.TESTFIELD(Open,TRUE);
            GLEntry."Applies-to ID" := EntryApplID;
            GLEntry.MODIFY;
          UNTIL GLEntry.NEXT = 0;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13
            //>>MIGRATION NAV 2013
              //STD EntryApplID := USERID;

              //>>LETTRAGE STLA 01.08.2006 COR001 [8]
              //std EntryApplID := USERID;
              EVALUATE(EntryApplID,USERID);
              //<<LETTRAGE STLA 01.08.2006 COR001 [8]
            //<<MIGRATION NAV 2013
        #15..25
        */
        //end;
    }


    //Unsupported feature: Property Modification (Length) on "ApplnCode(Variable 1120005)".

    //var
    //>>>> ORIGINAL VALUE:
    //ApplnCode : 10;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ApplnCode : 20;
    //Variable type has not been exported.
}

