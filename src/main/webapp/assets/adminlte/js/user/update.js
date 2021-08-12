/**
 * 修改
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
     * 打开修改窗口
     */
    $("body").on("click","i[id^='updateUserBtn-']",function () {
        // 当前选择的用户ID
        let id = $(this).attr("data-id");

        // 记录当前要修改的用户ID
        $("#updateUserId").val(id);

        // 获取用户详情
        $.ajax({
            // type，指定http请求方法，如：get、post
            type: "get",
            // url，后端服务地址
            url: ctx + "/users/" + id ,
            // async，true表示异步（默认），false表示同步
            async: true
        }).done(function (res) {
            // 处理响应结果
            if(res && res.status == 200){
                let user = res.data;

                // 把用户信息显示到页面上
                $("#updateForm input[name='username']").val(user.username);
                $("#updateForm input[name='nickname']").val(user.nickname);

                if(user.status && user.status == 1){
                    $("#updateForm #userStatus1").attr("checked","checked")
                }else {
                    $("#updateForm #userStatus2").attr("checked","");
                }

                $('#userUpdateModal').modal('show');

            } else {
                alert(res.message);
            }
        }).fail(function () {
            alert("新增失败");
        })
    })

    /**
     * 修改
     */
    $("#doUpdateBtn").click(function () {
        // 修改
        $.ajax({
            // type，指定http请求方法，如：get、post
            type: "put",
            // url，后端服务地址
            url: ctx + "/users" ,
            // async，true表示异步（默认），false表示同步
            async: true,
            /*contentType:"application/json;charset=UTF-8",*/
            // data，参数（一般是JSON格式）
            data: {
                id: $("#updateUserId").val(),
                nickname: $("#updateForm input[name='nickname']").val(),
                status: $("#updateForm input[name='status']:checked").val(),
                password: $("#updateForm input[name='password']").val()
            }
        }).done(function (res) {
            // 处理响应结果
            if(res && res.status == 200){
                reloadDataList();
                // 关闭新增窗口
                $('#userUpdateModal').modal('hide');
            } else {
                alert(res.message);
            }
        }).fail(function () {
            alert("修改失败");
        })

    });

})