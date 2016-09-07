package com.wang.app2;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wangdegang on 2016/9/3.
 */
public class UserDao {

    private static Map<String, User> userMap;
    static {
        userMap = new HashMap<String, User>();

        List<Authority> authorities1 = new ArrayList<Authority>();
        authorities1.add(new Authority("article1","/app2/article1.jsp"));
        authorities1.add(new Authority("article2","/app2/article2.jsp"));
        User user1  = new User("aaa",authorities1);
        userMap.put("aaa",user1);

        List<Authority> authorities2 = new ArrayList<Authority>();
        authorities2.add(new Authority("article3","/app2/article3.jsp"));
        authorities2.add(new Authority("article4","/app2/article4.jsp"));
        User user2  = new User("bbb",authorities2);
        userMap.put("bbb",user2);
    }
    public User get(String username) {
        return null;
    }
    public void update(String username, List<Authority> authorities){

    }
}
