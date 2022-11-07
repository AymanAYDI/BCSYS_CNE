dotnet
{
    assembly("")
    {
        type(""; "")
        {
        }
    }

    assembly("System.Xml")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Xml.XmlDocument"; "XmlDocument")
        {
        }

        type("System.Xml.XmlElement"; "XmlElement")
        {
        }

        type("System.Xml.XmlCDataSection"; "XmlCDataSection")
        {
        }
    }

}
