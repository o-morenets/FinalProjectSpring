angular.module("registration_form", [])
    .controller("AppCtrl", function ($scope, $http, $log) {
        $scope.auth = {};
        let resultMessageLabel = document.getElementById('resultMessage');
        let inputFirstNameEl = document.getElementById('inputFirstName');
        let inputLastNameEl = document.getElementById('inputLastName');
        let inputEmailEl = document.getElementById('inputEmail');
        let inputPasswordEl = document.getElementById('inputPassword');
        let buttonSubmit = document.getElementById('btnSubmit');

        inputEmailEl.addEventListener('input', () => {
            inputEmailEl.style.color = 'black';
        });

        $scope.sendForm = function (auth) {
            $http({
                method: "POST",
                url: "/api/reg_form",
                data: $.param(auth),
                headers: {"Content-Type": "application/x-www-form-urlencoded"}
            }).then(
                function(response) {
                    resultMessageLabel.style.color = 'green';
                    $scope.message = 'Registered successfully';
                    inputFirstNameEl.value = '';
                    inputLastNameEl.value = '';
                    inputEmailEl.value = '';
                    inputPasswordEl.value = '';
                    buttonSubmit.disabled = 'true';
                },
                function(error) {
                    resultMessageLabel.style.color = 'red';
                    $scope.message = error.data.message;
                    $log.info(error);
                    inputFirstNameEl.value = error.data.userSignupDTO.firstName;
                    inputLastNameEl.value = error.data.userSignupDTO.lastName;
                    inputEmailEl.style.color = 'red';
                    inputEmailEl.value = error.data.userSignupDTO.username;
                    inputPasswordEl.value = '';
                    buttonSubmit.disabled = 'true';
                }
            );
        }
    });