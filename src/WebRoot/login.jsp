<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/taglibs.jsp"%>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
	<link rel="shortcut icon" href="${base}/frame/media/image/favicon.ico" type="image/x-icon" />
    <title>数据展示后台</title>
    <!-- Bootstrap core CSS -->
    <link href="${base}/frame/media/css/bootstrap2.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${base}/frame/media/css/signin.css" rel="stylesheet">
  </head>

  <body>

    <div class="container">
      <form class="form-signin" action="${base}/login/enter.gfan" method="post">
        <h2 class="form-signin-heading" style="text-align:center">数据展示后台登陆</h2>
        <br>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="email" id="inputEmail" name="userName" class="form-control" placeholder="Email address" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Password" required>
        <c:if test="${msg!=null}">
	        <div class="alert alert-danger" role="alert">${msg}</div>
        </c:if>
        <c:if test="${msg==null}">
	        <br>
        </c:if>
        <button class="btn btn-lg btn-primary btn-block" type="submit">登陆</button>
      </form>
    </div>

  </body>
</html>
