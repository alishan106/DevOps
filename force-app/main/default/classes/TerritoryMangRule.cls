global class TerritoryMangRule
{    
    webService static void fireTerritoryManagementViaSoap(List<Account> lstAccountToUpdate) 
    { 
        partnerSoapSforceCom.Soap obj = new partnerSoapSforceCom.Soap();
        partnerSoapSforceCom.LoginResult loginResult = obj.login('org@username.com', 'Password');   
        obj.SessionHeader = new partnerSoapSforceCom.SessionHeader_element();
        obj.endpoint_x =loginResult.ServerUrl;
        obj.Sessionheader.sessionid = loginResult.sessionid;
        List<sobjectPartnerSoapSforceCom.sObject_x> lst = new List<sobjectPartnerSoapSforceCom.sObject_x>();
        for(Account ac:lstAccountToUpdate)
        {
            sobjectPartnerSoapSforceCom.sObject_x tmpObj = new sobjectPartnerSoapSforceCom.sObject_x();
            tmpObj.type_x = 'Account';
            tmpObj.Id = ac.Id;
            lst.add(tmpObj);
         }
        partnerSoapSforceCom.AssignmentRuleHeader_element  obj1 = new partnerSoapSforceCom.AssignmentRuleHeader_element();
        obj1.useDefaultRule = true;
        obj.AssignmentRuleHeader = obj1;
        partnerSoapSforceCom.SaveResult[] lst1 =obj.update_x(lst);
    } 
}