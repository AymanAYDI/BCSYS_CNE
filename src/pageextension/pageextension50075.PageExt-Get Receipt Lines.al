pageextension 50075 pageextension50075 extends "Get Receipt Lines"
{
    // Modif JX-XAD du 10/01/2008
    // Ajout de 4 champs dans le formulaire :
    // - Date de comptabilisation de la réception
    // - Nom du fournisseur
    // - N° de commande
    // - N° de commande fournisseur
    // 
    // // Modif LAB du 20/07/2009
    // // Ajout champ "Your reference"
    // 
    // //Modif JX-AUD du 05/04/2011
    // //ajout du champ analytique visible periode
    layout
    {
        addafter("Control 2")
        {
            field("Posting Date"; "Posting Date")
            {
            }
            field("Nom Fournisseur"; "Nom Fournisseur")
            {
                Caption = 'Vendor name';
            }
            field("Code Utilisateur Commande"; "Code Utilisateur Commande")
            {
            }
            field("Order Number"; "Order Number")
            {
                Caption = 'Order No.';
            }
            field("Your Reference"; "Your Reference")
            {
            }
            field("Vendor Order Number"; "Vendor Order Number")
            {
                Caption = 'Vendor Order No.';
            }
        }
        addafter("Control 20")
        {
            field("Axe 0"; Gtext_Axe0)
            {
                CaptionClass = Gtext_ColAxe0;
                MultiLine = true;
                Visible = "Axe 0Visible";
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 47".

    }

    var
        DateCompta: Date;
        NomFournisseur: Text[50];
        NumCommande: Code[20];
        CommandeFournisseur: Code[20];
        "En-tête réc. enregistrées": Record "120";
        Gtext_Axe0: Text[30];
        Gcode_Axe1: Code[20];
        Grecord_GeneralLedgerSetup: Record "98";
        Gtext_ColAxe0: Text[30];
        Grec_Dimension: Record "348";
        [InDataSet]
        "Axe 0Visible": Boolean;

    var
        Grec_DimSetEntry: Record "480";


        //Unsupported feature: Code Modification on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "Document No.HideValue" := FALSE;
        //Modif JX-AUD du 05/04/2011
        IF Grec_DimSetEntry.GET("Dimension Set ID", Gcode_Axe1) THEN
          Gtext_Axe0 := Grec_DimSetEntry."Dimension Value Code"
        ELSE
         Gtext_Axe0 :='';
        //FIN Modif JX-AUD du 05/04/2011
        DocumentNoOnFormat;
        */
        //end;


        //Unsupported feature: Code Insertion on "OnInit".

        //trigger OnInit()
        //Parameters and return type have not been exported.
        //begin
        /*
        "Axe 0Visible" := TRUE;
        */
        //end;


        //Unsupported feature: Code Insertion on "OnOpenPage".

        //trigger OnOpenPage()
        //begin
        /*
        //Modif JX-AUD du 05/04/2011
        "Axe 0Visible" := TRUE;
        IF Grecord_GeneralLedgerSetup.FIND('-') THEN BEGIN

          Gcode_Axe1 := Grecord_GeneralLedgerSetup."Shortcut Dimension 3 Code";
          IF Grec_Dimension.GET(Gcode_Axe1) THEN  Gtext_ColAxe0 := Grec_Dimension."Code Caption" ELSE "Axe 0Visible" := FALSE;

        END;
        //Modif JX-AUD du 05/04/2011
        */
        //end;

        //Unsupported feature: Property Deletion (SourceTableTemporary).

}

