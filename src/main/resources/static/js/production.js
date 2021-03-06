var app = angular.module("productionControl", []);

app.controller('ProductionIndexController', function ($scope, $window, $http, sharedParam, $rootScope) {

    $scope.itemCount = 10;
    $scope.pageNo = 0;
    $scope.currentPage = 0;
    $scope.sortingDirection = true;
    $scope.totalPages = 0;
    $scope.pageLinks = [];

    //CRUD
    $http({
        method: "GET",
        url: "/production/get/0/10/true"
    }).then(function (response) {
        $scope.prepareReceivedCollection(response);
    });

    $scope.openModal = function ($id) {
        sharedParam.setId($id);
        $rootScope.$broadcast('siblingAndParent');
    };

    $scope.deleteProduction = function ($id) {
        $http({
            method: "GET",
            url: "/production/delete/" + $id
        }).then(function (response) {
            $scope.getAll();
        });
    };

    $scope.getAll = function (link) {
        $http({
            method: "GET",
            url: link
        }).then(function (response) {
            $scope.prepareReceivedCollection(response);
        });
    };

    $scope.prepareReceivedCollection = function (response) {
        $scope.production = response.data.pwp;
        $scope.totalPages = response.data.totalPages;
        $scope.currentPage = response.data.currentPage;

        let links = [];
        if ($scope.currentPage === 0) {
            for (let i = 0; i <= 4; ++i) {
                let page = $scope.pageLinksCreator(i);
                links.push(page);
            }
        } else if ($scope.currentPage === 1) {
            for (let i = $scope.currentPage - 1; i < $scope.currentPage + 4; i++) {
                let page = $scope.pageLinksCreator(i);
                links.push(page);
            }
        } else if ($scope.currentPage > 1 && $scope.currentPage < $scope.totalPages - 2) {
            for (let i = $scope.currentPage - 2; i < $scope.currentPage + 3; i++) {
                let page = $scope.pageLinksCreator(i);
                links.push(page);
            }
        } else if ($scope.currentPage === $scope.totalPages - 2) {
            for (let i = $scope.currentPage - 3; i < $scope.currentPage + 2; i++) {
                let page = $scope.pageLinksCreator(i);
                links.push(page);
            }
        } else if ($scope.currentPage === $scope.totalPages - 1) {
            for (let i = $scope.currentPage - 4; i <= $scope.currentPage; i++) {
                let page = $scope.pageLinksCreator(i);
                links.push(page);
            }
        }
        $scope.pageLinks = links;

        $scope.firstAndLastLinks = {
            "first": "/production/get/0/" + $scope.itemCount + "/" + $scope.sortingDirection,
            "last" : "/production/get/" + $scope.totalPages - 1 + "/" + $scope.itemCount + "/" + $scope.sortingDirection
        };
    };

    // Create an object called page and fill it with index number and link to the page
    $scope.pageLinksCreator = function (id) {
        let page = {
            "index": 0,
            "link": ""
        };

        page.index = id;
        page.link = "/production/get/" + id + "/" + $scope.itemCount + "/" + $scope.sortingDirection;

        return page;
    };
});

