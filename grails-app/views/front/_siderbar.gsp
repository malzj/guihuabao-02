<aside>
    <div id="sidebar"  class="nav-collapse ">
        <div class="sidebar_object">
            <i class="page"></i>
            后台管理
        </div>
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
            <li>
                <g:link controller="front" action="companyUserList">
                    <span>用户管理</span>
                </g:link>
            </li>
            <li>
                <g:link controller="front" action="bumenList">
                    <span>部门管理</span>
                </g:link>
            </li>
            <li>
                <g:link controller="front" action="companyRoleList" style="display:none;">
                    <span>权限管理</span>
                </g:link>
            </li>
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>