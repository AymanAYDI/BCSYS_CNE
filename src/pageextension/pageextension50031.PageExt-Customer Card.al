pageextension 50031 pageextension50031 extends "Customer Card"
{
    layout
    {
        modify("Control 64")
        {
            Visible = false;
        }
        modify("Control 93")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (Importance) on "Control 28".

        modify("Control 123")
        {
            Visible = false;
        }
        addafter("Control 28")
        {
            field("Creation Date"; "Creation Date")
            {
            }
            field("Territory Code"; "Territory Code")
            {
            }
            field("Copy Sell-to Address"; "Copy Sell-to Address")
            {
            }
            field("Salesperson Filter"; "Salesperson Filter")
            {
                Importance = Additional;
            }
        }
        addafter("Control 156")
        {
            field("Customer Sales Profit Group"; "Customer Sales Profit Group")
            {
            }
            field("Submitted to DEEE"; "Submitted to DEEE")
            {
            }
        }
        addafter("Control 1120006")
        {
            field("Pay-to Customer No."; "Pay-to Customer No.")
            {
                Editable = false;
            }
            field("Shipping Advice"; "Shipping Advice")
            {
            }
        }
        addafter("Customized Calendar")
        {
            field("Combine Shipments by Order"; "Combine Shipments by Order")
            {
            }
            field("Not Valued Shipment"; "Not Valued Shipment")
            {
            }
            field("Shipt Print All Order Line"; "Shipt Print All Order Line")
            {
            }
        }
        addafter("Control 100")
        {
            group()
            {
                field("Transaction Type"; "Transaction Type")
                {

                    trigger OnValidate()
                    begin
                        //>>MIGRATION NAV 2013

                        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"
                        Incoterm;
                        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"

                        //<<MIGRATION NAV 2013
                    end;
                }
                field(TxtGTransType; TxtGTransType)
                {
                    Editable = false;
                }
            }
            group()
            {
                field("Transaction Specification"; "Transaction Specification")
                {

                    trigger OnValidate()
                    begin
                        //>>MIGRATION NAV 2013

                        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"
                        Incoterm;
                        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"

                        //<<MIGRATION NAV 2013
                    end;
                }
                field(TxtGTransSpe; TxtGTransSpe)
                {
                    Editable = false;
                }
            }
            group()
            {
                field("Transport Method"; "Transport Method")
                {

                    trigger OnValidate()
                    begin
                        //>>MIGRATION NAV 2013

                        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"
                        Incoterm;
                        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"

                        //<<MIGRATION NAV 2013
                    end;
                }
                field(TxtGTransMeth; TxtGTransMeth)
                {
                    Editable = false;
                }
            }
            group()
            {
                field("Exit Point"; "Exit Point")
                {

                    trigger OnValidate()
                    begin
                        //>>MIGRATION NAV 2013

                        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"
                        Incoterm;
                        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"

                        //<<MIGRATION NAV 2013
                    end;
                }
                field(TxtGESPoint; TxtGESPoint)
                {
                    Editable = false;
                }
            }
            group()
            {
                field(Area;Area)
                {

                    trigger OnValidate()
                    begin
                        //>>MIGRATION NAV 2013

                        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"
                        Incoterm;
                        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"

                        //<<MIGRATION NAV 2013
                    end;
                }
                field(TxtGArea;TxtGArea)
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunObject) on "Action 136".



        //Unsupported feature: Code Insertion on "NewBlanketSalesOrder(Action 1902575205)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //var
            //"-MIGNAV2013-": Integer;
            //Doc: Record "50003";
            //TableInformation: Record "2000000028";
        //begin
            /*
            //>>MIGRATION NAV 2013

            //>>NAVIDIIGEST BR 01.08.2006 NSC1.00 [Doc_Associés] Ajout code pour afficger Form
            Doc.SETRANGE(Doc."Table No.",18);
            Doc.SETRANGE(Doc."Reference No. 1","No.");
            TableInformation.SETRANGE(TableInformation."Table No.",18);
            IF TableInformation.FIND('-') THEN
            Doc.SETRANGE(Doc."Table Name",TableInformation."Table Name");
            PAGE.RUNMODAL(50006,Doc);
            //<<NAVIDIIGEST BR 01.08.2006 NSC1.00 [Doc_Associés] Ajout code pour afficger Form

            //<<MIGRATION NAV 2013
            */
        //end;
        addafter(Contact)
        {
            separator()
            {
            }
            action("Pay-to Customer No.")
            {
                Caption = 'Pay-to Customer No.';
                Image = Vendor;
                RunObject = Page 22;
                                RunPageLink = Pay-to Customer No.=FIELD(No.);
            }
            action(SFAC)
            {
                Caption = 'SFAC';
                Image = Customer;
                RunObject = Page 50008;
            }
        }
        addafter("Action 78")
        {
            action("Salesperson authorized")
            {
                Caption = 'Salesperson authorized';
                Image = SalesPerson;
                RunObject = Page 50046;
                                RunPageLink = Customer No.=FIELD(No.);
            }
        }
        addafter("Action 121")
        {
            separator()
            {
            }
            action("Associated Document")
            {
                Caption = 'Associated Document';
                Image = Document;

                trigger OnAction()
                var
                    Doc: Record "50003";
                    TableInformation: Record "2000000028";
                begin
                    //>>NAVIDIIGEST BR 01.08.2006 NSC1.00 [Doc_Associés] Ajout code pour afficger Form
                    Doc.SETRANGE(Doc."Table No.",18);
                    Doc.SETRANGE(Doc."Reference No. 1","No.");
                    TableInformation.SETRANGE(TableInformation."Table No.",18);
                    IF TableInformation.FIND('-') THEN
                    Doc.SETRANGE(Doc."Table Name",TableInformation."Table Name");
                    PAGE.RUNMODAL(50006,Doc);
                    //<<NAVIDIIGEST BR 01.08.2006 NSC1.00 [Doc_Associés] Ajout code pour afficger Form
                end;
            }
        }
    }

    var
        "-NSC1.00-": Integer;
        TxtGTransType: Text[100];
        TxtGTransSpe: Text[100];
        TxtGTransMeth: Text[100];
        TxtGESPoint: Text[100];
        TxtGArea: Text[100];
        RecGTransType: Record "258";
        RecGTransSpe: Record "285";
        RecGTransMeth: Record "259";
        RecGTransESPoint: Record "282";
        RecGArea: Record "284";


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ActivateFields;
        StyleTxt := SetStyle;
        BlockedCustomer := (Blocked = Blocked::All);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        //>>MIGRATION NAV 2013

        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"
        Incoterm;
        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"

        //<<MIGRATION NAV 2013
        */
    //end;

    procedure "---NSC1.00---"()
    begin
    end;

    procedure Incoterm()
    begin
        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"
        IF RecGTransSpe.GET("Transaction Specification") THEN
           TxtGTransSpe := RecGTransSpe.Text
        ELSE
          TxtGTransSpe := '';


        IF RecGTransType.GET("Transaction Type") THEN
           TxtGTransType := RecGTransType.Description
        ELSE
           TxtGTransType := '';


        IF RecGTransMeth.GET("Transport Method") THEN
           TxtGTransMeth := RecGTransMeth.Description
        ELSE
           TxtGTransMeth :='';


        IF RecGTransESPoint.GET("Exit Point") THEN
           TxtGESPoint := RecGTransESPoint.Description
        ELSE
           TxtGESPoint :='';


        IF RecGArea.GET(Area) THEN
           TxtGArea := RecGArea.Text
        ELSE
           TxtGArea := '';
        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout Text INCOTERM Onglet "INTERNATIONAL"
    end;
}