app.controller('RegisterProduction', function ($scope, $window, $http, sharedParam, $rootScope) {
    // Employee list that will be showed in frontend
    $scope.performerRows = [];

    $scope.collection = [];
    $scope.production = {
        "date": new Date(),
        "reference": "",
        "productId": 0,
        "product": null,
        "amount": 0,
        "cost": 0
    };

    $scope.prf = {
        "listId": 1,
        "id": null,
        "employee": null,
        "employeeId": 0,
        "experience": 0,
        "workedHours": 1,
        "salary": 0
    };

    $rootScope.$on('siblingAndParent', function (event, data) {
        $http({
            method: "GET",
            url: "/production/get/" + sharedParam.getId()
        }).then(function (response) {
            $scope.employees = response.data.employees;
            $scope.products = response.data.products;

            if (response.data.production !== null) {
                $scope.production = response.data.production.production;
                $scope.production.product = response.data.production.product;
                $scope.performerRows = [];

                for (let i = 0; i < response.data.production.performerRows.length; ++i) {
                    $scope.prf = {
                        "listId": 1,
                        "id": null,
                        "employee": null,
                        "employeeId": 0,
                        "experience": 0,
                        "workedHours": 1,
                        "salary": 0
                    };

                    $scope.prf.listId = i + 1;
                    $scope.prf.id = response.data.production.performerRows[i].id;
                    $scope.prf.employee = response.data.production.performerRows[i].employee;
                    $scope.prf.employeeId = response.data.production.performerRows[i].employee.id;
                    $scope.prf.experience = response.data.production.performerRows[i].experience;
                    $scope.prf.workedHours = response.data.production.performerRows[i].workedHours;
                    $scope.prf.salary = response.data.production.performerRows[i].salary;

                    $scope.performerRows.push($scope.prf);
                }
                $scope.calculateSalaryForOne();

                $scope.addNewRow();
            } else {
                $scope.overallSalary = 0;
                $scope.production = {
                    "date": new Date(),
                    "reference": "",
                    "productId": 0,
                    "product": null,
                    "amount": 0,
                    "cost": 0
                };
                $scope.performerRows = [];

                $scope.addNewRow();
            }
        });
    });

    $scope.selectProduct = function () {
        $scope.production.productId = $scope.production.product;
        $scope.production.product = $scope.products.find(x => x.id === $scope.production.product);

        $scope.calcTotalCost();
    };

    /*
     * Adding new row to table and calculating salaries for performers
     */
    $scope.addThisEmployee = function ($id) {
        if ($scope.performerRows.length === 1) {
            $scope.performerRows[0].employee = $scope.employees.find(x => x.id === $scope.performerRows[0].employee);
            $scope.performerRows[0].employeeId = $scope.performerRows[0].employee.id;
            $scope.performerRows[0].experience = $scope.performerRows[0].employee.experience;

            $scope.calculateSalaryForOne();
            $scope.addNewRow();

        } else {
            $scope.performerRows[$id - 1].employee = $scope.employees.find(x => x.id === $scope.performerRows[$id - 1].employee);
            $scope.performerRows[$id - 1].employeeId = $scope.performerRows[$id - 1].employee.id;
            $scope.performerRows[$id - 1].experience = $scope.performerRows[$id - 1].employee.experience;

            $scope.calculateSalaryForOne();
            if ($id === $scope.performerRows.length) {
                $scope.addNewRow();
            }
        }
    };

    $scope.addNewRow = function () {
        $scope.prf = {
            "listId": $scope.performerRows.length + 1,
            "id": null,
            "employee": null,
            "employeeId": 0,
            "experience": 1,
            "workedHours": 1,
            "salary": 0
        };
        $scope.performerRows.push($scope.prf);
    };

    $scope.calculateSalaryForOne = function () {
        $scope.overallSalary = 0;
        let whAndXp = 0;
        let salaryPerHour = 0;

        for (let i = 0; i < $scope.performerRows.length; i++) {
            if ($scope.performerRows[i].employee === null) break;
            whAndXp = whAndXp + ($scope.performerRows[i].experience * $scope.performerRows[i].workedHours);
        }

        salaryPerHour = $scope.production.cost / whAndXp;

        for (let i = 0; i < $scope.performerRows.length; i++) {
            if ($scope.performerRows[i].employee === null) break;

            $scope.performerRows[i].salary = $scope.salaryForOnePerson(
                salaryPerHour,
                $scope.performerRows[i].experience,
                $scope.performerRows[i].workedHours
            );

            $scope.overallSalary += $scope.performerRows[i].salary;
        }
    };

    /*
     * Formula for calculating salary itself for one person with rounding it to 1000
     */
    $scope.salaryForOnePerson = function ($salaryPerHour, $experience, $workHour) {
        return Math.round(($salaryPerHour * $experience * $workHour) / 1000) * 1000
    };

    /*****************************************************
     *
     * Work with production cost
     * */
    $scope.calcTotalCost = function () {
        $scope.production.cost = $scope.production.amount * $scope.production.product.rate;
        $scope.calculateSalaryForOne();
    };

    $scope.setTotalCostToNull = function () {
        $scope.production.amount = 0;
        $scope.production.cost = "";
    };
    /*****************************************************/

    /*
     * Collecting all data and saving production
     */
    $scope.saveProduction = function () {
        console.log($scope.production);
        console.log($scope.performerRows);

        $scope.performerRows.splice(-1,1);

        $scope.collection = {
            "production": $scope.production,
            "performers": $scope.performerRows
        };

        $http({
            method: "POST",
            url: "/production/register",
            data: $scope.collection
        }).then(function (response) {
            $window.location.reload();
        });
    };

    $scope.resetFormData = function () {
        $scope.date = new Date();
        $scope.product = "";
        $scope.reference = "";
        $scope.price = "";
        $scope.amount = "";
        $scope.cost = "";
        $scope.performerRows = [];
    }
});

app.service('sharedParam', function () {
    let id = -1;

    let setId = function (param) {
        id = param;
    };

    let getId = function () {
        return id;
    };

    return {
        setId : setId,
        getId : getId
    }
});