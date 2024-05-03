
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
            <c:if test="${product != null}">Edit Product</c:if>
            <c:if test="${product == null}">Create New Product</c:if>
        </title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/js/richtext.min.css" />
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.richtext.min.js"></script>
    </head>
    <body>
        <div class="w3-center">
            <h1 class="w3-green">
                <c:if test="${product != null}">
                    Edit Product
                </c:if>

                <c:if test="${product == null}">
                    Create New Product
                </c:if>
            </h1>
            
        </div>
        
        <div class="w3-container w3-centered">
            
            <c:if test="${product != null}">
                <form action="updateProduct" method="POST" id="productForm" enctype="multipart/form-data">
                <input type="hidden" name="productID" value="${product.productID}" />
            </c:if>
            
            <c:if test="${product == null}">
                <form action="createProduct" method="POST" id="productForm" enctype="multipart/form-data">
            </c:if>
                
            <table class="w3-table">
                <tr>
                    <td>Category:</td>
                    <td>
                        <select name="category" style="width: 300px;">
                        <c:forEach items="${categorys}" var="cat">
                            <c:if test="${cat.categoryID == product.category.categoryID}">
                                <option value="${cat.categoryID}" selected>
                            </c:if>

                            <c:if test="${cat.categoryID != product.category.categoryID}">
                                <option value="${cat.categoryID}" />
                            </c:if>
                                ${cat.name}
                        </c:forEach>

                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td align="right">Title:</td>
                    <td align="left"><input type="text" id="title" name="title" size="45" value="${product.title}" /></td>
                </tr>
                
                <tr>
                    <td align="right">Description:</td>
                    <td align="left">
                        <textarea rows="5" cols="50" name="description" id="description">${product.description}</textarea>
                    </td>
                </tr>
                
                <tr>
                    <td align="right">Product Image:</td>
                    <td align="left"><input type="file" id="productImage" name="productImage" size="45"/><br />
                    <img id="thumbnail" alt="Image Preview" style="width: 20%; margin-top: 10px;" src="data:image/jpg;base64,${product.base64Image}" /></td>
                </tr>
                
                <tr>
                    <td align="right">Price:</td>
                    <td align="left"><input type="text" id="price" name="price" size="45" value="${product.price}" /></td>
                </tr>
                
                <tr>
                    <td align="right">Publish Date:</td>
                    <td align="left"><input type="text" id="publishDate" name="publishDate" size="45" 
                                            value="<fmt:formatDate pattern='MM/dd/yyyy' value='${product.publishDate}'/>" /></td>
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
    
    <script type="text/javascript">
            
    $(document).ready(function() {
        $('#publishDate').datepicker();
        $('#description').richText();
        $('#productImage').change(function(){
            showImageThumbnail(this);
        });

        $("#productForm").validate({
            rules: {
                category: "required",
                title: "required",
                publishDate: "required",
                <c:if test="${product == null}">
                    productImage: "required",
                </c:if>
                price: "required",
                description: "required",
            },
            messages: {
                category: "Please select a category for the product",
                title: "Please enter product title",
                publishDate: "Please enter product publish date",
                productImage: "Please add product image",
                price: "Please enter product price",
                description: "Please enter product discription"
            }
        });

            $("#cancelButton").click(function() {
            history.go(-1);
        });
    });

    function showImageThumbnail(fileInput) {
        var file = fileInput.files[0];
        var reader = new FileReader();
        
        reader.onload = function(e) {
            $('#thumbnail').attr('src', e.target.result);
        };
        reader.readAsDataURL(file);
    }
</script>
    
</html>


