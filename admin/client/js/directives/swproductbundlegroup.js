'use strict';
angular.module('slatwalladmin')
.directive('swProductBundleGroup', 
['$http',
 '$log',
'productBundlePartialsPath',
function($http,
$log,
productBundlePartialsPath){
	return {
		require:"^swProductBundleGroups",
		restrict: 'A',
		templateUrl:productBundlePartialsPath+"productbundlegroup.html",
		scope:{
			productBundleGroup:"=",
			index:"="
		},
		link: function(scope, element,attrs,productBundleGroupsController){
			$log.debug('productBundleGroup');
			$log.debug(scope.productBundleGroup);
			
			scope.removeProductBundleGroup = function(){
				
			};
		}
	};
}]);
	
