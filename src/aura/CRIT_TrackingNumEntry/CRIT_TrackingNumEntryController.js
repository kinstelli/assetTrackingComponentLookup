({
	doInit: function(component, event, helper)
	{
	},		
    handleUpdatedText: function(component, event, helper)
    {
    	var trName = helper.allFieldsValid(component, event, helper);
    	if (trName)
    	{
    		helper.showSpinner(component);
    		helper.getAssetRecord(component, trName);
    	}else
    	{
    		helper.hideSpinner(component);
    	}
    }
})