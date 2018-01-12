(function(angular){
    
    var app = angular.module('theatreApp'); 


    app.config(function($stateProvider, $urlRouterProvider) {

        $stateProvider

        .state('newPerf', {
            name: "newPerf",
            url: "/newPerf",
            templateUrl: "newPerf.html"
        })
        .state('changing', {
            name: 'changing',
            url: '/changing/:id',
            templateUrl: 'changing/changing.html',
            controller: 'listOfPerformances as lp'
        })
        .state('allPerf', {
            name: 'allPerf',
            url: '/allPerf',
            templateUrl: 'allPerf/allPerf.html',
            controller: 'listOfPerformances as lp'
        })
        .state('openPerf', {
            name: 'openPerf',
            url: '/openPerf',
            templateUrl: 'openPerf/openPerf.html',
            // controller: 'openPerf as op'
        })
        .state('register', {
            name: 'register',
            url: '/register',
            templateUrl: 'register/register.html',
            // controller: 'openPerf as op'
        })
        $urlRouterProvider.otherwise("/allPerf") 



        
    });



    app.controller("listOfPerformances", function($http, $stateProvider) {
        
        var lp = this;

        lp.per = {
            'name':'stefan'
        }

        lp.performances = [];
        lp.users = [];

        // performance that we are changing
        lp.changing = {};

        // performance waiting to be reserved
        lp.reserving = {};

        // new performance
        lp.newOne = {};

        lp.newPerformance = {
            "name":"",
            "duration":"",
            "genre":"",
            "cast":"",
            "price":""
        };

        lp.newCheck = {
            "username":"",
            "password":""
        };


        lp.get_performance = function() {

            $http.get("/performances").then(function(response) {

                lp.performances = response.data;

            }), function(reason) {
                console.log(reason);
            };

        }

        lp.login_check = function() {

            $http.get("/users").then(function(response){

                lp.users = response.data;
                var a = "marko";
                if (a == lp.users["username"]) {
                    console.log(a);
                }

            }), function(reason) {
                console.log(reason);
            };


        }

        lp.check = function() {

            if (lp.newCheck["u"] == "asd") {
                console.log("Successful")
            }
                


        }


        lp.addPerformance = function() {

            var newPerformance = {
                "name": lp.newPerformance.name,
                "duration": lp.newPerformance.duration,
                "genre": lp.newPerformance.genre,
                "cast": lp.newPerformance.cast,
                "price": lp.newPerformance.price,
            };

            $http.post("/performance", newPerformance).then(function(response){
                if (response.data["status"] == "done") {
                    lp.get_performance();
                }
            },
            function(reason){
                console.log(reason);
            });



        };

        lp.deletePerf = function(id) {

            $http.delete("/deletePerf/"+id).then(function(response) {

                lp.get_performance();

            },
            function(reason) {
                console.log(reason);
            });



        }

        // prepare performance for changes
        lp.prepareChange = function(perf) {
            lp.changing = angular.copy(perf);
            console.log(lp.changing);
        }

        // reset to default
        lp.resetPerf = function() {
            lp.changing = {};
        }


        lp.changePerf = function() {

            $http.put("/changePerf/"+lp.changing.id, lp.changing).then(function(response){

                lp.get_performance();
                lp.changing = {};

            },
            function(reason) {

                console.log(reason);
                console.log(lp.changing);

            });


        }
        lp.get_performance();




        lp.getChPerf = function() {
        
            // $stateProvider.id

            $http.get('/onePerf/'+$stateProvider.id).then(function(response) {

                lp.changing = response.data;

            }), function(reason) {
                console.log(reason);
            };



        }



        lp.prepareReservation = function(perf) {
            lp.reserving = angular.copy(perf);
        }
        lp.reserve = function(perf) {

            $http.post("/reserve/"+perf.id, perf).then(function(response){
            
                console.log("reserved");
            
            },
            function(reason){

                console.log(reason);
            
            });

        }





    });

    








})(angular);