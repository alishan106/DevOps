@isTest
public class InsertAccountContactControllerTest {
    @isTest
    public static void AssignmentTest(){
        String jsonString = '[{"Name":"Amit Enterprises","Type":"Customer - Direct","Phone":"9797987987","Contacts":[{"FirstName":"Amit","LastName":"Kumar","Email":"amit@gmail.com"}]}]';
        System.assert(jsonString !=NULL);
        Test.startTest();
        InsertAccountContactController.InsertAccCon(jsonString);
        InsertAccountContactController.InsertAccCon('');
        Test.stopTest();
    }

}