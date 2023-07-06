@RestResource(urlMapping='//*')
global class CaseManager {
    @HttpGet
    global static List<Case> getCases() {
        
        List<Case> result =  [SELECT CaseNumber,Subject,Status,Origin,Priority
                              FROM Case LIMIT 5];
        return result;
    }
    @HttpPost
    global static ID createCase(String subject, String status, String origin, String priority) {
        Case thisCase = new Case(
            Subject=subject,
            Status=status,
            Origin=origin,
            Priority=priority);
        INSERT thisCase;   
        return thisCase.Id;
    }     
}