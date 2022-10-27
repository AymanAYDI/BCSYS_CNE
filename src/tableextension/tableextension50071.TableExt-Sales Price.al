tableextension 50071 tableextension50071 extends "Sales Price"
{
    // ------------------------------------------------------------------------
    // www.Prodware.Fr
    // ------------------------------------------------------------------------
    // 
    //  //>>MIGRATION NAV 2013
    // //>>NSC1.01
    // 
    // FE25-26.001:SEBC 08/01/2007 : - Price management
    //                               - Not update standard field "Allow Line Disc."
    //                               - Change "Init value" property of fiel "Allow Line Disc."
    //                                 Yes -> <No>
    LookupPageID = 7002;
    fields
    {
        modify("Sales Code")
        {
            TableRelation = IF (Sales Type=CONST(Customer Price Group)) "Customer Price Group"
                            ELSE IF (Sales Type=CONST(Customer)) Customer
                            ELSE IF (Sales Type=CONST(Campaign)) Campaign;
        }

        //Unsupported feature: Property Insertion (DecimalPlaces) on ""Minimum Quantity"(Field 14)".



        //Unsupported feature: Code Modification on ""Sales Code"(Field 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Sales Code" <> '' THEN
              CASE "Sales Type" OF
                "Sales Type"::"All Customers":
            #4..6
                    CustPriceGr.GET("Sales Code");
                    "Price Includes VAT" := CustPriceGr."Price Includes VAT";
                    "VAT Bus. Posting Gr. (Price)" := CustPriceGr."VAT Bus. Posting Gr. (Price)";
                    "Allow Line Disc." := CustPriceGr."Allow Line Disc.";
                    "Allow Invoice Disc." := CustPriceGr."Allow Invoice Disc.";
                  END;
            #13..15
                    "Currency Code" := Cust."Currency Code";
                    "Price Includes VAT" := Cust."Prices Including VAT";
                    "VAT Bus. Posting Gr. (Price)" := Cust."VAT Bus. Posting Group";
                    "Allow Line Disc." := Cust."Allow Line Disc.";
                  END;
                "Sales Type"::Campaign:
            #22..24
                    "Ending Date" := Campaign."Ending Date";
                  END;
              END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            //>>MIGRATION NAV 2013
            //>>FE25-26.001:SEBC
            RecGSalesSetup.GET;
            //<<FE25-26.001:SEBC
            //<<MIGRATION NAV 2013
            #1..9
                    //>>MIGRATION NAV 2013
                    //>>FE25-26.001:SEBC
                    IF RecGSalesSetup."Update Price Allow Line disc." THEN
                    //<<FE25-26.001:SEBC
                    //<<MIGRATION NAV 2013

            #10..18
                    //>>MIGRATION NAV 2013
                    //>>FE25-26.001:SEBC
                    IF RecGSalesSetup."Update Price Allow Line disc." THEN
                    //<<FE25-26.001:SEBC
                    //<<MIGRATION NAV 2013

            #19..27
            */
        //end;

        //Unsupported feature: Property Deletion (InitValue) on ""Allow Line Disc."(Field 7001)".

    }

    procedure CopySalesPriceToCustomersSalesPrice(var SalesPrice: Record "7002";CustNo: Code[20])
    var
        NewSalesPrice: Record "7002";
    begin
        IF SalesPrice.FINDSET THEN
          REPEAT
            NewSalesPrice := SalesPrice;
            NewSalesPrice."Sales Type" := NewSalesPrice."Sales Type"::Customer;
            NewSalesPrice."Sales Code" := CustNo;
            IF NewSalesPrice.INSERT THEN;
          UNTIL SalesPrice.NEXT = 0;
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    var
        "-FE25-26.001:SEBC-": Integer;
        RecGSalesSetup: Record "311";
}

