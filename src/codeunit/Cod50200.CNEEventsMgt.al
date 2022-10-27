codeunit 50200 "BC6_CNE_EventsMgt"
{

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnCreateCustomerOnBeforeCustomerModify', '', false, false)]
    local procedure T5050_OnCreateCustomerOnBeforeCustomerModify_Contact(var Customer: Record Customer; Contact: Record Contact)
    var
        CustTemplate: Record "Customer Template";
    begin
        Customer."Submitted to DEEE" := CustTemplate."BC6_Submitted to DEEE";
    end;
}
