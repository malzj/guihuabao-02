<aside class="col-xs-3">
    <div id="sidebar"  class="nav-collapse ">
        <div class="sidebar_object">
            <i class="page"></i>
            目标
        </div>
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
            <li class="sub-menu dcjq-parent-li">
                <div>
                    <g:link controller="front" action="user_target"  class="dcjq-parent">
                        <span>我的目标</span>
                        <span class="dcjq-icon"></span>
                    </g:link>
                </div>
                <ul class="sub db">
                    <li><a href="">负责的目标<em class="f-r">14</em></a></li>
                    <li><a href="">参与的目标<em class="f-r">14</em></a></li>
                </ul>
            </li>
        <li>
            <a href="">
                <span>下属目标</span>
                <span class="dcjq-icon"></span>
            </a>
        </li>
        <li class="sub-menu dcjq-parent-li">
            <div>
                <a href="" class="dcjq-parent">
                    <span>已完成目标</span>
                    <span class="dcjq-icon"></span>
                </a>
            </div>
            <ul class="sub db">
                <li><g:link controller="front" action="hasfinished_target">负责已完成目标<em class="f-r">14</em></g:link></li>
                <li><a href="">参与已完成目标<em class="f-r">14</em></a></li>
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
