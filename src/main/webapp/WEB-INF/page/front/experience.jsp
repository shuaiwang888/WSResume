<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" class="crt crt-nav-on crt-nav-type1 crt-main-nav-on crt-sidebar-on crt-layers-2">
<head>
    <%@ include file="common/style.jsp" %>
    <title>${user.name}-工作经验</title>
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
                            <h2 class="title-lg text-upper padd-box">工作经验</h2>
                            <div class="education">
                                <c:forEach items="${experiences}" var="experience">
                                    <div class="education-box">
                                        <time class="education-date">
                                            <span>
                                                <strong class="text-upper">
                                                    <fmt:formatDate value="${experience.beginDay}" pattern="yyyy" />
                                                </strong><fmt:formatDate value="${experience.beginDay}" pattern="/MM" /> -
                                                <strong>
                                                    <fmt:formatDate value="${experience.endDay}" pattern="yyyy" />
                                                </strong><fmt:formatDate value="${experience.endDay}" pattern="/MM" />
                                            </span>
                                        </time>
                                        <h3>${experience.job}</h3>
                                        <c:if test="${not empty experience.company.logo}">
                                            <div class="education-logo">
                                                <img src="${ctx}/${experience.company.logo}" alt="">
                                            </div>
                                        </c:if>
                                        <c:choose>
                                            <c:when test="${empty experience.company.website}">
                                                <span class="education-company">${experience.company.name}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="education-company">
                                                    <a href="${experience.company.website}" target="_blank">${experience.company.name}</a>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                        <p>${experience.intro}</p>
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