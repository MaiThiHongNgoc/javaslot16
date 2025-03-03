<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.project_library.entities.Loans" %>
<html>
<head>
    <title>Loan Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /*body {*/
        /*    font-family: Arial, sans-serif;*/
        /*    margin: 20px;*/
        /*    padding: 20px;*/
        /*    background-color: #f8f9fa;*/
        /*}*/
        h2, h3 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            margin-top: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .btn {
            padding: 8px 12px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }
        .btn-edit { background-color: #ffc107; }
        .btn-delete { background-color: #dc3545; }
        .btn-add { background-color: #28a745; margin-top: 10px; }
        .btn i { font-size: 14px; }
        input[type="text"], input[type="date"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        form {
            text-align: center;
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
    </style>
</head>
<body>

<header>
    <jsp:include page="../../include/header.jsp"/>
</header>

<h2>Loan Management</h2>
<h3>Add New Loan</h3>
<form id="addLoanForm">
    <input type="text" id="newBookId" placeholder="Book ID" required>
    <input type="text" id="newMemberId" placeholder="Member ID" required>
    <input type="date" id="newBorrowDate" required>
    <button type="submit" class="btn btn-add">
        <i class="fas fa-plus"></i> Add Loan
    </button>
</form>

<!-- Loan Table -->
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Book ID</th>
        <th>Member ID</th>
        <th>Borrow Date</th>
        <th>Return Date</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody id="loanTable">
    <% List<Loans> loans = (List<Loans>) request.getAttribute("loans");
        for (Loans loan : loans) { %>
    <tr data-id="<%= loan.getId() %>">
        <td><%= loan.getId() %></td>
        <td><input type="text" value="<%= loan.getBookId() %>" class="edit-book-id"></td>
        <td><input type="text" value="<%= loan.getMemberId() %>" class="edit-member-id"></td>
        <td><input type="date" value="<%= loan.getBorrowDate() %>" class="edit-borrow-date"></td>
        <td><input type="date" value="<%= loan.getReturnDate() %>" class="edit-return-date"></td>
        <td><input type="text" value="<%= loan.getStatus() %>" class="edit-status"></td>
        <td>
            <button class="btn btn-edit" onclick="updateLoan(<%= loan.getId() %>)">
                <i class="fas fa-save"></i> Save
            </button>
            <button class="btn btn-delete" onclick="deleteLoan(<%= loan.getId() %>)">
                <i class="fas fa-trash"></i> Delete
            </button>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>


<script>
    // Update loan details
    function updateLoan(id) {
        let row = $("tr[data-id='" + id + "']");
        let book_id = row.find(".edit-book-id").val();
        let member_id = row.find(".edit-member-id").val();
        let borrow_date = row.find(".edit-borrow-date").val();
        let return_date = row.find(".edit-return-date").val();
        let status = row.find(".edit-status").val();

        $.ajax({
            url: "loans",
            type: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                id: id,
                bookId: book_id,
                memberId: member_id,
                borrowDate: borrow_date,
                returnDate: return_date,
                status: status
            }),
            success: function() {
                alert("Loan updated successfully!");
            },
            error: function() {
                alert("Failed to update loan.");
            }
        });
    }

    // Delete a loan
    function deleteLoan(id) {
        if (confirm("Are you sure you want to delete this loan?")) {
            $.ajax({
                url: "loans?id=" + id,
                type: "DELETE",
                success: function() {
                    $("tr[data-id='" + id + "']").remove();
                    alert("Loan deleted successfully!");
                },
                error: function() {
                    alert("Failed to delete loan.");
                }
            });
        }
    }

    // Add new loan
    $("#addLoanForm").submit(function(e) {
        e.preventDefault();
        let book_id = $("#newBookId").val();
        let member_id = $("#newMemberId").val();
        let borrow_date = $("#newBorrowDate").val();

        $.ajax({
            url: "loans",
            type: "POST",
            data: {
                bookId: book_id,
                memberId: member_id,
                borrowDate: borrow_date
            },
            success: function() {
                alert("Loan added successfully!");
                location.reload();
            },
            error: function() {
                alert("Failed to add loan.");
            }
        });
    });
</script>

</body>
</html>
