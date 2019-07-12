package controller;


import viewmodel.HomepageViewModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.HttpConstraint;
import javax.servlet.annotation.ServletSecurity;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@ServletSecurity(@HttpConstraint(transportGuarantee = ServletSecurity.TransportGuarantee.CONFIDENTIAL))
@WebServlet(name = "Homepage", urlPatterns = {"/home"})
public class HomepageServlet extends BookstoreServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Forwards the request to homepage.jsp
        request.setAttribute("p", new HomepageViewModel(request));
        forwardToJsp(request, response, "/homepage");
    }
}
