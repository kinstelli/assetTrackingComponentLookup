public class CRIT_TrackingNumLookupController {

    
    // the param must take the form "C-XXXX-XX"
    // TODO: ISSUE -- can't lookup assets that don't already belong to user.
    @AuraEnabled
    public static Asset lookupAssetByTrackingNumber(String assetName) 
    {
            Asset theAsset = new Asset();
            
            //ensure that the given trackingDigit is an Integer
            String theQuery = 'SELECT Name, SerialNumber, Manufacturer__c, Model__c FROM Asset WHERE Name = :assetName LIMIT 1';
            
            System.debug(theQuery);
            try {
               // theAsset = [SELECT Name, SerialNumber, Manufacturer__c, Model__c FROM Asset Where TrackingNum_Number__c = :trInt and TrackingNum_Item__c = ':trItem' LIMIT 1];
                theAsset = database.query(theQuery);
            }catch(DmlException dmle)
            {
                System.debug('There was a database error: ' + dmle);
            }catch(QueryException qe)
            {
                System.debug('There was a query exception: ' + qe);
            }
            catch(Exception e){
                System.debug('There was an unexpected error: ' + e);
            }

            return theAsset;
    }
    
}