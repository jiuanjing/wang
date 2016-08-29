/**
 * 作者：cjl
 * 时间：2015年10月23日
 * 用于财务主题,月度分析（快报版）
 */
/*表1*/
/* 营业收入 */
function operatingRevenue() {
    $.ajax({
        url: "FinancialAnalysis_qr/IncomeGetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $(".operating_revenue_ty").html(arrayData.cy[0].value);
            $(".operating_revenue_ly").html(arrayData.ly[0].value);
            $(".operating_revenue_tl").html((arrayData.cy[0].value - arrayData.ly[0].value).toFixed(2));
            if (arrayData.ly[0].value != 0 && arrayData.ly[0].value != "" && arrayData.ly[0].value != null) {
                var rate = (arrayData.cy[0].value - arrayData.ly[0].value) / arrayData.ly[0].value * 100;
                rate = rate.toFixed(2);
                $(".operating_revenue_tlr").html(rate + "%");
            } else {
                $(".operating_revenue_tlr").html("-");
            }

        }
    });
}
/* 利润总额*/
function totalProfit() {
    $.ajax({
        url: "FinancialAnalysis_qr/ProfitGetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $(".total_profit_ty").html(arrayData.cy[0].value);
            $(".total_profit_ly").html(arrayData.ly[0].value);
            $(".total_profit_tl").html((arrayData.cy[0].value - arrayData.ly[0].value).toFixed(2));
            if (arrayData.ly[0].value != 0 && arrayData.ly[0].value != "" && arrayData.ly[0].value != null) {
                var rate = (arrayData.cy[0].value - arrayData.ly[0].value) / arrayData.ly[0].value * 100;
                rate = rate.toFixed(2);
                $(".total_profit_tlr").html(rate + "%");
            } else {
                $(".total_profit_tlr").html("-");
            }

        }
    });
}
/* 归属母公司净利润*/
function profitParent() {
    $.ajax({
        url: "FinancialAnalysis_qr/ProfitParentGetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $(".profit_parent_ty").html(arrayData.cy[0].value);
            $(".profit_parent_ly").html(arrayData.ly[0].value);
            $(".profit_parent_tl").html((arrayData.cy[0].value - arrayData.ly[0].value).toFixed(2));
            if (arrayData.ly[0].value != 0 && arrayData.ly[0].value != "" && arrayData.ly[0].value != null) {
                var rate = (arrayData.cy[0].value - arrayData.ly[0].value) / arrayData.ly[0].value * 100;
                rate = rate.toFixed(2);
                $(".profit_parent_tlr").html(rate + "%");
            } else {
                $(".profit_parent_tlr").html("-");
            }

        }
    });
}
/* 资产总额*/
function totalAsset() {
    $.ajax({
        url: "FinancialAnalysis_qr/TotalAssetGetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $(".total_asset_ty").html(arrayData.cy[0].value);
            $(".total_asset_ly").html(arrayData.ly[0].value);
            $(".total_asset_tl").html((arrayData.cy[0].value - arrayData.ly[0].value).toFixed(2));
            if (arrayData.ly[0].value != 0 && arrayData.ly[0].value != "" && arrayData.ly[0].value != null) {
                var rate = (arrayData.cy[0].value - arrayData.ly[0].value) / arrayData.ly[0].value * 100;
                rate = rate.toFixed(2);
                $(".total_asset_tlr").html(rate + "%");
            } else {
                $(".total_asset_tlr").html("-");
            }

        }
    });
}
/* 负债总额*/
function totalDebt() {
    $.ajax({
        url: "FinancialAnalysis_qr/TotalDebtGetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $(".total_debt_ty").html(arrayData.cy[0].value);
            $(".total_debt_ly").html(arrayData.ly[0].value);
            $(".total_debt_tl").html((arrayData.cy[0].value - arrayData.ly[0].value).toFixed(2));
            if (arrayData.ly[0].value != 0 && arrayData.ly[0].value != "" && arrayData.ly[0].value != null) {
                var rate = (arrayData.cy[0].value - arrayData.ly[0].value) / arrayData.ly[0].value * 100;
                rate = rate.toFixed(2);
                $(".total_debt_tlr").html(rate + "%");
            } else {
                $(".total_debt_tlr").html("-");
            }

        }
    });
}
/* 资产负债率*/
function assetLiabilityRatio() {
    $.ajax({
        url: "FinancialAnalysis_qr/AssetLiabilityRatioGetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $(".asset_liability_ratio_ty").html(arrayData.cy[0].value);
            $(".asset_liability_ratio_ly").html(arrayData.ly[0].value);
            $(".asset_liability_ratio_tl").html((arrayData.cy[0].value - arrayData.ly[0].value).toFixed(2));
            if (arrayData.ly[0].value != 0 && arrayData.ly[0].value != "" && arrayData.ly[0].value != null) {
                var rate = (arrayData.cy[0].value - arrayData.ly[0].value) / arrayData.ly[0].value * 100;
                rate = rate.toFixed(2);
                $(".asset_liability_ratio_tlr").html(rate + "%");
            } else {
                $(".asset_liability_ratio_tlr").html("-");
            }

        }
    });
}
/* 归属母公司净资产*/
function assetParent() {
    $.ajax({
        url: "FinancialAnalysis_qr/AssetParentGetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue'),
            DataSource: "QR"
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $(".asset_parent_ty").html(arrayData.cy[0].value);
            $(".asset_parent_ly").html(arrayData.ly[0].value);
            $(".asset_parent_tl").html((arrayData.cy[0].value - arrayData.ly[0].value).toFixed(2));
            if (arrayData.ly[0].value != 0 && arrayData.ly[0].value != "" && arrayData.ly[0].value != null) {
                var rate = (arrayData.cy[0].value - arrayData.ly[0].value) / arrayData.ly[0].value * 100;
                rate = rate.toFixed(2);
                $(".asset_parent_tlr").html(rate + "%");
            } else {
                $(".asset_parent_tlr").html("-");
            }
        }
    });
}
/* 归属母公司净资产收益率*/
function ROEParent() {
    $.ajax({
        url: "FinancialAnalysis_qr/ROEParentGetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $(".roe_parent_ty").html(arrayData.cy[0].value);
            $(".roe_parent_ly").html(arrayData.ly[0].value);
            $(".roe_parent_tl").html((arrayData.cy[0].value - arrayData.ly[0].value).toFixed(2));
            if (arrayData.ly[0].value != 0 && arrayData.ly[0].value != "" && arrayData.ly[0].value != null) {
                var rate = (arrayData.cy[0].value - arrayData.ly[0].value) / arrayData.ly[0].value * 100;
                rate = rate.toFixed(2);
                $(".roe_parent_tlr").html(rate + "%");
            } else {
                $(".roe_parent_tlr").html("-");
            }
        }
    });
}
/*表2*/
/*营业收入指标完成率*/
function IncomeTarget() {
    $.ajax({
        url: "FinancialAnalysis_qr/IncomeTargetGetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $(".revenue_tar").html(arrayData.cy[0].value);
            $(".revenue_self").html(arrayData.cy[1].value);
            $(".revenue_group").html(arrayData.cy[2].value);
            $(".revenue_self_rate").html((arrayData.cy[3].value).toFixed(2));
            $(".revenue_group_rate").html((arrayData.cy[4].value).toFixed(2));
        }
    });
}
/*利润总额指标完成率*/
function ProfitTarget() {
    $.ajax({
        url: "FinancialAnalysis_qr/ProfitTargetGetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $(".profit_tar").html(arrayData.cy[0].value);
            $(".profit_self").html(arrayData.cy[1].value);
            $(".profit_group").html(arrayData.cy[2].value);
            $(".profit_self_rate").html((arrayData.cy[3].value).toFixed(2));
            $(".profit_group_rate").html((arrayData.cy[4].value).toFixed(2));
        }
    });
}

