<!---

    Slatwall - An Open Source eCommerce Platform
    Copyright (C) ten24, LLC
	
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
	
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
	
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this program statically or dynamically with other modules is
    making a combined work based on this program.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
	
    As a special exception, the copyright holders of this program give you
    permission to combine this program with independent modules and your 
    custom code, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting program under terms 
    of your choice, provided that you follow these specific guidelines: 

	- You also meet the terms and conditions of the license of each 
	  independent module 
	- You must not alter the default display of the Slatwall name or logo from  
	  any part of the application 
	- Your custom code must not alter or create any files inside Slatwall, 
	  except in the following directories:
		/integrationServices/

	You may copy and distribute the modified version of this program that meets 
	the above guidelines as a combined work under the terms of GPL for this program, 
	provided that you include the source code of that other code when and as the 
	GNU GPL requires distribution of source code.
    
    If you modify this program, you may extend this exception to your version 
    of the program, but you are not obligated to do so.

Notes:

--->
<cfimport prefix="swa" taglib="../../../../tags" />
<cfimport prefix="hb" taglib="../../../../org/Hibachi/HibachiTags" />
<cfparam name="rc.order" type="any" />
<cfparam name="rc.edit" type="boolean" />

<cfsilent>
	<cfset local.chargeList = duplicate(rc.order.getOrderPaymentsSmartList()) />
	<cfset local.chargeList.addFilter('orderPaymentType.systemCode', 'optCharge') />
	<cfset local.chargeList.addFilter('orderPaymentStatusType.systemCode', 'opstActive') />
	
	<cfset local.creditList = duplicate(rc.order.getOrderPaymentsSmartList()) />
	<cfset local.creditList.addFilter('orderPaymentType.systemCode', 'optCredit') />
	<cfset local.creditList.addFilter('orderPaymentStatusType.systemCode', 'opstActive') />
	
	<cfset local.nonActiveList = duplicate(rc.order.getOrderPaymentsSmartList()) />
	<cfset local.nonActiveList.addInFilter('orderPaymentStatusType.systemCode', 'opstInvalid,opstRemoved') />
</cfsilent>

<cfoutput>
	<h5>#$.slatwall.rbKey('admin.entity.ordertabs.orderpayments.charges')#</h5>
	<hb:HibachiListingDisplay smartList="#local.chargeList#" 
			recordDetailAction="admin:entity.detailorderpayment"
			recordEditAction="admin:entity.editorderpayment">
		<hb:HibachiListingColumn propertyIdentifier="paymentMethod.paymentMethodName" />
		<hb:HibachiListingColumn propertyIdentifier="orderPaymentType.type" />
		<hb:HibachiListingColumn propertyIdentifier="dynamicAmountFlag" />
		<hb:HibachiListingColumn propertyIdentifier="amount" />
		<hb:HibachiListingColumn propertyIdentifier="amountReceived" />
		<hb:HibachiListingColumn propertyIdentifier="amountCredited" />
	</hb:HibachiListingDisplay>
	
	<h5>#$.slatwall.rbKey('admin.entity.ordertabs.orderpayments.credits')#</h5>
	<hb:HibachiListingDisplay smartList="#local.creditList#" 
			recordDetailAction="admin:entity.detailorderpayment"
			recordEditAction="admin:entity.editorderpayment">
		<hb:HibachiListingColumn propertyIdentifier="paymentMethod.paymentMethodName" />
		<hb:HibachiListingColumn propertyIdentifier="orderPaymentType.type" />
		<hb:HibachiListingColumn propertyIdentifier="dynamicAmountFlag" />
		<hb:HibachiListingColumn propertyIdentifier="amount" />
		<hb:HibachiListingColumn propertyIdentifier="amountReceived" />
		<hb:HibachiListingColumn propertyIdentifier="amountCredited" />
	</hb:HibachiListingDisplay>
	
	<h5>#$.slatwall.rbKey('admin.entity.ordertabs.orderpayments.nonActive')#</h5>
	<hb:HibachiListingDisplay smartList="#local.nonActiveList#" 
			recordDetailAction="admin:entity.detailorderpayment"
			recordEditAction="admin:entity.editorderpayment">
		<hb:HibachiListingColumn propertyIdentifier="orderPaymentStatusType.type" />
		<hb:HibachiListingColumn propertyIdentifier="paymentMethod.paymentMethodName" />
		<hb:HibachiListingColumn propertyIdentifier="orderPaymentType.type" />
		<hb:HibachiListingColumn propertyIdentifier="dynamicAmountFlag" search="false" range="false" sort="false" filter="false" />
		<hb:HibachiListingColumn propertyIdentifier="amount" />
		<hb:HibachiListingColumn propertyIdentifier="amountReceived" />
		<hb:HibachiListingColumn propertyIdentifier="amountCredited" />
	</hb:HibachiListingDisplay>
	
	<hb:HibachiProcessCaller action="admin:entity.preprocessorder" entity="#rc.order#" processContext="addOrderPayment" class="btn" icon="plus" modal="true" />
	
</cfoutput>
