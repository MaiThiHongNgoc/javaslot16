package com.example.project_library.controllers;

import com.example.project_library.entities.Books;
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

@WebServlet("/books")
public class BooksController extends HttpServlet {
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
        List<Books> books = entityManager.createStoredProcedureQuery("GetAllBooks", Books.class).getResultList();
        req.setAttribute("books", books);
        req.getRequestDispatcher("/view/book/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String title = req.getParameter("title");
            String author = req.getParameter("author");
            String category = req.getParameter("category");
            int availableCopies = Integer.parseInt(req.getParameter("available_copies"));

            entityManager.getTransaction().begin();
            StoredProcedureQuery query = entityManager.createStoredProcedureQuery("AddBook");
            query.registerStoredProcedureParameter("title", String.class, ParameterMode.IN);
            query.registerStoredProcedureParameter("author", String.class, ParameterMode.IN);
            query.registerStoredProcedureParameter("category", String.class, ParameterMode.IN);
            query.registerStoredProcedureParameter("available_copies", Integer.class, ParameterMode.IN);

            query.setParameter("title", title);
            query.setParameter("author", author);
            query.setParameter("category", category);
            query.setParameter("available_copies", availableCopies);

            query.execute();
            entityManager.getTransaction().commit();
            resp.sendRedirect("./books");
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            resp.sendRedirect("./books");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(req.getParameter("id"));
            entityManager.getTransaction().begin();
            StoredProcedureQuery query = entityManager.createStoredProcedureQuery("DeleteBook");
            query.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
            query.setParameter(1, bookId);
            query.execute();
            entityManager.getTransaction().commit();
            resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
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
                int bookId = jsonObject.getInt("id");
                String title = jsonObject.getString("title");
                String author = jsonObject.getString("author");
                String category = jsonObject.getString("category");
                int availableCopies = jsonObject.getInt("available_copies");

                entityManager.getTransaction().begin();
                StoredProcedureQuery query = entityManager.createStoredProcedureQuery("UpdateBook");
                query.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
                query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
                query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
                query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);
                query.registerStoredProcedureParameter(5, Integer.class, ParameterMode.IN);

                query.setParameter(1, bookId);
                query.setParameter(2, title);
                query.setParameter(3, author);
                query.setParameter(4, category);
                query.setParameter(5, availableCopies);

                query.execute();
                entityManager.getTransaction().commit();
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("Book updated successfully");
            } catch (Exception e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("Invalid JSON format: " + e.getMessage());
            }
        } else {
            resp.setStatus(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE);
            resp.getWriter().write("Unsupported Content-Type. Please use application/json.");
        }
    }
}