/*归属母公司净利润指标完成率*/
function ProfitParentTarget() {
    $.ajax({
        url: "FinancialAnalysis_qr/ProfitParentTargetGetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $(".profit_parent_tar").html(arrayData.cy[0].value);
            $(".profit_parent_self").html(arrayData.cy[1].value);
            $(".profit_parent_group").html(arrayData.cy[2].value);
            $(".profit_parent_self_rate").html((arrayData.cy[3].value).toFixed(2));
            $(".profit_parent_group_rate").html((arrayData.cy[4].value).toFixed(2));
        }
    });
}

/*表3*/
function Table03() {
    $.ajax({
        url: "FinancialAnalysis_qr/Table03GetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $("#table03").empty();
            if (arrayData.length > 0) {
                var a = 0;
                var b = 0;
                var c = 0;
                var d = 0;
                var e = 0;
                var f = 0;
                var g = 0;
                var h = 0;
                for (var i = 0; i < arrayData.length; i++) {
                    a = a + arrayData[i].operating_revenue;
                    b = b + arrayData[i].operating_revenue_ly;
                    c = c + arrayData[i].operating_revenue_differ;
                    d = d + arrayData[i].operating_revenue_rate;
                    e = e + arrayData[i].profit_parent;
                    f = f + arrayData[i].profit_parent_ly;
                    g = g + arrayData[i].profit_parent_differ;
                    h = h + arrayData[i].profit_parent_rate;
                    $("#table03").append("<tr>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].bu_name + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].operating_revenue + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].operating_revenue_ly + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].operating_revenue_differ.toFixed(2) + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].operating_revenue_rate.toFixed(2) + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent_ly + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent_differ.toFixed(2) + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent_rate.toFixed(2) + "</td>" +
                        "</tr>");
                }
                $("#table03").append("<tr style=\"border-bottom: 2px solid;\">" +
                    "<td style=\"text-align: center;font-weight: bold;\">合计</td>" +
                    "<td style=\"text-align: center;\">" + a.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + b.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + c.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + d.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + e.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + f.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + g.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + h.toFixed(2) + "</td>" +
                    "</tr>");
            }
        }
    });
}
/*表4*/
function Table04() {
    $.ajax({
        url: "FinancialAnalysis_qr/Table04GetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $("#table04").empty();
            if (arrayData.length > 0) {
                var a = 0;
                var b = 0;
                var c = 0;
                var d = 0;
                var e = 0;
                var f = 0;
                var g = 0;
                var h = 0;
                for (var i = 0; i < arrayData.length; i++) {
                    a = a + arrayData[i].operating_revenue;
                    b = b + arrayData[i].operating_revenue_ly;
                    c = c + arrayData[i].operating_revenue_differ;
                    d = d + arrayData[i].operating_revenue_rate;
                    e = e + arrayData[i].profit_parent;
                    f = f + arrayData[i].profit_parent_ly;
                    g = g + arrayData[i].profit_parent_differ;
                    h = h + arrayData[i].profit_parent_rate;
                    $("#table04").append("<tr>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].bu_name + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].operating_revenue + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].operating_revenue_ly + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].operating_revenue_differ.toFixed(2) + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].operating_revenue_rate.toFixed(2) + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent_ly + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent_differ.toFixed(2) + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent_rate.toFixed(2) + "</td>" +
                        "</tr>");
                }
                $("#table04").append("<tr style=\"border-bottom: 2px solid;\">" +
                    "<td style=\"text-align: center;font-weight: bold;\">环保业务合计</td>" +
                    "<td style=\"text-align: center;\">" + a.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + b.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + c.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + d.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + e.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + f.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + g.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + h.toFixed(2) + "</td>" +
                    "</tr>");
            }
        }
    });
}

