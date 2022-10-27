tableextension 50079 tableextension50079 extends "Posted Invt. Pick Header"
{
    // 
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // 
    // //>>MIGRATION NAV 2013
    // //>> CNE4.02
    // C:FE10 05.10.2011 : Invt. Pick - Direct Sales
    //                   - Add Field 50000 Sales Counter
    //                   - TestField Source Document - OnValidate()
    // 
    // Old 30 -> New 35 field "Your Reference"
    // old 30 -> New 50 field "Destination Name"
    // old 30 -> New 50 field "Destination Name 2"
    LookupPageID = 7395;
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 10)".

        modify("Source No.")
        {
            TableRelation = IF (Source Type=CONST(120)) "Purch. Rcpt. Header" WHERE (No.=FIELD(Source No.))
                            ELSE IF (Source Type=CONST(110)) "Sales Shipment Header" WHERE (No.=FIELD(Source No.))
                            ELSE IF (Source Type=CONST(6650)) "Return Shipment Header" WHERE (No.=FIELD(Source No.))
                            ELSE IF (Source Type=CONST(6660)) "Return Receipt Header" WHERE (No.=FIELD(Source No.))
                            ELSE IF (Source Type=CONST(5744)) "Transfer Shipment Header" WHERE (No.=FIELD(Source No.))
                            ELSE IF (Source Type=CONST(5746)) "Transfer Receipt Header" WHERE (No.=FIELD(Source No.))
                            ELSE IF (Source Type=CONST(5405)) "Production Order".No. WHERE (Status=FILTER(Released|Finished),
                                                                                            No.=FIELD(Source No.));
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
        field(50000;"Sales Counter";Boolean)
        {
            Caption = 'Sales Counter';
            Description = 'CNE4.01';
        }
        field(50001;"Your Reference";Text[35])
        {
            Caption = 'Your Reference';
        }
        field(50002;"Destination Name";Text[50])
        {
            Caption = 'Destination Name.';
        }
        field(50003;"Destination Name 2";Text[50])
        {
            Caption = 'Destination Name 2';
        }
        field(50004;Comments;Text[50])
        {
            Caption = 'Comments';
        }
        field(50403;"Bin Code";Code[20])
        {
            Caption = 'Bin Code';
            Description = 'CNE4.01';

            trigger OnLookup()
            var
                WMSManagement: Codeunit "7302";
                BinCode: Code[20];
            begin
                //>> C:FE09 Begin
                BinCode := WMSManagement.BinLookUp("Location Code",'','','');

                IF BinCode <> '' THEN
                  VALIDATE("Bin Code",BinCode);
                //<< End
            end;

            trigger OnValidate()
            var
                WMSManagement: Codeunit "7302";
            begin
            end;
        }
    }
}

