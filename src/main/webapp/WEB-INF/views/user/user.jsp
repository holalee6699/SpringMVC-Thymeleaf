<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>SSM | 用户管理</title>
  <!-- Theme style -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/fontawesome-free/css/all.min.css">

  <!-- Theme style -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/adminlte/css/adminlte.css">

  <!-- bootstrap-table -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/bootstrap-table/bootstrap-table.min.css">

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/bootstrap/css/bootstrap.min.css">


  <style type="text/css">
    .error {
      color: red;
    }
    input[type='text'][class*='error']{
      border: solid 1px red;
      box-shadow: 0px 0px 2px red;
    }
  </style>
</head>
<body class="hold-transition sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
  <!-- Navbar -->
  <%@include file="../layout/main-head.jsp"%>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <%@include file="../layout/main-sidebar.jsp"%>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>用户管理</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">用户管理</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Default box -->
      <div class="card">
        <div class="card-body">
          <div class="row" style="margin-bottom: 10px;">
            <div class="col-md-6">
              <div class="form-inline" style="display: flex;width: 350px;justify-content: space-between">
                <div class="form-group">
                  <input type="text" class="form-control" id="username" placeholder="账号或昵称">
                </div>
                <div class="form-group">
                  <select id="status" class="form-control">
                    <option value="">请选择</option>
                    <option value="1">启用</option>
                    <option value="0">禁用</option>
                  </select>
                </div>
                  <button id="searchBtn" class="btn btn-primary">查询</button>
              </div>
            </div>
            <div class="col-md-6" style="justify-content: flex-end;display: flex;">
              <button id="addBtn" class="btn btn-success">新增</button>
              <button id="deleteBtn" class="btn btn-danger" style="margin-left: 10px;" data-loading-text="Loading...">删除</button>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <table id="dataList"></table>
            </div>
          </div>
        </div>
      </div>
      <!-- /.card -->

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <%--新增窗口--%>
  <%@include file="user-add.jsp"%>

  <%--修改窗口--%>
  <%@include file="user-update.jsp"%>

  <%@include file="../layout/main-footer.jsp"%>

  <!-- Control Sidebar -->
  <%@include file="../layout/control-sidebar.jsp"%>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/assets/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/assets/adminlte/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${pageContext.request.contextPath}/assets/adminlte/js/demo.js"></script>
<!--bootstrap-table-->
<script src="${pageContext.request.contextPath}/assets/plugins/bootstrap-table/bootstrap-table.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugins/bootstrap-table/bootstrap-table-zh-CN.js"></script>


<script src="${pageContext.request.contextPath}/assets/plugins/bootbox/bootbox.all.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugins/jquery-validation/jquery.validate.min.js"></script>


<script>

  $(function () {
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


      /*bootbox.confirm("确定删除？",function (result) {
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
          /!*contentType:"application/json;charset=UTF-8",*!/
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
      });*/


    });


  })
</script>
</body>
</html>
