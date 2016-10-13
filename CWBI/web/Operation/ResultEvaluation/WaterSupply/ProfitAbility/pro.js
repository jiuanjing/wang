/**
 * Created by wang on 2016/10/5.
 */
var _config = {
    url: 'ProfitAbilityDiv2.jsp',
    title: '盈利能力整体分析表',
    method: 'post',
    singleSelect: true,
    nowrap: true,
    fitColumns: true,
    sortOrder: 'desc',
    remoteSort: false,
    rowNumbers: false,
    striped: true,
    loadMsg: '正在加载数据，请稍等......',
    queryParams: {
        date: $('#date').datebox('getValue')
    },
    onClickRow: function (rowIndex, rowData) {
        $("#company").val(rowData.m2);
    },
    columns: [[
        {
            field: 'm1',
            title: '排名',
            align: 'center'

        },
        {
            field: 'm2',
            title: '公司简称',
            align: 'left',
            formatter: function (value, rowData, rowIndex) {
                return "<a href='javascript:showDiv001()'>" + value + "</a>";
            }
        },
        {
            field: 'm3',
            title: '盈利能力整体分值(分)',
            sortable: true,
            sorter: function (a, b) {
                return (a * 10 > b * 10 ? 1 : -1);
            },
            align: 'right',
            formatter: function (value, rowData, rowIndex) {
                return "<a href='ProfitTotalTrend.html?company=" + rowData.m2 + "'>" + value + "</a>";
            }
        },
        {
            field: 'm4',
            title: '投资回报率(%)',
            sortable: true,
            sorter: function (a, b) {
                return (a * 10 > b * 10 ? 1 : -1);
            },
            align: 'right',
            formatter: function (value, rowData, rowIndex) {
                return "<a href='../SingleIndex.html?company=" + rowData.m2 + "&kpi = 1101'>" + value + "</a>";
            }
        },
        {
            field: 'm5',
            title: '综合毛利率(%)',
            sortable: true,
            sorter: function (a, b) {
                return (a * 10 > b * 10 ? 1 : -1);
            },
            align: 'right',
            formatter: function (value, rowData, rowIndex) {
                return "<a href='../SingleIndex.html?company=" + rowData.m2 + "&kpi = 1102'>" + value + "</a>";
            }
        },
        {
            field: 'm6',
            title: '工程毛利率(%)',
            sortable: true,
            sorter: function (a, b) {
                return (a * 10 > b * 10 ? 1 : -1);
            },
            align: 'right',
            formatter: function (value, rowData, rowIndex) {
                return "<a href='../SingleIndex.html?company=" + rowData.m2 + "&kpi = 1103'>" + value + "</a>";
            }
        },
        {
            field: 'm7',
            title: '水处理毛利率(%)',
            sortable: true,
            sorter: function (a, b) {
                return (a * 10 > b * 10 ? 1 : -1);
            },
            align: 'right',
            formatter: function (value, rowData, rowIndex) {
                return "<a href='../SingleIndex.html?company=" + rowData.m2 + "&kpi = 1104'>" + value + "</a>";
            }
        },
        {
            field: 'm8',
            title: '综合水价(元)',
            sortable: true,
            sorter: function (a, b) {
                return (a * 10 > b * 10 ? 1 : -1);
            },
            align: 'right',
            formatter: function (value, rowData, rowIndex) {
                return "<a href='../SingleIndex.html?company=" + rowData.m2 + "&kpi = 63'>" + value + "</a>";
            }
        },
        {
            field: 'm9',
            title: '综合电价(元)',
            sortable: true,
            sorter: function (a, b) {
                return (a * 10 > b * 10 ? 1 : -1);
            },
            align: 'right',
            formatter: function (value, rowData, rowIndex) {
                return "<a href='../SingleIndex.html?company=" + rowData.m2 + "&kpi = 36'>" + value + "</a>";
            }
        }
    ]]
};