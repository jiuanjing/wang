<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<String> idList = Arrays.asList("2100", "2200", "2300", "2400", "2500", "2600", "2700");
    List<String> valueList = Arrays.asList("盈利能力", "债务风险", "现金获取", "成本控制", "业务增长", "经营效率", "人员素质");
    List<Map<String,String>> list = new ArrayList<Map<String,String>>();
    for (int i=0;i<7;i++){
        Map<String,String> map = new HashMap<String,String>();
        map.put("id",idList.get(i));
        map.put("text",valueList.get(i));
        list.add(map);
    }
    Gson gson =  new Gson();
    String s = gson.toJson(list);
    out.write(s);
%>