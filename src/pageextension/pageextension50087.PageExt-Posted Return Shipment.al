pageextension 50087 pageextension50087 extends "Posted Return Shipment"
{
    // Début Modif JX-XAD du 05/08/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 79".

        addafter("Action 83")
        {
            action(CertificateOfSupplyDetails)
            {
                Caption = 'Certificate of Supply Details';
                Image = Certificate;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 780;
                RunPageLink = Document Type=FILTER(Return Shipment),Document No.=FIELD(No.);
            }
            action(PrintCertificateofSupply)
            {
                Caption = 'Print Certificate of Supply';
                Image = PrintReport;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                var
                    CertificateOfSupply: Record "780";
                begin
                    CertificateOfSupply.SETRANGE("Document Type",CertificateOfSupply."Document Type"::"Return Shipment");
                    CertificateOfSupply.SETRANGE("Document No.","No.");
                    CertificateOfSupply.Print;
                end;
            }
        }
    }

    var
        UserMgt: Codeunit "5700";


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetSecurityFilterOnRespCenter;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        FILTERGROUP(2);
        SETFILTER("User ID",UserMgt.jx_GetPurchasesFilter);
        FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008

        SetSecurityFilterOnRespCenter;
        */
    //end;
}

