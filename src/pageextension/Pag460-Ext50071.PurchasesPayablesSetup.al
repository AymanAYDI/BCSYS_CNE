pageextension 50071 "BC6_PurchasesPayablesSetup" extends "Purchases & Payables Setup" //460
{
    layout
    {
        addafter("Exact Cost Reversing Mandatory")
        {
            field("BC6_Minima de cde"; "BC6_Minima de cde")
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
            group("BC6_Freigth charge")
            {
                Caption = 'Freigth charge';
                field(BC6_Type; BC6_Type)
                {
                    ApplicationArea = All;
                }
                field("BC6_No."; "BC6_No.")
                {
                    ApplicationArea = All;
                }
                field("BC6_DEEE Management"; "BC6_DEEE Management")
                {
                    ShowCaption = false;
                    ApplicationArea = All;
                }
                field("BC6_Ask custom purch price"; "BC6_Ask custom purch price")
                {
                    ShowCaption = false;
                    ApplicationArea = All;
                }
            }
        }
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("BC6_SAV Return Order Nos."; "BC6_SAV Return Order Nos.")
            {
                ApplicationArea = All;
            }
        }
    }
}

