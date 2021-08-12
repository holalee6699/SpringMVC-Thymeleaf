
(function ($) {
    var ctx = "${pageContext.request.contextPath}";

    $('#dataList').bootstrapTable({
        columns: [{
            field: '',
            checkbox: true
        },{
            field: 'username',
            title: '账号',
        }, {
            field: 'nickname',
            title: '昵称',
            width: '20',
            widthUnit: '%'
        }, {
            field: 'status',
            title: '状态',
            width: '15',
            widthUnit: '%',
            formatter:function (value) {
                let desc = "禁用";
                if(value && parseInt(value) === 1){
                    desc = "启用";
                }
                return desc;
            }
        }, {
            field: 'createdTime',
            title: '创建时间'
        },{
            field: '',
            title: '操作',
            formatter:function (value,row) {
                let btns = "<a  href='javascript:void(0)' ><i id='updateUserBtn-" + row.id + "' data-id='" + row.id + "' class='fa fa-edit'></i></a>";
                return btns;
            }
        }],
        url: "${pageContext.request.contextPath}/users",
        method: "get",
        dataField: "data",
        totalField: "total",
        sidePagination: "server",
        pageNumber: 1,
        pageSize: 10,
        pagination: true,
        showHeader: true,
        queryParamsType: "undefined",
        queryParams: function (params) {
            return {
                username: $("#username").val(),
                status: $("#status").val(),
                page: params.pageNumber,
                size: params.pageSize
            }
        }
    })

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


    /**
     * 打开新增窗口
     */
    $("#addBtn").click(function () {
        $('#resetAddForm').click();
        $('#userADDModal').modal('show');
    });


    /**
     * 新增
     */
    /* $("#doAddBtn").click(function () {
       $.ajax({
         // type，指定http请求方法，如：get、post
         type: "post",
         // url，后端服务地址
         url: ctx + "/users",
         // async，true表示异步（默认），false表示同步
         async: true,
         // data，参数（一般是JSON格式）
         data: {
           username: $("#userAddModal #username").val(),
           nickname: $("#userAddModal #nickname").val(),
           status: $("#userAddModal input[name='status']:checked").val(),
           password: $("#userAddModal #password").val(),
         }
       }).done(function (res) {
         // 处理响应结果
         if(res && res.status == 200){
           reloadDataList();
         } else {
           alert(res.message);
         }

         // 关闭新增窗口
         $('#userAddModal').modal('hide');
       }).fail(function () {
         alert("新增失败");
       })
     });*/

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

    /**
     * 删除
     * */
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