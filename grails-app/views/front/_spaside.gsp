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
            <li class="sub-menu dcjq-parent-li">
                <g:link action="user_approve" class="dcjq-parent" >
                    <span>我的审批</span>
                </g:link>

            </li>
            <li class="sub-menu dcjq-parent-li">
                <g:link action="user_draft" class="dcjq-parent">
                    <span>草稿箱</span>
                    <em class="f-r">${com.guihuabao.Apply.countByApplyuidAndCidAndApplystatuss(session.user.id,session.company.id,0)}</em>
                </g:link>

            </li>
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>