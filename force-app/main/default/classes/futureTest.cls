public class futureTest {
    @InvocableMethod 
    public static void sendEmailToOwner(List<String> listUserNames) {
        callEmailSend(listUserNames);
    }
    @future
    public static void callEmailSend(List<String> listUserNames) {
        //Write the logic.
       //If it is a call out, use callout = true in future annoation
    }
}