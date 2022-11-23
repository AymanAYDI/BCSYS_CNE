pageextension 50081 pageextension50081 extends "Purchase List"
{
    layout
    {
        addafter("Control 6")
        {
            field(ID; ID)
            {
                Visible = BooGID;
            }
        }
        addafter("Control 99")
        {
            field(Amount; Amount)
            {
            }
            field("Amount Including VAT"; "Amount Including VAT")
            {
            }
        }
    }

    var
        "-MIGNAV2013-": Integer;
        RecGsalesSetup: Record "311";
        [InDataSet]
        BooGID: Boolean;


        //Unsupported feature: Code Modification on "OnOpenPage".

        //trigger OnOpenPage()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CopyBuyFromVendorFilter;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CopyBuyFromVendorFilter;
        //>>MIGRATION NAV 2013
        //>>FE019
        hideuser;
        //<<FE019
        //<<MIGRATION NAV 2013
        */
        //end;

    procedure "----NSC1,0---"()
    begin
    end;

    procedure hideuser()
    var
        RecLAccessControl: Record "2000000053";
    begin
        //>>FE019 point todo 48
        RecGsalesSetup.GET;
        RecGsalesSetup.TESTFIELD("allow Profit% to");
        //<<FE019 point todo 48

        //>>MIGRATION NAV 2013
        //OLD
        /*
        reclmembers.SETRANGE(reclmembers."User ID",USERID) ;
        //>>FE019 point todo 48
        //reclmembers.SETRANGE(reclmembers."Role ID",'SUPER') ;
        reclmembers.SETRANGE(reclmembers."Role ID",RecGsalesSetup."allow Profit% to") ;
        //<<FE019 point todo 48
        IF reclmembers.FIND('-') THEN
          CurrPage.ID.VISIBLE(TRUE)
        ELSE
          CurrPage.ID.VISIBLE(FALSE);
        */
        //NEW
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID);
        RecLAccessControl.SETRANGE("Role ID", RecGsalesSetup."allow Profit% to");
        IF RecLAccessControl.FINDFIRST THEN
            BooGID := TRUE
        ELSE
            BooGID := FALSE;
        //<<MIGRATION NAV 2013

    end;
}

