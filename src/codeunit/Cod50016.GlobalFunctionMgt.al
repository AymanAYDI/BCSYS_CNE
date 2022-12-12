codeunit 50016 "BC6_GlobalFunctionMgt"
{
    SingleInstance = true;



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




    var
        BooGAutoTextSpe: Boolean;
        PostingDate: Date;
        DeleteWhseActivity: Boolean;
        GDecMntTTCDEEE: Decimal;
        GDecMntHTDEEE: Decimal;


        SGDecMntTTCDEEE: Decimal;
        SGDecMntHTDEEE: Decimal;
        IntLSignFactor: Integer;

        _EcoPartnerDEEE: code[20];
        _DEEECategoryCode: code[20];
        _IsSAVReturnOrder: Boolean;

}
