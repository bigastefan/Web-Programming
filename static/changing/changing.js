(function(angular){

    var app = angular.module('theatreApp'); 
    
    app.controller("changing", function($http) {
        
        var ch = this;

        // performance we are changing
        ch.changing = {};

        ch.change = function() {
            console.log(ch.changing);
        }

        
        // prepare performance for changes
        ch.prepareChange = function(perf) {
            ch.changing = angular.copy(perf);
            console.log(ch.changing);
        }

        // reset to default
        ch.resetPerf = function() {
            ch.changing = {};
        }


        ch.changePerf = function() {

            $http.put("/changePerf/"+ch.changing.id, ch.changing).then(function(response){

                ch.get_performance();
                ch.changing = {};

            },
            function(reason) {

                console.log(reason);
                console.log(ch.changing);

            });
        }


    });

        
    

})(angular);