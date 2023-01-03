codeunit 50016 "BC6_GlobalFunctionMgt"
{
    SingleInstance = true;


    //********* Page 161***********//
    procedure SetVATAmount(pVATAmount: Decimal)
    begin
        VATAmount := pVATAmount;
    end;

    procedure GetVATAmount(): Decimal
    begin
        exit(VATAmount);
    end;

    procedure SetDecGVATAmount(pDecGVATAmount: Decimal)
    begin
        DecGVATAmount := pDecGVATAmount;
    end;

    procedure GetDecGVATAmount(): Decimal
    begin
        exit(DecGVATAmount);
    end;
    //------end
    procedure SetDecGTTCAmount(pDecGTTCAmount: Decimal)
    begin
        DecGTTCAmount := pDecGTTCAmount;
    end;

    procedure GetDecGTTCAmount(): Decimal
    begin
        exit(DecGTTCAmount);
    end;
    //-------end
    procedure SetAutoTextSpe(pAutoTextSpe: Boolean)
    begin
        BooGAutoTextSpe := pAutoTextSpe;
    end;

    procedure GetAutoTextSpe(): Boolean
    begin
        exit(BooGAutoTextSpe);
    end;

    procedure SetPostingDate(pPostingDate: Date)
    begin
        PostingDate := pPostingDate;

    end;

    procedure GetPostingDate(): Date
    begin
        exit(PostingDate);
    end;

    procedure SetDeleteWhseActivity(pDeleteWhseActivity: Boolean)
    begin
        DeleteWhseActivity := pDeleteWhseActivity;
    end;

    procedure GetDeleteWhseActivity(): Boolean
    begin
        exit(DeleteWhseActivity);

    end;
    /****************** purch line *******************/
    procedure SetGDecMntTTCDEEE(pDecMntTTCDEEE: Decimal)
    begin
        GDecMntTTCDEEE := pDecMntTTCDEEE;
    end;

    procedure GetGDecMntTTCDEEE(): Decimal
    begin
        exit(GDecMntTTCDEEE);
    end;



    procedure SetGDecMntHTDEEE(pDecMntHTDEEE: Decimal)
    begin
        GDecMntHTDEEE := pDecMntHTDEEE;
    end;



    procedure GetGDecMntHTDEEE(): Decimal
    begin
        exit(GDecMntHTDEEE);
    end;
    /****************** end ****************/

    /****************sales line *************/
    procedure SetSGDecMntTTCDEEE(pDecMntTTCDEEE: Decimal)
    begin
        SGDecMntTTCDEEE := pDecMntTTCDEEE;
    end;



    procedure GetSGDecMntTTCDEEE(): Decimal
    begin
        exit(SGDecMntTTCDEEE);
    end;



    procedure SetSGDecMntHTDEEE(pDecMntHTDEEE: Decimal)
    begin
        SGDecMntHTDEEE := pDecMntHTDEEE;
    end;



    procedure GetSGDecMntHTDEEE(): Decimal
    begin
        exit(SGDecMntHTDEEE);
    end;
    //****************************************/

    procedure SetIntLSignFactor(pIntLSignFactor: Integer)
    begin
        IntLSignFactor := pIntLSignFactor;
    end;

    procedure GetIntLSignFactor(): Integer
    begin
        exit(IntLSignFactor);
    end;
    //***************************
    procedure Set_EcoPartnerDEEE(p_EcoPartnerDEEE: code[20])
    begin
        _EcoPartnerDEEE := p_EcoPartnerDEEE;
    end;

    procedure Get_EcoPartnerDEEE(): code[20]
    begin
        exit(_EcoPartnerDEEE);
    end;

    //*********
    procedure Set_DEEECategoryCode(p_DEEECategoryCode: code[20])
    begin
        _DEEECategoryCode := p_DEEECategoryCode;
    end;

    procedure Get_DEEECategoryCode(): code[20]
    begin
        exit(_DEEECategoryCode);
    end;
    //*****
    procedure Set_IsSAVReturnOrder(p_IsSAVReturnOrder: Boolean)
    begin
        _IsSAVReturnOrder := p_IsSAVReturnOrder;
    end;

    procedure Get_IsSAVReturnOrder(): Boolean
    begin
        exit(_IsSAVReturnOrder);
    end;

    procedure Set_PurchGDecMntTTCDEEE(pPurchDecMntTTCDEEE: Decimal)
    begin
        PurchGDecMntTTCDEEE := pPurchDecMntTTCDEEE;
    end;

    procedure Get_PurchGDecMntTTCDEEE(): Decimal
    begin
        exit(PurchGDecMntTTCDEEE);
    end;

    procedure Set_PurchGDecMntHTDEEE(pPurchGDecMntHTDEEE: Decimal)
    begin
        PurchGDecMntHTDEEE := pPurchGDecMntHTDEEE;
    END;

    procedure Get_PurchGDecMntHTDEEE(): Decimal
    begin
        exit(PurchGDecMntHTDEEE);
    end;

    procedure Set_PurchEcoPartnerDEEE(p_EcoPartnerDEEE: code[20])
    begin
        _PurchEcoPartnerDEEE := p_EcoPartnerDEEE;
    end;

    procedure Get_PurchEcoPartnerDEEE(): code[20]
    begin
        exit(_PurchEcoPartnerDEEE);
    end;

    procedure Set_PurchDEEECategoryCode(p_DEEECategoryCode: code[20])
    begin
        _PurchDEEECategoryCode := p_DEEECategoryCode;
    end;

    procedure Get_PurchDEEECategoryCode(): code[20]
    begin
        exit(_PurchDEEECategoryCode);
    end;

    //******** Page 233 ******//
    procedure SetBooGVendorNoStyle(pBooGVendorNoStyle: Boolean)
    begin
        BooGVendorNoStyle := pBooGVendorNoStyle;
    end;

    procedure GetBooGVendorNoStyle(): Boolean
    begin
        exit(BooGVendorNoStyle);
    end;


    procedure SetSalesReservationFound(pSalesReservationFound: Boolean)
    begin
        SalesReservationFound := pSalesReservationFound;
    end;

    procedure GetSalesReservationFound(): Boolean
    begin
        exit(SalesReservationFound);
    end;

    procedure GetCD7321_TempSalesLine(var TempSalesLineLocal: Record "Sales Line" temporary)
    begin

        TempSalesLineLocal.Copy(TempSalesLine, true);

    end;

    procedure SetCD7321_TempSalesLine(var TempSalesLineLocal: Record "Sales Line" temporary)
    begin

        TempSalesLine.Copy(TempSalesLineLocal, true);

    end;

    procedure SetDeleteWhseActivityHeaderOk(pDeleteWhseActivityHeaderOk: Boolean)
    begin
        DeleteWhseActivityHeaderOk := pDeleteWhseActivityHeaderOk;
    end;

    procedure GetDeleteWhseActivityHeaderOk(): Boolean
    begin
        exit(DeleteWhseActivityHeaderOk);
    end;

    procedure SetT77_SalesHeader(var SalesHeader: Record "Sales Header")
    begin
        T77_SalesHeader.Copy(SalesHeader, true);
    end;

    procedure GetT77_SalesHeader(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.Copy(T77_SalesHeader, true);
    end;

    //******** Page 5703************//
    procedure SetNewReceiptBinCodeEnable(pNewReceiptBinCodeEnable: Boolean)
    begin
#pragma warning disable AA0206
        NewReceiptBinCodeEnable := pNewReceiptBinCodeEnable;
#pragma warning restore AA0206
    end;
    //------ end set
    procedure SetNewShipmentBinCodeEnable(pNewShipmentBinCodeEnable: Boolean)
    begin
        NewShipmentBinCodeEnable := pNewShipmentBinCodeEnable;
    end;

    procedure GetNewShipmentBinCodeEnable(): Boolean
    begin
        exit(NewShipmentBinCodeEnable);
    end;
    //------ end  
    procedure SetNewAssemblyShipmentBinCodeEnable(pNewAssemblyShipmentBinCodeEnable: Boolean)
    begin
#pragma warning disable AA0206
        NewAssemblyShipmentBinCodeEnable := pNewAssemblyShipmentBinCodeEnable;
#pragma warning restore AA0206
    end;
    //------ end set




    //--------- page30 
    procedure GetShowIncreaseCoeff(): Boolean
    begin
        exit(NewShowIncreaseCoeff);
    end;
    //------ end  
    procedure SetShowIncreaseCoeff(pShowIncreaseCoeff: Boolean)
    begin
        NewShowIncreaseCoeff := pShowIncreaseCoeff;
    end;

    procedure SetYourReference(pYourReference: Text)
    begin
        YourReference := pYourReference;
    end;

    procedure GetYourReference(): Text;
    begin
        exit(YourReference);
    end;

    procedure SetG_LinkedPurchOrderNo(pG_LinkedPurchOrderNo: Code[20])
    begin
        G_LinkedPurchOrderNo := pG_LinkedPurchOrderNo;
    end;

    procedure GetG_LinkedPurchOrderNo(): Code[20];
    begin
        exit(G_LinkedPurchOrderNo);
    end;

    procedure SetEnableIncrPurchCost(pEnableIncrPurchCost: Boolean)
    begin
        EnableIncrPurchCost := pEnableIncrPurchCost;
    end;

    procedure GetEnableIncrPurchCost() EnableIncrPurchCost: Boolean;
    begin
        exit(EnableIncrPurchCost);
    end;

    procedure SetBoolGCopyLinesExactly(pBoolGCopyLinesExactly: Boolean)
    begin
        BoolGCopyLinesExactly := pBoolGCopyLinesExactly;
    end;

    procedure GetBoolGCopyLinesExactly(): Boolean;
    begin
        exit(BoolGCopyLinesExactly);
    end;

    procedure SetHideValidationDialog(pHideValidationDialog: Boolean);
    begin
        HideValidationDialog := pHideValidationDialog;
    end;

    procedure GetHideValidationDialog(): Boolean;
    begin
        exit(HideValidationDialog);
    end;

    var
        T77_SalesHeader: Record "Sales Header";
        TempSalesLine: Record "Sales Line" temporary;
        _IsSAVReturnOrder: Boolean;
        BooGAutoTextSpe: Boolean;
        BooGVendorNoStyle: Boolean;
        DeleteWhseActivity: Boolean;
        DeleteWhseActivityHeaderOk: Boolean;
        NewAssemblyShipmentBinCodeEnable: Boolean;
        NewReceiptBinCodeEnable: Boolean;
        NewShipmentBinCodeEnable: Boolean;
        NewShowIncreaseCoeff: Boolean;
        SalesReservationFound: Boolean;
        EnableIncrPurchCost: Boolean;
        BoolGCopyLinesExactly: Boolean;
        HideValidationDialog: Boolean;
        _DEEECategoryCode: code[20];
        _EcoPartnerDEEE: code[20];
        _PurchDEEECategoryCode: Code[20];
        _PurchEcoPartnerDEEE: Code[20];
        G_LinkedPurchOrderNo: Code[20];
        PostingDate: Date;
        DecGTTCAmount: Decimal;
        DecGVATAmount: Decimal;
        GDecMntHTDEEE: Decimal;
        GDecMntTTCDEEE: Decimal;
        PurchGDecMntHTDEEE: Decimal;
        PurchGDecMntTTCDEEE: Decimal;
        SGDecMntHTDEEE: Decimal;
        SGDecMntTTCDEEE: Decimal;
        VATAmount: Decimal;
        IntLSignFactor: Integer;
        YourReference: Text;


}
