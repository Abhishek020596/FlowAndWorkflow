public class OrderEmailHandler {
    public static void sendEmailNotification(List<Order> orderList){
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        
        EmailTemplate emailTemplate = [Select Id, HtmlValue, Body from EmailTemplate where name = 'sendEmailOrderStatusFailed'];
        String htmlValue = emailTemplate.HtmlValue;
        
        List<String> str = new List<String>{'abhishek@raagvitech.com'};
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        for(Order odd : orderList){
            if(odd.Status == 'Failed'){
                if(odd.OrderNumber != null){
                    htmlValue = htmlValue.replace('OrderNumber',Odd.OrderNumber);
                    htmlValue = htmlValue.replace('Status',Odd.Status);
                    System.debug('__________OrderNumber_________' +htmlValue);
                }
                mail.setToAddresses(str);
                mail.setSubject('Order Details');
                mail.setUseSignature(false);
                mail.setSaveAsActivity(false);
                mail.setTemplateID(emailTemplate.Id);
                mail.setHtmlBody(htmlValue);
                mail.setTargetObjectId(UserInfo.getUserId());
                mail.setWhatId(emailTemplate.Id);
                mail.setSenderDisplayName('Abhishek');
            }
        }
        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
        } catch (Exception e) {
            System.debug('__________Exception____________' +e.getMessage());
        } 
    }
}