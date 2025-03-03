<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.project_library.entities.Loans" %>
<html>
<head>
    <title>Loan Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f5f5f5;
        }

        h2, h3 {
            text-align: center;
            color: #333;
        }

        /* Form Styling */
        form {
            max-width: 500px;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        input[type="text"], input[type="date"], select {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        /* Button Styling */
        .btn {
            padding: 10px 15px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            font-size: 16px;
            transition: 0.3s;
        }

        .btn-add {
            background-color: #28a745;
            width: 100%;
            margin-top: 10px;
        }
        .btn-add:hover {
            background-color: #218838;
        }

        .btn-edit {
            background-color: #007bff;
        }
        .btn-edit:hover {
            background-color: #0056b3;
        }

        .btn-delete {
            background-color: #dc3545;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }

        /* Table Styling */
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
            font-size: 16px;
        }

        th {
            background-color: #f8d210;
            color: white;
            text-transform: uppercase;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        /* Align icons properly */
        .btn i {
            font-size: 18px;
        }

    </style>
</head>
<body>

<header>
    <jsp:include page="../../include/header.jsp"/>
</header>

<form id="addLoanForm">
    <input type="text" id="newBookId" placeholder="Book ID" required>
    <input type="text" id="newMemberId" placeholder="Member ID" required>
    <input type="date" id="newBorrowDate" required>

    <select id="newStatus" required>
        <option value="">Select Status</option>
        <option value="Borrowed">Borrowed</option>
        <option value="Returned">Returned</option>
    </select>

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
        <td><input type="text" value="<%= loan.getBook_id() %>" class="edit-book-id"></td>
        <td><input type="text" value="<%= loan.getMember_id() %>" class="edit-member-id"></td>
        <td><input type="date" value="<%= loan.getBorrow_date() %>" class="edit-borrow-date"></td>
        <td><input type="date" value="<%= loan.getReturn_date() %>" class="edit-return-date"></td>
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
    $("#addLoanForm").submit(function (e) {
        e.preventDefault();
        let book_id = $("#newBookId").val();
        let member_id = $("#newMemberId").val();
        let borrow_date = $("#newBorrowDate").val();
        let status = $("#newStatus").val(); // Get the status value

        if (!status) {
            alert("Please select a loan status.");
            return;
        }

        $.ajax({
            url: "loans",
            type: "POST",
            data: {
                bookId: book_id,
                memberId: member_id,
                borrowDate: borrow_date,
                status: status // Include status
            },
            success: function () {
                alert("Loan added successfully!");
                location.reload();
            },
            error: function () {
                alert("Failed to add loan.");
            }
        });
    });

</script>
<header>
    <jsp:include page="../../include/footer.jsp"/>
</header>

</body>
</html>
