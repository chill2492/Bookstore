package controller;

import viewmodel.ConfirmationViewModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ConfirmationServlet", urlPatterns = {"/confirmation"})
public class ConfirmationServlet extends BookstoreServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forwards the request to confirmation.jsp
        request.setAttribute("p", new ConfirmationViewModel(request));
        forwardToJsp(request, response, "/confirmation");
    }
}
