(function(angular){

    var app = angular.module('theatreApp'); 
    
    app.controller("register", function($http) {
        
        var reg = this;

        reg.person = {
            'name':'',
            'surname':'',
            'username':'',
            'password':'',
            'email':'',
            'userid':'other'
        }

        reg.registration = function() {

            $http.post('/reg', reg.person).then(function(response) {
                if (response.data["status"] == "done") {
                    console.log("Successeful registration");
                }
            },
            function(reason){
                console.log(reason)
            });



        }


    });

        
    

})(angular);