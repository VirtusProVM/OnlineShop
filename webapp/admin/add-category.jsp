
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category Form</title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
        
    </head>
    <body>
        
        <div class="w3-center">
            <h1 class="w3-green">
                <c:if test="${category != null}">
                    Edit Category
                </c:if>

                <c:if test="${category == null}">
                    Create New Category
                </c:if>
            </h1>
            
        </div>
                    
        <div class="w3-container w3-centered">
            
            <c:if test="${category != null}">
                <form action="updateCategory" method="POST" id="categoryForm">
                <input type = "hidden" name = "categoryID" value ="${category.categoryID}" />
            </c:if>
            
            <c:if test="${category == null}">
                <form action="createCategory" method="POST" id="categoryForm">
            </c:if>
                
            <table class="w3-table">
                <tr>
                    <td align="right">Category:</td>
                    <td align="left"><input type="text" id="category" name="name"
                        size="20" value="${category.name}" class="w3-input w3-hover-grey" />
                    </td>
                </tr>
                
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input class="w3-button w3-green w3-round" type="submit" value="Save" /> 
                        <input class="w3-button w3-red w3-round" type="button" value="Cancel" onclick="javascript: history.go(-1)" />
                    </td>
                </tr>

            </table>
        </div>
    </body>
</html>

<script type="text/javascript">
        
    $(document).ready(function() {
        $("#categoryForm").validate({
            rules: {
                name: "required"
            },

            messages: {
                name: "Please enter category name"
            }
        });
            $("#cancelButton").click(function () {
            history.go(-1);
        });
    });
</script>
