<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<html>
<head>
    <title>Library Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<header>
    <jsp:include page="../include/header.jsp"/>
</header>
<body>
<div class="container mt-4">

    <%-- Sách được mượn nhiều nhất --%>
    <div class="card mt-4">
        <div class="card-header bg-primary text-white">
            Most Borrowed Book
        </div>
        <div class="card-body">
            <%
                List<Object[]> mostBorrowedBook = (List<Object[]>) request.getAttribute("mostBorrowedBook");
                if (mostBorrowedBook != null && !mostBorrowedBook.isEmpty()) {
            %>
            <p><strong>Title:</strong> <%= mostBorrowedBook.get(0)[0] %></p>
            <p><strong>Times Borrowed:</strong> <%= mostBorrowedBook.get(0)[1] %></p>
            <% } else { %>
            <p>No data available.</p>
            <% } %>
        </div>
    </div>

    <%-- Danh sách sách đã mượn --%>
    <div class="card mt-4">
        <div class="card-header bg-success text-white">
            Borrowed Books
        </div>
        <div class="card-body">
            <%
                List<Object[]> borrowedBooks = (List<Object[]>) request.getAttribute("borrowedBooks");
                if (borrowedBooks != null && !borrowedBooks.isEmpty()) {
            %>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Title</th>
                    <th>Borrower</th>
                    <th>Borrow Date</th>
                </tr>
                </thead>
                <tbody>
                <% for (Object[] book : borrowedBooks) { %>
                <tr>
                    <td><%= book[0] %></td>
                    <td><%= book[1] %></td>
                    <td><%= book[2] %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } else { %>
            <p>No borrowed books found.</p>
            <% } %>
        </div>
    </div>

    <%-- Thành viên chưa từng mượn sách --%>
    <div class="card mt-4">
        <div class="card-header bg-danger text-white">
            Members Who Never Borrowed Books
        </div>
        <div class="card-body">
            <%
                List<Object[]> membersNeverBorrowed = (List<Object[]>) request.getAttribute("membersNeverBorrowed");
                if (membersNeverBorrowed != null && !membersNeverBorrowed.isEmpty()) {
            %>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Member ID</th>
                    <th>Name</th>
                    <th>Email</th>
                </tr>
                </thead>
                <tbody>
                <% for (Object[] member : membersNeverBorrowed) { %>
                <tr>
                    <td><%= member[0] %></td>
                    <td><%= member[1] %></td>
                    <td><%= member[2] %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } else { %>
            <p>All members have borrowed books.</p>
            <% } %>
        </div>
    </div>
</div>
<header>
    <jsp:include page="../include/footer.jsp"/>
</header>
</body>
</html>
