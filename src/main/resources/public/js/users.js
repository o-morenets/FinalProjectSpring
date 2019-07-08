angular.module("users_form", [])
    .controller("UserCtrl", ["$scope", "$http", function ($scope, $http) {
        $scope.users = [];

        $scope.getUsers = function () {
            $http({
                method: "GET",
                url: "/users",
                headers: {"Content-Type": "application/json"}
            }).then(
                function (response) {
                    $scope.users = response.data.users;
                },
                function (error) {
                    console.log("userCtrl error")
                }
            );
        }
    }]);