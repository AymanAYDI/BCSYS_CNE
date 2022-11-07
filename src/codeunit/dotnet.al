dotnet
{
    assembly("mscorlib")
    {
        type("System.IO.File"; "File")
        {
        }

        type("System.IO.Directory"; "Directory")
        {
        }

        type("System.IO.StreamWriter"; "StreamWriter")
        {
        }

        type("System.Text.Encoding"; "Encoding")
        {
        }

        type("System.Text.UTF8Encoding"; "UTF8Encoding")
        {
        }

        type("System.IO.FileStream"; "FileStream")
        {
        }

        type("System.IO.Stream"; "Stream")
        {
        }

        type("System.IO.SearchOption"; "SearchOption")
        {
        }

        type("System.String"; "String")
        {
        }

        type("System.IO.Path"; "Path")
        {
        }

        type("System.Collections.Generic.IEnumerable`1"; "IEnumerable_Of_T")
        {
        }

        type("System.Collections.Generic.IEnumerator`1"; "IEnumerator_Of_T")
        {
        }
    }

    assembly("System.Windows.Forms")
    {
        Version = '2.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Windows.Forms.DialogResult"; "DialogResult")
        {
        }

        type("System.Windows.Forms.OpenFileDialog"; "OpenFileDialog")
        {
        }

        type("System.Windows.Forms.FolderBrowserDialog"; "FolderBrowserDialog")
        {
        }
    }

    assembly("")
    {
        type(""; "")
        {
        }
    }

    assembly("System")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Net.NetworkCredential"; "NetworkCredential")
        {
        }

        type("System.Net.WebClient"; "WebClient")
        {
        }

        type("System.Diagnostics.ProcessStartInfo"; "ProcessStartInfo")
        {
        }

        type("System.Diagnostics.ProcessWindowStyle"; "ProcessWindowStyle")
        {
        }

        type("System.Diagnostics.Process"; "Process")
        {
        }

        type("System.Net.FtpWebRequest"; "FtpWebRequest")
        {
        }

        type("System.Net.FtpWebResponse"; "FtpWebResponse")
        {
        }

        type("System.Net.WebRequestMethods+File"; "WebRequestMethods_File")
        {
        }

        type("System.ComponentModel.ListChangedEventArgs"; "ListChangedEventArgs")
        {
        }

        type("System.ComponentModel.AddingNewEventArgs"; "AddingNewEventArgs")
        {
        }

        type("System.Collections.Specialized.NotifyCollectionChangedEventArgs"; "NotifyCollectionChangedEventArgs")
        {
        }

        type("System.ComponentModel.PropertyChangedEventArgs"; "PropertyChangedEventArgs")
        {
        }

        type("System.ComponentModel.PropertyChangingEventArgs"; "PropertyChangingEventArgs")
        {
        }

        type("System.Net.HttpStatusCode"; "HttpStatusCode")
        {
        }

        type("System.Collections.Specialized.NameValueCollection"; "NameValueCollection")
        {
        }
    }

    assembly("Newtonsoft.Json")
    {
        type("Newtonsoft.Json.Linq.JObject"; "JObject")
        {
        }

        type("Newtonsoft.Json.Linq.JArray"; "JArray")
        {
        }

        type("Newtonsoft.Json.JsonConvert"; "JsonConvert")
        {
        }

        type("Newtonsoft.Json.Formatting"; "Formatting")
        {
        }

        type("Newtonsoft.Json.JsonToken"; "JsonToken")
        {
        }

        type("Newtonsoft.Json.Linq.JValue"; "JValue")
        {
        }

        type("Newtonsoft.Json.Linq.JProperty"; "JProperty")
        {
        }

        type("Newtonsoft.Json.Linq.JToken"; "JToken")
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
    }

}
