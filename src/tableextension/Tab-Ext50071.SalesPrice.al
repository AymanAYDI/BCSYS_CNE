tableextension 50071 "BC6_SalesPrice" extends "Sales Price"
{

    // TODO: Check : 'Sales Price Replaced by the new implementation (V16) of price calculation: table Price List Line'
    fields
    {
        //Unsupported feature: Code Modification on ""Sales Code"(Field 2).OnValidate". TODO:

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

    var
        RecGSalesSetup: Record "Sales & Receivables Setup";
        "-FE25-26.001:SEBC-": Integer;
}

