package com.wang.app2;

import java.util.List;

/**
 * Created by wangdegang on 2016/9/3.
 */
public class User {
    private String username;
    private List<Authority> authorities;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public List<Authority> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(List<Authority> authorities) {
        this.authorities = authorities;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", authorities=" + authorities +
                '}';
    }

    public User(String username, List<Authority> authorities) {
        this.username = username;
        this.authorities = authorities;
    }

    public User() {
    }
}
