report 50048 "Bin Barcodes"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // 
    // //>> CNE4.01
    // A:FE01 01.09.2011 : Bin Label Print
    DefaultLayout = RDLC;
    RDLCLayout = './BinBarcodes.rdlc';

    Caption = 'Bin Barcodes';

    dataset
    {
        dataitem(DataItem7020; Table7354)
        {
            RequestFilterFields = "Location Code", "Code";
            column(Bin_Location_Code; "Location Code")
            {
            }
            column(Bin_Code; Code)
            {
            }
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number)
                                    WHERE (Number = CONST (1));
                column(GetBarCode_gBin1_Code_; GetBarCode(gBin1.Code))
                {
                }
                column(gBin1__Location_Code_; gBin1."Location Code")
                {
                }
                column(gBin1_Code; gBin1.Code)
                {
                }
                column(GetBarCode_gBin1_Code__Control1000000006; GetBarCode(gBin1.Code))
                {
                }
                column(CopyLoop_Number; Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    CLEAR(gBin1);
                    gBin1 := Bin;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        gBin1: Record "7354";
        gBin2: Record "7354";
        BarcodeMngt: Codeunit "50099";

    [Scope('Internal')]
    procedure GetBarCode(piBinCode: Code[20]): Text[250]
    begin
        EXIT(BarcodeMngt.EncodeBarcode39(piBinCode));
    end;
}

