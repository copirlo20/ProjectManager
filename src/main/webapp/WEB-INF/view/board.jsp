<!-- prettier-ignore -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- prettier-ignore -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- prettier-ignore -->
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!-- prettier-ignore -->
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - SB Admin</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/locales/bootstrap-datepicker.vi.min.js"></script>
        <script src="/js/scripts.js"></script>
    </head>
    <body class="sb-nav-fixed">
        <jsp:include page="./layout/header.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="./layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main style="padding-bottom: 60px">
                    <div class="container-fluid px-4">
                        <h4 class="mt-4"></h4>
                        <div class="d-flex flex-row flex-nowrap" style="gap: 1rem">
                            <c:forEach var="taskList" items="${taskLists}" varStatus="loop">
                                <div class="card text-bg-light mb-3" style="min-width: 20rem; max-width: 22rem; margin-bottom: 4px">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h5>${taskList.name}</h5>
                                        <div>
                                            <button class="btn btn-sm btn-outline-primary"><i class="fas fa-edit"></i></button>
                                            <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteTaskListModal"><i class="fas fa-trash"></i></button>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex flex-column">
                                            <c:forEach var="task" items="${taskList.tasks}" varStatus="loop">
                                                <div class="card shadow-sm mb-3" style="width: 100%; border-radius: 8px">
                                                    <div class="card-body">
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <h5 class="card-title mb-0">${task.title}</h5>
                                                            <span class="badge bg-success">Done</span>
                                                        </div>
                                                        <p class="card-text text-muted" style="font-size: 0.9rem">${task.description}</p>
                                                        <div class="d-flex justify-content-between align-items-center mt-3">
                                                            <div>
                                                                <i class="fas fa-comment-alt fa-lg" data-bs-toggle="modal" data-bs-target="#commentModal"></i>
                                                                <i class="fas fa-user-circle fa-lg"></i>
                                                            </div>
                                                            <div>
                                                                <button class="btn btn-light btn-sm"><i class="fas fa-arrow-left"></i></button>
                                                                <button class="btn btn-light btn-sm"><i class="fas fa-arrow-right"></i></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="commentModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="commentModalLabel">Bình luận</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <!-- Danh sách bình luận cũ -->
                                                                <div class="mb-3">
                                                                    <div id="commentList" class="border rounded p-2 overflow-auto" style="max-height: 300px">
                                                                        <c:forEach var="comment" items="${task.comments}" varStatus="loop">
                                                                            <p class="mb-1"><strong>${comment.user.fullName}:</strong> ${comment.content}</p>
                                                                            <small class="text-muted">${comment.createdAt}</small>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                                <!-- Form nhập bình luận mới -->
                                                                <form id="addCommentForm" method="post" action="/addComment">
                                                                    <div class="mb-3">
                                                                        <label for="newComment" class="form-label">Bình luận của bạn</label>
                                                                        <textarea id="newComment" name="comment" class="form-control" rows="3" required></textarea>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                                        <button type="submit" class="btn btn-success">Gửi</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <button class="btn btn-primary btn-sm mt-2" data-bs-toggle="modal" data-bs-target="#addTaskModal-${taskList.id}"><i class="fas fa-plus"></i> Task</button>
                                    </div>
                                </div>
                                <!-- Modal add task -->
                                <div class="modal fade" id="addTaskModal-${taskList.id}" tabindex="-1" aria-labelledby="addTaskModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="addTaskModalLabel">Thêm danh sách</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form:form id="addTaskForm" modelAttribute="taskDto" method="post" action="/addTask">
                                                    <form:hidden path="taskListId" value="${taskList.id}" />
                                                    <div class="mb-3">
                                                        <label for="title" class="form-label">Tiêu đề</label>
                                                        <form:input path="title" id="title" class="form-control" required="true" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="description" class="form-label">Mô tả</label>
                                                        <form:textarea path="description" id="description" class="form-control" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <input type="checkbox" id="enableDueDate" />
                                                        <label for="enableDueDate">Thời hạn</label>
                                                    </div>
                                                    <div class="mb-3" id="datepicker-container" style="display: none">
                                                        <form:input type="hidden" path="dueDate" id="dueDate" value="1970-01-01" />
                                                        <div id="datepicker-inline" class="shadow-sm p-3 bg-light rounded"></div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                        <button type="submit" class="btn btn-success">Thêm</button>
                                                    </div>
                                                </form:form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Modal xóa TaskList -->
                                <div class="modal fade" id="deleteTaskListModal" tabindex="-1" aria-labelledby="deleteTaskListModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="deleteTaskListModalLabel">Xác nhận</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">Bạn chắc chắn muốn xóa danh sách này?</div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                <a type="button" class="btn btn-danger" id="confirmDeleteBtn" href="/deleteTaskList/${taskList.id}">Xóa</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="position-fixed bottom-0 start-0 end-0 overflow-auto" style="height: 20px; padding-bottom: 60px; z-index: 1">
                        <div style="width: 200vw"></div>
                    </div>
                </main>
                <jsp:include page="./layout/footer.jsp" />
            </div>
        </div>
        <!-- Modal add taskLisk -->
        <div class="modal fade" id="addTaskListModal" tabindex="-1" aria-labelledby="addTaskListModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addTaskListModalLabel">Tạo bảng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form:form id="addTaskListForm" modelAttribute="taskListDto" method="post" action="/addTaskList">
                            <form:hidden path="boardId" value="${boardId}" />
                            <div class="mb-3">
                                <label for="title" class="form-label">Tiêu đề</label>
                                <form:input path="name" id="title" class="form-control" required="true" />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                <button type="submit" class="btn btn-success">Tạo</button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
