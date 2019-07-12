<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="p" scope="request" type="viewmodel.ConfirmationViewModel"/>

<!doctype html>
<html>
<head>
    <title>eBookZone Confirmation Page</title>

    <meta charset="utf-8">
    <meta name="description" content="The confirmation page for eBookZone">

    <link rel="stylesheet" type="text/css" href="<c:url value="/css/normalize-and-reset.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/main.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/header.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/footer.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/confirmation.css"/>">
</head>

<body clas="main">
<main>
    <jsp:include page="header.jsp"/>

    <section id="header">
        <div id="confirmationDetails">
            <p id="confirmationHeader">Confirmation</p>

            <p id="confirmationNumber">Thank you for your order with eBookZone!<br>
                Your confirmation number is: ${p.orderDetails.order.confirmationNumber}</p>

            <p id="dateCreated"><fmt:formatDate type="both" value="${p.orderDetails.order.dateCreated}"
                                                pattern="MMMM dd, yyyy hh:mm:ss a z" dateStyle="long"
                                                timeStyle="long"/></p>
        </div>

    </section>

    <section id="middle">

        <div class="confirmationTable">
            <table id="confirmationTable">
                <tr class="header">
                    <th>Book Title</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>

                <c:forEach var="lineItem" items="${p.orderDetails.lineItems}" varStatus="iter">
                    <tr class="bookListing">
                        <td id="bookTitle">${p.orderDetails.books[iter.index].title}</td>
                        <td id="quantity">${lineItem.quantity}</td>
                        <td id="price"><fmt:formatNumber type="currency"
                                                         currencySymbol="$"
                                                         value="${p.orderDetails.books[iter.index].price/100.00}"/></td>
                    </tr>
                </c:forEach>

                <tr>
                    <td>--Delivery Surcharge--</td>
                    <td></td>
                    <td id="surcharge"><fmt:formatNumber type="currency"
                                                         currencySymbol="$"
                                                         value="${p.surcharge/100.0}"/></td>
                </tr>
                <tr class="totalAmount">
                    <td>Total</td>
                    <td></td>
                    <td><fmt:formatNumber type="currency"
                                          currencySymbol="$"
                                          value="${p.orderDetails.order.amount/100.0}"/>
                    </td>
                </tr>

            </table>

        </div>

    </section>

    <section id="bottom">
        <div id="customerInfo">
            <p id="customerInfoHeading">Customer Information</p>
            <hr>
            <p id="customerName"><span style="font-weight: bold">Name:</span> ${p.orderDetails.customer.customerName}
            </p>
            <p id="customerEmail"><span style="font-weight: bold">Email:</span> ${p.orderDetails.customer.email}</p>
            <p id="address"><span style="font-weight: bold">Address:</span> ${p.orderDetails.customer.address}</p>
            <p id="creditCard"><span style="font-weight: bold">Credit Card:</span> **** ****
                **** ${p.orderDetails.customer.ccNumber.substring(p.orderDetails.customer.ccNumber.length() -4)}
                ${p.orderDateForDisplay}
            </p>

        </div>
    </section>

    <jsp:include page="footer.jsp"/>
</main>

</body>
</html>
