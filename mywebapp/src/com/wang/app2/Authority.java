package com.wang.app2;

/**
 * Created by wangdegang on 2016/9/3.
 */
public class Authority {
    private String displayName;
    private String url;

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Authority() {
    }

    public Authority(String displayName, String url) {
        this.displayName = displayName;
        this.url = url;
    }

    @Override
    public String toString() {
        return "Authority{" +
                "displayName='" + displayName + '\'' +
                ", url='" + url + '\'' +
                '}';
    }
}
