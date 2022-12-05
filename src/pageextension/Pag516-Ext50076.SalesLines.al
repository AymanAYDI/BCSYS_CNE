pageextension 50076 "BC6_SalesLines" extends "Sales Lines" //516
{
    // SourceTableView=SORTING("Shipment Date","Document Type","Sell-to Customer No.","Document No.","Line No."); TODO:
    layout
    {
        modify(Reserve)
        {
            Visible = false;
        }
        modify("Reserved Qty. (Base)")
        {
            Visible = false;
        }
    }

}

