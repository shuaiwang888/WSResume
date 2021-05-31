package com.ws.wr.bean.base;

import java.util.Date;

public abstract class DateBean extends BaseBean{
    private Date beginDay; // 这里的日期是用的Date类型，可以方便取出年/月/日进行比较；如果不比，就可以用String类型，只用来展示
    private Date endDay;

    public Date getBeginDay() {
        return beginDay;
    }

    public void setBeginDay(Date beginDay) {
        this.beginDay = beginDay;
    }

    public Date getEndDay() {
        return endDay;
    }

    public void setEndDay(Date endDay) {
        this.endDay = endDay;
    }
}
