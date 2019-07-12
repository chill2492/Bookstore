package controller;

import business.ApplicationContext;
import business.book.Book;
import business.cart.ShoppingCart;
import viewmodel.CategoryViewModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "CategoryServlet", urlPatterns = {"/category"})
public class CategoryServlet extends BookstoreServlet {
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            ShoppingCart cart = (ShoppingCart) request.getSession().getAttribute("cart");
            String bookIdString = request.getParameter("bookId");

            long bookId = Long.parseLong(bookIdString);
            Book book = ApplicationContext.INSTANCE.getBookDao().findByBookId(bookId);


            boolean isAjaxRequest =
                    "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"));
            if (isAjaxRequest) {
                String jsonString = "{\"cartCount\": " + cart.getNumberOfItems() + "}";
                response.setContentType("application/json");
                response.getWriter().write(jsonString);
                response.flushBuffer();
                return;
            }
            cart.addItem(book);
        }
        response.sendRedirect(request.getContextPath() + "/category?category=" + request.getParameter("category"));

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Forwards the request to category.jsp
        request.setAttribute("p", new CategoryViewModel(request));
        forwardToJsp(request, response, "/category");
    }
}
