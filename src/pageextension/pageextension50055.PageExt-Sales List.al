pageextension 50055 pageextension50055 extends "Sales List"
{
    // //MODIF JX-AUD du 15/03/2013
    // //Ajout du champ "Notre référence"
    layout
    {
        addafter("Control 15")
        {
            field("Your Reference"; "Your Reference")
            {
                Caption = 'Our Reference';
            }
        }
    }


    //Unsupported feature: Code Modification on "GetPageId(PROCEDURE 29)".

    //procedure GetPageId();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF MiniPagesMapping.READPERMISSION THEN
      IF MiniPagesMapping.GET(PageId) THEN
        EXIT(MiniPagesMapping.SubstitutePageID);

    EXIT(PageId);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF MiniPagesMapping.READPERMISSION THEN
      IF MiniPagesMapping.GET(PageId) THEN
        EXIT(MiniPagesMapping."Substitute Page ID");

    EXIT(PageId);
    */
    //end;
}

