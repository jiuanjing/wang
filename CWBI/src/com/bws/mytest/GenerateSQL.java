package com.bws.mytest;

import com.bws.dbOperation.DBOperation;
import com.google.gson.Gson;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by wangdegang on 2016/8/30.
 */
public class GenerateSQL {
    public static void main(String[] args) {
        int A = 1160;
        double b = A * 0.1 * 0.7 + A * 0.1 * 0.7 * 0.063 + A + A * 0.063;
        System.out.println(b);
    }
}