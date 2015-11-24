<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-6-16
  Time: 下午3:59
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>规划宝后台管理系统</title>

    <!-- Bootstrap core CSS -->
    <link href="${resource(dir: 'css', file: 'bootstrap.min.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'bootstrap-reset.css')}" rel="stylesheet">
    <!--external css-->
    <link href="${resource(dir: 'assets/font-awesome/css', file: 'font-awesome.css')}" rel="stylesheet">
    <link href="${resource(dir: 'assets/jquery-easy-pie-chart', file: 'jquery.easy-pie-chart.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'owl.carousel.css')}" rel="stylesheet">

    <!--right slidebar-->
    <link href="${resource(dir: 'css', file: 'slidebars.css')}" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${resource(dir: 'css', file: 'styleone.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'style-responsive.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
</head>

<body>

<section id="container" >
    <!--header start-->
    <g:render template="header" />
    <!--header end-->
    <!--main content start-->
    <section id="main-content" style="margin-left: 0px;">
        <section class="wrapper" style="margin-top: 94px;">
            <div class="testPaper">
                <ul class="steps clearfix">
                <li class="stp active">
                    <span>第一步</span>
                    <p>现状评估</p>
                </li>
                <li class="arrow"></li>
                <li class="stp">
                    <span>第二步</span>
                    <p>规模目标</p>
                </li>
                <li class="arrow"></li>
                <li class="stp">
                    <span>第三步</span>
                    <p>财务目标</p>
                </li>
                <li class="arrow"></li>
                <li class="stp">
                    <span>第四步</span>
                    <p>组织架构</p>
                </li>
                <li class="arrow"></li>
                <li class="stp">
                    <span>第五步</span>
                    <p>工作推进</p>
                </li>
            </ul>
                <div class="test-question">
                    <div class="test-title">客户自填信息</div>
                    <g:form class="form-horizontal tasi-form" url="[controller:'front',action:'testEvaluate']" method="post"  enctype= "multipart/form-data">
                        <g:hiddenField name="testPaperId" value="${testPaperId}"></g:hiddenField>
                    <div class="info">
                        <div class="classify-title">
                            <h2>企业基础信息：</h2>
                        </div>
                        <div class="question">
                            <p>1、您在企业的职位？年龄？学历？</p>
                            <p class="options">
                                职位：<input type="text" name="infos[22]" />
                                年龄：<input type="text" name="infos[22]" />
                                学历：<input type="text" name="infos[22]" />
                            </p>
                        </div>
                        <div class="question">
                            <p>2、您的企业品牌名称是?</p>
                            <p class="options">
                                企业名称：<input type="text" name="infos[23]" />
                            </p>
                        </div>
                        <div class="question">
                            <p>3、当前企业所属行业？</p>
                            <p class="options">
                                <input type="radio" name="infos[24]" value="A" />A、餐饮业
                                <input type="radio" name="infos[24]" value="B" />B、美容美发
                                <input type="radio" name="infos[24]" value="C" />C、汽车后市场
                                <input type="radio" name="infos[24]" value="D" />D、金融
                                <input type="radio" name="infos[24]" value="E" />E、教育
                                <input class="other" type="radio" name="infos[24]" />F、其他
                                <input type="text" class="other-info" disabled="disabled"/>
                            </p>
                        </div>
                        <div class="question">
                            <p>4、企业成立年限?</p>
                            <p class="options">
                                自填：<input type="text" name="infos[25]" />
                            </p>
                        </div>
                        <div class="question">
                            <p>5、企业办公地址？</p>
                            <p class="options">
                                自填：<input type="text" name="infos[26]" />
                            </p>
                        </div>
                    </div>
                    <div class="classify-title">
                        <h2>一、团队能力指标：(满分15分 每题最高3分)</h2>
                    </div>
                    <div class="question1">
                        <p>1、企业总部团队员工数量？</p>
                        <p class="options">
                            <input type="radio" name="infos[27]" value="A" />A、10人
                            <input type="radio" name="infos[27]" value="B" />B、10人-50人
                            <input type="radio" name="infos[27]" value="C" />C、50人-100人
                            <input type="radio" name="infos[27]" value="D" />D、100人以上
                        </p>
                    </div>
                    <div class="question1">
                        <p>2、总部团队平均学历？ </p>
                        <p class="options">
                            <input type="radio" name="infos[28]" value="A" />A、初中及以下
                            <input type="radio" name="infos[28]" value="B" />B、高中/中专
                            <input type="radio" name="infos[28]" value="C" />C、本科
                            <input type="radio" name="infos[28]" value="D" />D、本科以上
                        </p>
                    </div>
                    <div class="question1">
                        <p>3、公司组织团队健全程度？ </p>
                        <p class="options">
                            <input type="radio" name="infos[29]" value="A" />A、组织齐全
                            <input type="radio" name="infos[29]" value="B" />B、有部门和分工 待完善
                            <input type="radio" name="infos[29]" value="C" />C、不健全 急需补充
                            <input type="radio" name="infos[29]" value="D" />D、不知道需哪些部门
                        </p>
                    </div>
                    <div class="question1">
                        <p>4、员工平均薪资</p>
                        <p class="options">
                            自填：<input type="text" name="infos[30]" />
                        </p>
                    </div>
                    <div class="question1">
                        <p>5、公司运用哪些信息化工具？（可多选）</p>
                        <p class="options">
                            <input type="checkbox" name="infos[31]" value="A" />A、收银系统
                            <input type="checkbox" name="infos[31]" value="B" />B、ERP软件
                            <input type="checkbox" name="infos[31]" value="C" />C、网站
                            <input type="checkbox" name="infos[31]" value="D" />D、微信
                            <input type="checkbox" name="infos[31]" value="E" />E、微博
                            <input type="checkbox" name="infos[31]" value="F" />F、CRM软件
                            <input class="other" type="checkbox" name="infos[31]" />G、其他
                            <input type="text" class="other-info" disabled="disabled"/>
                        </p>
                    </div>
                        <div class="classify-title">
                            <h2>二、财务支付指标：（满分20分 每题最高4分）</h2>
                        </div>
                        <div class="question1">
                            <p>1、单店开店成本是多少万元？</p>
                            <p class="options">
                                自填：<input type="text" name="infos[32]" />万元
                            </p>
                        </div>
                        <div class="question1">
                            <p>2、近两年平均净利润？</p>
                            <p class="options">
                                自填：<input type="text" name="infos[33]" />万元
                            </p>
                        </div>
                        <div class="question1">
                            <p>3、公司可用流动现金？</p>
                            <p class="options">
                                自填：<input type="text" name="infos[34]" />万元
                            </p>
                        </div>
                        <div class="question1">
                            <p>4、营销支出占公司利润的比例：</p>
                            <p class="options">
                                自填：<input type="text" name="infos[35]" />%
                            </p>
                        </div>
                        <div class="question1">
                            <p>5、最近一年开店数量</p>
                            <p class="options">
                                自填：<input type="text" name="infos[36]" />个
                            </p>
                        </div>
                        <div class="classify-title">
                            <h2>三、规模发展指标: （满分30分 每题最高3分）</h2>
                        </div>
                        <div class="question1">
                            <p>1、您的品牌是否有品牌定位、VI手册、营建手册 ？</p>
                            <p class="options">
                                <input type="radio" name="infos[37]" value="A" />A、都没有
                                <input type="radio" name="infos[37]" value="B" />B、有其中一种
                                <input type="radio" name="infos[37]" value="C" />C、有其中两种
                                <input type="radio" name="infos[37]" value="D" />D、都有
                            </p>
                        </div>
                        <div class="question1">
                            <p>2、您现在的发展模式？ </p>
                            <p class="options">
                                <input type="radio" name="infos[38]" value="A" />A、全部直营
                                <input type="radio" name="infos[38]" value="B" />B、直营为主 加盟为辅
                                <input type="radio" name="infos[38]" value="C" />C、加盟为主 直营为辅
                            </p>
                        </div>
                        <div class="question1">
                            <p>3、店面选址位置（可多选）？</p>
                            <p class="options">
                                <input type="checkbox" name="infos[39]" value="A" />A、学校
                                <input type="checkbox" name="infos[39]" value="B" />B、商场底商
                                <input type="checkbox" name="infos[39]" value="C" />C、商场内部
                                <input type="checkbox" name="infos[39]" value="D" />D、社区
                                <input type="checkbox" name="infos[39]" value="A" />E、医院
                                <input type="checkbox" name="infos[39]" value="B" />F、车站
                                <input type="checkbox" name="infos[39]" value="C" />G、机场
                                <input class="other" type="checkbox" name="infos[39]" />H、其他
                                <input type="text" class="other-info" disabled="disabled"/>
                            </p>
                        </div>
                        <div class="question1">
                            <p>4、您现在直营店面数量？</p>
                            <p class="options">
                                自填：<input type="text" name="infos[40]" />个
                            </p>
                        </div>
                        <div class="question1">
                            <p>5、如果加盟，如何收取费用？加盟费（填空）商标使用费（填空） 保证金（填空)</p>
                            <p class="options">
                                自填：<input type="text" name="infos[41]" />万元
                                <input type="text" name="infos[41]" />万元
                                <input type="text" name="infos[41]" />万元
                            </p>
                        </div>
                        <div class="question1">
                            <p>6、行业是否存在进入壁垒？如果存在，最主要的进入壁垒是？</p>
                            <p class="options">
                                <input type="radio" name="infos[42]" value="A" />A、学校
                                <input type="radio" name="infos[42]" value="B" />B、商场底商
                                <input type="radio" name="infos[42]" value="C" />C、商场内部
                                <input type="radio" name="infos[42]" value="D" />D、社区
                                <input class="other" type="radio" name="infos[42]" />E、其他
                                <input type="text" class="other-info" disabled="disabled"/>
                            </p>
                        </div>
                        <div class="question1">
                            <p>7、行业竞争状况？ </p>
                            <p class="options">
                                <input type="radio" name="infos[43]" value="A" />A、惨烈
                                <input type="radio" name="infos[43]" value="B" />B、激烈
                                <input type="radio" name="infos[43]" value="C" />C、有一定竞争
                                <input type="radio" name="infos[43]" value="D" />D、没竞争压力
                            </p>
                        </div>
                    <div class="question1">
                        <p>8、您认为您企业的核心竞争力体现在？ </p>
                        <p class="options">
                            <input type="radio" name="infos[44]" value="A" />A、产品/技术
                            <input type="radio" name="infos[44]" value="B" />B、团队组织
                            <input type="radio" name="infos[44]" value="C" />C、体系发展能力
                            <input type="radio" name="infos[44]" value="D" />D、没核心竞争力
                        </p>
                    </div>
                    <div class="question1">
                        <p>9、公司是否具有科学的连锁发展体系？ </p>
                        <p class="options">
                            <input type="radio" name="infos[45]" value="A" />A、有
                            <input type="radio" name="infos[45]" value="B" />B、有一些
                            <input type="radio" name="infos[45]" value="C" />C、没有
                        </p>
                    </div>
                    <div class="question1">
                        <p>10、公司是否有清晰的目标规划？</p>
                        <p class="options">
                            <input type="radio" name="infos[46]" value="A" />A、没想法 更没目标
                            <input type="radio" name="infos[46]" value="B" />B、没想法 更没目标
                            <input type="radio" name="infos[46]" value="C" />C、有目标 有初步规划
                            <input type="radio" name="infos[46]" value="D" />D、有目标 有初步规划
                        </p>
                    </div>
                    <div class="classify-title">
                        <h2>四、单店盈利能力：（满分20分 每题最高4分）</h2>
                    </div>
                    <div class="question1">
                        <p>1、单店营业面积是多少？</p>
                        <p class="options">
                            <input type="radio" name="infos[47]" value="A" />A、20平-60平
                            <input type="radio" name="infos[47]" value="B" />B、80平-150平
                            <input type="radio" name="infos[47]" value="C" />C、150平-200平
                            <input type="radio" name="infos[47]" value="D" />D、200平以上
                        </p>
                    </div>
                    <div class="question1">
                        <p>2、单店日营业额是多少？</p>
                        <p class="options">
                            自填：<input type="text" name="infos[48]" />万元
                        </p>
                    </div>
                    <div class="question1">
                        <p>3、单店毛利率是多少？</p>
                        <p class="options">
                            自填：<input type="text" name="infos[49]" />%
                        </p>
                    </div>
                    <div class="question1">
                        <p>4、单店净利润率是多少？</p>
                        <p class="options">
                            自填：<input type="text" name="infos[50]" />%
                        </p>
                    </div>
                    <div class="question1">
                        <p>5、每天单店产出，坪效比是多少？（坪效=销售额/经营面积）</p>
                        <p class="options">
                            自填：<input type="text" name="infos[51]" />
                        </p>
                    </div>
                    <div class="classify-title">
                        <h2>五、产品复制能力：（满分15分 每题最高3分）</h2>
                    </div>
                    <div class="question1">
                        <p>1、产品技术是否申请专利？</p>
                        <p class="options">
                            <input type="radio" name="infos[52]" value="A" />A、是
                            <input type="radio" name="infos[52]" value="B" />B、没有
                        </p>
                    </div>
                    <div class="question1">
                        <p>2、产品设备投资占总体开店投资比例？</p>
                        <p class="options">
                            <input type="radio" name="infos[53]" value="A" />A、15%以上
                            <input type="radio" name="infos[53]" value="B" />B、10-15%
                            <input type="radio" name="infos[53]" value="C" />C、5%-10%
                            <input type="radio" name="infos[53]" value="D" />D、5%以下
                        </p>
                    </div>
                    <div class="question1">
                        <p>3、是否有自己的工厂？</p>
                        <p class="options">
                            <input type="radio" name="infos[54]" value="A" />A、有，面积<input type="text" name="infos[54].area" />平
                            <input type="radio" name="infos[54]" value="B" />B、没有 代工或店内操作
                        </p>
                    </div>
                    <div class="question1">
                        <p>4、产品的配送方式？</p>
                        <p class="options">
                            <input type="radio" name="infos[55]" value="A" />A、店内制作
                            <input type="radio" name="infos[55]" value="B" />B、1-2种核心产品配送
                            <input type="radio" name="infos[55]" value="C" />C、多数半成品/制成品配送
                            <input type="radio" name="infos[55]" value="D" />D、原料及所有半成品/制成品配送
                        </p>
                    </div>
                    <div class="question1">
                        <p>5、对加盟店面输出的产品？</p>
                        <p class="options">
                            <input type="radio" name="infos[56]" value="A" />A、半成品
                            <input type="radio" name="infos[56]" value="B" />B、原材料
                            <input type="radio" name="infos[56]" value="C" />C、核心产品
                            <input type="radio" name="infos[56]" value="D" />D、全部输出
                        </p>
                    </div>
                        <div style="text-align: center;margin-top: 55px;">
                        <button type="submit" class="btn btn-info">提交答卷</button>
                        </div>
                    </g:form>
                </div>
            </div>
        </section>
        <!--main content end-->

        <!--footer start-->
        %{--<footer class="site-footer">--}%
        %{--<div class="text-center">--}%
        %{--2013 &copy; FlatLab by VectorLab.--}%
        %{--<a href="index.html#" class="go-top">--}%
        %{--<i class="fa fa-angle-up"></i>--}%
        %{--</a>--}%
        %{--</div>--}%
        %{--</footer>--}%
        <!--footer end-->
    </section>

    <!-- js placed at the end of the document so the pages load faster -->
    <script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
    <script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
    <script class="include" type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dcjqaccordion.2.7.js')}"></script>
    <script src="${resource(dir: 'js', file: 'jquery.scrollTo.min.js')}"></script>
    <script src="${resource(dir: 'js', file: 'jquery.nicescroll.js')}" type="text/javascript"></script>
    <script src="${resource(dir: 'js', file: 'jquery.sparkline.js')}" type="text/javascript"></script>
    <script src="${resource(dir: 'assets/jquery-easy-pie-chart/', file: 'jquery.easy-pie-chart.js')}"></script>
    <script src="${resource(dir: 'js', file: 'owl.carousel.js')}" ></script>
    <script src="${resource(dir: 'js', file: 'jquery.customSelect.min.js')}" ></script>
    <script src="${resource(dir: 'js', file: 'respond.min.js')}" ></script>

    <!--right slidebar-->
    <script src="${resource(dir: 'js', file: 'slidebars.min.js')}"></script>

    <!--common script for all pages-->
    <script src="${resource(dir: 'js', file: 'common-scripts.js')}"></script>

    <!--script for this page-->
    <script src="${resource(dir: 'js', file: 'sparkline-chart.js')}"></script>
    <script src="${resource(dir: 'js', file: 'easy-pie-chart.js')}"></script>
    <script src="${resource(dir: 'js', file: 'count.js')}"></script>

    %{--<script>--}%

    %{--//owl carousel--}%

    %{--$(document).ready(function() {--}%
    %{--$("#owl-demo").owlCarousel({--}%
    %{--navigation : true,--}%
    %{--slideSpeed : 300,--}%
    %{--paginationSpeed : 400,--}%
    %{--singleItem : true,--}%
    %{--autoPlay:true--}%

    %{--});--}%
    %{--});--}%

    %{--//custom select box--}%

    %{--$(function(){--}%
    %{--$('select.styled').customSelect();--}%
    %{--});--}%

    %{--</script>--}%
    <!--其他选项js-->
    <script type="text/javascript">
        $(document).ready(function(){
            $('.other').change(function(){

                var select=$(this).is(':checked');

                if(select){
                    $(this).siblings('.other-info').removeAttr('disabled');
                }else{
                    $(this).siblings('.other-info').attr('disabled','disabled');
                }
            });
            $('.other-info').blur(function(){
                var info=$(this).val();
                $(this).siblings('.other').val(info);
            })
        })
    </script>

</body>
</html>