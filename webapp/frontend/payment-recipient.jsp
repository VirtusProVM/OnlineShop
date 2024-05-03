
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Recipient</title>
    </head>
    <body>
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div align="center">
            
            <h2>You have made payment successfully</h2>
            
            
            <jsp:directive.include file="../frontend/recipient.jsp" />
                                    
            <div>
                <br />
                <input type="submit" value="Print Recipient" onclick="javascript:showPrintRecipientPopup();" />
            </div>
        </div>
                                    
        <script type="text/javascript">
            
            function showPrintRecipientPopup() {
                var width = 600;
                var height = 250;
                var top = (screen.width - width) / 2;
                var left = (screen.width - width) / 2;
                
                window.open('frontend/print-recipient.jsp', '_blank', 'width=' + width + ' , height=' + height + ' , top=' + top + ' , left=' 
                        + left);
            }
        </script>
    </body>
</html>
