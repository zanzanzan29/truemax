
<!--Start footer-->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--Start footer-->
<script>

    // Get Confirm Dialog
    const confirmDialog = document.getElementById('confirm-dialog');

    // Get OK Button
    const confirmOk = document.getElementById('confirm-ok');

    // Get Cancel Button
    const confirmCancel = document.getElementById('confirm-cancel');

    // Get Delete Links
    const deleteLinks = document.querySelectorAll('.xoa');

    // Confirm Delete Function
    const confirmDelete = (event) => {
        // Show Confirm Dialog
        confirmDialog.style.display = 'block';

        // Prevent Default Action
        event.preventDefault();

        // Get URL from Link
        const url = event.target.href;

        // Add Click Listener to OK Button
        confirmOk.addEventListener('click', () => {
            // Redirect to URL
            window.location.href = url;
        });

        // Add Click Listener to Cancel Button
        confirmCancel.addEventListener('click', () => {
            // Hide Confirm Dialog
            confirmDialog.style.display = 'none';
        });
    };

    // Add Click Listener to Delete Links
    deleteLinks.forEach((deleteLink) => {
        deleteLink.addEventListener('click', confirmDelete);
    });
</script>
<footer class="footer">
    <div class="container">
        <div class="text-center">
            Copyright © 2023 CodeGym
        </div>
    </div>
</footer>
<!--End footer-->

<!--start color switcher-->
<div class="right-sidebar">
    <div class="switcher-icon">
        <i class="zmdi zmdi-settings zmdi-hc-spin"></i>
    </div>
    <div class="right-sidebar-content">

        <p class="mb-0">Gaussion Texture</p>
        <hr>

        <ul class="switcher">
            <li id="theme1"></li>
            <li id="theme2"></li>
            <li id="theme3"></li>
            <li id="theme4"></li>
            <li id="theme5"></li>
            <li id="theme6"></li>
        </ul>

        <p class="mb-0">Gradient Background</p>
        <hr>

        <ul class="switcher">
            <li id="theme7"></li>
            <li id="theme8"></li>
            <li id="theme9"></li>
            <li id="theme10"></li>
            <li id="theme11"></li>
            <li id="theme12"></li>
            <li id="theme13"></li>
            <li id="theme14"></li>
            <li id="theme15"></li>
        </ul>

    </div>
</div>
<!--end color switcher-->

</div><!--End wrapper-->

<!-- Bootstrap core JavaScript-->
<script src="/templates/admin/assets/js/jquery.min.js"></script>
<script src="/templates/admin/assets/js/popper.min.js"></script>
<script src="/templates/admin/assets/js/bootstrap.min.js"></script>

<!-- simplebar js -->
<script src="/templates/admin/assets/plugins/simplebar/js/simplebar.js"></script>
<!-- sidebar-menu js -->
<script src="/templates/admin/assets/js/sidebar-menu.js"></script>
<!-- loader scripts -->
<script src="/templates/admin/assets/js/jquery.loading-indicator.js"></script>
<!-- Custom scripts -->
<script src="/templates/admin/assets/js/app-script.js"></script>
<!-- Chart js -->

<script src="/templates/admin/assets/plugins/Chart.js/Chart.min.js"></script>

<!-- Index js -->
<script src="/templates/admin/assets/js/index.js"></script>


</body>
</html>
