<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>Admin - TrustMart</title>
  <!-- loader-->
  <link href="/templates/admin/assets/css/pace.min.css" rel="stylesheet"/>
  <script src="/templates/admin/assets/js/pace.min.js"></script>
  <!--favicon-->
  <link rel="icon" href="/templates/admin/assets/images/favicon.ico" type="image/x-icon">
  <!-- Vector CSS -->
  <link href="/templates/admin/assets/plugins/vectormap/jquery-jvectormap-2.0.2.css" rel="stylesheet"/>
  <!-- simplebar CSS-->
  <link href="/templates/admin/assets/plugins/simplebar/css/simplebar.css" rel="stylesheet"/>
  <!-- Bootstrap core CSS-->
  <link href="/templates/admin/assets/css/bootstrap.min.css" rel="stylesheet"/>
  <!-- animate CSS-->
  <link href="/templates/admin/assets/css/animate.css" rel="stylesheet" type="text/css"/>
  <!-- Icons CSS-->
  <link href="/templates/admin/assets/css/icons.css" rel="stylesheet" type="text/css"/>
  <!-- Sidebar CSS-->
  <link href="/templates/admin/assets/css/sidebar-menu.css" rel="stylesheet"/>
  <!-- Custom Style-->
  <link href="/templates/admin/assets/css/app-style.css" rel="stylesheet"/>
  <link href="/templates/admin/assets/css/style.css" rel="stylesheet" />

</head>

<body class="bg-theme bg-theme1">

<!-- Start wrapper-->
<div id="wrapper">

  <!--Start sidebar-wrapper-->
  <div id="sidebar-wrapper" data-simplebar="" data-simplebar-auto-hide="true">
    <div class="brand-logo">
      <a href="index.jsp">
        <img src="/templates/admin/assets/images/logo-icon.png" class="logo-icon" alt="logo icon">
        <h5 class="logo-text">Admin - TrueMart</h5>
      </a>
    </div>
    <ul class="sidebar-menu do-nicescrol">
      <li class="sidebar-header">Welcome!!!!</li>
      <li>
        <a href="/admin">
          <i class="zmdi zmdi-view-dashboard"></i> <span>Home</span>
        </a>
      </li>
      <li>
        <a href="/admin/users">
          <i class="zmdi zmdi-odnoklassniki"></i> <span>User</span>
        </a>
      </li>
      <li>
        <a href="/admin/shop">
          <i class="zmdi zmdi-assignment-check"></i> <span>Shop</span>
        </a>
      </li>
      <li>
        <a href="">
          <i class="zmdi zmdi-assignment-check"></i> <span>Bill</span>
        </a>
      </li>
      <li>
        <a href="/admin/contact">
          <i class="zmdi zmdi-outlook"></i> <span>Contact</span>
        </a>
      </li>
      <li class="drpr">
        <a class="" data-toggle="collapse" href="#products" aria-expanded="true">
          <i class="zmdi zmdi-battery-flash"></i> <span>Product</span>
        </a>
        <ul class="products in" id="products" aria-expanded="true">
          <li>
            <a href="/admin/category">
              <i class="zmdi zmdi-group"></i> <span>Category</span>
            </a>
          </li>
          <li>
            <a href="/admin/product">
              <i class="zmdi zmdi-flattr"></i> <span>Product Details</span>
            </a>
          </li>
          <li>
            <a href="/admin/review">
              <i class="zmdi zmdi-assignment-o"></i> <span>Product Review</span>
            </a>
          </li>
        </ul>
      </li>


    </ul>

  </div>
  <!--End sidebar-wrapper-->

  <!--Start topbar header-->
  <header class="topbar-nav">
    <nav class="navbar navbar-expand fixed-top">
      <ul class="navbar-nav mr-auto align-items-center">
        <li class="nav-item">
          <a class="nav-link toggle-menu" href="javascript:void();">
            <i class="icon-menu menu-icon"></i>
          </a>
        </li>
        <li class="nav-item">
          <form class="search-bar" id="seachtt" action="" method="post">
            <input type="text" name="search" class="form-control" placeholder="Enter keywords">
            <a href=""><i class="icon-magnifier"></i></a>
          </form>
        </li>
      </ul>

      <ul class="navbar-nav align-items-center right-nav-link">
        <li class="nav-item dropdown-lg">
          <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();">
            <i class="fa fa-envelope-open-o"></i></a>
        </li>
        <li class="nav-item dropdown-lg">
          <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();">
            <i class="fa fa-bell-o"></i></a>
        </li>
        <li class="nav-item language">
          <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();"><i class="fa fa-flag"></i></a>
          <ul class="dropdown-menu dropdown-menu-right">
            <li class="dropdown-item"> <i class="flag-icon flag-icon-gb mr-2"></i> English</li>
            <li class="dropdown-item"> <i class="flag-icon flag-icon-fr mr-2"></i> French</li>
            <li class="dropdown-item"> <i class="flag-icon flag-icon-cn mr-2"></i> Chinese</li>
            <li class="dropdown-item"> <i class="flag-icon flag-icon-de mr-2"></i> German</li>
          </ul>
        </li>
        <c:if test="${UserLogin != null}">
        <li class="nav-item">
          <a class="nav-link dropdown-toggle dropdown-toggle-nocaret" data-toggle="dropdown" href="#">
            <span class="user-profile"><img src="https://via.placeholder.com/110x110" class="img-circle" alt="user avatar"></span>
          </a>
          <ul class="dropdown-menu dropdown-menu-right">
            <li class="dropdown-item user-details">
              <a href="javaScript:void();">
                <div class="media">
                  <div class="avatar"><img class="align-self-start mr-3" src="https://via.placeholder.com/110x110" alt="user avatar"></div>
                  <div class="media-body">
                    <h6 class="mt-2 user-title">${UserLogin.username}</h6>
                    <p class="user-subtitle">${UserLogin.email}</p>
                  </div>
                </div>
              </a>
            </li>
            <li class="dropdown-divider"></li>
            <li class="dropdown-item"><i class="icon-envelope mr-2"></i> Message</li>
            <li class="dropdown-divider"></li>
            <li class="dropdown-item"><i class="icon-wallet mr-2"></i> Account</li>
            <li class="dropdown-divider"></li>
            <li class="dropdown-item"><i class="icon-settings mr-2"></i> Setting</li>
            <li class="dropdown-divider"></li>
            <li class="dropdown-item"><i class="icon-power mr-2"></i><a href="/admin/auth?actionUser=logout">Log out</a> </li>
          </ul>
        </li>
        </c:if>
        <c:if test="${UserLogin == null}">
          <li class="nav-item">
            <a href="/admin/auth">
              Đăng Nhập
            </a>
          </li>
        </c:if>
      </ul>
    </nav>
  </header>
  <!--End topbar header-->

  <div class="clearfix"></div>
