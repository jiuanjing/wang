package com.wang.servlet;

import java.io.File;

public class Dir {
    public static void main(String[] args) {
        File file = new File("d:\\web");
        showDir(file);
    }

    public static void showDir(File f) {
        File[] files = f.listFiles();
        assert files != null;
        for (File file : files) {
            if (file.isDirectory()) {
                showDir(file);
            } else
                System.out.println(file);

        }
    }
}
