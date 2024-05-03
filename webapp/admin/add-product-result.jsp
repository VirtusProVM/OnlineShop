
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Product To Order</title>
    </head>
    <body>
        
        <div align="center">
            
            <h2>The product ${product.title} has been added to order ID: ${order.orderID}</h2>
            <input type="button" value="close" onclick="javascript:self.close();" />
            
        </div>
            
            <script type="text/javascript">
                window,onunload = function() {
                    window.opener.location.reload();
                }
            </script>
    </body>
</html>
