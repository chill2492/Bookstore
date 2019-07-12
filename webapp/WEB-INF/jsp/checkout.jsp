<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="p" scope="request" type="viewmodel.CheckoutViewModel"/>

<!doctype html>
<html>
<head>
    <title>eBookZone Checkout Page</title>

    <meta charset="utf-8">
    <meta name="description" content="The checkout page for eBookZone">

    <link rel="stylesheet" type="text/css" href="<c:url value="/css/normalize-and-reset.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/main.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/header.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/footer.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/checkout.css"/>">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="js/jquery.validate.js"></script>
    <script src="js/additional-methods.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#checkoutForm").validate({
                rules: {
                    name: "required",
                    email: {
                        required: true,
                        email: true
                    },
                    phone: {
                        required: true,
                        phoneUS: true
                    },
                    address: {
                        required: true
                    },
                    ccNumber: {
                        required: true,
                        creditcard: true
                    },
                }
            });
        });
    </script>
</head>

<body class="home">
<main>
    <jsp:include page="header.jsp"/>

    <section id="checkoutMain">

        <div id="checkoutHeader">
            <p>CHECKOUT</p>
        </div>

        <div id="checkoutFormErrors">
            <c:if test="${p.hasValidationError}">
                <c:if test="${p.customerForm.hasNameError}">
                    ${p.customerForm.nameErrorMessage}<br>
                </c:if>

                <c:if test="${p.customerForm.hasPhoneError}">
                    ${p.customerForm.phoneErrorMessage}<br>
                </c:if>

                <c:if test="${p.customerForm.hasAddressError}">
                    ${p.customerForm.addressErrorMessage}<br>
                </c:if>

                <c:if test="${p.customerForm.hasEmailError}">
                    ${p.customerForm.emailErrorMessage}<br>
                </c:if>

                <c:if test="${p.customerForm.hasCcNumberError}">
                    ${p.customerForm.ccNumberErrorMessage}<br>
                </c:if>

                <c:if test="${p.customerForm.hasCcExpDateError}">
                    ${p.customerForm.ccExpDateErrorMessage}<br>
                </c:if>
            </c:if>

            <c:if test="${p.hasTransactionError}">
                Transactions have not been implemented yet.<br>
            </c:if>
        </div>

        <div id="checkoutFormAndInfo">
            <div id="checkoutFormBox">
                <form class="checkoutForm" id="checkoutForm" action="<c:url value='checkout'/>" method="post">
                    <label class="formLabel"><sup><span class="required">*</span></sup>Name</label>
                    <input class="textField" type="text" size="20" maxlength="45" name="name"
                           value="${p.customerForm.name}"><br>

                    <label class="formLabel"><sup><span class="required">*</span></sup>Address</label>
                    <input class="textField" type="text" size="20" maxlength="45" id="address" name="address"
                           value="${p.customerForm.address}"><br>

                    <label class="formLabel"><sup><span class="required">*</span></sup>Phone</label>
                    <input class="textField" type="text" size="20" maxlength="45" id="phone" name="phone"
                           value="${p.customerForm.phone}"><br>

                    <label class="formLabel" for="email"><sup><span class="required">*</span></sup>Email</label>
                    <input class="textField" id="email" name="email" type="text" size="20" maxlength="45"
                           value="${p.customerForm.email}"><br>

                    <label class="formLabel" for="creditcard"><sup><span class="required">*</span></sup>Credit Card</label>
                    <input class="textField" type="text" size="20" maxlength="45" id="creditcard" name="ccNumber"
                           value="${p.customerForm.ccNumber}"><br>

                    <label class="formLabel"><sup><span class="required">*</span></sup>Exp. Date</label>
                    <select class="selectMenu" name="ccMonth">
                        <c:set var="montharr"
                               value="${['January','February','March','April','May','June','July','August','September','October','November','December']}"/>
                        <c:forEach begin="1" end="12" var="month">
                            <option value="${month}"
                                    <c:if test="${p.customerForm.ccMonth eq month}">selected</c:if>>
                                    ${month}-${montharr[month - 1]}
                            </option>
                        </c:forEach>
                    </select>

                    <select class="selectMenu" name="ccYear">
                        <c:forEach begin="2018" end="2027" var="year">
                            <option value="${year}"
                                    <c:if test="${p.customerForm.ccYear eq year}">selected</c:if>>
                                    ${year}
                            </option>
                        </c:forEach>
                    </select>

                    <p id="required"><sup><span class="required">*</span></sup>Indicates required field</p>
                    <br>

                    <input id="boldSubmitButton" type="submit" value="Submit">

                </form>

            </div>


            <div id="checkoutInfoText">
                <span id="transaction">Transaction Details</span>
                <hr>

                <p id="transactionDetails">Your credit card will be charged <strong><fmt:formatNumber type="currency"
                                                                                                      currencySymbol="$"
                                                                                                      value="${(p.cart.subtotal + p.checkoutSurcharge)/100.0}"/></strong>.
                </p>

                <p>(Subtotal: <fmt:formatNumber type="currency" currencySymbol="$" value="${p.cart.subtotal/100.0}"/> +
                    Shipping: <fmt:formatNumber type="currency" currencySymbol="$"
                                                value="${p.checkoutSurcharge/100.0}"/>)</p>
            </div>
        </div>
        </div>

    </section>
    <jsp:include page="footer.jsp"/>
</main>
</body>
</html>
