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
            <%def otargetcount = com.guihuabao.Target.countByCidAndFzuidAndStatusAndEtimeGreaterThanEqualsAndEtimeLessThanEquals(session.company.id,session.user.id,0,date,etime)%>
            <%def otaskcount = com.guihuabao.Task.countByCidAndPlayuidAndOvertimeAndOverhourLessThanEqualsAndOvertimeGreaterThanEqualsAndOverhourGreaterThanEqualsAndLookstatusAndStatus(session.company.id,session.user.id,enddate,endtime,nowdate,nowtime,2,0)%>
            <%def messageTaskFcount = com.guihuabao.Task.countByCidAndFzuidAndLookstatusAndStatusAndRemindstatus(session.company.id,session.user.id,2,1,1)%>
            <%def newapplycount = com.guihuabao.Apply.countByApprovaluidAndCidAndApplystatus(session.user.id,session.company.id,0)%>
            <%def applycount = com.guihuabao.Apply.countByApplyuidAndCidAndRemindstatus(session.user.id,session.company.id,1)%>
            <%def taskreplycount = com.guihuabao.ReplyTask.countByBpuidAndCidAndStatus(session.user.id,session.company.id,0)%>
            <%def utargetcount = com.guihuabao.ReplyMission.countByBpunameAndStatus(session.user.name,0)%>
            <%def finishtargetcount = com.guihuabao.ReplyMission.countByBpunameAndStatus(session.user.name,0)%>
            <%def allcount = utaskcount+otargetcount+otaskcount+messageTaskFcount+newapplycount+applycount+taskreplycount+utargetcount%>
            <ul>
                <li class="msg">
                    <a href="javascript:;"><i class="fa fa-bell"></i>消息<g:if test="${allcount!=0}"><span class="tsh bg-important">${allcount}</span></g:if></a>
                    <ul class="list">
                        <g:if test="${utaskcount!=0}">
                        <li>
                            <g:link action="unreadTask" >
                                未读任务
                                <em class="f-r">${utaskcount}</em>
                            </g:link>
                        </li>
                        </g:if>
                        <g:if test="${otargetcount!=0}">
                        <li>
                            <g:link action="messageTargetOver" >
                                目标到期提醒
                                <em class="f-r">${otargetcount}</em>
                            </g:link>
                        </li>
                        </g:if>
                        <g:if test="${otaskcount!=0}">
                        <li>
                        <g:link action="messageTaskOver" >
                            任务到期提醒
                            <em class="f-r">${otaskcount}</em>
                        </g:link>
                        </li>
                        </g:if>
                        <g:if test="${messageTaskFcount!=0}">
                        <li>
                            <g:link action="messageTaskF" >
                                已完成任务
                                <em class="f-r">${messageTaskFcount}</em>
                            </g:link>
                        </li>
                        </g:if>
                        <g:if test="${newapplycount!=0}">
                        <li>
                            <g:link action="user_approve" >
                                审批提醒
                                <em class="f-r">${newapplycount}</em>
                            </g:link>
                        </li>
                        </g:if>
                        <g:if test="${applycount!=0}">
                            <li>
                                <g:link action="apply" >
                                    申请通过提醒
                                    <em class="f-r">${applycount}</em>
                                </g:link>
                            </li>
                        </g:if>
                        <g:if test="${taskreplycount!=0}">
                            <li>
                                <g:link action="unreadTaskReply" >
                                    未读任务回复
                                    <em class="f-r">${taskreplycount}</em>
                                </g:link>
                            </li>
                        </g:if>
                        <g:if test="${utargetcount!=0}">
                            <li>
                                <g:link action="unread_comment" >
                                    未读目标回复
                                    <em class="f-r">${utargetcount}</em>
                                </g:link>
                            </li>
                        </g:if>
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
            <li><g:link action="apply"><i class="apply"></i>申请</g:link></li>
            <li><g:link action="myReport"><i class="bg"></i>报告</g:link></li>
            <li><a href="javascript:;"><i class="app"></i>应用</a></li>
            <g:if test="${session.user.rid}">
            <li><g:link action="companyUserList" ><i class="ht"></i>后台</g:link></li>
            </g:if>
        </ul>
        <g:link action="hxhelper" class="f-r zs"><i></i>和许助手</g:link>
    </div>
</header>
<!--header end-->