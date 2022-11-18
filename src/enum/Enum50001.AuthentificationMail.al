enum 50001 "BC6_AuthentificationMail"
{
    Extensible = false;

    value(0; Anonymous)
    {
        Caption = 'Anonymous', comment = 'FRA="Anonyme"';
    }
    value(1; NTLM)
    {
        Caption = 'NTLM', comment = 'FRA="NTLM"';
    }
    value(2; Basic)
    {
        Caption = 'Basic', comment = 'FRA="Standard"';
    }
}
