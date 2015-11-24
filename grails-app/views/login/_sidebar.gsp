<aside>
    <div id="sidebar"  class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu reset mt80" id="nav-accordion">
            <li>
                <g:link controller="login" action="userList">
                    <i class="fa user"></i>
                    <span>用户管理</span>
                </g:link>
            </li>
            <li>
                <g:link controller="login" action="companyList">
                    <i class="fa company"></i>
                    <span>公司管理</span>
                </g:link>
            </li>
            <li>
                <g:link controller="login" action="roleList">
                    <i class="fa role"></i>
                    <span>权限管理</span>
                </g:link>
            </li>

            <li class="sub-menu dcjq-parent-li">
                <a class="dcjq-parent" href="javascript:;">
                    <i class="fa hx"></i>
                    <span>和许</span>
                    <span class="dcjq-icon"></span>
                </a>
                <ul class="sub">
                    <li><g:link controller="login" action="hxhelper">和许助手</g:link></li>

                    <li><g:link controller="login" action="tools">工具和案例</g:link></li>

                    <li><g:link controller="login" action="hxset">和许设置</g:link></li>
                </ul>
            </li>
            <li>
                <g:link controller="login" action="appList">
                    <i class="fa role"></i>
                    <span>应用管理</span>
                </g:link>
            </li>
        <li class="sub-menu dcjq-parent-li">
            <a class="dcjq-parent" href="javascript:;">
                <i class="fa hx"></i>
                <span>规划</span>
                <span class="dcjq-icon"></span>
            </a>
            <ul class="sub">
                <li><g:link controller="login" action="testPaperList">测试题列表</g:link></li>

                <li><g:link controller="login" action="frameworkImgList">架构示例图列表</g:link></li>

                <li><g:link controller="login" action="frameworkDepartmentList">企业常规部门</g:link></li>
            </ul>
        </li>
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>