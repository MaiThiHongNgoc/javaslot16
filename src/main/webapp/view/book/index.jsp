<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.project_library.entities.Books" %>

<html>
<head>
    <title>Book Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* General styles */
        /*body {*/
        /*    font-family: Arial, sans-serif;*/
        /*    background-color: #f8f9fa;*/
        /*    margin: 0;*/
        /*    padding: 20px;*/
        /*}*/

        h2, h3 {
            text-align: center;
            color: #333;
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        td input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        /* Button styling */
        .btn {
            padding: 8px 12px;
            cursor: pointer;
            border: none;
            color: white;
            font-size: 14px;
            border-radius: 4px;
            transition: background 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn-edit {
            background-color: #ffc107;
        }

        .btn-edit:hover {
            background-color: #e0a800;
        }

        .btn-delete {
            background-color: #dc3545;
        }

        .btn-delete:hover {
            background-color: #c82333;
        }

        .btn-add {
            background-color: #28a745;
            display: block;
            width: 100%;
            margin-top: 15px;
        }

        .btn-add:hover {
            background-color: #218838;
        }

        /* Form styling */
        form {
            max-width: 500px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        header {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<header>
    <jsp:include page="../../include/header.jsp"/>
</header>

<h2>Book Management</h2>
<h3>Add New Book</h3>
<form id="addBookForm">
    <input type="text" id="newTitle" placeholder="Title" required>
    <input type="text" id="newAuthor" placeholder="Author" required>
    <input type="text" id="newCategory" placeholder="Category" required>
    <input type="number" id="newCopies" placeholder="Available Copies" required>
    <button type="submit" class="btn btn-add">+📖 Add Book</button>
</form>


<!-- Table displaying books -->
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Author</th>
        <th>Category</th>
        <th>Available Copies</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody id="bookTable">
    <%
        List<Books> books = (List<Books>) request.getAttribute("books");
        for (Books book : books) {
    %>
    <tr data-id="<%= book.getId() %>">
        <td><%= book.getId() %></td>
        <td><input type="text" value="<%= book.getTitle() %>" class="edit-title"></td>
        <td><input type="text" value="<%= book.getAuthor() %>" class="edit-author"></td>
        <td><input type="text" value="<%= book.getCategory() %>" class="edit-category"></td>
        <td><input type="number" value="<%= book.getAvailable_copies() %>" class="edit-copies"></td>
        <td>
            <button class="btn btn-edit" onclick="updateBook(<%= book.getId() %>)">
                ✏️ Save
            </button>
            <button class="btn btn-delete" onclick="deleteBook(<%= book.getId() %>)">
                🗑️ Delete
            </button>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>

<script>
    // Update book details
    function updateBook(id) {
        let row = $("tr[data-id='" + id + "']");
        let title = row.find(".edit-title").val();
        let author = row.find(".edit-author").val();
        let category = row.find(".edit-category").val();
        let availableCopies = row.find(".edit-copies").val();

        $.ajax({
            url: "books",
            type: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                id: id,
                title: title,
                author: author,
                category: category,
                available_copies: availableCopies
            }),
            success: function(response) {
                alert("Book updated successfully!");
            },
            error: function() {
                alert("Failed to update book.");
            }
        });
    }
</script>

</body>
</html>
