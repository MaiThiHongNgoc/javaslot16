<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<header>
    <jsp:include page="include/header.jsp"></jsp:include>
</header>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>
<header>
    <jsp:include page="include/footer.jsp"/>
</header>
</body>

</html>