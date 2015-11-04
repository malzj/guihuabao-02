<aside class="col-xs-2" style="position:fixed;height:100%;">
    <div id="sidebar"  class="nav-collapse ">
        <div class="sidebar_object">
            <i class="page report_icon"></i>
            报告
        </div>
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
            <li>
                <g:link action="myReport">
                    <span>我的报告</span>
                </g:link>
            </li>
            <g:if test="${session.user.pid==1||session.user.pid==2}">
            <li>
                <g:link action="reportSubordinate">
                    <span>下属报告</span>
                </g:link>
            </li>
            </g:if>
            <li>
                <g:link action="replyReport">
                    <span>未读回复</span>
                    <em class="f-r">${com.guihuabao.ReplyReport.countByBpuidAndCidAndStatus(session.user.id,session.company.id,0)}</em>
                </g:link>
            </li>
            <li>
                <g:link action="allReplyReport">
                    <span>所有回复</span>
                </g:link>
            </li>
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>