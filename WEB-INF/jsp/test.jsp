<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    </head>
<body>

<jsp:useBean id="selectedCategoryName" scope="request" type="java.lang.String"/>
<jsp:useBean id="selectedBookList" scope="request" type="java.util.List"/>

<ul>

        <li><a href="test?category=arts">arts</a></li>
        <li><a href="test?category=education">education</a></li>
        <li><a href="test?category=humor">humor</a></li>
        <li><a href="test?category=music">music</a></li>
        <li><a href="test?category=romance">romance</a></li>
        <li><a href="test?category=sports">sports</a></li>

</ul>

<h1 style="text-transform: capitalize;">${selectedCategoryName}</h1>

<table border="1">
    <!-- column headers -->
    <tr>
        <th>book_id</th>
        <th>title</th>
        <th>author</th>
        <th>price</th>
        <th>is_public</th>
        <th>category_id</th>
    </tr>

    <!-- column data -->
    <c:forEach var="book" items="${selectedBookList}">
        <jsp:useBean id="book" scope="page" type="business.book.Book"/>
        <tr>
            <td>${book.bookId}</td>
            <td>${book.title}</td>
            <td>${book.author}</td>
            <td>${book.price}</td>
            <td>${book.getisPublic()}</td>
            <td>${book.categoryId}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
