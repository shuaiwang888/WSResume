<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" class="crt crt-nav-on crt-nav-type1 crt-main-nav-on crt-sidebar-on crt-layers-2">
<head>
    <%@ include file="common/style.jsp" %>
    <title>${user.name}-教育经验</title>
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
                            <h2 class="title-lg text-upper padd-box">教育经验</h2>
                            <div class="education">
                                <c:forEach items="${educations}" var="education">
                                    <div class="education-box">
                                        <time class="education-date">
                                            <span>
                                                <strong class="text-upper">
<%--                                                    年月分开--%>
                                                    <fmt:formatDate value="${education.beginDay}" pattern="yyyy" />
                                                </strong><fmt:formatDate value="${education.beginDay}" pattern="/MM" /> -
                                                <strong>
                                                    <fmt:formatDate value="${education.endDay}" pattern="yyyy" />
                                                </strong><fmt:formatDate value="${education.endDay}" pattern="/MM" />
                                            </span>
                                        </time>
                                        <h3>${education.typeString}</h3>
                                        <span class="education-company">${education.name}</span>
                                        <p>${education.intro}</p>
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