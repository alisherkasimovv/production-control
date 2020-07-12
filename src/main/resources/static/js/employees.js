let app = angular.module('productionEmpControl', []);
app.controller('EmployeeController', function ($scope, $window, $http, sharedParam, $rootScope) {
    $scope.employees = [];

    // CRUD
    $http({
        method: "GET",
        url: "/employees/get"
    }).then(function (response) {
        $scope.employees = response.data;
        xps = response.data;
    });

    $scope.deleteEmployee = function ($id) {
        $http({
            method: "GET",
            url: "/employees/delete/" + $id
        }).then(function (response) {
            $scope.employees = response.data;
        });
    };

    $scope.openModal = function ($id) {
        sharedParam.setId($id);
        $rootScope.$broadcast('siblingAndParent');
    }

});

app.controller('EmployeeModalController', function ($scope, $window, $http, sharedParam, $rootScope) {

    var temporaryCardID = "";

    $rootScope.$on('siblingAndParent', function(event, data) {

        $http({
            method: "GET",
            url: "/employees/get/groups"
        }).then(function (response) {
            $scope.groups = response.data;
        });

        $http({
            method: "GET",
            url: "/employees/get/" + sharedParam.getId()
        }).then(function (response) {

            $scope.employee = response.data;
        });
    });

    $scope.editEmployee = function () {
        $http({
            method: "POST",
            url: "/employees/edit",
            data: $scope.employee
        }).then(function (response) {
            console.log(response.data);
            $window.location.reload();
        });
    };

    $scope.saveEmployee = function () {

        $http({
            method: "POST",
            url: "/employees/save",
            data: $scope.employee
        }).then(function (response) {
            $window.location.reload();
        });
    };

    $scope.printVal = function () {
        $scope.item = $scope.employee.experience;
    };

    $scope.disableCardInput = function () {
        if (!$scope.employee.cardDisabled) {
            temporaryCardID = $scope.employee.cardId;
            $scope.employee.cardId = "Card ID is not assigned";
        } else {
            $scope.employee.cardId = temporaryCardID;
        }
    }

});

app.service('sharedParam', function () {
    var id = 0;

    var setId = function (param) {
        id = param;
    };

    var getId = function () {
        return id;
    };

    return {
        setId : setId,
        getId : getId
    }
});