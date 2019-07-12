<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>eBookZone</title>

    <meta charset="utf-8">
    <meta name="description" content="The homepage for eBookZone">

    <link rel="stylesheet" href="<c:url value="/css/normalize-and-reset.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/header.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/footer.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/homepage.css"/>">

</head>

<body>
<jsp:useBean id="p" scope="request" type="viewmodel.HomepageViewModel"/>
<main>
    <jsp:include page="header.jsp"/>
    <section id="upperHome">
        <p>Welcome to the best online eBook store - it's time to go digital....eBook style!</p>
    </section>

    <section id="midHome">
        <div class="box">
            <div id="bestSeller">
                <div id="seller">
                    <p>BEST SELLERS</p>
                </div>

                <ul class="flex-container">
                    <c:forEach var="book" items="${p.selectedBestSellerBooks}">
                        <li class="flex-item">
                            <a href="#">
                                <img src="<c:url value="${p.bookImagePath}${book.title}.png"/>" width="122" height="187"
                                     class="book"
                                     alt="${book.title}">
                            </a>
                        </li>
                    </c:forEach>

                </ul>
            </div>
        </div>
    </section>

    <section id="bottomHome">
        <div class="flex-container">

            <div id="newReleases">

                <div id="releases">
                    <p><b>NEW RELEASES</b></p>
                </div>

                <ul class="flex-container">
                    <c:forEach var="book" items="${p.selectedNewReleasesBooks}">
                        <li class="flex-item">
                            <a href="#">
                                <img src="<c:url value="${p.bookImagePath}${book.title}.png"/>" width="122" height="187"
                                     class="book"
                                     alt="${book.title}">
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <div id="topRated">

                <div id="rated">
                    <p><b>TOP RATED</b>
                    <p/>
                </div>

                <ul class="flex-container">

                    <c:forEach var="book" items="${p.selectedTopRatdeBooks}">

                        <li class="flex-item">
                            <a href="#">
                                <img src="<c:url value="${p.bookImagePath}${book.title}.png"/>" width="122" height="187"
                                     class="book"
                                     alt="${book.title}">
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

    </section>

    <jsp:include page="footer.jsp"/>
</main>
</body>
</html>