package com.example.project_library.controllers;

import com.example.project_library.entities.Loans;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet("/loans")
public class LoansController extends HttpServlet {
    private EntityManagerFactory entityManagerFactory;
    private EntityManager entityManager;

    @Override
    public void init() throws ServletException {
        super.init();
        entityManagerFactory = Persistence.createEntityManagerFactory("default");
        entityManager = entityManagerFactory.createEntityManager();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Loans> loans = entityManager.createStoredProcedureQuery("GetAllLoans", Loans.class).getResultList();
        req.setAttribute("loans", loans);
        req.getRequestDispatcher("/view/loans/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            int memberId = Integer.parseInt(req.getParameter("memberId"));
            String borrowDate = req.getParameter("borrowDate");
            String status = req.getParameter("status");

            entityManager.getTransaction().begin();
            StoredProcedureQuery query = entityManager.createStoredProcedureQuery("InsertLoan");
            query.registerStoredProcedureParameter("book_id", Integer.class, ParameterMode.IN);
            query.registerStoredProcedureParameter("member_id", Integer.class, ParameterMode.IN);
            query.registerStoredProcedureParameter("borrow_date", String.class, ParameterMode.IN);
            query.registerStoredProcedureParameter("status", String.class, ParameterMode.IN);
            query.setParameter("book_id", bookId);
            query.setParameter("member_id", memberId);
            query.setParameter("borrow_date", borrowDate);
            query.setParameter("status", status);
            query.execute();
            entityManager.getTransaction().commit();

            resp.sendRedirect("./loans");
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            resp.sendRedirect("./loans");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if ("application/json".equals(req.getContentType())) {
            StringBuilder requestBody = new StringBuilder();
            BufferedReader reader = req.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                requestBody.append(line);
            }

            try {
                JSONObject jsonObject = new JSONObject(requestBody.toString());
                int id = jsonObject.getInt("id");
                String returnDate = jsonObject.getString("returnDate");
                String status = jsonObject.getString("status");

                entityManager.getTransaction().begin();
                StoredProcedureQuery query = entityManager.createStoredProcedureQuery("UpdateLoan");
                query.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
                query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
                query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
                query.setParameter(1, id);
                query.setParameter(2, returnDate);
                query.setParameter(3, status);
                query.execute();
                entityManager.getTransaction().commit();

                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("Loan updated successfully");
            } catch (Exception e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("Invalid JSON format: " + e.getMessage());
            }
        } else {
            resp.setStatus(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE);
            resp.getWriter().write("Unsupported Content-Type. Please use application/json.");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));

            entityManager.getTransaction().begin();
            StoredProcedureQuery query = entityManager.createStoredProcedureQuery("DeleteLoan");
            query.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
            query.setParameter(1, id);
            query.execute();
            entityManager.getTransaction().commit();

            resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

}
