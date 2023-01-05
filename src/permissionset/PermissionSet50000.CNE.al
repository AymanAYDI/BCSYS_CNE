permissionset 50000 "BC6_CNE"
{
    Caption = 'CNE';
    Assignable = true;
    Permissions = tabledata "BC6_Affair Steps" = RIMD,
        tabledata "BC6_Categories of item" = RIMD,
        tabledata "BC6_Contact Mailing List" = RIMD,
        tabledata "BC6_Contact Project Relation" = RIMD,
        tabledata "BC6_DEEE Ledger Entry" = RIMD,
        tabledata "BC6_DEEE Tariffs" = RIMD,
        tabledata "BC6_Historique Mails Envoyés" = RIMD,
        tabledata "BC6_IC Table Validate" = RIMD,
        tabledata "BC6_Item Sales Profit Group" = RIMD,
        tabledata "BC6_Mailing List" = RIMD,
        tabledata "BC6_Navi+ Documents" = RIMD,
        tabledata "BC6_Navi+ Setup" = RIMD,
        tabledata "BC6_Return Order Relation" = RIMD,
        tabledata "BC6_Return Solution" = RIMD,
        tabledata "BC6_Salesperson authorized" = RIMD,
        tabledata "BC6_Setup Various Tables" = RIMD,
        tabledata "BC6_SMTP Mail Setup1" = RIMD,
        tabledata "BC6_Special Extended Text Line" = RIMD,
        tabledata "BC6_Temporary import catalogue" = RIMD,
        tabledata "BC6_Various Tables" = RIMD,
        tabledata "Customer Sales Profit Group" = RIMD,
        table "BC6_Affair Steps" = X,
        table "BC6_Categories of item" = X,
        table "BC6_Contact Mailing List" = X,
        table "BC6_Contact Project Relation" = X,
        table "BC6_DEEE Ledger Entry" = X,
        table "BC6_DEEE Tariffs" = X,
        table "BC6_Historique Mails Envoyés" = X,
        table "BC6_IC Table Validate" = X,
        table "BC6_Item Sales Profit Group" = X,
        table "BC6_Mailing List" = X,
        table "BC6_Navi+ Documents" = X,
        table "BC6_Navi+ Setup" = X,
        table "BC6_Return Order Relation" = X,
        table "BC6_Return Solution" = X,
        table "BC6_Salesperson authorized" = X,
        table "BC6_Setup Various Tables" = X,
        table "BC6_SMTP Mail Setup1" = X,
        table "BC6_Special Extended Text Line" = X,
        table "BC6_Temporary import catalogue" = X,
        table "BC6_Various Tables" = X,
        table "Customer Sales Profit Group" = X,
        codeunit "Batch Upd. Cross Ref. Bar Code" = X,
        codeunit "BC6_Barcode Mngt AutoID" = X,
        codeunit "BC6_Batch.Update Location" = X,
        codeunit "BC6_Business Reminder Mail" = X,
        codeunit "BC6_Creat Auto Cde Achat" = X,
        codeunit "BC6_Create Pur. Ord From Sales" = X,
        codeunit "BC6_Create SalesDoc Directory" = X,
        codeunit "BC6_CustEntry-Apply Posted SPE" = X,
        codeunit "BC6_Events Mgt" = X,
        codeunit "BC6_Format Report Footer Add" = X,
        codeunit "BC6_FotoWin Management" = X,
        codeunit "BC6_Functions Mgt" = X,
        codeunit "BC6_G/L Reg.-DEEE Ledger" = X,
        codeunit "BC6_IC Transfert Validation IC" = X,
        codeunit "BC6_IC Validation IC Doc lien" = X,
        codeunit "BC6_Invt. Pick To Reclass." = X,
        codeunit "BC6_Item History Management" = X,
        codeunit BC6_PagesEvents = X,
        codeunit "BC6_PDF Mail Management" = X,
        codeunit "BC6_Permission Form" = X,
        codeunit "BC6_Post Code Rebuild" = X,
        codeunit "BC6_Reconstitue lettrage CLI" = X,
        codeunit "BC6_Reconstitue lettrage FOU" = X,
        codeunit BC6_ReportHelper = X,
        codeunit "BC6_Return Order Mgt." = X,
        codeunit BC6_ScanDeviceHelper = X,
        codeunit "BC6_Session Killer" = X,
        codeunit "BC6_Tsf Trf Ach CNE ==> Bourg" = X,
        codeunit "BC6_Update IC Partner Items" = X,
        codeunit "BC6_Update Inv. Amount" = X,
        codeunit BC6_UpdateSalesShipment = X,
        codeunit "BC6_VendEntry-Apply Posted SPE" = X,
        codeunit "Extract Item Group Discount" = X,
        codeunit "Update Bin Content/To Prepare" = X,
        page "BC6_Add Log Purch. Comment" = X,
        page "BC6_Affair Comment Sub-form" = X,
        page "BC6_Affair Steps Sub-form" = X,
        page "BC6_Affair Steps Tracking" = X,
        page "BC6_Affected Orders" = X,
        page "BC6_Bin Content List MiniForm" = X,
        page "BC6_Bin List MiniForm" = X,
        page "BC6_Code Coverage 2" = X,
        page "BC6_Code Coverage Code 2" = X,
        page "BC6_Contact Affair List" = X,
        page "BC6_Contact Affair Relation" = X,
        page "BC6_Contact Affair Subform" = X,
        page "BC6_Cred. Memo Lines Subform 2" = X,
        page "BC6_Customer Profit" = X,
        page "BC6_DEEE Ledger Entries" = X,
        page "BC6_DEEE Tariffs List" = X,
        page "BC6_Documents Managment" = X,
        page "BC6_Douchettes Role Center" = X,
        page "BC6_Intégration article" = X,
        page "BC6_Inventory Card MiniForm" = X,
        page "BC6_Inventory Card MiniForm F2" = X,
        page "BC6_Inventory Card MiniForm F3" = X,
        page "BC6_Inventory Pick Mini" = X,
        page "BC6_Invoice Lines Subform 2" = X,
        page "BC6_Invoice Lines Subform 3" = X,
        page "BC6_Invt Pick List MiniForm" = X,
        page "BC6_Invt. Pick Card MiniForm" = X,
        page "BC6_Item Category List" = X,
        page "BC6_Item Invt." = X,
        page "BC6_Item Journal Pick List" = X,
        page "BC6_Item List MiniForm" = X,
        page "BC6_Item List Search CNE" = X,
        page "BC6_Item List Test" = X,
        page "BC6_Item Replanishment List" = X,
        page "BC6_Item Sales Profit Group" = X,
        page "BC6_Item Sales/Purch. History" = X,
        page "BC6_Item ScanDevice Factbox" = X,
        page "BC6_LOC Purchase Return Order" = X,
        page "BC6_LOC Sales Ret. Order List" = X,
        page "BC6_Locat. Sales Return Order" = X,
        page "BC6_Location List MiniForm" = X,
        page "BC6_Log Purch. Comment Lines" = X,
        page "BC6_Menu MiniForm" = X,
        page "BC6_Navi+ Setup" = X,
        page "BC6_Order Processor RC Admin" = X,
        page "BC6_Purch His. By-From FactBox" = X,
        page "BC6_Purch. Inv. Line Subform" = X,
        page "BC6_Purch. Rcpt. Lines Subform" = X,
        page "BC6_Purchase Lines Subform2" = X,
        page "BC6_Purchase Order (MAGASIN)" = X,
        page "BC6_Purchase Return Order Cue" = X,
        page "BC6_Quote Blocked" = X,
        page "BC6_Recherche Fichier" = X,
        page "BC6_Reclass. Card MiniForm" = X,
        page "BC6_Reclass. Card MiniForm F2" = X,
        page "BC6_Reclass. Card MiniForm F3" = X,
        page "BC6_Return Ship. Line Subform" = X,
        page "BC6_Return Solutions" = X,
        page "BC6_Sales Archives" = X,
        page "BC6_Sales Archives - Quotes" = X,
        page "BC6_Sales Hist. Sellto FactBox" = X,
        page "BC6_Sales Line Profit" = X,
        page "BC6_Sales Lines Subform 2" = X,
        page "BC6_Sales Lines Subform 3" = X,
        page "BC6_Sales Order (MAGASIN)" = X,
        page "BC6_Sales Order Lines" = X,
        page "BC6_Sales Order Lines Test" = X,
        page "BC6_Sales Quote Arch. Cde" = X,
        page "BC6_Sales Quote Arch. Sub. Cde" = X,
        page "BC6_Sales Quote Archive STD" = X,
        page "BC6_Salesperson authorized" = X,
        page "BC6_Salesperson Role Center" = X,
        page "BC6_SAV Purch. Ret. Order List" = X,
        page "BC6_SAV Purchase Return Order" = X,
        page "BC6_SAV Sales Ret. Order List" = X,
        page "BC6_SAV Sales Return Order" = X,
        page BC6_ScanDeviceButtons = X,
        page "BC6_Setup Various Tables" = X,
        page "BC6_Setup Various Tables2" = X,
        page "BC6_SFAC Client" = X,
        page "BC6_Shipment Lines Subform 2" = X,
        page "BC6_Shipment Lines Subform 3" = X,
        page "BC6_Special Extended Text" = X,
        page "BC6_Special Extended Text list" = X,
        page "BC6_Tab. Diverses (Non Modif)" = X,
        page "BC6_Test capture" = X,
        page "BC6_Test Scan List" = X,
        page "BC6_Various Tables" = X,
        page "BC6_Various Tables List" = X,
        page "Credit Memo Lines Subform 4" = X,
        page "Invt. Pick Card MiniForm F2" = X,
        page "Invt. Pick Card MiniForm F3" = X,
        page "Link purch. order - sale order" = X,
        page "LOC Purch. Return Order List" = X,
        page "Order Processor Role Center CN" = X,
        page "Purch. Cr. Memo Line Subform" = X,
        page "BC6_Racc. clavier terminaux" = X,
        page "Return Rcpt Lines Subform 2" = X,
        page "Sales Hist. Sell-to FactBo STD" = X,
        page "Sales Quote Archive SubformSTD" = X,
        page "Sales/Purch. History FactB STD" = X,
        page "Sales/Purch. History FactBox" = X,
        page "Salespers Processor Activities" = X,
        page "Salesperson Role Center SCENEO" = X,
        page "Scan Ship & Receive Activities" = X,
        page "Stockkeeping Unit List ACTI" = X,
        page "BC6_Stock. Unit List METZ" = X;
}