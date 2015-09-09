<aside class="col-xs-2" style="position:fixed;height:100%;">
    <div id="sidebar"  class="nav-collapse ">
        <div class="sidebar_object">
            <i class="page apply_icon"></i>
            审批
        </div>
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion" >
            <li class="sub-menu dcjq-parent-li">
                <g:link action="apply" >
                    <span>我的申请</span>
                </g:link>

            </li>
            <g:if test="${session.user.pid!='3'}">
            <li class="sub-menu dcjq-parent-li">
                <g:link action="user_approve" class="dcjq-parent" >
                    <span>我的审批</span>
                </g:link>

            </li>
            </g:if>
            <li class="sub-menu dcjq-parent-li">
                <g:link action="user_draft" class="dcjq-parent">
                    <span>草稿箱</span>
                    <em class="f-r">${com.guihuabao.Apply.countByApplyuidAndCidAndApplystatuss(session.user.id,session.company.id,0)}</em>
                </g:link>

            </li>
            <g:if test="${session.user.pid!='3'}">
                <li class="sub-menu dcjq-parent-li">
                <g:link action="copyToMe" class="dcjq-parent">
                    <span>抄送我的</span>
                    <em class="f-r">${com.guihuabao.Apply.countByCopyuidAndCidAndCopyremind(session.user.id,session.company.id,1)}</em>
                </g:link>
                </li>
            </g:if>
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>