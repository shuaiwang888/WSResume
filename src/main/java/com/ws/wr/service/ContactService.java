package com.ws.wr.service;

import com.ws.wr.bean.Contact;
import com.ws.wr.bean.ContactListParam;
import com.ws.wr.bean.ContactListResult;

public interface ContactService extends BaseService<Contact> {
    ContactListResult list(ContactListParam param);
    boolean read(Integer id);
}
