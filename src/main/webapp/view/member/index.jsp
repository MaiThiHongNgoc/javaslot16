<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.project_library.entities.Members" %>
<html>
<head>
    <title>Member Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* General styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        /* Table styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border-bottom: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f8d210;
            color: #333;
            font-weight: bold;
        }

        /* Form styles */
        #memberForm {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-left: 5px solid  #f8d210;
            max-width: 600px;
            margin: 20px auto;
        }

        #memberForm input {
            flex: 1;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: 0.3s;
        }

        #memberForm input:focus {
            border-color: #45637d;
            outline: none;
            box-shadow: 0 0 5px rgba(69, 99, 125, 0.5);
        }

        /* Button styles */
        .btn {
            padding: 8px 12px;
            margin: 4px;
            cursor: pointer;
            border: none;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            font-size: 14px;
            transition: 0.3s;
        }

        .btn-edit {
            background-color: #28a745;
            color: white;
        }

        .btn-edit:hover {
            background-color: #218838;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
        }

        .btn-delete:hover {
            background-color: #c82333;
        }

        /* Save button */
        #memberForm button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px 15px;
            cursor: pointer;
            border-radius: 6px;
            font-size: 14px;
            transition: 0.3s;
        }

        #memberForm button:hover {
            background-color: #0056b3;
        }

        /* Icon styles */
        .btn i {
            font-size: 16px;
        }

    </style>
</head>

<header>
    <jsp:include page="../../include/header.jsp"/>
</header>

<body>


<form id="memberForm">
    <input type="hidden" id="memberId">
    <input type="text" id="name" placeholder="Name" required>
    <input type="email" id="email" placeholder="Email" required>
    <input type="text" id="phone" placeholder="Phone" required>
    <input type="text" id="address" placeholder="Address" required>
    <button type="submit"><i class="fas fa-save"></i> Save</button>
</form>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Address</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Members> members = (List<Members>) request.getAttribute("members");
        if (members != null) {
            for (Members member : members) {
    %>
    <tr id="row-<%= member.getId() %>">
        <td><%= member.getId() %></td>
        <td><%= member.getName() %></td>
        <td><%= member.getEmail() %></td>
        <td><%= member.getPhone() %></td>
        <td><%= member.getAddress() %></td>
        <td>
            <button class="btn btn-edit" onclick="editMember(<%= member.getId() %>)">
                <i class="fas fa-edit"></i> Edit
            </button>
            <button class="btn btn-delete" onclick="deleteMember(<%= member.getId() %>)">
                <i class="fas fa-trash"></i> Delete
            </button>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>

<script>
    $(document).ready(function () {
        $("#memberForm").submit(function (event) {
            event.preventDefault();
            let id = $("#memberId").val();
            let name = $("#name").val();
            let email = $("#email").val();
            let phone = $("#phone").val();
            let address = $("#address").val();
            let memberData = { name, email, phone, address };

            if (id) {
                // Update member
                $.ajax({
                    url: "members",
                    type: "PUT",
                    contentType: "application/json",
                    data: JSON.stringify({ id, ...memberData }),
                    success: function () {
                        alert("Member updated successfully!");
                        location.reload();
                    }
                });
            } else {
                // Add new member
                $.post("members", memberData, function () {
                    alert("Member added successfully!");
                    location.reload();
                });
            }
        });
    });

    function editMember(id) {
        let row = $("#row-" + id);
        $("#memberId").val(id);
        $("#name").val(row.children("td:nth-child(2)").text());
        $("#email").val(row.children("td:nth-child(3)").text());
        $("#phone").val(row.children("td:nth-child(4)").text());
        $("#address").val(row.children("td:nth-child(5)").text());
    }

    function deleteMember(id) {
        if (confirm("Are you sure you want to delete this member?")) {
            $.ajax({
                url: "members?id=" + id,
                type: "DELETE",
                success: function () {
                    alert("Member deleted successfully!");
                    location.reload();
                }
            });
        }
    }
</script>
<header>
    <jsp:include page="../../include/footer.jsp"/>
</header>

</body>
</html>
