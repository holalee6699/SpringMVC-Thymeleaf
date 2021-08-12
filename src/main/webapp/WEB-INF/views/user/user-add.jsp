<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div class="modal fade" id="userADDModal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <form id="addForm">
          <div class="modal-header">
              <h4 class="modal-title" id="gridSystemModalLabel">新增用户</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
              <div class="form-group">
                <label for="username">账号</label>
                <input type="text" class="form-control" id="username" name="username" placeholder="请输入账号" autocomplete="off">
              </div>
              <div class="form-group">
                <label for="nickname">昵称</label>
                <input type="text" class="form-control" id="nickname" name="nickname" placeholder="请输入昵称" autocomplete="off">
              </div>
              <div class="form-group">
                <label for="password">密码</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" autocomplete="off">
              </div>
              <div class="form-group">
                <input type="radio" name="status" value="1" checked="checked">启用
                <input type="radio" name="status" value="0">禁用
              </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
              <button id="resettAddForm" type="reset" class="btn btn-dark">重置</button>
            <button id="doADDBtn" class="btn btn-primary">保存</button>
          </div>
      </form>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->