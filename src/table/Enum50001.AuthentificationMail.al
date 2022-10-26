enum 50001 "BC6_AuthentificationMail"
{
    Extensible = false;

    value(0; Anonymous)
    {
        Caption = 'Anonymous';
    }
    value(1; NTLM)
    {
        Caption = 'NTLM';
    }
    value(2; Basic)
    {
        Caption = 'Basic';
    }
}
