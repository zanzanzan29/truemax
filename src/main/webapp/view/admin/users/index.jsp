<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/templates/admin/inc/header.jsp"%>
	
  <div class="content-wrapper">
    <div class="container-fluid">
     
     

        <c:set var="success" value="${param.msg}"/>
        <c:set var="error" value="${param.err}"/>
        <c:if test="${success == '1'}">
            <p class="success">Add user successfully.</p>
        </c:if>
        <c:if test="${success == '2'}">
            <p class="success">Edit user successfully.</p>
        </c:if>
        <c:if test="${success == '3'}">
            <p class="success">Delete user successfully.</p>
        </c:if>
        <c:if test="${error == '1'}">
            <p class="errors">Id does not exist!!!</p>
        </c:if>
        <c:if test="${error == '2'}">
            <p class="errors">Delete account failed!!!</p>
        </c:if>

      <div class="row">
        <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Users</h5>
                <c:if test="${UserLogin.role == 'Admin'}">
                    <a href="/admin/users?actionUser=creat" class="them"><i class="zmdi zmdi-account-add"></i> Add</a>
                </c:if>
			  <div class="table-responsive khoangcach">
               <table class="table table-striped">
                  <thead>
                    <tr>
                      <th scope="col">#</th>
                      <th scope="col">User Name</th>
                      <th scope="col">Full Name</th>
                      <th scope="col">Role</th>
                      <th scope="col">Function</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:forEach var="users" items="${usersList}">
                    <tr>
                      <th scope="row">${users.id}</th>
                      <td>${users.username}</td>
                      <td>${users.lastname} ${users.firstname}</td>
                      <td>${users.role}</td>
                      <td>
                          <c:if test="${UserLogin.role == 'Admin'}">
                              <a href="/admin/users?actionUser=edit&&id=${users.id}" class="sua"><i class="zmdi zmdi-brush"></i> Edit</a>
                              <c:if test="${users.role != 'Admin'}">
                                <a href="/admin/users?actionUser=del&&id=${users.id}" class="xoa" onclick="return confirmDelete();"><i class="zmdi zmdi-block"></i> Delete</a>
                              </c:if>
                          </c:if>
                          <c:if test="${UserLogin.role != 'Admin'}">
                                <c:if test="${UserLogin.id == users.id}">
                                    <a href="/admin/users?actionUser=edit&&id=${users.id}" class="sua"><i class="zmdi zmdi-brush"></i> Edit</a>
                                </c:if>
                          </c:if>
                      </td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
            </div>
            </div>
          </div>
        </div>
      </div><!--End Row-->
        <!-- Add Confirm Dialog -->
        <div id="confirm-dialog" class="confirm-dialog">
            <div>
            <p>Are you sure you want to delete this contact?</p>
            <button id="confirm-ok" class="confirm-ok">OK</button>
            <button id="confirm-cancel" class="confirm-cancel">Cancel</button>
            </div>
        </div>

        <div class="confirm-dialog-open">

        </div>


	  <!--start overlay-->
		  <div class="overlay toggle-menu"></div>
		<!--end overlay-->

    </div>
    <!-- End container-fluid-->
    
    </div><!--End content-wrapper-->
   <!--Start Back To Top Button-->
    <a href="javaScript:void();" class="back-to-top"><i class="fa fa-angle-double-up"></i> </a>
    <!--End Back To Top Button-->


<%@include file="/templates/admin/inc/footer.jsp"%>