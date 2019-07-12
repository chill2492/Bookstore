<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
    <jsp:useBean id="p" scope="request" type="viewmodel.BaseViewModel"/>

    <section id="leftHeader">

        <div id="logo">
            <a href="home">
                <img src="${p.siteImagePath}eBookZone Logo.jpg" alt="eBookZone Logo" width="150px" height="90px"/>
            </a>
        </div>

    </section>

    <section id="midHeader">

        <div id="textLogo">
            <a href="home">
                <img src="${p.siteImagePath}Text Logo.JPG" alt="eBookZone Text Logo" width="200px" height="45px"/>
            </a>
        </div>

        <div id="searchForm" action="category">

            <c:set var="search_bar">
                <c:choose>
                    <c:when test="${p.selectedCategory.name == null}">
                        category?category=arts
                    </c:when>

                    <c:otherwise>
                        category?category=${p.selectedCategory.name}
                    </c:otherwise>

                </c:choose>
            </c:set>

            <c:url var="search__bar_url" value="${search_url}"/>
            <input id="searchBar" type="text" name="category" placeholder=" Search for an ebook...">
            <a href="${search__bar_url}">
                <input id="searchIcon" type="image" src="${p.siteImagePath}Search Icon.jpg" alt="Search Icon">
            </a>
        </div>

        <section id="bottomHeader">

            <div class="topnav">

                <c:forEach var="category" items="${p.categories}">

                    <a href="category?category=${category.name}">${category.name}</a>

                </c:forEach>


            </div>


        </section>

    </section>

    <section id="rightHeader">

        <div id="cartAndLogin">

            <div id="cartIcon">

                <div id="cartCount">
                    ${p.cart.numberOfItems}
                </div>

                <a href="cart">
                    <img src="${p.siteImagePath}Shopping Cart Icon.png"
                         alt="Shopping Cart Icon" width="25" height="25"/>
                </a>
            </div>

            <div id="sign-in">
                <p>Hello, <a href="#">Sign In</a></p>
            </div>

        </div>

        <section id="categoriesButton">

            <div class="dropdown">

                <button class="dropbtn">
                    Categories
                </button>

                <div class="dropdown-content">

                    <c:forEach var="category" items="${p.categories}">

                        <a href="category?category=${category.name}">${category.name}</a>

                    </c:forEach>
                </div>
            </div>
        </section>
    </section>

</header>
