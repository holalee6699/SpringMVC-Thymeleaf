/**
 * 新增
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
     * 打开新增窗口
     */
    $("#addBtn").click(function () {
        $('#resetAddForm').click();
        $('#userADDModal').modal('show');
    });

    /**
     * 新增表单校验
     */
    $("#addForm").validate({
        rules:{
            username: {
                required: true,
                rangelength: [3, 20]
            },
            nickname: {
                required: true,
                rangelength: [1, 50]
            },
            password: {
                required: true,
                rangelength: [5, 10]
            }
        },
        messages:{
            username: {
                required: "请输入账号",
                rangelength: $.validator.format("账号长度为 {0} 到 {1} 个字符")
            },
            nickname: {
                required: "请输入昵称",
                rangelength: $.validator.format("昵称长度为 {0} 到 {1} 个字符")
            },
            password: {
                required: "请输入密码",
                rangelength: $.validator.format("密码长度为 {0} 到 {1} 个字符")
            }
        },
        submitHandler: function(form) {
            // 校验通过
            addUser();
        }
    });

    /**
     * 新增
     */
    function addUser() {
        $.ajax({
            // type，指定http请求方法，如：get、post
            type: "post",
            // url，后端服务地址
            url: ctx + "/users",
            // async，true表示异步（默认），false表示同步
            async: true,
            // data，参数（一般是JSON格式）
            data: {
                username: $("#userADDModal #username").val(),
                nickname: $("#userADDModal #nickname").val(),
                status: $("#userADDModal input[name='status']:checked").val(),
                password: $("#userADDModal #password").val(),
            }
        }).done(function (res) {
            // 处理响应结果
            if(res && res.status == 200){
                reloadDataList();
                // 关闭新增窗口
                $('#userADDModal').modal('hide');
            } else {
                alert(res.message);
            }
        }).fail(function () {
            alert("新增失败");
        })
    }

})