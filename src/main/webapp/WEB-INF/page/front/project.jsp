<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" class="crt crt-nav-on crt-nav-type1 crt-main-nav-on crt-sidebar-on crt-layers-2">
<head>
    <%@ include file="common/style.jsp" %>
    <title>${user.name}-项目经验</title>
</head>
<body class="">
    <div class="crt-wrapper">
        <%@ include file="common/smallNav.jsp" %>

        <div id="crt-container" class="crt-container">
            <%@ include file="common/bigNav.jsp" %>
            <div class="crt-container-sm">
                <div class="crt-paper-layers">
                    <div class="crt-paper clear-mrg">
                        <div class="crt-paper-cont paper-padd clear-mrg">
                            <h2 class="title-lg text-upper padd-box">项目经验</h2>
                            <div class="education">
                                <c:forEach items="${projects}" var="project">
                                    <div class="education-box">
                                        <time class="education-date">
                                            <span>
                                                <strong class="text-upper">
                                                    <fmt:formatDate value="${project.beginDay}" pattern="yyyy" />
                                                </strong><fmt:formatDate value="${project.beginDay}" pattern="/MM" /> -
                                                <strong>
                                                    <fmt:formatDate value="${project.endDay}" pattern="yyyy" />
                                                </strong><fmt:formatDate value="${project.endDay}" pattern="/MM" />
                                            </span>
                                        </time>
                                        <c:choose>
                                            <c:when test="${empty project.website}">
                                                <h3>${project.name}</h3>
                                            </c:when>
                                            <c:otherwise>
                                                <h3><a href="${project.website}" target="_blank">${project.name}</a></h3>
                                            </c:otherwise>
                                        </c:choose>

                                        <c:if test="${not empty project.company.logo}">
                                            <div class="education-logo">
                                                <img src="${ctx}/${project.company.logo}" alt="">
                                            </div>
                                        </c:if>
                                        <c:choose>
                                            <c:when test="${empty project.company.website}">
                                                <span class="education-company">${project.company.name}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="education-company">
                                                    <a href="${project.company.website}" target="_blank">${project.company.name}</a>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                        <p>${project.intro}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <!-- .crt-paper -->
                </div><!-- .crt-paper-layers -->
            </div><!-- .crt-container-sm -->
        </div>

        <%@ include file="common/foot.jsp" %>
    </div><!-- .crt-wrapper --><!-- Scripts -->
    <%@ include file="common/script.jsp" %>
</body>
</html>