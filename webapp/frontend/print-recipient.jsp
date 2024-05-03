
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Recipient</title>
    </head>
    <body onload="window.print();">
        
        <div align="center">
            <jsp:directive.include file="../frontend/recipient.jsp" />
        </div>
    </body>
</html>
