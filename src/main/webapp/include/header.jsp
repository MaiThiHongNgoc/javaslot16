<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 2/27/2025
  Time: 8:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

  <style>
    header {
      width: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: #f8f9fa;
      padding: 10px 0;
    }

    .navbar {
      width: 80%; /* Điều chỉnh độ rộng navbar */
      max-width: 1200px; /* Giới hạn max width */
    }

    .navbar-nav {
      margin: 0 auto; /* Căn giữa các mục trong navbar */
      display: flex;
      justify-content: center;
      width: 100%;
    }

    .navbar-nav .nav-item {
      margin: 0 15px; /* Khoảng cách giữa các mục */
    }
  </style>
</head>
<body>
<header>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
              aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
        <ul class="navbar-nav">
          <li class="nav-item active">
            <a class="nav-link" href="home">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="books">Book</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="members">Member</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="loans">Loans</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</header>
</body>
</html>
