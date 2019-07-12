<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
    <title>eBookZone Cart Page</title>

    <meta charset="utf-8">
    <meta name="description" content="The cart page for eBookZone">

    <link rel="stylesheet" href="<c:url value="/css/normalize-and-reset.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/header.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/footer.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/cart.css"/>">
</head>

<body>
<jsp:useBean id="p" scope="request" type="viewmodel.CartViewModel"/>

<main>
    <jsp:include page="header.jsp"/>

    <section id="upperCart">
        <div class="cartInfo">
            <div id="cartHeader">
                <p>YOUR SHOPPING CART</p>
            </div>

            <div class="cartButtons">
                <c:set var="continue_shopping_location">
                    <c:choose>
                        <c:when test="${p.selectedCategory.name == null}">
                            category?category=arts
                        </c:when>

                        <c:otherwise>
                            category?category=${p.selectedCategory.name}
                        </c:otherwise>

                    </c:choose>
                </c:set>

                <c:url var="continue_shopping_url" value="${continue_shopping_location}"/>
                <a href="${continue_shopping_url}">
                    <input class="continueShopping" type="submit" name="submit"
                           value="Continue Shopping"/>
                </a>

                <c:if test="${p.cart.numberOfItems > 0}">
                    <a href="checkout"><input class="proceedToCheckout" type="submit" name="submit"
                                              value="Proceed To Checkout"/></a>
                </c:if>

            </div>

        </div>
    </section>

    <section id="midCart">
        <div id="cartTotalItems">

            <c:choose>

                <c:when test="${p.cart.numberOfItems > 1}">
                    <p class="cartItems">Total Items: ${p.cart.numberOfItems} | Subtotal: $${p.cart.subtotal/100.0}</p>
                </c:when>

                <c:when test="${p.cart.numberOfItems == 1}">
                    <p class="cartItems">Total Item: ${p.cart.numberOfItems} | Subtotal: $${p.cart.subtotal/100.0}</p>
                </c:when>

                <c:otherwise>
                    <p class="cartItems">Your shopping cart is empty</p>
                </c:otherwise>

            </c:choose>

        </div>
    </section>

    <section id=lowerCart">
        <div class="cartTable">
            <table id="cartTable">
                <tr class="header">
                    <th>Book</th>
                    <th>Book Title</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>

                <c:forEach var="cartItem" items="${p.cart.items}">
                    <tr class="bookListing">
                        <td class="bookImage"><img src="<c:url value="${p.bookImagePath}${cartItem.book.title}.png"/>"
                                                   width="122" height="187" class="book"
                                                   alt="${cartItem.book.title}"></td>
                        <td class="bookTitle">${cartItem.book.title}</td>
                        <td class="bookQuantity">
                            <form action="<c:url value='cart'/>" method="post">
                                <input type="hidden" name="bookId" value="${cartItem.book.bookId}"/>
                                <input type="hidden" name="action" value="update"/>
                                <input class="number" type="number" value="${cartItem.quantity}" name="quantity" min="0"
                                       max="99"/>
                                <input class="update" type="submit" name="submit" value="Update"/>
                            </form>

                        </td>
                        <td class="bookPrice">$${cartItem.price/100.0}</td>
                    </tr>
                </c:forEach>

            </table>

        </div>

    </section>


    <jsp:include page="footer.jsp"/>
</main>

</body>
</html>