/*表5*/
function Table05() {
    $.ajax({
        url: "FinancialAnalysis_qr/Table05GetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            $("#table05").empty();
            if (arrayData.length > 0) {
                var a = 0;
                var b = 0;
                var c = 0;
                var d = 0;
                var e = 0;
                var f = 0;
                for (var i = 0; i < arrayData.length; i++) {
                    a = a + arrayData[i].profit_parent;
                    b = b + arrayData[i].profit_parent_ly;
                    c = c + arrayData[i].profit_parent_differ;
                    d = d + arrayData[i].profit_parent_rate;
                    e = e + arrayData[i].profit_parent_budget_self;
                    f = f + arrayData[i].finished_rate;

                    $("#table05").append("<tr>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].dept_name + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent_ly + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent_differ.toFixed(2) + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent_rate.toFixed(2) + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].profit_parent_budget_self.toFixed(2) + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData[i].finished_rate.toFixed(2) + "</td>" +
                        "</tr>");
                }
                $("#table05").append("<tr style=\"border-bottom: 2px solid;\">" +
                    "<td style=\"text-align: center;font-weight: bold;\">公司整体合计</td>" +
                    "<td style=\"text-align: center;\">" + a.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + b.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + c.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + d.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + e.toFixed(2) + "</td>" +
                    "<td style=\"text-align: center;\">" + f.toFixed(2) + "</td>" +
                    "</tr>");
            }
        }
    });
}

/*排名*/
/*归属于项目公司净资产收益率、归属于首创净利润*/
function RiskTip01() {
    $.ajax({
        url: "FinancialAnalysis_qr/RiskTip01GetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            console.log(arrayData.rows[0].CompanyName);
            $("#risk_tip_01").empty();
            if (arrayData.rows.length > 0) {
                for (var i = 0; i < arrayData.rows.length; i++) {
                    $("#risk_tip_01").append("<tr>" +
                        "<td style=\"text-align: center;\">" + (i + 1) + "</td>" +
                        "<td>" + arrayData.rows[i].CompanyName + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData.rows[i].roe + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData.rows[i].profit_cw + "</td>" +
                        "</tr>");
                }
            }
        }
    });
}
/*归属于项目公司净资产收益率、归属于首创净利润*/
function RiskTip02() {
    $.ajax({
        url: "FinancialAnalysis_qr/RiskTip02GetData.jsp",
        dataType: "text",
        type: "post",
        data: {
            date: $('#date').datebox('getValue')
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval('(' + return_data + ')');
            console.log(arrayData.rows[0].CompanyName);
            $("#risk_tip_02").empty();
            if (arrayData.rows.length > 0) {
                for (var i = 0; i < arrayData.rows.length; i++) {
                    $("#risk_tip_02").append("<tr>" +
                        "<td style=\"text-align: center;\">" + (i + 1) + "</td>" +
                        "<td>" + arrayData.rows[i].CompanyName + "</td>" +
                        "<td style=\"text-align: center;\">" + arrayData.rows[i].cost_profit_ratio + "</td>" +
                        "</tr>");
                }
            }
        }
    });
}
	