public class TelegramUtility {
    
    public static String BOT_API = Label.Telegram_Bot_API_key;

    public static void sendMessage(Message message) {
        Http httpClient = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setEndpoint('https://api.telegram.org/bot' + BOT_API + '/sendMessage');
        String body = JSON.serialize(Message);
        request.setBody(body);
        HttpResponse response = httpClient.send(request);
    }
    
    public class Message {
        Public Integer chat_id;
        Public String text;
        
        public Message(Integer chat_id, String text) {
            this.chat_id = chat_id;
            this.text = text;
        }
        
    }
}