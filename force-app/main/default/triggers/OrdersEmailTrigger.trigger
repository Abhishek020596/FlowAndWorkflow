trigger OrdersEmailTrigger on Order (after insert, after update) {
    if(Trigger.isAfter){
        OrderEmailHandler.sendEmailNotification(Trigger.new);
    }
}