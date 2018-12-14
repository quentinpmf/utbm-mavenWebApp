<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <title>Saint-Joseph</title>
    <link href="style.css" rel="stylesheet">
    <!-- searchbar CSS -->
    <link href="searchbar.css" rel="stylesheet">
    <!-- searchbar JS -->
    <script src="searchbar.js"></script>
  </head>

  <body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
          <a class="navbar-brand" href="home.jsp">Université privée Saint-Joseph</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
              <li class="nav-item">
                <a class="nav-link" href="home">Accueil
                
                </a>
              </li>
              <li class="nav-item active">
                <a class="nav-link" href="course_sessions">Formations</a>
                <span class="sr-only">(current)</span>
              </li>
              <%
                  HttpSession userSession = request.getSession(true);
                  Object lastname = userSession.getAttribute("lastname");
                  Object firstname = userSession.getAttribute("firstname");
                  System.out.println("lastname = "+lastname);
                  System.out.println("firstname = "+firstname);

                  if(lastname != null)
                  {
              %>        
                    <li class="nav-item">
                        <a class="nav-link" href="deconnexion">Déconnexion de <%=lastname%><%=firstname%></a>
                    </li>
              <%
                  }
                  else
                  {
              %>
                    <li class="nav-item">
                       <a class="nav-link" href="connexion">Connexion</a>
                    </li>
                    <li class="nav-item">
                       <a class="nav-link" href="inscription">Inscription</a>
                    </li>
              <%
                  }
              %>
            </ul>
          </div>
        </div>
    </nav>

    <!-- Page Content -->
    <div class="container">

      <!-- Page Heading -->
      <h1 class="my-4">Toutes les sessions
        <small>de formations</small>
      </h1>
      
      <%
        if(lastname != null)
        {     
    %>        
        <div class="form-group row">
            <div class="col-lg-2 col-sm-4">
                <a class="btn btn-info" href="createcourse" role="button">Créer une formation</a>
            </div>
            <div class="col-lg-2 col-sm-4">
                <a class="btn btn-danger" href="createcoursesession" role="button">Créer une session de formation</a>
            </div>
        </div>
    <%
        }
    %>
    
      <div class="form-group row">
          <div class="col-lg-4 col-sm-6"><input type="text" id="myInputForTitle" onkeyup="myNewFunction()" placeholder="Recherche par nom.." title="Type in a title"></div>
          <div class="col-lg-4 col-sm-6"><input type="text" id="myInputForDate" onkeyup="myNewFunction()" placeholder="Recherche par date de début.." title="Type in a date"></div>
          <div class="col-lg-4 col-sm-6">
                <select class="form-control" onchange="myNewFunction()" id="myInputForLocation">
                    <option value="" selected>Recherche par ville..</option>
                    <c:forEach items="${locations}" var="location">
                        <option value="${location.city.trim()}">${location.city.trim()}</option>
                    </c:forEach>
                </select>
          </div>
      </div>

        <div id="myCsDiv">
            <div class="row">
                <c:forEach items="${courseSessions}" var="courseSession">
                    <div class="col-lg-4 col-sm-6 portfolio-item sessions_list" data-title="${courseSession.courseCode.title.trim()}" data-location="${courseSession.locationId.city.trim()}" data-startdate="<fmt:formatDate value="${courseSession.startDate}" pattern="dd/MM/yyyy"/>">
                        <div class="card h-100">
                          <img class="card-img-top" src="${courseSession.image}" alt="">
                          <div class="card-body">
                            <h4 class="card-title">${courseSession.courseCode.title}</h4>
                            <p class="card-text">
                                <i>Du <fmt:formatDate value="${courseSession.startDate}" pattern="dd/MM/yyyy"/> au <fmt:formatDate value="${courseSession.endDate}" pattern="dd/MM/yyyy"/></i>
                                <br>
                                <u>Lieu</u> : ${courseSession.locationId.city}
                                <br>
                                <u>Places restantes</u> : ${courseSession.placesLibres}/${courseSession.maxi}
                            </p>
                            <p class="card-text">
                              <c:if test = "${!courseSession.placesLibres.trim().equals('0') }">
                                <a class="btn btn-success" href="registercoursesession?courseId=${courseSession.id}" role="button">Se pré-inscrire</a>
                              </c:if>
                              <c:if test = "${courseSession.placesLibres.trim().equals('0') }">
                                <a class="btn btn-secondary" role="button">Complet</a>
                              </c:if>
                              <!--
                              <c:if test = "${courseSession.placesLibres.trim().equals('0') }">
                                <a class="btn btn-warning" role="button">Inscrit</a>
                              </c:if>
                              -->
                            </p>
                          </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div> 
    </div>
    
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-5 bg-dark">
      <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; Your Website 2018</p>
      </div>
      <!-- /.container -->
    </footer>

  </body>

</html>
