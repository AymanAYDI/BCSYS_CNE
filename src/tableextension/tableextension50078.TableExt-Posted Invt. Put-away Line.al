tableextension 50078 tableextension50078 extends "Posted Invt. Put-away Line"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // 
    // //>>MIGRATION NAV 2013
    // //>> CNE4.01
    // B:FE07 01.09.2011 : Invt Pick Card MiniForm
    //                   - Add Field 50040 Source No. 2
    //                   - Add Field 50041 Source Line No. 2
    //                   - Add Field 50041 Source Document 2
    //                   - Add Field 50043 Source Bin Code
    LookupPageID = 7396;
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }
        modify("Destination No.")
        {
            TableRelation = IF (Destination Type=CONST(Vendor)) Vendor
                            ELSE IF (Destination Type=CONST(Customer)) Customer
                            ELSE IF (Destination Type=CONST(Location)) Location
                            ELSE IF (Destination Type=CONST(Item)) Item
                            ELSE IF (Destination Type=CONST(Family)) Family
                            ELSE IF (Destination Type=CONST(Sales Order)) "Sales Header".No. WHERE (Document Type=CONST(Order));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Agent Code"(Field 42)".

        modify("Bin Code")
        {
            TableRelation = IF (Action Type=FILTER(<>Take)) Bin.Code WHERE (Location Code=FIELD(Location Code),
                                                                            Zone Code=FIELD(Zone Code))
                                                                            ELSE IF (Action Type=FILTER(<>Take),
                                                                                     Zone Code=FILTER('')) Bin.Code WHERE (Location Code=FIELD(Location Code))
                                                                                     ELSE IF (Action Type=CONST(Take)) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
                                                                                                                                                       Zone Code=FIELD(Zone Code))
                                                                                                                                                       ELSE IF (Action Type=CONST(Take),
                                                                                                                                                                Zone Code=FILTER('')) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code));
        }
        field(50040;"Source No. 2";Code[20])
        {
            Caption = 'Source No.';
            Description = 'CNE4.01';
            Editable = false;
            TableRelation = IF (Source Document 2=CONST(Sales Order)) "Sales Header".No. WHERE (Document Type=CONST(Order));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50041;"Source Line No. 2";Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No.';
            Description = 'CNE4.01';
            Editable = false;
        }
        field(50042;"Source Document 2";Option)
        {
            BlankZero = true;
            Caption = 'Source Document';
            Description = 'CNE4.01';
            Editable = false;
            OptionCaption = ',Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,Inbound Transfer,Outbound Transfer,Prod. Consumption,Prod. Output';
            OptionMembers = ,"Sales Order",,,"Sales Return Order","Purchase Order",,,"Purchase Return Order","Inbound Transfer","Outbound Transfer","Prod. Consumption","Prod. Output";
        }
        field(50043;"Source Bin Code";Code[20])
        {
            Caption = 'Lien code emplacement origine';
            Description = 'CNE4.01';
            Editable = false;
        }
        field(50045;"Warehouse Comment";Text[50])
        {
            Caption = 'Warehouse Comments';
            Description = 'CNE4.01';
        }
    }
}

