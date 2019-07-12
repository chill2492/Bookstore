<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
    <title>eBookZone Category Page</title>

    <meta charset="utf-8">
    <meta name="description" content="The category page for eBookZone">


    <link rel="stylesheet" href="<c:url value="/css/normalize-and-reset.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/header.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/footer.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/category.css"/>">
</head>

<body>
<jsp:useBean id="p" scope="request" type="viewmodel.CategoryViewModel"/>
<main>
    <jsp:include page="header.jsp"/>

    <section id="midSection">
        <div class="row">

            <div class="left-column">

                <ul class="vertical-menu">
                    <c:forEach var="category" items="${p.categories}">
                        <c:choose>
                            <c:when test="${p.selectedCategory.name==category.name}">
                                <li><a href="category?category=${p.selectedCategory.name}"
                                       class="active">${p.selectedCategory.name}</a></li>
                            </c:when>

                            <c:otherwise>
                                <li><a href="category?category=${category.name}">${category.name}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                </ul>


            </div>

            <div class="right-column">

                <div id="selectedCategory">
                    <!-- books category -->
                    <div id="category">
                        <p>${p.selectedCategory.name}</p>
                    </div>

                    <ul class="flex-container">

                        <c:forEach var="book" items="${p.selectedCategoryBooks}">

                            <div class="flex-item">
                                <li class="bookListing">
                                    <img src="<c:url value="${p.bookImagePath}${book.title}.png"/>" width="122"
                                         height="187" class="book"
                                         alt="${book.title}">
                                    <div class="bookContent">
                                        <p class="title">${book.title}</p>
                                        <p class="author">by ${book.author}</p>
                                        <p class="price">$${book.price/100.0}</p>

                                        <div class="buttonFlex">
                                            <form action="<c:url value='category'/>" method="post">
                                                <input type="hidden" name="bookId" value="${book.bookId}"/>
                                                <input type="hidden" name="action" value="add"/>
                                                <input type="hidden" name="category"
                                                       value="${p.selectedCategory.name}"/>
                                                <div class="buttonFlex">
                                                    <button class="addToCartButton"
                                                            data-book-id="${book.bookId}"
                                                            data-action="add">
                                                        Add to Cart
                                                    </button>

                                                </div>

                                            </form>
                                            <c:if test="${book.getisPublic()}">
                                                <button class="readMore">Read More</button>
                                            </c:if>

                                        </div>
                                    </div>
                                </li>
                            </div>
                        </c:forEach>


                    </ul>

                </div>

            </div>


        </div>

    </section>

    <jsp:include page="footer.jsp"/>
</main>

<script src="<c:url value="/js/ajax-functions.js"/>" type="text/javascript"></script>

<script>
    var addToCartButtons = document.getElementsByClassName("addToCartButton");
    for (var i = 0; i < addToCartButtons.length; i++) {
        addToCartButtons[i].addEventListener("click", function (event) {
            addToCartEvent(event.target)
        });
    }

    function addToCartEvent(button) {
        var data = {
            "bookId": button.dataset.bookId,
            "action": button.dataset.action
        };
        ajaxPost('category', data, function (text, xhr) {
            addToCartCallback(text, xhr)
        });
    }

    function addToCartCallback(responseText, xhr) {
        var cartCount = JSON.parse(responseText).cartCount;
        document.getElementById('cartCount').textContent = '' + cartCount;
    }
</script>

</body>
</html>