package com.ws.wr.dao.impl;

import com.ws.wr.bean.Company;
import com.ws.wr.bean.Project;
import com.ws.wr.dao.ProjectDao;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProjectDaoImpl extends BaseDaoImpl<Project> implements ProjectDao {
    private static String listSql;
    private static String getSql;
    private static RowMapper<Project> rowMapper;
    static {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT ");
        sql.append("t1.id, t1.created_time, t1.name, t1.intro, t1.website, t1.image, t1.begin_day, t1.end_day, ");
        sql.append("t2.id, t2.created_time, t2.name, t2.logo, t2.website, t2.intro ");
        sql.append("FROM project t1 JOIN company t2 ON t1.company_id = t2.id");
        listSql = sql.toString();
        getSql = listSql + " WHERE t1.id = ?";

        rowMapper = new RowMapper<Project>() {
            @Override
            public Project mapRow(ResultSet resultSet, int i) throws SQLException {
                // 表1
                Project project = new Project();
                project.setId(resultSet.getInt("t1.id"));
                project.setCreatedTime(resultSet.getDate("t1.created_time"));
                project.setName(resultSet.getString("t1.name"));
                project.setIntro(resultSet.getString("t1.intro"));
                project.setWebsite(resultSet.getString("t1.website"));
                project.setImage(resultSet.getString("t1.image"));
                project.setBeginDay(resultSet.getDate("t1.begin_day"));
                project.setEndDay(resultSet.getDate("t1.end_day"));

                // 表2
                Company company = new Company();
                project.setCompany(company);

                company.setId(resultSet.getInt("t2.id"));
                company.setCreatedTime(resultSet.getDate("t2.created_time"));
                company.setIntro(resultSet.getString("t2.intro"));
                company.setLogo(resultSet.getString("t2.logo"));
                company.setWebsite(resultSet.getString("t2.website"));
                company.setName(resultSet.getString("t2.name"));

                return project;
            }
        };
    }

    @Override
    public boolean save(Project bean) {
        Integer id = bean.getId();
        List<Object> args = new ArrayList<>();
        args.add(bean.getName());
        args.add(bean.getIntro());
        args.add(bean.getWebsite());
        args.add(bean.getImage());
        args.add(bean.getBeginDay());
        args.add(bean.getEndDay());
        args.add(bean.getCompany().getId()); // 重要
        String sql;
        if (id == null || id < 1) { // 添加
            sql = "INSERT INTO project(name, intro, website, image, begin_day, end_day, company_id) VALUES(?, ?, ?, ?, ?, ?, ?)";
        } else {
            sql = "UPDATE project SET name = ?, intro = ?, website = ?, image = ?, begin_day = ?, end_day = ?, company_id = ? WHERE id = ?";
            args.add(id);
        }
        return tpl.update(sql, args.toArray()) > 0;
    }

    @Override
    public Project get(Integer id) {
        return tpl.queryForObject(getSql, rowMapper, id);
    }

    @Override
    public List<Project> list() {
        return tpl.query(listSql, rowMapper);
    }
}
