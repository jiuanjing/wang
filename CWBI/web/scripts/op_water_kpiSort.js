/**
 * 根据kpi的值来获取该kpi的分类
 * @type {string[]}
 */
var _profit = ["盈利能力","1101", "1102", "1103", "1104", "63", "36","Profit.json"];
var _service = ["业务增长","1501", "1502", "1503","1504","Business.json"];
var _operate = ["经营效率","1601", "68", "1603", "1604", "1605","Effeient.json"];
var _cash = ["现金获取","1301", "3", "1303","Cash.json"];
var _debt = ["债务风险","1201", "1202","Debt.json"];
var _cost = ["成本控制","34","1402", "1403", "1404", "1405", "44", "38", "1408", "62", "1410","31","Cost.json"];
var _people = ["人员素质","1701","Person.json"];
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