codeunit 99005 "CNE4.02"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // 
    // //  CNE4.01 LOT A
    // 
    // 
    // //>> A:FE01 01.09.2011 : Bin Label Print
    // Impression des codes emplacements (Symbologie Code 39)
    // Bin Label Print (Code 39 Symbology)
    // 
    // //>> A:FE02 01.09.2011 : Assign Internal Item Code
    // Fonction d’attribution d’un code-barres interne à l’article (Symbologie EAN13)
    // Assign Internal Item Code (EAN13 Symbology)
    // 
    // //>> A:FE03 01.09.2011 : Item Label Print
    // Impression des étiquettes de la référence article EAN13 au format code-barres
    // Item Label Print (EAN13 Symbology)
    // 
    // Impression code EAN 13, police IDAutomation
    // Convert Item number in Barcode (Font IDAutomation : EAN13 Symbology)
    // 
    // //>> A:FE12 01.09.2011 : Reclass Card MiniForm
    // Ecran TP (Terminal Portable) : Formulaire de saisie pour ranger le stock dans un nouvel emplacement (Reclassement article)
    // Reclass Card MiniForm
    // 
    // //>> A:FE13 01.09.2011 : Inventory Card MiniForm
    // Ecran TP : Formulaire de saisie inventaire pour réaliser le relevé du stock par emplacement
    // Inventory Card MiniForm
    // 
    // //>> A:FE14 01.09.2011 : Inventory Control : Refresh Phys. Quantity
    // Feuille inventaire de contrôle : Fonction d’actualisation des quantités constatées
    // Inventory Control : Refresh Phys. Quantity
    // 
    // 
    // //  CNE4.01 LOT B
    // 
    // 
    // //>> B:FE04 01.09.2011 : MiniForm Menu & User Access
    // Ecran TP : Menu utilisateur pour accéder aux 3 fonctions magasin sur terminal portable (Prélèvement, Reclassement, Inventaire)
    // MiniForm Menu
    // 
    // //>> B:FE05 01.09.2011 : Inventory Pick List
    // Edition du bon de préparation à partir du prélèvement stock (2 modes de tri ou d'affichage)
    // Inventory Pick List
    // 
    // //>> B:FE06 01.09.2011 : Item Card : Show Quantity on Invt Pick List
    // Calcul et affichage de la quantité en-cours de prélèvement stock sur la fiche article et les lignes de commandes ventes
    // 
    // //>> B:FE07 01.09.2011 : Invt Pick Card MiniForm
    // Ecran TP : Formulaire de saisie du prélèvement stock
    // Invt Pick Card MiniForm
    // 
    // 
    // //  CNE4.02 LOT C
    // 
    // 
    // //>> C:FE08 05.10.2011 : Availability Customer Area - Post Invt Pick To Customer Area
    // Mise à disposition client : Nouvelle fonction de validation pour ranger le stock prélevé, dans un emplacement dédié à la comm
    // Availability Customer Area : Post Invt Pick To Customer Area
    // 
    // //>> C:FE09 05.10.2011 : Availability Customer Area - Shipping Bin
    // Mise à disposition client : Gestion d’un emplacement d’expédition dans la fiche magasin et l’en-tête de commande
    // Availability Customer Area : Shipping Bin
    // 
    // //>> C:FE10 05.10.2011 : Invt. Pick - Direct Sales
    // Prélèvement d’une commande de type vente comptoire
    // Invt. Pick - Direct Sales
    // 
    // //>> C:FE11 05.10.2011 : On Purchase Receipt - Alert For Sales Availability
    // Alerte à la réception d’achat, d’une demande de mise à disposition du stock pour une commande client
    // On Purchase Receipt - Alert For Sales Availability


    trigger OnRun()
    begin
    end;
}

