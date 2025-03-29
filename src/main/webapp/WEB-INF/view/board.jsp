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
        <title>Project Management</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js"></script>
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
                                            <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteTaskListModal-${taskList.id}"><i class="fas fa-trash"></i></button>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex flex-column">
                                            <c:forEach var="task" items="${taskList.tasks}" varStatus="loop">
                                                <div class="card shadow-sm mb-3" style="width: 100%; border-radius: 8px">
                                                    <div class="card-body p-2">
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <h5 class="card-title mb-0">${task.title}</h5>
                                                            <span class="badge bg-success">Done</span>
                                                        </div>
                                                        <p class="card-text text-muted" style="font-size: 0.9rem">${task.description}</p>
                                                        <div class="d-flex justify-content-between align-items-center mt-3">
                                                            <div>
                                                                <p class="mb-0"><i class="fas fa-comment-alt fa-sm" data-bs-toggle="modal" data-bs-target="#commentModal-${task.id}"></i> <span>${fn:length(task.comments)}</span></p>
                                                                <!-- <p class="mb-0"><i class="fas fa-user-circle fa-sm"></i></p> -->
                                                            </div>
                                                            <div>
                                                                <a class="btn btn-light btn-sm" href="/moveTaskToList/${boardId}/${task.id}/${taskList.position - 1}"><i class="fas fa-arrow-left"></i></a>
                                                                <a class="btn btn-light btn-sm" href="/moveTaskToList/${boardId}/${task.id}/${taskList.position + 1}"><i class="fas fa-arrow-right"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Modal comment -->
                                                <div class="modal fade" id="commentModal-${task.id}" tabindex="-1" aria-labelledby="commentModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="commentModalLabel">Comment</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div class="mb-3">
                                                                    <div id="commentList" class="border rounded p-2 overflow-auto bg-light" style="max-height: 300px">
                                                                        <c:forEach var="comment" items="${task.comments}" varStatus="loop">
                                                                            <div class="d-flex ${comment.user.id == sessionScope.userId ? 'justify-content-end' : 'justify-content-start'}">
                                                                                <div class="p-2 rounded-3 ${comment.user.id == sessionScope.userId ? 'bg-primary text-white' : 'bg-danger text-white'}" style="max-width: 70%">
                                                                                    <p class="mb-0"><strong>${comment.user.fullName}:</strong></p>
                                                                                    <pre class="d-inline">${comment.content}</pre>
                                                                                </div>
                                                                            </div>
                                                                            <div class="d-flex ${comment.user.id == sessionScope.userId ? 'justify-content-end' : 'justify-content-start'}">
                                                                                <small class="text-muted mb-1 mt-0">${comment.createdAt}</small>
                                                                            </div>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                                <form:form id="addCommentForm-${task.id}" modelAttribute="commentDto" method="post" action="/addComment">
                                                                    <form:hidden path="taskId" value="${task.id}" />
                                                                    <form:hidden path="userId" value="${userId}" />
                                                                    <div class="mb-3">
                                                                        <form:textarea id="newComment-${task.id}" path="content" class="form-control" rows="5" required="true" data-task-id="${task.id}" />
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                                                                        <button type="submit" class="btn btn-success btn-sm">Send</button>
                                                                    </div>
                                                                </form:form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addTaskModal-${taskList.id}"><i class="fas fa-plus"></i> Task</button>
                                    </div>
                                </div>

                                <!-- Modal delete taskList -->
                                <div class="modal fade" id="deleteTaskListModal-${taskList.id}" tabindex="-1" aria-labelledby="deleteTaskListModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="deleteTaskListModalLabel">Confirm</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">Are you sure you want to delete this list?</div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                                                <a type="button" class="btn btn-danger btn-sm" id="confirmDeleteBtn" href="/deleteTaskList/${taskList.id}">Delete</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal add task -->
                                <div class="modal fade" id="addTaskModal-${taskList.id}" tabindex="-1" aria-labelledby="addTaskModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="addTaskModalLabel">Add Task</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form:form id="addTaskForm" modelAttribute="taskDto" method="post" action="/addTask">
                                                    <form:hidden path="taskListId" value="${taskList.id}" />
                                                    <div class="mb-3">
                                                        <label for="title" class="form-label">Title</label>
                                                        <form:input path="title" id="title" class="form-control" required="true" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="description" class="form-label">Description</label>
                                                        <form:textarea path="description" id="description" class="form-control" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <input type="checkbox" id="enableDueDate-${taskList.id}" data-taskList-id="${taskList.id}" />
                                                        <label for="enableDueDate">Deadline</label>
                                                    </div>
                                                    <div class="mb-3" id="datepicker-container" style="display: none">
                                                        <form:input type="hidden" path="dueDate" id="dueDate" value="1970-01-01" />
                                                        <div id="datepicker-inline" class="shadow-sm p-3 bg-light rounded"></div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary btn-sm">Add</button>
                                                    </div>
                                                </form:form>
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
                        <h5 class="modal-title" id="addTaskListModalLabel">New List</h5>
                    </div>
                    <div class="modal-body">
                        <form:form id="addTaskListForm" modelAttribute="taskListDto" method="post" action="/addTaskList">
                            <form:hidden path="boardId" value="${boardId}" />
                            <div class="mb-3">
                                <label for="title" class="form-label">Title</label>
                                <form:input path="name" id="title" class="form-control" required="true" />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-success btn-sm">Create</button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${not empty openModalId}">
            <script>
                showModal('${openModalId}');
            </script>
        </c:if>
    </body>
</html>
