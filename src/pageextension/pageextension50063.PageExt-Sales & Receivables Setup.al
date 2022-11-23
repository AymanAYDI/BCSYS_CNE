pageextension 50063 pageextension50063 extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Control 81")
        {
            field("Promised Delivery Date"; "Promised Delivery Date")
            {
            }
            field("Requested Delivery Date"; "Requested Delivery Date")
            {
            }
            field("E-Mail Administrateur"; "E-Mail Administrateur")
            {
                Caption = 'Mail pour déblocage devis';
            }
            field(Nbr_Devis; Nbr_Devis)
            {
                Caption = 'Blocage devis si nb dépasse ';
            }
            field(Période; Période)
            {
                Caption = 'Blocage devis sur période';
            }
            field("PDF Mail Tag"; "PDF Mail Tag")
            {
            }
            field("Update Price Allow Line disc."; "Update Price Allow Line disc.")
            {
            }
            field("DEEE Management"; "DEEE Management")
            {
            }
            field("allow Profit% to"; "allow Profit% to")
            {
            }
            field("Contact's Address on sales doc"; "Contact's Address on sales doc")
            {
            }
            field("RTE Fax Tag"; "RTE Fax Tag")
            {
            }
            field("Active Quantity Management"; "Active Quantity Management")
            {
            }
            field("Active Released Printing Order"; "Active Released Printing Order")
            {
            }
            field("Purchasing Code Grouping Line"; "Purchasing Code Grouping Line")
            {
            }
            field("Technicals Directory Path"; "Technicals Directory Path")
            {
            }
        }
        addafter("Control 25")
        {
            field("SAV Return Order Nos."; "SAV Return Order Nos.")
            {
            }
        }
    }


    //Unsupported feature: Code Insertion on "OnClosePage".

    //trigger OnClosePage()
    //begin
    /*
    //VALPARDEF5 HJ 13/11/2006 NAVW14.00.01,NSC1.01 [15] Definir la valeur par defaut du champs nombre devis
    IF Nbr_Devis=0 THEN
       BEGIN
          Rec.GET();
          Nbr_Devis:=5;
          Rec.MODIFY
       END;
    */
    //end;
}

