pageextension 50058 pageextension50058 extends "Purchases & Payables Setup"
{
    // //Modif JX-AUD du 25/10/11
    // //Ajout de l'onglet Approbation et du champ Montant max. autorisé
    layout
    {
        addafter("Control 61")
        {
            field("Excel File Vendor Not Created"; "Excel File Vendor Not Created")
            {
            }
            field("Mail Invoice Path"; "Mail Invoice Path")
            {
            }
        }
        addafter("Control 1904569201")
        {
            group(Approval)
            {
                Caption = 'Approval';
                field("Max. Amount allowed"; "Max. Amount allowed")
                {
                    Caption = 'Max. amount allowed';

                    trigger OnValidate()
                    begin
                        Rec.MODIFY;
                    end;
                }
            }
        }
        addafter("Control 7")
        {
            group(Imports)
            {
                Caption = 'Imports';
                field("Entity Code"; "Entity Code")
                {
                }
                field("Timing Dimension 0"; "Timing Dimension 0")
                {
                }
                field("Verify Dim 0 on Purch. Line"; "Verify Dim 0 on Purch. Line")
                {
                }
                field("Timing Dimension 1"; "Timing Dimension 1")
                {
                }
                field("Verify Dim 1 on Purch. Line"; "Verify Dim 1 on Purch. Line")
                {
                }
                field("Timing Dimension 2"; "Timing Dimension 2")
                {
                }
                field("Verify Dim 2 on Purch. Line"; "Verify Dim 2 on Purch. Line")
                {
                }
                field("Timing Dimension 3"; "Timing Dimension 3")
                {
                }
                field("Verify Dim 3 on Purch. Line"; "Verify Dim 3 on Purch. Line")
                {
                }
            }
        }
    }
}

