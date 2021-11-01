<%--
  Created by IntelliJ IDEA.
  User: 
  Date: 2020/6/6
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="utf-8">--%>
<%--    <title>第一个 ECharts 实例</title>--%>
<%--    <!-- 引入 echarts.js -->--%>
<%--    <script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>--%>
<%--</head>--%>
<%--<body>--%>
<%--<!-- 为ECharts准备一个具备大小（宽高）的Dom -->--%>
<%--<div id="main" style="width: 600px;height:400px;"></div>--%>
<%--<script type="text/javascript">--%>
<%--    // 基于准备好的dom，初始化echarts实例--%>
<%--    var myChart = echarts.init(document.getElementById('main'));--%>

<%--    // 指定图表的配置项和数据--%>
<%--    var option = {--%>
<%--        title: {--%>
<%--            text: '第一个 ECharts 实例'--%>
<%--        },--%>
<%--        tooltip: {},--%>
<%--        legend: {--%>
<%--            data:['销量']--%>
<%--        },--%>
<%--        xAxis: {--%>
<%--            data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]--%>
<%--        },--%>
<%--        yAxis: {},--%>
<%--        series: [{--%>
<%--            name: '销量',--%>
<%--            type: 'bar',--%>
<%--            data: [5, 20, 36, 10, 10, 20]--%>
<%--        }]--%>
<%--    };--%>

<%--    // 使用刚指定的配置项和数据显示图表。--%>
<%--    myChart.setOption(option);--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>


<html>
<head>
    <title>详细数据</title>
    <script src="layui/echarts.min.js"></script>
    <script src="layui/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            $.ajax({
                url: 'info',
                type: 'POST',
                dataType: 'json',
                success: function(res){
                    var das =  res.data;//总数据的数组
                    console.log(das.length)
                    var nums = new Array();//数量的数组
                    var type = new Array();//类型的数组
                    for(var i = 0 ; i < das.length ; i++){
                        nums.push(das[i].type_id)
                        type.push(das[i].typer_name)
                    }
                    console.log(nums)
                    console.log(type)
                    putinfo(type,nums)
                },
                error: function(res){
                    alert("错误！")
                }
            });

            function putinfo(typeName,typeNum) {
                // 基于准备好的dom，初始化echarts实例
                var myChart = echarts.init(document.getElementById('main'));
                // 指定图表的配置项和数据
                var option = {
                    title: {
                        text: '统计图'
                    },
                    tooltip: {},
                    legend: {
                        data:['数量']
                    },
                    xAxis: {
                        data: typeName
                    },
                    yAxis: {},
                    series: [{
                        name: '数量',
                        type: 'bar',
                        data: typeNum
                    }]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
            }
        })
    </script>
</head>
<body>

<div id="main" style="height:400px"></div>
</body>
</html>

