var kpiTotal=['总体能力','盈利能力','债务风险','现金获取','成本控制','业务增长','经营效率','人员素质'];
var kpiCost=['管理费用成本比','人均可控管理费用','吨水经营成本','吨水人工成本','单位药剂费','单位电耗'];
var kpiDebt=['资产负债率','已获利息倍数'];
var kpiCash=['经营性现金流量净额','水费回收率','应收账款余额增减率'];
var kpiOpe=['人均产值','人均净利润'];
var kpiPeo=['人员素质结构分布'];
var kpiPro=['投资回报率（ROI）','水处理毛利率','污水处理单价','综合电价'];
function chooseKpi(kpi) {
    if (kpiTotal.indexOf(kpi)){
        return 'ConclusionKpi.json';
    }
}