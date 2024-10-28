public with sharing class CaseController {

    @AuraEnabled
    public static void createCase(String subject, String description, String priority, String email, String userName) {
        Case newCase = new Case(
            Subject = subject,
            Description = description,
            Priority = priority,
            SuppliedEmail = email,
            SuppliedName = userName,
            Status = 'New',
            Origin = 'Web'            
        );
        insert newCase;
    }
}
