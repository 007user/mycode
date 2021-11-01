<%--
  Created by IntelliJ IDEA.
  User: 
  Date: 2020/4/28
  Time: 15:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <script src="layui/layui.js"></script>
    <script src="layui/jquery-3.3.1.min.js"></script>
    <script>
        layui.use(['table','form', 'layedit', 'laydate'], function() {
            var table = from = layui.form
                , laydate = layui.laydate
                ,layer = layui.layer
            function getType(){
                $.ajax({
                    url:"select",
                    dataType:"json",
                    success:function(res){
                        $(function () {
                            var list = res;
                            /* console.log(list)
                             console.log(list.data[0].type_id)
                             console.log(list.data[0].typer_name)*/
                            if(list.data.length>0){
                                for(var i =0;i<list.data.length;i++){
                                    console.log(8)
                                    $("#booktype").append("<option value="+res.data[i].type_id+">"+res.data[i].typer_name+"</option>");
                                }
                                //重新渲染
                                layui.form.render("select");
                            }
                        })
                    }
                });
            }
            getType();


            function getAuthor(){
                $.ajax({
                    url:"selec",
                    dataType:"json",
                    success:function(res){
                        $(function () {
                            var list = res;
                            console.log(list)
                            if(list.data.length>0){
                                for(var i =0;i<list.data.length;i++){
                                    $("#bookAuthor").append("<option value="+res.data[i].author_id+">"+res.data[i].author_name+"</option>");
                                }
                                //重新渲染
                                layui.form.render("select");
                            }
                        })
                    }
                });
            }
            getAuthor();

            laydate.render({
                elem: '#date2'
            });



            $(function () {
                $("#addbtn").click(function () {
                    var bookname = $("#booknamer").val();
                    var booktypeid = $("#bookAuthor").val();
                    var booktime = $("#date2").val();
                    var booktpice = $("#bookpices").val();
                    var bookauthorid = $("#booktype").val();
                    /*$.post('add_book',{bookname:bookname,booktypeid:booktypeid,booktime:booktime,booktpice:booktpice,bookauthorid:bookauthorid},function (msg) {
                    })*/
                    $.ajax({
                        url: 'add_book',
                        type: 'POST',
                        dataType: 'json',
                        data:{bookname:bookname,booktypeid:booktypeid,booktime:booktime,booktpice:booktpice,bookauthorid:bookauthorid},
                        success: function(res){
                            console.log(res)
                        },
                        error: function(res){
                                layer.msg('添加成功！');
                        }
                })
            })
        })
        })
    </script>
<body>
    <form class="layui-form layui-from-pane" lay-filter="databack" action="" style="margin-top:20px" >
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">书籍名称</label>
                <div class="layui-input-inline">
                    <input type="tel" id="booknamer" lay-verify="required|phone" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">书本作者</label>
                <div class="x-body layui-form" style=" width: 180px;margin-left: 110px">
                    <select  id="bookAuthor">
                        <option value="">请选择类型</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">上架时间</label>
                <div class="layui-input-inline">
                    <input type="tel"  name="booktime" id="date2" lay-verify="required|phone" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">书本价格</label>
                <div class="layui-input-inline">
                    <input type="tel" id="bookpices" name="bookpices" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-inline">
                <label class="layui-form-label">书本类型</label>
                    <div class="x-body layui-form" style=" width: 180px;margin-left: 110px">
                        <select  id="booktype">
                            <option value="">请选择类型</option>
                        </select>
                    </div>
            </div>
        </div>
        <div class="layui-form-item" style="margin-top:40px">
            <div class="layui-input-block">
                <button id="addbtn" class="layui-btn">确认添加</button>
            </div>
        </div>
    </form>
</body>
</html>
