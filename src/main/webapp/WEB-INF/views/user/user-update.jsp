<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <form id="updateForm">
          <input type="hidden" id="updateUserId" />
          <div class="modal-header">
              <h4 class="modal-title" id="gridSystemModalLabel">修改用户</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
              <div class="form-group">
                <label for="username3">账号</label>
                <input type="text" class="form-control" id="username3" name="username" placeholder="请输入账号" autocomplete="off" disabled>
              </div>
              <div class="form-group">
                <label for="nickname3">昵称</label>
                <input type="text" class="form-control" id="nickname3" name="nickname" placeholder="请输入昵称" autocomplete="off">
              </div>
              <div class="form-group">
                <label for="password3">密码</label>
                <input type="password" class="form-control" id="password3" name="password" placeholder="........." autocomplete="off">
              </div>
              <div class="form-group">
                <input type="radio" id="userStatus1" name="status" value="1" checked="checked">启用
                <input type="radio" id="userStatus2"  name="status" value="0">禁用
              </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
              <button id="resettAddForm" type="reset" class="btn btn-dark">重置</button>
            <button id="doUpdateBtn" class="btn btn-primary">修改</button>
          </div>
      </form>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->