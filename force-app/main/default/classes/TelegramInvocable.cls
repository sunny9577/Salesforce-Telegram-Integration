public class TelegramInvocable {
    
    @InvocableMethod(label='Send Via Telegram' description='Send Message to Contact Via Telegram')
    public static void logData(List<MyInputClass> data) {
        Map<Id, String> contactMessage = new Map<Id, String>();
        for(MyInputClass contactData : data) {
            contactMessage.put(contactData.contactId, contactData.message);
        }
        for(Contact contact : [SELECT id,Telegram_User_ID__c FROM Contact WHERE Id in :contactMessage.keySet() AND Telegram_User_ID__c != null]) {
            sendMessage(Integer.valueOf(contact.Telegram_User_ID__c), contactMessage.get(contact.Id));
        }
    }
    
    @future(callout = true)
    private static void sendMessage(Integer userId, String reply) {
        TelegramUtility.Message message = new TelegramUtility.Message(userId, reply);
        TelegramUtility.sendMessage(message);
    }
    
    public class MyInputClass {
        
        @InvocableVariable(label = 'Contact ID')
        public ID contactId;
        @InvocableVariable(label = 'Message')
        public String message;
        
    }
}