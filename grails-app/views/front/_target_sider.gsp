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
                    <li> <g:link controller="front" action="user_target"  class="dcjq-parent">负责的目标<em class="f-r">14</em></g:link></li>
                    <li> <g:link controller="front" action="join_mission"  class="dcjq-parent">参与的任务<em class="f-r">14</em></g:link></li>
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
                <li><g:link controller="front" action="hasfinished_target">负责已完成目标<em class="f-r">14</em></g:link></li>
                <li><g:link controller="front" action="join_hasfinished_mission">参与已完成任务<em class="f-r">14</em></g:link></li>
            </ul>
        </li>

            <li>
                <g:link controller="front" action="all_user_target">
                    <span>全部任务</span>
                </g:link>
            </li>
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>
