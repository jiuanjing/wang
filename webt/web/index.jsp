<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>登陆</title>
    <script>
//        var isSubmit = false;
        function checkPost() {
            var name =document.getElementById('name').value;
            var url = 'hello.jsp?name='+name;
            url = encodeURI(url);
            console.log(url);
            window.location.href = url;
//            if (!isSubmit) {
//                isSubmit = true;
//                return isSubmit;
//            } else {
//                alert("请不要重复提交");
//                return false;
//            }
        }
    </script>
    <style>
        .user {
            margin: 30px;
            height: 20px;
            width: 100px;
        }

        .sub {
            margin-left: 30px;
        }

        h2 {
            margin-left: 30px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
<h2>欢迎登陆</h2>
<div class="form">
    <form action="" method="get">
        <div class="username user"><label>
            姓名:<input type="text" name="name" id="name">
        </label></div>
        <div class="password user">
            <label>
                密码:<input type="password" name="password">
            </label></div>
        <div class="btn sub">
            <input type="button" value="提交" onclick="checkPost()"></div>
    </form>
</div>
</body>
</html>
