<%@page import="com.google.gson.Gson" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    Gson gson = new Gson();
    Map<String, Object> mapAll = new HashMap<String, Object>();
    List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

    Map<String, Object> map = new HashMap<String, Object>();
    Map<String, Object> mapHead1 = new HashMap<String, Object>();
    Map<String, Object> mapHead2 = new HashMap<String, Object>();

    mapHead1.put("_parentId", "");
    mapHead1.put("ID", "1");
    mapHead1.put("factory_name", "北京首创");
    mapHead2.put("_parentId", "");
    mapHead2.put("ID", "2");
    mapHead2.put("factory_name", "南京首创");

    map.put("_parentId", "");

    list.add(mapHead1);
    list.add(mapHead2);
    list.add(map);

    mapAll.put("total", list.size());
    mapAll.put("rows", list);
    String str_return = gson.toJson(mapAll);
    out.print(str_return);
%>