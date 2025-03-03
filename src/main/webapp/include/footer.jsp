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
    <title>Full Screen Footer</title>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
    <!-- MDB -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/8.2.0/mdb.min.css" rel="stylesheet"/>

    <style>
        footer {
            /*position: fixed;*/
            bottom: 0;
            left: 0;
            width: 100%;
            hight:100%;
            background-color: #45637d;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
        }
        .container {
            width: 80%;
            max-width: 1200px;
        }
        .copyright {
            /*position: absolute;*/
            bottom: 0;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.2);
            text-align: center;
            padding: 10px 0;
        }
    </style>
</head>
<body>

<footer>
    <div class="container p-4">
        <!-- Video Section -->
        <section>
            <div class="row d-flex justify-content-center">
                <div class="col-lg-6">
                    <div class="ratio ratio-16x9">
                        <iframe class="shadow-1-strong rounded"
                                src="https://www.youtube.com/embed/vlDzYIIOYmM"
                                title="YouTube video"
                                allowfullscreen>
                        </iframe>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Copyright -->
    <div class="copyright">
        © 2025 Bản quyền thuộc về:
        <a class="text-white" href="https://mdbootstrap.com/">HongNgocT2308A</a>
    </div>
</footer>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/8.2.0/mdb.umd.min.js"></script>

</body>
</html>
