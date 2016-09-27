/**
 * 根据kpi的值来获取该kpi的分类
 * @type {string[]}
 */
var _profit = ["盈利能力","投资回报率（ROI）", "水处理毛利率", "污水处理单价", "综合电价","ProfitKpi.json"];
var _service = ["业务增长","营业收入增长率", "人工成本利润率", "利润总额增长率","ServiceKpi.json"];
var _operate = ["经营效率","人均产值", "人均净利润","OperatingKpi.json"];
var _cash = ["现金获取","经营性现金流量净额", "水费回收率", "应收账款余额增减率","GetCashKpi.json"];
var _debt = ["债务风险","资产负债率", "已获利息倍数","DebtRiskKpi.json"];
var _cost = ["成本控制","管理费用成本比", "人均可控管理费用", "吨水经营成本", "吨水人工成本", "单位药剂费", "单位电耗", "吨水电费", "吨水维修费", "吨水管理费","CostControlKpi.json"];
var _people = ["人员素质","人员素质结构分布","PeoplewareKpi.json"];
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