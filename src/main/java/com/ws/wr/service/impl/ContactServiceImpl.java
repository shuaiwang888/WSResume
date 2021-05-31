package com.ws.wr.service.impl;

import com.ws.wr.bean.Contact;
import com.ws.wr.bean.ContactListParam;
import com.ws.wr.bean.ContactListResult;
import com.ws.wr.dao.ContactDao;
import com.ws.wr.service.ContactService;


public class ContactServiceImpl extends BaseServiceImpl<Contact> implements ContactService {

    @Override
    public ContactListResult list(ContactListParam param) {
        return ((ContactDao) dao).list(param);
    }

    @Override
    public boolean read(Integer id) {
        return ((ContactDao) dao).read(id);
    }
}
