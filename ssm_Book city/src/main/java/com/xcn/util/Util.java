package com.xcn.util;


import org.apache.commons.lang.StringUtils;

public class Util {

    public static String getSqlInStrByStrArray(String str) {
        StringBuffer temp = new StringBuffer();
        if(StringUtils.isEmpty(str)){
            System.out.println("1");
            return "('')";
        }
        //temp.append("(");
        if(StringUtils.isNotEmpty(str)){
            String[] strArray=str.split(",");
            if (strArray != null && strArray.length > 0 ) {
                for (int i = 0; i < strArray.length; i++) {
                    temp.append("'");
                    temp.append(strArray[i]);
                    temp.append("'");
                    if (i !=  (strArray.length-1) ) {
                        temp.append(",");
                    }
                }
            }
        }
        //temp.append(")");
        return temp.toString();
    }
}
