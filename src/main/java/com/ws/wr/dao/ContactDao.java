package com.ws.wr.dao;

import com.ws.wr.bean.Contact;
import com.ws.wr.bean.ContactListParam;
import com.ws.wr.bean.ContactListResult;

public interface ContactDao extends BaseDao<Contact> {
    ContactListResult list(ContactListParam param);
    boolean read(Integer id);
}
