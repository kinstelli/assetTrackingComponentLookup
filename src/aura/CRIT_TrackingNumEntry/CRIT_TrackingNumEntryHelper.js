({
	showSpinner: function(component)
	{
		var spinner = component.find("spinnyStatus");
		$A.util.removeClass(spinner, 'invisible');
	},
	hideSpinner: function(component)
	{
		console.log("hiding spinner");
		var spinner = component.find("spinnyStatus");
		$A.util.addClass(spinner, 'invisible');
	},
	allFieldsValid: function(component, event, helper)
    {

	    var trNumOwner = '' + component.get("v.trNumOwner");
        var trNumDigits = '' + component.get("v.trNumDigits");
        var trNumItem = '' + component.get("v.trNumItem");
        


		//establish errors
		var curField = component.find("trackNumOwnerInput");
		curField.set("v.errors", null);
		var errorCount = 0;
		if(trNumOwner.search(/[^A-Za-z\s]/) != -1) // alpha only
		{
			errorCount++;
			curField.set("v.errors", [{message:"Must be a letter."}])
		}
		if(trNumOwner.length > 1) // 
		{
			errorCount++;
			curField.set("v.errors", [{message:"Must be a single character."}]); // Set Error
		}
		var curField = component.find("trackNumDigitsInput");
		curField.set("v.errors", null);
		if(trNumDigits.search(/[^0-9\s]/) != -1) // numeric only
		{
			errorCount++;
			curField.set("v.errors", [{message:"Must be numeric."}]); // Set Error
		}

		var curField = component.find("trackNumItemInput");
		curField.set("v.errors", null);
		if(trNumItem.search(/[^A-Za-z\s]/) != -1) // alpha only
		{
			errorCount++;
			curField.set("v.errors", [{message:"Letters only."}]); // Set Error
		}
		if(trNumItem.length > 2) // alpha only
		{
			errorCount++;
			curField.set("v.errors", [{message:"Must be two letters."}]); // Set Error
		}

		//var currentText = event.getSource().get("v.value");
		if ( errorCount == 0 && trNumOwner.length == 1 && trNumDigits.length > 1 && trNumDigits.length < 8 && trNumItem.length == 2 )
		{
			console.log("Doing lookup of: " + trNumOwner + "-" + trNumDigits + '-' + trNumItem );
			//helper.populateListOfMatchingValues(component, currentText);
			//helper.showMenu(component);
			var returnString =  "" + trNumOwner + "-" + trNumDigits + '-' + trNumItem;
			return returnString.toUpperCase();
		}
		else
		{
			return false;
		}
	},
	getAssetRecord : function(component, assetName) 
	{
		var doGetAssetFromServer = component.get("c.lookupAssetByTrackingNumber"); // call Apex Class
        var lookupParams = {
        					'assetName': assetName
        				    };
        doGetAssetFromServer.setParams(lookupParams);
        doGetAssetFromServer.setCallback(this, 
        	function setFoundValuesToOptionsList(resultSet)
            {
                var assetResult = resultSet.getReturnValue();

            	console.log("Returned from Apex with this value:");
            	console.log(assetResult);

                component.set("v.assetResult", assetResult );
                     this.hideSpinner(component);
            });
       $A.enqueueAction(doGetAssetFromServer);	
	}

})