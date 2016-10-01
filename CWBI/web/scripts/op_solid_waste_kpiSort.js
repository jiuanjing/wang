/**
 * 根据kpi的值来获取该kpi的分类
 * @type {string[]}
 * @author wang
 */
var _profit = ["盈利能力","4101", "4102", "4103", "4104","ProfitKpi.json"];
var _service = ["业务增长","4501", "4502", "4503","ServiceKpi.json"];
var _operate = ["经营效率","4601", "4602","OperatingKpi.json"];
var _cash = ["现金获取","4301", "4302", "4303","GetCashKpi.json"];
var _debt = ["债务风险","4201", "4202","DebtRiskKpi.json"];
var _cost = ["成本控制","4401", "4402", "4403", "4404", "4405", "4406", "4407", "4408", "4409","CostControlKpi.json"];
var _people = ["人员素质","4701","PeoplewareKpi.json"];
function _getKpiSort(kpi) {
    var a = [_people, _profit, _service, _operate, _cash, _debt, _cost];
    for (var i=0;i<a.length;i++) {
        if (a[i].indexOf(kpi)>-1){
            return a[i][0];
        }
    }
}
/**
 * 根据kpi获取相对应的json
 * @param kpi
 * @returns {*}
 * @private
 * @author wang
 */
function _getKpiUrl(kpi) {
    var a = [_people, _profit, _service, _operate, _cash, _debt, _cost];
    for (var i=0;i<a.length;i++) {
        if (a[i].indexOf(kpi)>-1){
            var l = a[i].length-1;
            return a[i][l];
        }
    }
}