package com.example.project_library.controllers;

import com.example.project_library.entities.Members;
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

@WebServlet("/members")
public class MembersController extends HttpServlet {
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
        List<Members> members = entityManager.createStoredProcedureQuery("GetAllMembers", Members.class).getResultList();
        req.setAttribute("members", members);
        req.getRequestDispatcher("/view/member/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");

            entityManager.getTransaction().begin();
            StoredProcedureQuery query = entityManager.createStoredProcedureQuery("AddMember");
            query.registerStoredProcedureParameter("name", String.class, ParameterMode.IN);
            query.registerStoredProcedureParameter("email", String.class, ParameterMode.IN);
            query.registerStoredProcedureParameter("phone", String.class, ParameterMode.IN);
            query.registerStoredProcedureParameter("address", String.class, ParameterMode.IN);
            query.setParameter("name", name);
            query.setParameter("email", email);
            query.setParameter("phone", phone);
            query.setParameter("address", address);
            query.execute();
            entityManager.getTransaction().commit();

            resp.sendRedirect("./members");
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            resp.sendRedirect("./members");
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
                String name = jsonObject.getString("name");
                String email = jsonObject.getString("email");
                String phone = jsonObject.getString("phone");
                String address = jsonObject.getString("address");

                entityManager.getTransaction().begin();
                StoredProcedureQuery query = entityManager.createStoredProcedureQuery("UpdateMember");
                query.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
                query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
                query.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
                query.registerStoredProcedureParameter(4, String.class, ParameterMode.IN);
                query.registerStoredProcedureParameter(5, String.class, ParameterMode.IN);
                query.setParameter(1, id);
                query.setParameter(2, name);
                query.setParameter(3, email);
                query.setParameter(4, phone);
                query.setParameter(5, address);
                query.execute();
                entityManager.getTransaction().commit();

                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("Member updated successfully");
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
            StoredProcedureQuery query = entityManager.createStoredProcedureQuery("DeleteMember");
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
