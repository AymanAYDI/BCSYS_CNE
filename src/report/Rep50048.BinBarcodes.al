report 50048 "BC6_Bin Barcodes"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/BinBarcodes.rdl';

    Caption = 'Bin Barcodes', Comment = 'FRA="Code barre emplacement"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Bin; Bin)
        {
            RequestFilterFields = "Location Code", "Code";
            column(Bin_Location_Code; "Location Code")
            {
            }
            column(Bin_Code; Code)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
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


    labels
    {
    }

    var
        gBin1: Record Bin;
        gBin2: Record Bin;
        BarcodeMngt: Codeunit "BC6_Barcode Mngt AutoID";


    procedure GetBarCode(piBinCode: Code[20]): Text[250]
    begin
        EXIT(BarcodeMngt.EncodeBarcode39(piBinCode));
    end;
}

