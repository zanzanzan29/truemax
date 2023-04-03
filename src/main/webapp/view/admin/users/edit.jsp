<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/templates/admin/inc/header.jsp"%>
<meta charset="UTF-8">
  <div class="content-wrapper">
    <div class="container-fluid">

        <c:set var="error" value="${param.err}"/>
        <c:if test="${error == '1'}">
            <p class="errors">Edit account failed!!!</p>
        </c:if>
    <div class="row mt-3">
      <div class="col-lg-6 cachle">
         <div class="card">
           <div class="card-body">
           <div class="card-title">Edit User</div>
           <hr>
            <form action="" method="post" class="addfr">
           <div class="form-group">
            <label for="username">User Name</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="Enter the user name" value="${users.username}" disabled required>
           </div>
           <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter the password">
           </div>
            <div class="form-group">
                <label for="role">Role</label>
                <select name="role" id="role" DISABLED>
                    <option value="Customer" <c:if test="${users.role == 'Customer'}">selected</c:if>>Customer</option>
                    <option value="Producter" <c:if test="${users.role == 'Producter'}">selected</c:if>>Producter</option>
                    <option value="Admin" <c:if test="${users.role == 'Admin'}">selected</c:if>>Admin</option>
                </select>
            </div>
            <div class="form-group">
                <label for="lastname">Last Name</label>
                <input type="text" class="form-control" id="lastname" name="lastname" placeholder="Enter the last name " value="${users.lastname}" required>
            </div>
           <div class="form-group">
            <label for="firstname">First Name</label>
            <input type="text" class="form-control" id="firstname" name="firstname" placeholder="Enter the first name" value="${users.firstname}" required>
           </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter the email" value="${users.email}" required>
            </div>
            <div class="form-group">
                <label for="phonenumber">Phone</label>
                <input type="text" class="form-control" id="phonenumber" name="phonenumber" placeholder="Enter the phone" value="${users.phonenumber}" required>
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" class="form-control" id="address" name="address" placeholder="Enter the phone" value="${users.address}" required>
            </div>
           <div class="form-group">
            <button type="submit" class="btn btn-light px-5">Edit</button>
          </div>
          </form>
         </div>
         </div>
      </div>
    </div><!--End Row-->

	<!--start overlay-->
		  <div class="overlay toggle-menu"></div>
		<!--end overlay--

    </div>
    <!-- End container-fluid-->
    
   </div><!--End content-wrapper-->
   <!--Start Back To Top Button-->
    <a href="javaScript:void();" class="back-to-top"><i class="fa fa-angle-double-up"></i> </a>
    <!--End Back To Top Button-->

<%@include file="/templates/admin/inc/footer.jsp"%>