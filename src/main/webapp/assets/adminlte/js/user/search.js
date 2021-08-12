/**
 * 查询
 */
(function () {
    var ctx = "${pageContext.request.contextPath}";

    /**
     * 刷新数据列表
     */
    function reloadDataList(){
        $('#dataList').bootstrapTable("refresh");
    }

    /**
     * 查询
     */
    $("#searchBtn").on("click",function (e) {
        $('#dataList').bootstrapTable("refresh",{url: "${pageContext.request.contextPath}/users"});
    })

})