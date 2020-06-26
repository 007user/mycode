<%--
  Created by IntelliJ IDEA.
  User: 小白
  Date: 2020/5/15
  Time: 22:57
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

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <script>
        layui.use(['table','form', 'layedit', 'laydate'], function(){
            var table = layui.table
                ,from = layui.form
                ,laypage = layui.laypage //分页
                ,layer = layui.layer //弹层
                ,element = layui.element //元素操作
                ,laydate = layui.laydate

            function getClassify(){
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
                                    $("#booktype").append("<option value="+res.data[i].typer_name+">"+res.data[i].typer_name+"</option>");
                                }
                                //重新渲染
                                layui.form.render("select");
                            }
                        })
                    }
                });
            }

            getClassify();


            /*下面是书籍编辑的方法*/
            //给表单赋值的方法
            function a(a,b,c,d,e) {
                from.val("databack", { //formTest 即 class="layui-form" 所在元素属性 lay-filter="" 对应的值
                    "booknamer": a // "name": "value"
                    ,"bookauthorr": b
                    ,"booktime":c
                    ,"bookpices": d
                    ,"booktype": e
                });
            }
            function setFormValue(data,obj){
                console.log(obj)
                a(obj.book_name,obj.author.author_name,obj.book_time,obj.book_pice,obj.type.typer_name);
                $("#updatabtn").click(function () {
                    var time = $("#date2").val();
                    var pices = $("#bookpices").val();
                    console.log(time)
                    console.log(pices)
                    $.post('updataBook',{time:time,pices:pices,id:obj.book_id},function (msg) {
                        if('true'== msg){
                            alert("修改成功！")
                        }else {
                            alert("修改失败！")
                        }
                    })
                })
            }

            //日期
            laydate.render({
                elem: '#date'
            });
            laydate.render({
                elem: '#date1'
            });
            laydate.render({
                elem: '#date2'
            });

            table.render({
                elem: '#demo'
                ,url: 'bookAll' //数据接口
                ,title: '用户表'
                ,toolbar:'default'
                ,page: true //开启分页
                ,limits: [10,15]
                ,limit:15
                ,totalRow: true //开启合计行
                ,cols: [[ //表头
                    {type: 'checkbox', fixed: 'left'},
                    {field: 'book_id', title: '编号',fixed: 'left',sort:'true',align: 'center'}
                    ,{field: 'book_name', title: '书名', align: 'center'}
                    ,{templet: '<div>{{createrFormat(d.author.author_name)}}</div>', align: 'center', title: '书本作者'}
                    ,{field: 'book_time', title: '上架时间',align: 'center'},
                    ,{field: 'book_pice', title: '价格', align: 'center'},
                    ,{templet: '<div>{{createrFormat(d.type.typer_name)}}</div>',width:100, align: 'center', title: '书本类型'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:250, align: 'center'}
                ]]
            });

            /*操作工具*/
            function tool(barname) {
                table.on(barname, function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                    var data = obj.data //获得当前行数据
                        ,layEvent = obj.event; //获得 lay-event 对应的值
                    var a = table.checkStatus('demo')//获取表中格中选的据数，dome为表格的id值
                    switch(layEvent){
                        case 'detail':
                            layer.msg('查看操作');
                            break;
                        case 'edit':
                            layer.open({
                                type: 1,
                                title: "修改书本信息",
                                area: ['440px', '500px'],
                                content:$("#popUpdateTest"),
                            });
                            setFormValue(obj,data);
                            break;
                        case 'delete':
                            if(a.data.length <= 0){
                                layer.msg('请选择数据');
                            }else {
                                layer.confirm('真的删除行么', function(index){
                                    //layui中找到CheckBox所在的行，并遍历找到行的顺序
                                    $("div.layui-table-body table tbody input[name='layTableCheckbox']:checked").each(function () { // 遍历选中的checkbox
                                        n = $(this).parents("tbody tr").index();  // 获取checkbox所在行的顺序
                                        //移除行
                                        $("div.layui-table-body table tbody ").find("tr:eq(" + n + ")").remove();
                                        //如果是全选移除，就将全选CheckBox还原为未选中状态
                                        $("div.layui-table-header table thead div.layui-unselect.layui-form-checkbox").removeClass("layui-form-checked");
                                    });
                                    layer.close(index);
                                    var array = new Array();
                                    for (var i = 0;i<a.data.length;i++){
                                        array.push(a.data[i].book_id);
                                    }
                                    $(function () {
                                        $.post("delbook",{id:array.toString()},function (msg) {
                                            if('true' == msg){
                                                layer.msg("删除成功！")
                                            }
                                        })
                                    })
                                })
                            }
                            break;
                        case 'del':
                            layer.confirm('真的删除行么', function(index){
                                obj.del();
                                layer.close(index);
                                $(function () {
                                    $.post("delbook",{id:data.book_id},function (msg) {
                                        console.log(msg)
                                        if('true' == msg){
                                            layer.msg("删除成功！")
                                        }
                                    })
                                })
                            })
                            break;
                        case 'detail':
                            layer.msg('查看操作');
                            break;
                    }
                });
            }
            //监听行工具事件右边
            tool('tool(test)');
            /*监听行工具事件表格上面*/
            tool('toolbar(test)');
        });

        function createrFormat(o){
            return o;
        }

        $(function () {
            function t(url,bookname,bookauthor,booktype,btm,atm){
                var table = layui.table
                table.render({
                    elem: '#demo'
                    ,url: 'bookAll?bookname='+bookname+'&'+'bookauthor='+bookauthor+'&'+'bookauthor='+bookauthor+'&'+'booktype='+booktype+'&'+'btm='+btm+'&'+'atm='+atm //数据接口
                    ,title: '用户表'
                    ,page: true //开启分页
                    ,limits: [10,15]
                    ,limit:15
                    ,toolbar:'default'
                    ,totalRow: true //开启合计行
                    ,cols: [[ //表头
                        {type: 'checkbox', fixed: 'left'},
                        {field: 'book_id', title: '编号',fixed: 'left',sort:'true',align: 'center'}
                        ,{field: 'book_name', title: '书名', align: 'center'}
                        ,{templet: '<div>{{createrFormat(d.author.author_name)}}</div>', align: 'center', title: '书本作者'}
                        ,{field: 'book_time', title: '上架时间',align: 'center'},
                        ,{field: 'book_pice', title: '价格', align: 'center'},
                        ,{templet: '<div>{{createrFormat(d.type.typer_name)}}</div>',width:100, align: 'center', title: '书本类型'}
                        ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:250, align: 'center'}
                    ]]
                });
            }

            $("#search").click(function () {
                var bookname =  $("#bookname").val();
                var bookauthor =  $("#bookauthor").val();
                var booktype =  $("#booktype").val();
                console.log(booktype)
                var btm =  $("#date").val();
                var atm =  $("#date1").val();
                t('bookAll',bookname,bookauthor,booktype,btm,atm);
            })
        });
    </script>
