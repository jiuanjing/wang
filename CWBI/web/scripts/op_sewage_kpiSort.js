/**
 * 根据kpi的值来获取该kpi的分类
 * @type {string[]}
 */
var _profit = ["盈利能力","2101", "2102", "150", "118","ProfitKpi.json"];
var _service = ["业务增长","2501", "2502", "2503","ServiceKpi.json"];
var _operate = ["经营效率","158", "2602","OperatingKpi.json"];
var _cash = ["现金获取","2301", "103", "2303","GetCashKpi.json"];
var _debt = ["债务风险","2201", "2202","DebtRiskKpi.json"];
var _cost = ["成本控制","2401", "2402", "2403", "2404", "126", "120", "2407", "149", "148","CostControlKpi.json"];
var _people = ["人员素质","2701","PeoplewareKpi.json"];
function _getKpiSort(kpi) {
    var a = [_people, _profit, _service, _operate, _cash, _debt, _cost];
    for (var i=0;i<a.length;i++) {
        if (a[i].indexOf(kpi)>-1){
            return a[i][0];
        }
    }
}
function _getKpiUrl(kpi) {
    var a = [_people, _profit, _service, _operate, _cash, _debt, _cost];
    for (var i=0;i<a.length;i++) {
        if (a[i].indexOf(kpi)>-1){
            var l = a[i].length-1;
            return a[i][l];
        }
    }
}