package com.ws.wr.util;

public class Strings {

    /**
     * 字符转换
     * @param str 可能传过来的是小驼峰（myAge），大驼峰（MyAge）
     * @return my_age
     */
    public static String underLineCase(String str) {
        if (str == null) return null;
        int len = str.length();
        if (len == 0) return str;

        StringBuilder sb = new StringBuilder();
        sb.append(Character.toLowerCase(str.charAt(0))); // 把一个字符传过来变成小写
        for (int i = 1; i < len; i++) {
            char c = str.charAt(i);

            if (Character.isUpperCase(c)) {
                sb.append("_");
                sb.append(Character.toLowerCase(c));
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}
