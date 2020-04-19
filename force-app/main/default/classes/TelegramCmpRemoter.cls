public class TelegramCmpRemoter {
    
    @AuraEnabled
    public static void sendMessage(String contactId, String messageBody) {
        try {
            List<Contact> contacts = [SELECT id,Telegram_User_ID__c FROM Contact WHERE Id = :contactId AND Telegram_User_ID__c != null];
            if(contacts.size() > 0) {
                TelegramUtility.Message message = new TelegramUtility.Message(Integer.valueOf(contacts[0].Telegram_User_ID__c), messageBody);
                TelegramUtility.sendMessage(message);
            } else {
                throw new TelegramException('Message cannot be sent as the contact is not registered to receive updates.');    
            }
        }catch (Exception e) {
            throw new AuraHandledException(e.getMessage());    
        }
        
    }
    
    public class TelegramException extends Exception {}
}