</head>
<body>

<form class="layui-form" action="" >
    <div class="layui-form-item">
        <div class="layui-inline">
            <div class="layui-input-inline">
                <input type="tel" id="bookname"  autocomplete="off" class="layui-input" placeholder="书名">
            </div>
            <div class="layui-input-inline">
                <input type="tel" id="bookauthor"  autocomplete="off" class="layui-input" placeholder="作者">
            </div>
            <div class="layui-input-inline">
                <div class="x-body layui-form" style=" width: 180px">
                    <select  id="booktype">
                        <option value="">请选择类型</option>
                    </select>
                </div>
            </div>
            <%--<div class="layui-input-inline">
                <input type="tel" id="booktype"  autocomplete="off" class="layui-input" placeholder="类型">
            </div>--%>
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input type="text"  name="date" id="date" lay-verify="date" autocomplete="off" class="layui-input" placeholder="开始日期">
                </div>
            </div>
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input type="text"  name="date1" id="date1" lay-verify="date" autocomplete="off" class="layui-input" placeholder="结束日期">
                </div>
            </div>
            <button id="search" type="button" class="layui-btn layui-btn-normal"><i class="layui-icon">&#xe615;</i></button>
        </div>
    </div>
</form>
<table id="demo" lay-filter="test"></table>

<div class="layui-row" id="popUpdateTest" style="display:none;">
    <form class="layui-form layui-from-pane" lay-filter="databack" action="" style="margin-top:20px" >
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">书籍名称</label>
                <div class="layui-input-inline">
                    <input type="tel" name="booknamer" lay-verify="required|phone" autocomplete="off" class="layui-input" disabled="">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">书本作者</label>
                <div class="layui-input-inline">
                    <input type="tel" name="bookauthorr" lay-verify="required|phone" autocomplete="off" class="layui-input" disabled="">
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
            <div class="layui-inline">
                <label class="layui-form-label">书本类型</label>
                <div class="layui-input-inline">
                    <input type="tel" name="booktype" lay-verify="required|phone" autocomplete="off" class="layui-input" disabled="">
                </div>
            </div>
        </div>
        <div class="layui-form-item" style="margin-top:40px">
            <div class="layui-input-block">
                <button id="updatabtn" class="layui-btn">确认修改</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>

