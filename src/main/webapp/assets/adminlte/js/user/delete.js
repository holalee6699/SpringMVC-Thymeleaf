/**
 * 删除
 */
(function ($) {
    var ctx = "${pageContext.request.contextPath}";

    /**
     * 刷新数据列表
     */
    function reloadDataList(){
        $('#dataList').bootstrapTable("refresh");
    }

    $("#deleteBtn").click(function () {
        // 获取选中的行
        let selectedList = $("#dataList").bootstrapTable("getSelections");
        if(selectedList && selectedList.length <= 0){
            // alert("请选择");
            bootbox.alert({
                title:"警告",
                backdrop:true,
                size:"sm",
                message:"请选择"
            });
            return;
        }

        // 选中行的数据ID
        let ids = selectedList.map(function (res) {
            return res.id;
        })


        bootbox.confirm({
            message:"确定删除？",
            backdrop:true,
            size:"sm",
            buttons: {
                confirm: {
                    label: '删除',
                    className: 'btn-danger'
                },
                cancel: {
                    label: '取消',
                    className: 'btn-default'
                }
            },
            callback: function (result) {
                if(!result){
                    return;
                }

                // 删除
                $.ajax({
                    // type，指定http请求方法，如：get、post
                    type: "delete",
                    // url，后端服务地址
                    url: ctx + "/users" ,
                    // async，true表示异步（默认），false表示同步
                    async: true,
                    /*contentType:"application/json;charset=UTF-8",*/
                    // data，参数（一般是JSON格式）
                    data: {
                        ids: ids
                    }
                }).done(function (res) {
                    // 处理响应结果
                    if(res && res.status == 200){
                        reloadDataList();
                    } else {
                        alert(res.message);
                    }
                }).fail(function () {
                    alert("删除失败");
                })
            }
        });


    });
})(jQuery)