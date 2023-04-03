<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/templates/admin/inc/header.jsp"%>
	
  <div class="content-wrapper">
    <div class="container-fluid">


        <c:set var="error" value="${param.err}"/>
        <c:if test="${error == '1'}">
            <p class="errors">Add category failed!!!</p>
        </c:if>
    <div class="row mt-3">
      <div class="col-lg-6 cachle">
         <div class="card">
           <div class="card-body">
           <div class="card-title">Add Category</div>
           <hr>
            <form method="post" action="">
           <div class="form-group">
            <label for="input-1">Category Name</label>
           <c:if test="${error == null || error.equals('1')}">
            <input type="text" class="form-control" id="input-1" name="category_name" placeholder="Enter the category name" value="${category_name}">
           </c:if>
           <c:if test="${error.equals('2')}">
               <input type="text" class="form-control" id="input-1" name="category_name" style="border: 2px solid red;" placeholder="Enter the category name" value="${category_name}">
               <p class="ersssss" id="errorMsg" style="color: red;font-size: 19px;padding-top: 10px;font-weight: bold">Category name already exists!!!</p>
           </c:if>
           </div>
           <div class="form-group">
            <button type="submit" class="btn btn-light px-5">Add</button>
          </div>
          </form>
         </div>
         </div>
      </div>
    </div><!--End Row-->

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