codeunit 99004 "CN3.00"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // //>>CNE3.00
    //   Correction SOBI
    // 
    // T 37 Sales line  NAVW14.00.02,COR001,CNE1.04,SUP_CNE1.00.00.01,CNE3.00
    // T 39 Purchase Line  NAVW14.00.02,COR001,NSC2.02,DEEE1.00,CNE2.05,CNE3.00
    // 
    // F 7175 Credit Memo Lines Subform NAVW14.00,CNE1.00,CNE3.00
    // F 50014 Item Sales/Purch. History CNE1.00,CNE3.00
    // F 50015 Sales Order Lines  CNE2.05,CNE3.00
    // F 50030 Return Shipment Line Subform CNE1.00,CNE3.00
    // F 50039 Credit Memo Lines Subform 2 NAVW14.00,CNE1.00,CNE3.00
    // F 50040 Return Rcpt Lines Subform 2 NAVW14.00,CNE1.00,CNE3.00
    // F 50041 Sales Lines Subform 3  NAVW14.00,DEEE1.00,CNE1.00,CNE3.00
    // F 50042 Shipment Lines Subform 3 NAVW14.00,CNE1.00,CNE3.00
    // F 50043 Invoice Lines Subform 3  NAVW14.00,CNE1.00,CNE3.00
    // F 50044 Credit Memo Lines Subform 4 NAVW14.00,CNE1.00,CNE3.00
    // 
    // R 50008 Purchase Order NSC1.03,DEEE1.00,NSC2.00,CNE1.0.0.1,CNE3.00
    // R 50019 Affair List   CNE2.05,CNE3.00
    // R 50032 Order Confirmation CNE NSC1.03,DEEE1.00,CNE1.00,CNE3.00
    // 
    // C 1 ApplicationManagement NAVW14.00.02,NAVFR4.00.02,NSC2.04.01,CNE1.04,CNE3.00


    trigger OnRun()
    begin
    end;
}

