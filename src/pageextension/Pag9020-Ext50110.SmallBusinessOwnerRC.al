pageextension 50110 "BC6_SmallBusinessOwnerRC" extends "Small Business Owner RC"//9020
{
    actions
    {
        addafter("Extended Texts")
        {
            action(BC6_Bible)
            {
                Caption = 'Bible', Comment = 'FRA="Bible"';
                Image = Report;
                RunObject = Report "BC6_BIBLE V2";
            }
            action("BC6_Vente Stat/Client")
            {
                Caption = 'Sales Stat/Customer', Comment = 'FRA="Vente Stat/Client"';
                Image = Report;
                RunObject = Report "BC6_Sales Stat/Customer";
            }
            action("BC6_Vente Stat/Fournisseur")
            {
                Caption = 'Sales Stat/Vendor', Comment = 'FRA="Vente Stat/Fournisseur"';
                Image = Report;
                RunObject = Report "BC6_Sales Statistic/Vendor";
            }
            action("BC6_Statistiques vente")
            {
                Caption = 'Sales statistics', Comment = 'FRA="Statistiques vente"';
                Image = Report;
                RunObject = Report "Sales Statistics";
            }
        }
    }
}
