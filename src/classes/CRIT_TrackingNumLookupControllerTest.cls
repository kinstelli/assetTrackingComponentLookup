@isTest
public class CRIT_TrackingNumLookupControllerTest {

	//TODO: finish this...
    @testSetup 
    static void setup() 
    {
        System.debug('Creating all the setup records.');
        CRIT_TrackingNumLookupControllerTest.createTestAssets();

    }

    static List<Asset> createTestAssets()
    {
        List<Asset> newAssets = new List<Asset>();
        for (Integer a = 5000; a < 5200; a++)
        {
            Asset newTestAsset = new Asset();
            newTestAsset.TrackingNum_Item__c = 'CP';
            newTestAsset.TrackingNum_Number__c = a;
            newTestAsset.Name = 'C-' + a + '-CP';
            newTestAsset.Manufacturer__c = 'Apple';
            newTestAsset.Model__c = 'iPhone';
            newTestAsset.SerialNumber = 'xxx1212xxx121212';
            newAssets.add(newTestAsset);
        }
        insert newAssets;
        return newAssets;
    }

    @isTest
    static void testLookupAssetByTrackingNumber()
    {
    	String goodAssetName = 'C-5000-CP';
		Asset foundAsset = CRIT_TrackingNumLookupController.lookupAssetByTrackingNumber(goodAssetName);
	   	System.assertEquals(foundAsset.Name, goodAssetName); //TODO: increment this as necessary
   		System.assertEquals(foundAsset.Manufacturer__c, 'Apple');
   		System.assertEquals(foundAsset.Model__c, 'iPhone');
   		System.assertEquals(foundAsset.SerialNumber, 'xxx1212xxx121212');
    	System.debug('TEST: Lookup of name: ' + goodAssetName + ' - Resulting asset: ' + foundAsset);

    	String nonexistentAssetName = 'C-5454054-CP';
		Asset notFoundAsset = CRIT_TrackingNumLookupController.lookupAssetByTrackingNumber(nonexistentAssetName);
	   	System.assertEquals(notFoundAsset.Name, null);
	   	System.assertEquals(notFoundAsset.Manufacturer__c, null);
    	System.debug('TEST: Lookup of name: ' + nonexistentAssetName + ' - Resulting asset: ' + notFoundAsset);

    	String malformedAssetName = 'administrator\'--';
		Asset malformedAsset = CRIT_TrackingNumLookupController.lookupAssetByTrackingNumber(malformedAssetName);
	   	System.assertEquals(malformedAsset.Name, null);
	   	System.assertEquals(malformedAsset.Manufacturer__c, null);
	   	System.debug('TEST: Lookup of name: ' + malformedAssetName + ' - Resulting asset: ' + malformedAsset);

   		malformedAssetName = ' > 1 ';
		malformedAsset = CRIT_TrackingNumLookupController.lookupAssetByTrackingNumber(malformedAssetName);
	   	System.assertEquals(malformedAsset.Name, null);
	   	System.assertEquals(malformedAsset.Manufacturer__c, null);
	   	System.debug('TEST: Lookup of name: ' + malformedAssetName + ' - Resulting asset: ' + malformedAsset);
  
    }


}	
