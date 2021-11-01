<%@ page import="static com.sun.xml.internal.ws.api.message.Packet.Status.Request" %><%--
  Created by IntelliJ IDEA.
  User: 
  Date: 2020/4/28
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>登录页</title>
    <link rel="stylesheet" href="layui/login.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/jquery-3.3.1.min.js"></script>
    <script>

        $(function () {
            $("#codeImg").click(function () {
                var path = "http://localhost:8080/code?"+new Date().getUTCMilliseconds();
                $("#codeImg").attr('src',path);
                console.log(path)
            })

            $("#btn").click(function () {
                var uname = $("#uname").val().trim();
                var upwd = $("#upassword").val().trim();
                var code = $("#code").val().trim();

                var checkSubmit = false;
                $("#result").html("")
                if (uname == "") {
                    $("#result").html("用戶名不能空");
                    checkSubmit = false;
                } else if (upwd == "") {
                    $("#result").html("密码不能为空");
                    checkSubmit = false;
                } else if(code == ""){
                    $("#result").html("验证码不能空");
                    checkSubmit = false;
                } else {
                    checkSubmit = true;
                }

                if((checkSubmit) ){
                    $.post("login",{uname:uname,upwd:upwd,code:code},function (msg) {
                        if ("true" == msg){
                            location.href = "index.jsp";
                        }else {
                            location.href = "login.jsp";
                        }
                    })
                }
            })
        })
    </script>
</head>
<body>
<div class="form-box">
    <div id="result" style="margin-left: 85px; color: red;">${msg}</div>
    <form method="post" name="from">
        <div class="item">
            <label for="uname">账号：</label>
            <input type="text" name="uname" id="uname" autofocus="autofocus" class="userinfo" placeholder="请输入您的账号" value="">
        </div>
        <div class="item">
            <label for="upassword">密码：</label>
            <input type="password" name="upassword" id="upassword" class="userinfo" placeholder="请输入您的密码" value="">
        </div>
        <div class="item">
            <label for="code">code：</label>
            <input type="text" name="code" id="code" class="userinfo" placeholder="请输入code" value="">
        </div>
        <img src="http://localhost:8080/code" id="codeImg">
        <div class="item">
            <input type="button" id="btn" value="登陆" class="layui-btn btn">
            <input type="reset" value="重置" class="layui-btn btn">
        </div>
    </form>
</div>
<script src="layui/login.js"></script>
<script src="layui/layui.js"></script>
</body>
</html>
