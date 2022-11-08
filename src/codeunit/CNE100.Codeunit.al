codeunit 99001 "CNE1.00"
{
    // //>>CNE1.00
    // 
    // C    99001   CNE1.00                    CNE1.00
    // C        1   ApplicationManagement      NAVW14.00.02,NAVFR4.00.02,NSC2.04.01,CNE1.00
    // 
    // --------------------FEP-ADVE-200706_18_B-------------------------------------------------
    // T       36   Sales Header               NAVW14.00.02,NSC1.01,DEEE1.00,CNE1.00
    // T      112   Sales Invoice Header       NAVW14.00,NSC1.01,CNE1.00
    // T      114   Sales Cr.Memo Header       NAVW14.00,NSC1.01,CNE1.00
    // T      38    Purchase Header            NAVW14.00.02,COR001,NSC1.00,NSC1.01,DEEE1.00,CNE1.00
    // T     122    Purch. Inv. Header         NAVW13.70,NSC1.01,CNE1.00
    // T     124    Purch. Cr. Memo Hdr.       NAVW13.70,NSC1.01,CNE1.00
    // T     167    Job                        NAVW14.00.01,CNE1.00
    // F      42    Sales Order                NAVW14.00.02,NSC2.01,DEEE1.00,CNE1.00
    // F      43    Sales Invoice              NAVW14.00.02,NSC1.01,DEEE1.00,CNE1.00
    // F      44    Sales Credit Memo          NAVW14.00.02,NSC1.01,DEEE1.00,CNE1.00
    // F     132    Posted Sales Invoice       NAVW14.00,NAVFR4.00,NSC1.01,CNE1.00
    // F     134    Posted Sales Credit Memo   NAVW14.00,NSC1.01,CNE1.00
    // F      49    Purchase Quote             NAVW14.00.02,NSC1.01,CNE1.00
    // F      50    Purchase Order             NAVW14.00.02,NSC1.01,DEEE1.00,CNE1.00
    // F     138    Posted Purchase Invoice    NAVW14.00,NSC1.01,CNE1.00
    // --------------------------------------------------------------------------------------------
    // --------------------FEP-ADVE-200706_18_E-------------------------------------------------
    // T      37   Sales Line                 NAVW14.00.02,COR001,NSC2.02,DEEE1.01,CNE1.00
    // T     113   Sales Invoice Line         NAVW14.00,NSC1.0,DEEE1.00,CNE1.00
    // T     115   Sales Cr.Memo Line         NAVW14.00,NSC1.0,DEEE1.00,CNE1.00
    // T     39    Purchase Line              NAVW14.00.02,COR001,NSC1.00,NSC1.01,DEEE1.00,CNE1.00
    // T     123   Purch. Inv. Line           NAVW14.00,NSC1.00,DEEE1.00,CNE1.00
    // T     125   Purch. Cr. Memo Line.      NAVW14.00,NSC1.0,DEEE1.00,CNE1.00
    // R     50017 Sales Statistic/Vendor     CNE1.00
    // -----------------------------------------------------------------------------------------
    // 
    // --------------------FEP-ADVE-200706_18_A-------------------------------------------------
    // T     36    Sales Header                 NAVW14.00.02,NSC1.01,DEEE1.00,CNE1.00
    // T     38    Purchase Header              NAVW14.00.02,COR001,NSC1.00,NSC1.01,DEEE1.00,CNE1.00
    // T    110    Sales Shipment Header        NAVW14.00,NSC1.01,CNE1.00
    // T    112    Sales Invoice Header         NAVW14.00,NSC1.01,CNE1.00
    // T    114    Sales Cr.Memo Header         NAVW14.00,NSC1.01,CNE1.00
    // T    122    Purch.Inv.Header             NAVW13.70,NSC1.01,CNE1.00
    // T    124    Purch.Cr.Memo Hdr.           NAVW13.70,NSC1.01,CNE1.00
    // T    167    Job                          NAVW14.00.01,CNE1.00
    // T  50004    Navi+Setup                   NSC1.00,NSC1.01,CNE1.00
    // T  50009    Contact Project Relation     CNE1.00
    // T  50010    Affair Steps                 CNE1.00
    // F     41    Sales Quote                  NAVW14.00.02,NSC1.01,CNE1.00
    // F     42    Sales Order                  NAVW14.00.02,NSC2.01,DEEE1.00,CNE1.00
    // F     43    Sales Invoice                NAVW14.00.02,NSC1.01,DEEE1.00,CNE1.00
    // F     44    Sales Credit Memo            NAVW14.00.02,NSC1.01,DEEE1.00,CNE1.00
    // F     46    Purchase Quote               NAVW14.00.02,NSC1.01,CNE1.00
    // F     50    Purchase Order               NAVW14.00.02,NSC1.01,DEEE1.00,CNE1.00
    // F     88    Job Card                     NAVW13.00,CNE1.00
    // F     89    Job List                     NAVW13.00,CNE1.00
    // F    130    Posted Sales Shipement       NAVW14.00,NAVFR4.00,NSC1.01,CNE1.00
    // F    132    Posted Sales Invoice         NAVW14.00,NAVFR4.00,NSC1.01,CNE1.00
    // F    134    Posted Sales Credit Memo     NAVW14.00,NSC1.01,CNE1.00
    // F    138    Posted Purchase Invoice      NAVW14.00,NSC1.01,CNE1.00
    // F    140    Posted Purchase Credit Memo  NAVW14.00,NSC1.01,CNE1.00
    // F   6630    Sales Return Order           NAVW14.00.01,NSC1.01,CNE1.00
    // F  50006    Documents Management         NSC1.00,CNE1.00
    // F  50007    Navi+Setup                   NSC1.00,CNE1.00
    // F  50031    Contact Affair Subform       CNE1.00
    // F  50032    Affair Comment sub-form      CNE1.00
    // F  50033    Affair Steps Sub-form        CNE1.00
    // F  50034    Affair Steps Tracking        CNE1.00
    // R  50008    Purchase Order               NSC1.03,DEEE1.00,NSC2.00,CNE1.00
    // R  50009    Sales Quote                  NSC1.03,DEEE1.00,CNE1.00
    // R  50010    Sales- Invoice CNE           NSC2.00,DEEE1.00,CNE1.00
    // R  50011    Sales- Shipement CNE         NSC1.04,NSC2.02,CNE1.00
    // R  50013    Sales- Credit Memo CNE       NSC1.03,DEEE1.00,NSC2.00,CNE1.00
    // R  50015    Proces Request               NSC1.03,CNE1.00
    // R  50032    Order Confirmation CNE       NSC1.03,DEEE1.00
    // R  50019    Affair List                  CNE1.00
    // M     80    Partner                      NSC1.01,DEEE1.00,CNE1.00
    // -----------------------------------------------------------------------------------------
    // 
    // --------------------FEP-ACHATS-200706_18_A-------------------------------------------------
    // T       37   Sales Line                 NAVW14.00.02,COR001,NSC2.02,DEEE1.01,CNE1.00
    // F       46   Sales Order Subform        NAVW14.00.02,NSC1.00,NSC1.01,DEEE1.00,CNE1.00
    // R    50097   Preparation NAVIDIIGEST    NSC1.12,CNE1.00
    // T       36   Sales Header               NAVW14.00.02,NSC1.01,DEEE1.00,CNE1.00
    // C      414   Release Sales Document     NAVW13.70,NSC1.01,CNE1.00
    // F    50015   Sales Order Lines          CNE1.00
    // F    50027   Affected Orders            CNE1.00
    // F       42   Sales Order                NAVW14.00.02,NSC2.01,DEEE1.00,CNE1.00
    // F       50   Purchase Order             NAVW14.00.02,NSC1.01,DEEE1.00,CNE1.00
    // 
    // -----------------------------------------------------------------------------------------
    // 
    // --------------------FEP-ADVE-200706_18_B-------------------------------------------------
    // T       37   Sales Line                 NAVW14.00.02,COR001,NSC2.02,DEEE1.01,CNE1.00
    // T      113   Sales Invoice Line         NAVW14.00,NSC1.0,DEEE1.00,CNE1.00
    // T      115   Sales Cr.Memo Line         NAVW14.00,NSC1.0,DEEE1.00,CNE1.00
    // T     6661   Return Receipt Line        NAVW14.00.01, NSC1.0,CNE1.00
    // T      121   Purch. Rcpt. Line          NAVW14.00.01,NSC1.0,CNE
    // T      123   Purch. Inv. Line           NAVW14.00,NSC1.00,DEEE1.00,CNE1.00
    // T     6651   Return Shipment Line       NAVW14.00.01,NSC1.0,CNE
    // T      125   Purch. Cr. Memo Line       NAVW14.00,NSC1.0,DEEE1.00,CNE1.00
    // F       46   Sales Order Subform        NAVW14.00.02,NSC1.00,NSC1.01,DEEE1.00,CNE1.00
    // F    50014   Item Sales/Purch. History  CNE1.00
    // F     7172   Sales Lines Subform        NAVW14.00,DEEE1.00,CNE1.00
    // F     7173   Shipment Lines Subform     NAVW14.00,CNE1.00
    // F     7174   Invoice Lines Subform      NAVW14.00,CNE1.00
    // F     7175   Credit Memo Lines Subform  NAVW14.00,CNE1.00
    // F     7176   Return Rcpt Lines Subform  NAVW14.00,CNE1.00
    // F    50016   Purchase Lines Subform     CNE1.00
    // F    50017   Purch. Rcpt. Line Subform  CNE1.00
    // F    50018   Purch. Inv. Line Subform   CNE1.00
    // F    50019   Purch. Cr. Memo Line Subform CNE1.00
    // F    50030   Return Shipment Line Subform CNE1.00
    // C    50009   Item History Management    CNE1.00
    // 
    // 
    // --------------------FEP-ADVE-200706_18_D-------------------------------------------------
    // 
    // T       21   Cust. Ledger Entry         NAVW14.00.02,NAVFR4.00.02,COR001,NSC1.00,DEEE1.00
    // R    50018   Sales Stat/Customer        CNE1.00


    trigger OnRun()
    begin
    end;
}

