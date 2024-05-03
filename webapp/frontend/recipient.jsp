
<h3>Your Payment Recipient</h3>
<table>
        <h2>Seller Information</h2>

        <tr>
            <td><b>E-mail</b></td>
            <td>email@gmail.com</td>
        </tr>

        <tr>
            <td><b>Phone</b></td>
            <td>+ 1 23 456789</td>
        </tr>
    </table>

    <h2>Buyer Information</h2>
    <table>
        <h2>Buyer Information</h2>

        <tr>
            <td><b>E-mail</b></td>
            <td>${payer.email}</td>
        </tr>

        <tr>
            <td><b>First Name</b></td>
            <td>${payer.firstname}</td>
        </tr>

        <tr>
            <td><b>Last Name</b></td>
            <td>${payer.lastname}</td>
        </tr>
    </table>

    <h2>Order Details</h2>

    <table>

        <tr>
            <td><b>Order ID</b></td>
            <td>${orderID}</td>
        </tr>

        <tr>
            <td><b>Order By:</b></td>
            <td>${loggedCustomer}</td>
        </tr>

        <tr>
            <td><b>Transaction Description</b></td>
            <td>${transaction.description}</td>
        </tr>

        <tr>
            <td colspan="2"><b>Items</b></td>
        </tr>

        <tr>
            <td colspan="2">
                <table border="1">
                    <tr>
                        <th>No</th>
                        <th>Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Subtotal</th>
                    </tr>

                    <c:forEach var="item" items="${transaction.itemList.items}" varStatus="var">
                        <tr>
                            <td>${var.index + 1}</td>
                            <td>${item.name}</td>
                            <td>${item.quantity}</td>
                            <td><fmt:formatNumber value="${item.price}" type="currency" /> </td>
                            <td><fmt:formatNumber value="${item.subtotal}" type="currency" /></td>
                        </tr>
                    </c:forEach>

                        <tr>
                            <td colspan="5" align="right">
                                <p>Subtotal: <fmt:formatNumber value="${transaction.amount.details.subtotal}" type="currency" /></p>
                                <p>Tax: <fmt:formatNumber value="${transaction.amount.details.tax}" type="currency" /></p>
                                <p>Shipping Fee: <fmt:formatNumber value="${transaction.amount.details.shipping}" type="currency" /></p>
                                <p>Total: <fmt:formatNumber value="${transaction.amount.total}" type="currency" /></p>
                            </td>
                        </tr>
                </table>
            </td>
        </tr>
    </table>