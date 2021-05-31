package com.ws.wr.dao.impl;

import com.ws.wr.bean.Contact;
import com.ws.wr.bean.ContactListParam;
import com.ws.wr.bean.ContactListResult;
import com.ws.wr.dao.ContactDao;
import org.springframework.jdbc.core.BeanPropertyRowMapper;

import java.util.ArrayList;
import java.util.List;

public class ContactDaoImpl extends BaseDaoImpl<Contact> implements ContactDao {

    @Override
    public boolean save(Contact bean) {
        Integer id = bean.getId();
        List<Object> args = new ArrayList<>();
        args.add(bean.getName());
        args.add(bean.getEmail());
        args.add(bean.getComment());
        args.add(bean.getSubject());
        args.add(bean.getAlreadyRead());

        String sql;
        if (id == null || id < 1) { // 添加
            sql = "INSERT INTO contact(name, email, comment, subject, already_read) VALUES(?, ?, ?, ?, ?)";
        } else {
            sql = "UPDATE contact SET name = ?, email = ?, comment = ?, subject = ?, already_read = ? WHERE id = ?";
            args.add(id);
        }
        return tpl.update(sql, args.toArray()) > 0;
    }

    @Override
    public Contact get(Integer id) {
        String sql = "SELECT id, created_time, name, email, comment, subject, already_read FROM contact WHERE id = ?";
        return tpl.queryForObject(sql, new BeanPropertyRowMapper<>(Contact.class), id);
    }

    @Override
    public List<Contact> list() {
        String sql = "SELECT id, created_time, name, email, comment, subject, already_read FROM contact";
        return tpl.query(sql, new BeanPropertyRowMapper<>(Contact.class));
    }

    // 多条件查询页面
    @Override
    public ContactListResult list(ContactListParam param) {
        ContactListResult result = new ContactListResult();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, created_time, name, email, comment, subject, already_read FROM contact WHERE 1 = 1 ");

        // 参数
        List<Object> args = new ArrayList<>();

        // 条件(只有满足下面的各个条件才会附加响应的sql语句，动态生成一个sql语句进行查询，
        // 因为多条件查询时6个参数存在没有设置(为空)的，即为空时不能发过去
        StringBuilder condition = new StringBuilder();

        if (param.getBeginDay() != null) { // 开始时间
            condition.append("AND created_time >= ? ");
            args.add(param.getBeginDay());
            result.setBeginDay(param.getBeginDay());
        }

        if (param.getEndDay() != null) { // 结束时间
            condition.append("AND created_time <= ? ");
            args.add(param.getEndDay());
            result.setEndDay(param.getEndDay());
        }

        String keyword = param.getKeyword();
        if (keyword != null && keyword.length() > 0) { // 关键字
            result.setKeyword(keyword);
            condition.append("AND (name LIKE ? OR email LIKE ? OR subject LIKE ? OR comment LIKE ?) ");
            keyword = "%" + keyword + "%";
            args.add(keyword);
            args.add(keyword);
            args.add(keyword);
            args.add(keyword);
        }

        Integer read = param.getAlreadyRead();
        if (read != null && read < ContactListParam.READ_ALL) { // 阅读状态
            condition.append("AND already_read = ? ");
            args.add(read);
            result.setAlreadyRead(read);
        }

        // 总数量、总页数
        Integer pageSize = param.getPageSize();
        if (pageSize == null || pageSize < 10) {
            pageSize = 10;
        }

        /*
        总数量：101
        每一页显示20条
        总页数 = (总数量 + 每页的数量 - 1) / 每页的数量
         */
        String countSql = "SELECT COUNT(*) FROM contact WHERE 1 = 1 " + condition;
        Integer totalCount = tpl.queryForObject(countSql, Integer.class, args.toArray());
        if (totalCount == 0) return result;

        int totalPages = (totalCount + pageSize - 1) / pageSize;
        result.setTotalPages(totalPages);
        result.setTotalCount(totalCount);

        // 分页显示操作
        sql.append(condition);
        // LIMIT:从第一个?显示到第二个?
        sql.append("LIMIT ?, ?");
        Integer pageNo = param.getPageNo();
        if (pageNo == null || pageNo < 1) {
            pageNo = 1;
        } else if (pageNo > totalPages) { // 页码如果已经超过了总页数，就跳转到最后一页
            pageNo = totalPages;
        }
        args.add((pageNo - 1) * pageSize);
        args.add(pageSize);
        result.setPageNo(pageNo);
        result.setPageSize(pageSize);

        List<Contact> contacts = tpl.query(sql.toString(), new BeanPropertyRowMapper<>(Contact.class), args.toArray());
        result.setContacts(contacts);

        return result;
    }

    @Override
    // 查看后标为已读
    public boolean read(Integer id) {
        String sql = "UPDATE contact SET already_read = 1 WHERE id = ?";
        return tpl.update(sql, id) > 0;
    }
}
