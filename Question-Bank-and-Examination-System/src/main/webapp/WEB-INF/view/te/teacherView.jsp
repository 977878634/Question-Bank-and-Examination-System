<%--
  Created by IntelliJ IDEA.
  User: shan
  Date: 18.6.7
  Time: 11:23
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>教师主页</title>
    <link rel="stylesheet"  href="/static/css/TeacherView.css">
    <link rel="stylesheet" href="/static/lib/font-awesome-4.7.0/css/font-awesome.min.css" >
    <link rel="stylesheet" href="/static/lib/bootstrap-3.3.7-dist/css/bootstrap.css" >
    <script src="/static/lib/jquery/jquery-3.2.1.min.js"></script>
    <script src="/static/lib/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>

<%@ include file="../head.jsp" %>

<div class="container">
    <div class="row clearfix">
        <!-- 左侧 -->
        <div class="col-md-3 column">
            <div class="introduce">
                <div class="introduce_bg">
                    <div class="circle_img">
                        <c:choose>
                            <c:when test="${user.img == null || user.img == ''}">
                                <img id="headImg" class="circle_img" src="/static/img/teacher.png"/>
                            </c:when>
                            <c:otherwise>
                                <img id="headImg" class="circle_img" src="${user.img}"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="name"><span>${user.name}</span></div>
                    <div class="edit">
                        <a href="/info" style="color: black;">
                            <i class="fa fa-pencil-square-o fa-lg" aria-hidden="true"></i>
                            <span>个人中心</span>
                        </a>
                    </div>
                </div>
            </div>
            <a href="/te/course/add">
                <div class="new_btn">新建课程</div>
            </a>
            <a href="/download?filename=题库导入题目模板.zip">
                <div class="new_btn">题库导入题目模板</div>
            </a>
            <a href="/download?filename=班级导入学生模板.txt">
                <div class="new_btn">班级导入学生模板</div>
            </a>
        </div>
        <!-- 右侧 -->
        <div class="col-md-9 column">
            <!-- 上部分 -->
            <div class="up">
                <shiro:hasRole name="student">
                    <div class="up_left" style="background: white; color: black" href="/st">
                        <a style="color: black;text-decoration: none" href="/st">我学的课</a>
                    </div>
                    <div class="line"><span style="color: lightgray">|</span></div>
                </shiro:hasRole>
                <div class="up_right" style="background: #5CB85C ;color: white" href="/te">
                    <a style="color: #ffffff;text-decoration: none" href="/te">我教的课</a>
                </div>
            </div>
            <!-- 下部分 -->
            <!-- 左 中 右 -->
            <c:forEach items="${courseList}" var="course" varStatus="status">
                <div class="item">
                    <div class="item_up">
                        <c:choose>
                            <c:when test="${course.img == null || course.img ==''}">
                                <img class="child_item" src="/static/img/course.jpg" alt="">
                            </c:when>
                            <c:otherwise>
                                <img class="child_item" src="${course.img}" alt="">
                            </c:otherwise>
                        </c:choose>

                    </div>
                    <div class="item_down">
                        <div class="class_name"><h4>课程名称：${course.name}</h4>
                        </div>
                        <div class="class_intro"><span>课程简介：${course.introduce}</span>
                        </div>
                        <div class="delete_btn" style="margin-top: 3px">
                            <a href="/te/course?id=${course.id}" class="btn btn-primary">查看 </a>
                            <button  class="btn btn-danger" onclick="deleteClass(${course.id})">删除 </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<script src="/static/lib/layer-v3.1.1/layer/layer.js"></script>
<script>
    function deleteClass(id)
    {
        event.stopPropagation();
        layer.confirm('你确定要删除这门课程吗？', {
            btn: ['确定','取消']
        }, function(){
            //删除试卷
            $.ajax({
                url:'/te/course/delete',
                type:'POST',
                data:{
                    "id":id,
                },
                timeout:5000,
//    		    dataType:'json',
                success:function(data){
                    layer.msg(data.toString());
                    window.location.reload();
                },
                error:function(){
                    layer.msg("数据出现错误");
                }
            });

        }, function(){

        });
    }
</script>
</body>
</html>
