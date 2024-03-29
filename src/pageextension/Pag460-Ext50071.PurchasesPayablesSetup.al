pageextension 50071 "BC6_PurchasesPayablesSetup" extends "Purchases & Payables Setup" //460
{
    layout
    {
        addafter("Exact Cost Reversing Mandatory")
        {
            field("BC6_Minima de cde"; Rec."BC6_Minima de cde")
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
            group("BC6_Freigth charge")
            {
                Caption = 'Freigth charge', Comment = 'FRA="Ligne de port"';
                field(BC6_Type; Rec.BC6_Type)
                {
                    ApplicationArea = All;
                }
                field("BC6_No."; Rec."BC6_No.")
                {
                    ApplicationArea = All;
                }
                field("BC6_DEEE Management"; Rec."BC6_DEEE Management")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("BC6_Ask custom purch price"; Rec."BC6_Ask custom purch price")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
            }
        }
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("BC6_SAV Return Order Nos."; Rec."BC6_SAV Return Order Nos.")
            {
                ApplicationArea = All;
            }
        }
    }
}
