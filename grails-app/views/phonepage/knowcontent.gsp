<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1">
    <link href="${resource(dir: 'css', file: 'bootstrap.min.css')}" rel="stylesheet">
    <link href="${resource(dir: 'assets/font-awesome/css', file: 'font-awesome.css')}" rel="stylesheet">

    <style rel="stylesheet">
    *{margin:0;padding:0;}
    a{text-decoration: none;}
    a:hover{text-decoration: none;cursor: pointer;}
    body{width:100%;height:200px;}
    .header-1{color:#fff;font-size: 20px;width:100%;height:40px;background-color:#03a9f5;border-shadow:3px 1px 3px #000;-webkit-box-shadow:0 1px 3px #b4b4b4;z-index:100;position:relative; }
    .header-1 a{color:#fff;display:inline-block;font-size: 20px;line-height: 40px;position:absolute;top:0px;left:20px;}
    .header-1 span{margin:0 auto;display: inline-block;width:100%;height:40px;text-align: center;line-height: 40px;}
    .nav-1{width:100%;height:54px;background-color:#f0f0f0;border-bottom:1px solid #dcdcdc;overflow: hidden;}
    .nav-1 .page{border:2px solid #03a9f5;border-radius: 5px;width:50%;height:36px;margin:9px auto;overflow: hidden;}
    .nav-1 .page a{display: inline-block;width:50%;height:100%;text-align: center;color:#03a9f5;background-color: #fff;line-height: 36px;}
    .nav-1 .page #prev{border-right:1px solid #03a9f5;}
    .content-1{width:100%;padding:10px;}
    .content-1 img{width:100%;height:100%;}
    .disabled {pointer-events: none; color:#B9C1C5!important; }
    </style>
</head>

<body>
%{--<div class="header-1">--}%
%{--<a>--}%
%{--<i class="fa fa-angle-left"></i>返回--}%
%{--</a>--}%
%{--<span>案例</span>--}%
%{--</div>--}%
<div class="nav-1">
    <div class="page">
        <a href="#" id="prev">上一页</a><a href="#" id="next">下一页</a>
        %{--<g:link action="knowcontent" id="${id}" params="[offset: offset.toInteger()-1]" style="border-right: 2px solid #03a9f5;">上一页</g:link><g:link action="knowcontent" id="${id}" params="[offset: offset.toInteger()+1]">下一页</g:link>--}%
    </div>

</div>
<input type="hidden" class="id" id="id" value="${id}"/>
<input type="hidden" class="offset" id="offset"  style="width:40px;"/>
<div class="content-1">
    ${contentInfo?.introduction}
</div>
<script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
<script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">

    $('#next').click(function(){
        var id=$('#id').val();
        var offset=$('#offset').val()
        if(offset==''){
                  offset=0+1;
        }else{
            var offset=parseInt(offset)+1;
        }

        console.log("id="+id+"offset="+offset);
        $.ajax( {
            url:'${webRequest.baseUrl}/phonepage/knowcontent2',
            method:'post',
            dataType:'json',
            async:'false',
            data:{id:id,offset:offset},
            success:function(data){
                console.log(data.offset)

                $('.content-1').html(data.contentInfo);
                $('#id').val(data.id);
                $('#offset').val(data.offset);

                if(data.next==1){
                    $('#next').addClass('disabled')

                }else{
                    $('#next').removeClass('disabled')
                }
                if(data.prev==1){
                    $('#prev').addClass('disabled')

                }else{
                    $('#prev').removeClass('disabled')
                }
            },
            error:function(){
                alert('获取数据失败！')
            }
        })
    })
    $('#prev').click(function(){
        var id=$('#id').val();
        var offset=$('#offset').val()
        console.log(offset+"11111111111111111111");
        if(offset==''){
            offset=0;
        }else{
            var offset=parseInt($('#offset').val())-1;
        }

        console.log("id="+id+"offset="+offset);
        $.ajax( {
            url:'${webRequest.baseUrl}/phonepage/knowcontent2',
            method:'post',
            dataType:'json',
            async:'false',
            data:{id:id,offset:offset},
            success:function(data){
                console.log(data.offset)

                $('.content-1').html(data.contentInfo);
                $('#id').val(data.id);
                $('#offset').val(data.offset);
                if(data.next==1){
                    $('#next').addClass('disabled')

                }else{
                    $('#next').removeClass('disabled')
                }
                if(data.prev==1){
                    $('#prev').addClass('disabled')

                }else{
                    $('#prev').removeClass('disabled')
                }
            },
            error:function(){
                alert('获取数据失败！')
            }
        })
    })
</script>
</body>
</html>