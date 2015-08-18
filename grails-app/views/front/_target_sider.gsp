
<aside class="col-xs-3" style="position:fixed;height:100%;">
    <div id="sidebar"  class="nav-collapse " >
        <div class="sidebar_object">
            <i class="page"></i>
            目标
        </div>
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
            <li class="sub-menu dcjq-parent-li">
                <div>
                    <a >
                        <span>我的目标</span>
                        <span class="dcjq-icon"></span>
                    </a>
                </div>
                <ul class="sub db">
                    <li> <g:link controller="front" action="user_target"  class="dcjq-parent">负责的目标<em class="f-r">${com.guihuabao.Target.countByCidAndFzuidAndStatus(session.user.cid,session.user.id,0)}</em></g:link></li>
                    <li> <g:link controller="front" action="join_mission"  class="dcjq-parent">参与的任务<em class="f-r">${com.guihuabao.Mission.countByPlaynameAndStatusAndIssubmit(session.user.name,0,1)}</em></g:link></li>
                </ul>
            </li>
        <li>
            <g:link controller="front" action="xsTarget">
                <span>下属目标</span>
                <span class="dcjq-icon"></span>
            </g:link>
        </li>
        <li class="sub-menu dcjq-parent-li">
            <div>
                    <a>
                    <span>已完成目标</span>
                    <span class="dcjq-icon"></span>
                    </a>
            </div>
            <ul class="sub db">
                <li><g:link controller="front" action="hasfinished_target">负责已完成目标<em class="f-r">${com.guihuabao.Target.countByCidAndFzuidAndStatus(session.user.cid,session.user.id,1)}</em></g:link></li>
                <li><g:link controller="front" action="join_hasfinished_mission">参与已完成任务<em class="f-r">${com.guihuabao.Mission.countByPlaynameAndStatus(session.user.name,1)}</em></g:link></li>
            </ul>
        </li>

            <li>
                <g:link controller="front" action="all_user_target">
                    <span>全部任务</span>
                </g:link>
            </li>
            <li>
                <g:link controller="front" action="unread_comment">
                    <span>未读评论</span><em class="f-r">${com.guihuabao.ReplyMission.countByBpunameAndStatus(session.user.name,0)}</em>
                </g:link>
            </li>
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>
