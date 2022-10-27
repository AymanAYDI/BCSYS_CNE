tableextension 50064 tableextension50064 extends "Registered Whse. Activity Hdr."
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    //  //>>MIGRATION NAV 2013
    // //>> CNE4.01
    // C:FE10 01.11.2011 : Invt. Pick - Direct Sales
    //                   - Add Field 50000 Sales Counter
    LookupPageID = 5797;
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 10)".

    }

    //Unsupported feature: Property Modification (Name) on "OpenRegisteredActivityHeader(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "OpenRegisteredActivityHeader(PROCEDURE 12)".

    //procedure OpenRegisteredActivityHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RegisteredWhseActivHeader.SETRANGE(Type,CurrentType);
    IF USERID <> '' THEN BEGIN
      WhseEmployee.SETRANGE("User ID",USERID);
      IF NOT WhseEmployee.FIND('-') THEN
        ERROR(Text000,USERID);

      IF (CurrentLocationCode = '') AND ChangeLocation THEN
        CurrentLocationCode := WmsManagement.GetDefaultLocation;
      RegisteredWhseActivHeader.SETRANGE("Location Code",CurrentLocationCode);
      IF NOT RegisteredWhseActivHeader.FINDFIRST THEN
        REPEAT
          RegisteredWhseActivHeader.SETRANGE("Location Code",WhseEmployee."Location Code");
          IF RegisteredWhseActivHeader.FINDFIRST THEN BEGIN
            CurrentLocationCode := RegisteredWhseActivHeader."Location Code";
            FoundLocation := TRUE;
          END;
        UNTIL (WhseEmployee.NEXT = 0) OR FoundLocation;

      NewRegisteredWhseActivHeader.FILTERGROUP := 2;
      NewRegisteredWhseActivHeader.SETRANGE("Location Code",CurrentLocationCode);
      NewRegisteredWhseActivHeader.FILTERGROUP := 0;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF USERID <> '' THEN BEGIN
      FILTERGROUP := 2;
      SETRANGE("Location Code",WmsManagement.GetAllowedLocation("Location Code"));
      FILTERGROUP := 0;
    END;
    */
    //end;

    //Unsupported feature: Deletion (ParameterCollection) on "OpenRegisteredActivityHeader(PROCEDURE 12).CurrentType(Parameter 1005)".


    //Unsupported feature: Deletion (ParameterCollection) on "OpenRegisteredActivityHeader(PROCEDURE 12).ChangeLocation(Parameter 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "OpenRegisteredActivityHeader(PROCEDURE 12).CurrentLocationCode(Parameter 1007)".


    //Unsupported feature: Deletion (ParameterCollection) on "OpenRegisteredActivityHeader(PROCEDURE 12).NewRegisteredWhseActivHeader(Parameter 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "OpenRegisteredActivityHeader(PROCEDURE 12).RegisteredWhseActivHeader(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "OpenRegisteredActivityHeader(PROCEDURE 12).WhseEmployee(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "OpenRegisteredActivityHeader(PROCEDURE 12).FoundLocation(Variable 1006)".

}

