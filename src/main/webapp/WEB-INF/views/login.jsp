<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%--<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AdminLTE 3 | Log in (v2)</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/fontawesome-free/css/all.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/adminlte/css/adminlte.min.css">

    <script>
        function init() {

        }
    </script>
</head>
<body class="hold-transition login-page" onload="init()">
<div class="login-box">
    <!-- /.login-logo -->
    <div class="card card-outline card-primary">
        <div class="card-header text-center">
            <a href="../../index2.html" class="h1"><b>Admin</b>LTE</a>
        </div>
        <div class="card-body">
            <p class="login-box-msg">欢迎登录</p>

        <%--<form action="${pageContext.request.contextPath}/login" method="post">--%>
                <div class="input-group mb-3">
                    <input name="username" id="username" type="text" class="form-control" placeholder="账号">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-user"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <input name="password" id="password" type="password" class="form-control" placeholder="密码">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <!-- /.col -->
                    <div class="col-12">
                        <button id="loginBtn" type="submit" class="btn btn-primary btn-block">登录</button>
                    </div>
                    <!-- /.col -->
                </div>
            <%--</form>--%>

        </div>
        <!-- /.card-body -->
    </div>
    <!-- /.card -->
</div>
<!-- /.login-box -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/assets/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/assets/adminlte/js/adminlte.min.js"></script>
<script>
    $(function () {
        var ctx = "${pageContext.request.contextPath}";
        $("#loginBtn").on("click",function () {
            $.ajax({
                // type,指定http请求方法，如：get、post
                type: ctx + "post",
                // url，后端服务端口
                url: ctx + "/login",
                // async，true，表示异步（默认），false，表示同步
                async: false,
                // data，参数（一般是JSON格式）
                data: {
                    username: $("#username").val(),
                    password: $("#password").val(),
                }
            }).done(function (res) {
                // 处理响应式结果
                if (res && res.status == 200){
                    // 成功,跳转到首页
                    window.location.href = ctx + "/";
                } else {
                    // 失败
                    $(".login-box-msg").html("<span style='color: red'>" + res.message + "</span>");
                }
            }).fail(function () {
                $(".login-box-msg").html("<span style='color: red'>请求失败</span>");
            })
        });
    })
</script>

</body>
</html>

