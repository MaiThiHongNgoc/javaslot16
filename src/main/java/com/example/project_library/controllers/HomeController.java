package com.example.project_library.controllers;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    private EntityManagerFactory entityManagerFactory;

    @Override
    public void init() throws ServletException {
        super.init();
        entityManagerFactory = Persistence.createEntityManagerFactory("default");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            List<Object[]> borrowedBooks = entityManager.createStoredProcedureQuery("GetBorrowedBooks").getResultList();
            List<Object[]> mostBorrowedBook = entityManager.createStoredProcedureQuery("MostBorrowedBook").getResultList();
            List<Object[]> membersNeverBorrowed = entityManager.createStoredProcedureQuery("GetMembersNeverBorrowed").getResultList();

            req.setAttribute("borrowedBooks", borrowedBooks);
            req.setAttribute("mostBorrowedBook", mostBorrowedBook);
            req.setAttribute("membersNeverBorrowed", membersNeverBorrowed);

            req.getRequestDispatcher("/view/home.jsp").forward(req, resp);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void destroy() {
        entityManagerFactory.close();
    }
}
