codeunit 99999 "MODIFHL1.07"
{
    // //>> SUP_CNE1.00.00.01
    // 
    // T  37  Sales Line  NAVW14.00.02,COR001,CNE2.05,SUP_CNE1.00.00.01
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //>>Modif HL
    // // 30/05/08  SU-ISDU cf Appel I006546
    // // R 50010   Sales - Invoice CNE NSC2.00,DEEE1.00,CNE1.00
    // //<<
    // //>>Modif HL
    // // 18/06/08 SU-DADE    cf appel I006631  END du Do déplacé(OLD CODE)
    // // R 50008  Purchase Order  NSC1.03,DEEE1.00,NSC2.00,CNE1.0.0.1,SU
    // //<<
    // 
    // //<< MODIF_HL_I009784_2008-12-22_SU_ALCA
    // - R50019 Affair List - Liste affaire - CNE2.05, SU
    // 
    // //>>MODIF HL 10/03/2009 SU-GEPO cf appel I011127
    // R50009  Sales Quote   NSC1.03,DEEE1.00,CNE1.0.0.1,SU
    // 
    // //>>MODIFHL1.05 - T50005
    // I011762.001:DO 15/04/2009
    // - Set automaticaly true for "Automatic Ext. Texts" field in the Item Table when an Extended Text is created.
    // 
    // //>>MODIFHL1.06
    // F50015   Sales Order Lines   CNE2.05,CNE3.00,MODIFHL1.06
    // 
    // //>>MODIFHL1.07
    // F50015   Sales Order Lines   CNE2.05,CNE3.00,MODIFHL1.07
    // 
    // //>>MODIF HL 20/10/2009 SU-LALE cf appel I014680
    // C   99000854   Inventory Profile Offsetting   NAVW14.00.02,SU
    // 
    // 
    // //>> MODIF HL  30/10/2009 SU-DADE cf appel I014941
    // R 50009  Sales Quote  NSC1.03,DEEE1.00,CNE1.0.0.1,SU
    // 
    // //>> MODIF HL 28/01/2010 SU-LALE cf appel I016274
    // T 37      Sales Line          NAVW14.00.02,COR001,CNE1.04,SUP_CNE1.00.00.01,CNE3.00,SU
    // F 50015   Sales Order Lines   CNE2.05,CNE3.00,MODIFHL1.07,SU
    // 
    // //>> MODIF HL 29/04/2010 SU-LALE cf appel I018132
    // F   22   Customer List   NAVW14.00,NSC1.00,DEEE1.00,SU
    // 
    // //>> MODIF HL 17/05/2011 SU-LALE cf appel TI046353
    // C   83   Sales-Quote to Order (Yes/No)   NAVW13.70,NSC1.01,SU
    // 
    // //>> MODIF HL 27/12/2011 SU-LALE cf appel TI077137
    // C   7322   Create Inventory Pick   NAVW14.00.02,CNE4.02,SU
    // 
    // 
    // //>> MODIF HL 03/01/2012 SU-DADE cf appel TI078267
    // R   50037 Relance  CNE NSC1.01,SU
    // 
    // //>> MODIF HL 04/01/12 SU-DADE cf APPEL TI078354
    // R   50038 Statement avec traite NSC1.01,SU
    // 
    // //>> MODIF HL 15/05/2012 SU-LALE cf appel TI099639
    // R   50008   Purchase Order   NSC1.03,DEEE1.00,NSC2.00,CNE3.03,CNE4.02,SU
    // 
    // //>> MODIF HL 20/06/2012 SU-GEPO cf appel TI108747
    // F 42        Sales Order       NAVW14.00.02,NSC2.01,DEEE1.00,CNE3.03,CNE4.02,SU
    // 
    // //>> MODIF HL 03/07/2012 SU-GEPO cf appel TI110958
    // R 50032     Order Confirmation CNE       NSC1.03,DEEE1.00,CNE3.03,SU
    // 
    // //>> MODIF HL 27/07/2012 SU-LALE cf appel TI113954
    // T   246     Requisition Line   NAVW14.00.02,NSC1.01,SU
    // 
    // //>> MODIF HL 10/10/2012 SU-DADE cf appel TI125406
    // R   50011   Sales - Shipment CNE  NSC1.04,NSC2.02,CNE1.03,CNE4.02,SU
    // 
    // //<< 10/10/2012 SU-DADE cf Appal TI125440
    // R   50010   Sales - Invoice CNE   NSC2.00,DEEE1.00,CNE1.00,SU
    // 
    // //>> MODIF HL 16/10/2012 SU-LALE cf appel TI123761
    // F   30      Item Card   NAVW14.00.01,NSC1.01,DEEE1.00,CNE1.00,CNE4.01,SU
    // 
    // //>> MODIF HL 22/10/2012 SU-LALE cf appel TI127191
    // T   39      Purchase Line          NAVW14.00.02,COR001,NSC2.02,DEEE1.00,CNE2.05,CNE3.00,CNE4.02,SU
    // C   86      Sales-Quote to Order   NAVW14.00,NSC1.00,CNE4.01,SU
    // 
    // ------------------------------------------------------------------------


    trigger OnRun()
    begin
    end;
}

