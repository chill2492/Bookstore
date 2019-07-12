package controller;

import business.ApplicationContext;
import business.book.Book;
import business.cart.ShoppingCart;
import viewmodel.CartViewModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.HttpConstraint;
import javax.servlet.annotation.ServletSecurity;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@ServletSecurity(@HttpConstraint(transportGuarantee = ServletSecurity.TransportGuarantee.CONFIDENTIAL))
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends BookstoreServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            ShoppingCart cart = (ShoppingCart) request.getSession().getAttribute("cart");
            String bookId = request.getParameter("bookId");
            String quantity = request.getParameter("quantity");

            try {
                cart.update(ApplicationContext.INSTANCE.getBookDao().findByBookId(Integer.parseInt(bookId)), Short.parseShort(quantity));

            } catch (Exception e) {
                // no message was sent to user in affable bean project
            }
            response.sendRedirect(request.getContextPath() + "/cart");
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forwards the request to cart.jsp
        request.setAttribute("p", new CartViewModel(request));
        forwardToJsp(request, response, "/cart");
    }
}
