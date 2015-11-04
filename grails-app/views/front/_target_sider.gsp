
<aside class="col-xs-2" style="position:fixed;height:100%;padding-left:0;">
    <div id="sidebar"  class="nav-collapse " >
        <div class="sidebar_object">
            <i class="page tar_icon"></i>
            目标
        </div>
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
        <li class="sub-menu dcjq-parent-li">
            <a class="dcjq-parent" href="javascript:;">
                <span>我的目标</span>
                <span class="dcjq-icon"></span></a>
            <ul style="display: none;" class="sub">
                <li> <g:link controller="front" action="user_target"  class="dcjq-parent">负责的目标<em class="f-r">${com.guihuabao.Target.countByCidAndFzuidAndStatus(session.user.cid,session.user.id,0)}</em></g:link></li>
                <li> <g:link controller="front" action="join_mission"  class="dcjq-parent">参与的任务<em class="f-r">${com.guihuabao.Mission.countByPlaynameAndStatusAndIssubmit(session.user.name,0,1)}</em></g:link></li>
            </ul>

        </li>
        <g:if test="${session.user.pid==1||session.user.pid==2}">
        <li>

            <g:link controller="front" action="targetSubordinate">
                <span>下属目标</span>
                %{--<span class="dcjq-icon"></span>--}%
            </g:link>
        </li>
        </g:if>
        <li class="sub-menu dcjq-parent-li">
                    <a class="dcjq-parent" href="javascript:;">
                    <span>已完成目标</span>
                    <span class="dcjq-icon"></span>
                    </a>
            <ul class="sub" style="display: none;">
                <li><g:link controller="front" action="hasfinished_target">负责的目标<em class="f-r">${com.guihuabao.Target.countByCidAndFzuidAndStatus(session.user.cid,session.user.id,1)}</em></g:link></li>
                <li><g:link controller="front" action="join_hasfinished_mission">参与的任务<em class="f-r">${com.guihuabao.Mission.countByPlaynameAndStatus(session.user.name,1)}</em></g:link></li>
            </ul>
        </li>

            <li>
                <g:link controller="front" action="all_user_target">
                    <span>全部目标</span>
                </g:link>
            </li>
            <li>
                <g:link controller="front" action="unread_comment">
                    <span>未读回复</span><em class="f-r">${com.guihuabao.ReplyMission.countByBpunameAndStatus(session.user.name,0)}</em>
                </g:link>
            </li>
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>
