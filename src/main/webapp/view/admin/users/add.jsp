<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/templates/admin/inc/header.jsp"%>
<meta charset="UTF-8">
  <div class="content-wrapper">
    <div class="container-fluid">

        <c:set var="error" value="${param.err}"/>
        <c:if test="${error == '1'}">
            <p class="errors">Add account failed!!!</p>
        </c:if>
    <div class="row mt-3">
      <div class="col-lg-6 cachle">
         <div class="card">
           <div class="card-body">
           <div class="card-title">Add User</div>
           <hr>
            <form action="" method="post" class="addfr" name="addfr">
           <div class="form-group">
            <label for="username">User Name</label>
               <c:if test="${error == '2'}">
                   <input type="text" class="form-control" id="username" name="username" style="border: 2px solid red;" placeholder="Enter the user name" value="${users.username}" required onclick="removeStyle(this)">
                   <p class="ersssss" id="errorMsg" style="color: red;font-size: 19px;padding-top: 10px;font-weight: bold">Username already exists!!!</p>
               </c:if>
               <c:if test="${error == null || error == 1}">
                   <input type="text" class="form-control" id="username" name="username" placeholder="Enter the user name" value="${users.username}" required>
               </c:if>

           </div>
           <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter the password" required>
           </div>
            <div class="form-group">
                <label for="role">Role</label>
                <select name="role" id="role">
                    <option value="Customer" <c:if test="${users.role == 'Customer'}">selected</c:if>>Customer</option>
                    <option value="Producter" <c:if test="${users.role == 'Producter'}">selected</c:if>>Producter</option>
                    <option value="Admin" <c:if test="${users.role == 'Admin'}">selected</c:if>>Admin</option>
                </select>
            </div>
            <div class="form-group">
                <label for="lastname">Last Name</label>
                <input type="text" class="form-control" id="lastname" name="lastname" placeholder="Enter the last name " value="${users.lastname}" required >
            </div>
           <div class="form-group">
            <label for="firstname">First Name</label>
            <input type="text" class="form-control" id="firstname" name="firstname" placeholder="Enter the first name" value="${users.firstname}" required >
           </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter the email" value="${users.email}" required >
            </div>
            <div class="form-group">
                <label for="phonenumber">Phone</label>
                <input type="text" class="form-control" id="phonenumber" name="phonenumber" placeholder="Enter the phone" value="${users.phonenumber}" required>
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" class="form-control" id="address" name="address" placeholder="Enter the phone" value="${users.address}" required >
            </div>
           <div class="form-group">
            <button type="submit" class="btn btn-light px-5" id="submitadd" >Add</button>
          </div>
          </form>
         </div>
         </div>
      </div>
    </div><!--End Row-->

<script>
    function removeStyle(element) {
        element.removeAttribute('style');
        document.getElementById('errorMsg').style.display = 'none';
    }

</script>




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