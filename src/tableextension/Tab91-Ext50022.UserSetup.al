tableextension 50022 "BC6_UserSetup" extends "User Setup" //91
{
    fields
    {
        field(50000; "BC6_E-mail Business Reminder"; Text[150])
        {
            Caption = 'E-mail Business Reminder', Comment = 'FRA="E-mail relance affaire"';
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Min. Forms Menu"; Boolean)
        {
            Caption = 'Portable Terminal Menu', Comment = 'FRA="Menu terminal portable"';
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Auth.Qty.to Handle Change"; Boolean)
        {
            Caption = 'Autorize Qty. to Handle Change', Comment = 'FRA="Autoriser. modif qté à traiter"';
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Aut.Qty.toHan.TestPickQty"; Boolean)
        {
            Caption = 'Aut. Qty. to Hand. withPickQty', Comment = 'FRA="Autoriser. modif qté à traiter vérif. qté prélevée"';
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Limited User"; Boolean)
        {
            Caption = 'Limited User', Comment = 'FRA="Utilisateur Limité"';
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Aut. Real Sales Profit %"; Boolean)
        {
            Caption = 'Aut. Real Sales Profit %', Comment = 'FRA="Afficher marge sur vente sans coeff."';
            DataClassification = CustomerContent;
        }
        field(50006; "BC6_Activ. Mini Margin Control"; Boolean)
        {
            Caption = 'Activate Mini Margin / Blocked Price Control', Comment = 'FRA="Activer contrôle marge mini / Prix bloqués"';
            DataClassification = CustomerContent;
        }
        field(50007; "BC6_SAV Admin"; Boolean)
        {
            Caption = 'SAV Admin', Comment = 'FRA="Administrateur SAV"';
            DataClassification = CustomerContent;
        }
    }
}
