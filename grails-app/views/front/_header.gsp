<%@ page import="java.text.SimpleDateFormat" %>
<!--header start-->
<header class="header" style="position:fixed;">
    <div class="top">
        <div class="t_left"><img width="25" height="25" src="${resource(dir:"images",file: ''+com.guihuabao.CompanyUser.findByIdAndCid(session.user.id,session.company.id).img+'')}" />你好${session.user.username}</div>
        <div class="t_right">
            %{--<ul>--}%
                %{--<li><a href="javascript:;"><i class="fa fa-bell"></i>&nbsp;&nbsp;消息<span class="tsh bg-important">5</span></a></li>--}%
                %{--<li>|</li>--}%
                %{--<li><g:link action="personalSet" ><i class="fa fa-cog"></i>设置</g:link></li>--}%
                %{--<li>|</li>--}%
                %{--<li><a href="javascript:;"><i></i>安全退出</a></li>--}%
            %{--</ul>--}%
            <%SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm")%>
            <%def date = time.format(new Date())%>
            <%Calendar calendar = new GregorianCalendar();%>
            <%Date date1 = time.parse(date)%>
            <%calendar.setTime(date1);%>
            <%calendar.add(Calendar.HOUR,6)%>
            <%def etime = time.format(calendar.getTime())%>
            <%def timearr = etime.split(" ")%>
            <%def timearr1 = date.split(" ")%>
            <%def enddate = timearr[0]%>
            <%def endtime = timearr[1]%>
            <%def nowdate = timearr1[0]%>
            <%def nowtime = timearr1[1]%>
            <%def utaskcount = com.guihuabao.Task.countByCidAndPlayuidAndLookstatusAndStatus(session.company.id,session.user.id,0,0)%>
            <%def otargetcount = com.guihuabao.Target.countByCidAndFzuidAndEtimeAndEtimeGreaterThanEqualsAndStatus(session.company.id,session.user.id,etime,date,0)%>
            <%def otaskcount = com.guihuabao.Task.countByCidAndPlayuidAndOvertimeAndOverhourLessThanEqualsAndOvertimeGreaterThanEqualsAndOverhourGreaterThanEqualsAndStatus(session.company.id,session.user.id,enddate,endtime,nowdate,nowtime,0)%>
            <%def allcount = utaskcount+otargetcount+otaskcount%>
            <ul>
                <li class="msg">
                    <a href="javascript:;"><i class="fa fa-bell"></i>消息<span class="tsh bg-important">${allcount}</span></a>
                    <ul class="list">
                        <li>
                            <g:link action="messageTask" >
                                未读任务
                                <em class="f-r">${utaskcount}</em>
                            </g:link>
                        </li>
                        <li>
                            <g:link action="messageTargetOver" >
                                目标到期提醒
                                <em class="f-r">${otargetcount}</em>
                            </g:link>
                        </li>
                        <li>
                        <g:link action="messageTaskOver" >
                            任务到期提醒
                            <em class="f-r">${otaskcount}</em>
                        </g:link>
                        </li>
                    </ul>
                </li>
                <li>|</li>
                <li class="set">
                    <a href="javascript:;" ><i class="fa fa-cog"></i>设置</a>
                    <ul class="list">
                        <li>
                            <g:link action="personalSet" >个人设置</g:link>
                        </li>
                        <li>
                            <g:link action="funIntroduction" id="1" >系统设置</g:link>
                        </li>
                    </ul>
                </li>
                <li>|</li>
                <li class="exit"><g:link action="logout" ><i></i>安全退出</g:link></li>
            </ul>
        </div>
    </div>
    <div class="navbox">
        <!--logo start-->
        <a href="index.html" class="logo"><img height="30" src="${resource(dir: 'img', file: 'logo.png')}"></a>
        <!--logo end-->
        <ul class="nav">
            <li><g:link action="frontIndex"><i class="home"></i>首页</g:link></li>
            <li><g:link action="user_target"><i class="aim"></i>目标</g:link></li>
            <li><g:link action="taskCreate"><i class="rw"></i>任务</g:link></li>
            <li><g:link action="apply"><i class="fa fa-edit" style="font-size:30px;margin-top:10px;"></i>审批</g:link></li>
            <li><g:link action="myReport"><i class="bg"></i>报告</g:link></li>
            <li><a href="javascript:;"><i class="app"></i>应用</a></li>
            <li><g:link action="companyUserList" ><i class="ht"></i>后台</g:link></li>
        </ul>
        <g:link action="hxhelper" class="f-r zs"><i></i>和许助手</g:link>
    </div>
</header>
<!--header end-->