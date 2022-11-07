pageextension 50028 pageextension50028 extends "General Ledger Entries"
{
    // //MODIF JX-AUD du 19/10/10
    // //Rajout des colonnes Lettre et Date lettrage
    // 
    // //MODIF JX-XAD 25/05/2011
    // //Mise à jour des axes analytiques dans les documents enregistrés
    // //Ajout bouton modification désignation
    // 
    // //Modif JX-AUD du 18/01/12
    // //Ajout du code axe INTRAGROUPE du Compte de contrepartie
    // 
    // //Modif JX-AUD du 10/02/12
    // //Ajout de la colonne N° origine
    // 
    // //Modif JX-ABE du 13/08/2015
    // //Ajout de la colonne Groupe compta produit TVA
    // 
    // 
    // //Modif JX-ABE du 04/05/2016
    // //Ajout la colonne N° doc. externe
    layout
    {
        addfirst("Control 1")
        {
            field("Transaction No."; "Transaction No.")
            {
            }
        }
        addafter("Control 14")
        {
            field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            {
            }
            field(Quantity; Quantity)
            {
                Visible = false;
            }
        }
        addafter("Control 1120002")
        {
            field(Letter; Letter)
            {
                Visible = false;
            }
            field("Letter Date"; "Letter Date")
            {
                Visible = false;
            }
        }
        addafter("Control 18")
        {
            field(Gtext_CodeAxe; Gtext_CodeAxe)
            {
                Caption = 'Code intragroupe ';
            }
            field("Source No."; "Source No.")
            {
            }
        }
        addafter("Control 38")
        {
            field("External Document No."; "External Document No.")
            {
            }
        }
        moveafter("Control 1"; "Control 20")
    }
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 49".


        //Unsupported feature: Property Insertion (AccessByPermission) on "GLDimensionOverview(Action 50)".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 65".

        addafter("Action 65")
        {
            separator()
            {
            }
            action("Modify dimensions")
            {
                Caption = 'Modify dimensions';

                trigger OnAction()
                var
                    ModifierAxesFacture: Report "50063";
                begin
                    //MODIF JX-XAD 25/05/2011
                    IF "Source Type" = "Source Type"::"Fixed Asset" THEN BEGIN
                        ERROR(Text001);
                    END;
                    ShowDimensions;

                    //Fin MODIF JX-XAD 25/05/2011
                end;
            }
        }
    }

    var
        Text001: Label 'This type of G/L Entry is blocked by modification of dimensions';
        Grecord_GeneralLedgerSetup: Record "98";
        Grec_Dimension: Record "348";
        Grec_DefaultDimension: Record "352";
        Gtext_CodeAxe: Text[30];
        Gcode_Axe: Code[20];
        Gtext_ColAxe: Text[30];
        Grec_NEntetefacturefournisseur: Record "122";


        //Unsupported feature: Code Insertion on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //begin
        /*
        //Modif JX-AUD du 18/01/12

        Gtext_CodeAxe := '';

        IF "Source Type" = "Source Type":: Vendor THEN
        BEGIN
          IF Grec_DefaultDimension.GET(23,"Source No.",Gcode_Axe) THEN
          BEGIN
            Gtext_CodeAxe := Grec_DefaultDimension."Dimension Value Code";
          END ELSE
            Gtext_CodeAxe := '';
        END;

        IF "Source Type" = "Source Type":: Customer THEN
        BEGIN
          IF Grec_DefaultDimension.GET(18,"Source No.",Gcode_Axe) THEN
          BEGIN
            Gtext_CodeAxe := Grec_DefaultDimension."Dimension Value Code";
          END ELSE
            Gtext_CodeAxe := '';
        END;

        //Fin modif JX-AUD du 18/01/12

        //Modif JX-AEL du 22/03/16

        IF ("Source Type" = "Source Type":: Vendor) AND
        ("Document Type" = "Document Type"::Invoice) THEN

            Grec_NEntetefacturefournisseur.GET("Document No.")
            ELSE

        CLEAR(Grec_NEntetefacturefournisseur);


        //Fin modif JX-AEL du 22/03/16
        */
        //end;


        //Unsupported feature: Code Insertion on "OnInit".

        //trigger OnInit()
        //Parameters and return type have not been exported.
        //begin
        /*
        //Modif JX-AUD du 03/01/2012
        IF Grecord_GeneralLedgerSetup.FIND('-') THEN BEGIN
           Gcode_Axe := Grecord_GeneralLedgerSetup."Shortcut Dimension 8 Code";
        END;

        //IF Grec_Dimension.GET(Gcode_Axe) THEN Gtext_ColAxe := Grec_Dimension."Code Caption";
        //Fin modif JX-AUD du 03/01/2012
        */
        //end;
}

