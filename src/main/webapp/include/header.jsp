<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Library Management</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

  <style>
    /* Header Styles */
    header {
      width: 100%;
      background-color: #45637d;
      padding: 10px 0;
    }

    /* Navbar Styles */
    .navbar {
      max-width: 1200px;
      width: 100%;
    }

    .navbar-nav {
      display: flex;
      justify-content: center;
      width: 100%;
    }

    .navbar-nav .nav-item {
      margin: 0 15px;
    }

    .nav-link {
      color: white !important;
      font-weight: 500;
      transition: 0.3s;
    }

    .nav-link:hover {
      color: #f8d210 !important;
    }

    /* Mobile Styles */
    @media (max-width: 992px) {
      .navbar-nav {
        flex-direction: column;
        text-align: center;
      }
      .navbar-nav .nav-item {
        margin: 10px 0;
      }
    }
  </style>
</head>
<body>
<header>
  <nav class="navbar navbar-expand-lg">
    <div class="container">
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
              aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link active" href="home">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="books">Books</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="members">Members</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="loans">Loans</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</header>
</body>
</html>
