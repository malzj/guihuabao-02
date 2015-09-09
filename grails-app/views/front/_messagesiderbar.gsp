<%@ page import="java.text.SimpleDateFormat" %>
<aside class="col-xs-2">
    <div id="sidebar"  class="nav-collapse ">
        <div class="sidebar_object">
            <i class="fa fa-edit"></i>
            消息
        </div>
        <%SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm")%>
        <%def date = time.format(new Date())%>
        <%Calendar calendar = new GregorianCalendar();%>
        <%Date date1 = time.parse(date)%>
        <%calendar.setTime(date1);%>
        <%def nowday = new Date()%>
        <%def hour=nowday.getHours()%>
        <%switch (hour){
            case 19: calendar.add(Calendar.HOUR,4); break;
            case 20: calendar.add(Calendar.HOUR,3); break;
            case 21: calendar.add(Calendar.HOUR,2); break;
            case 22: calendar.add(Calendar.HOUR,1); break;
            case 23: calendar.add(Calendar.HOUR,0); break;
            default: calendar.add(Calendar.HOUR,6); break;
        }%>
        <%def etime = time.format(calendar.getTime())%>
        <%def timearr = etime.split(" ")%>
        <%def timearr1 = date.split(" ")%>
        <%def enddate = timearr[0]%>
        <%def endtime = timearr[1]%>
        <%def nowdate = timearr1[0]%>
        <%def nowtime = timearr1[1]%>
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
            %{--<li class="sub-menu dcjq-parent-li">--}%
                %{--<g:link action="messageTask" >--}%
                    %{--<span>未读任务</span>--}%
                    %{--<em class="f-r">${com.guihuabao.Task.countByCidAndPlayuidAndLookstatusAndStatus(session.company.id,session.user.id,0,0)}</em>--}%
                %{--</g:link>--}%
            %{--</li>--}%
            %{--<li class="sub-menu dcjq-parent-li">--}%
                %{--<g:link action="messageTargetOver" class="dcjq-parent" >--}%
                    %{--<span>目标到期提醒</span>--}%
                    %{--<em class="f-r">${com.guihuabao.Target.countByCidAndFzuidAndEtimeAndEtimeGreaterThanEqualsAndStatus(session.company.id,session.user.id,etime,date,0)}</em>--}%
                %{--</g:link>--}%

            %{--</li>--}%
            <li class="sub-menu dcjq-parent-li">
                <g:link action="messageTaskOver" class="dcjq-parent">
                    <span>任务到期提醒</span>
                    <em class="f-r">${com.guihuabao.Task.countByCidAndPlayuidAndOvertimeAndOverhourLessThanEqualsAndOverhourGreaterThanEqualsAndLookstatusAndStatus(session.company.id,session.user.id,nowdate,endtime,nowtime,2,0)}</em>
                    %{--${com.guihuabao.Task.countByCidAndPlayuidAndOvertimeAndOverhourLessThanEqualsAndOvertimeGreaterThanEqualsAndOverhourGreaterThanEqualsAndLookstatusAndStatus(session.company.id,session.user.id,enddate,endtime,nowdate,nowtime,2,0)}--}%
                </g:link>

            </li>
            <li class="sub-menu dcjq-parent-li">
                <g:link action="messageTaskF" >
                    <span>完成任务</span>
                    <em class="f-r">${com.guihuabao.Task.countByCidAndFzuidAndLookstatusAndStatusAndRemindstatus(session.company.id,session.user.id,2,1,1)}</em>
                </g:link>
            </li>
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>