package com.wang.token;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class TokenProcessor {
    private long previous;
    private static TokenProcessor instance =
            new TokenProcessor();
    public static String FORM_TOKEN_KEY = "FORM_TOKEN_KEY";

    private TokenProcessor() {
    }

    public static TokenProcessor getInstance() {
        return instance;
    }

    /**
     * 比较session中取出的token和用户表单中
     * session值是否一致，是则返回true,否返回false
     *
     * @param req
     * @return boolean
     */
    public synchronized boolean isTokenVaild(HttpServletRequest req) {

        HttpSession session = req.getSession(false);
        if (session == null) return false;

        String saved = (String) session.getAttribute(FORM_TOKEN_KEY);
        if (saved == null) return false;

        String token = req.getParameter(FORM_TOKEN_KEY);
        if (token == null) return false;

        return saved.equals(token);
    }

    /**
     * 移除session中的token
     *
     * @param req
     */
    public synchronized void resetToken(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return;
        session.removeAttribute(FORM_TOKEN_KEY);
    }

    /**
     * 产生一个表单标识号放入session中
     *
     * @param req
     * @throws NoSuchAlgorithmException
     */
    public synchronized void saveToken(HttpServletRequest req) throws NoSuchAlgorithmException {
        HttpSession session = req.getSession();
        byte[] id = session.getId().getBytes();
        long current = System.currentTimeMillis();
        if (current == previous) current++;
        previous = current;
        byte[] now = String.valueOf(current).getBytes();
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(id);
        md.update(now);
        String token = toHex(md.digest());
        session.setAttribute(FORM_TOKEN_KEY, token);
    }

    /**
     * 将一个字节数组转换为十六进制的字符串
     *
     * @param buffer
     * @return
     */
    private String toHex(byte[] buffer) {
        StringBuffer sb = new StringBuffer(buffer.length * 2);
        for (byte b : buffer) {
            sb.append(Character.forDigit(b & 0xf0 >> 4, 16));
            sb.append(Character.forDigit(b & 0x0f, 16));
        }
        return sb.toString();
    }
}
