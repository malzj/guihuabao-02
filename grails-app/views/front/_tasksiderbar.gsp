<aside class="col-xs-2" style="position:fixed;height:100%;">
    <div id="sidebar"  class="nav-collapse ">
        <div class="sidebar_object">
            <i class="page task_icon"></i>
            任务
        </div>
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
            <li class="sub-menu dcjq-parent-li">
            <div>
                <g:link class="dcjq-parent" action="taskCreate">
                    <span>我的任务</span>
                    <span class="dcjq-icon"></span>
                </g:link>
            </div>
            <ul class="sub db">
                <li><g:link action="fzTask" >负责的任务<em class="f-r">${com.guihuabao.Task.countByCidAndFzuidAndStatus(session.company.id,session.user.id,0)}</em></g:link></li>
                <li><g:link action="cyTask" >参与的任务<em class="f-r">${com.guihuabao.Task.countByCidAndPlayuidAndLookstatusAndStatus(session.company.id,session.user.id,2,0)}</em></g:link></li>
            </ul>
            </li>
            <li>
                <g:link action="unreadTask" >
                    <span>未读任务</span>
                    <em class="f-r">${com.guihuabao.Task.countByCidAndPlayuidAndLookstatus(session.company.id,session.user.id,0)}</em>
                </g:link>
            </li>
            <li>
                <g:link action="unacceptTask" >
                    <span>未接受任务</span>
                    <em class="f-r">${com.guihuabao.Task.countByCidAndPlayuidAndLookstatus(session.company.id,session.user.id,1)}</em>
                </g:link>
            </li>
            <li>
                <g:link action="unreadTaskReply" >
                    <span>未读回复</span>
                    <em class="f-r">${com.guihuabao.ReplyTask.countByBpuidAndCidAndStatus(session.user.id,session.company.id,0)}</em>
                </g:link>
            </li>
            <g:if test="${session.user.pid==1||session.user.pid==2}">
            <li>
                <g:link action="taskSubordinate" >
                    <span>下属任务</span>
                </g:link>
            </li>
            </g:if>
            %{--<li>--}%
                %{--<g:link action="finishedTask" >--}%
                    %{--<span>已完成任务</span>--}%
                    %{--<em class="f-r">${com.guihuabao.Task.countByCidAndPlayuidAndStatus(session.company.id,session.user.id,1)}</em>--}%
                %{--</g:link>--}%
            %{--</li>--}%
            %{--<li>--}%
                %{--<g:link action="allTask" >--}%
                    %{--<span>全部任务</span>--}%
                %{--</g:link>--}%
            %{--</li>--}%
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>