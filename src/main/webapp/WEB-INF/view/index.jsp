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
        <script src="/js/scripts.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body class="sb-nav-fixed">
        <jsp:include page="./layout/header.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="./layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main style="padding-bottom: 60px">
                    <div class="container-fluid px-4">
                        <h3 class="mt-2">Workspace</h3>
                        <c:set var="colors" value="bg-primary,bg-success,bg-danger,bg-dark" />
                        <c:set var="index" value="0" />
                        <div class="row">
                            <c:forEach var="board" items="${boards}" varStatus="loop">
                                <c:set var="color" value="${fn:split(colors, ',')[loop.index % 4]}" />
                                <div class="col-xl-3 col-md-6 mb-3">
                                    <div class="card shadow-sm border-0 rounded-3 ${color} text-white position-relative">
                                        <div class="card-header bg-opacity-25 border-0 d-flex justify-content-between align-items-center p-2">
                                            <h5 class="fw-bold m-0 text-truncate">${board.name}</h5>
                                            <div>
                                                <a href="#" class="text-white small me-2" data-bs-toggle="modal" data-bs-target="#updateBoardModal-${board.id}">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="#" class="text-white small" data-bs-toggle="modal" data-bs-target="#deleteBoardModal-${board.id}">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="card-body p-2">
                                            <p class="small text-truncate">${board.description}</p>
                                            <p class="text-white-50 small mb-1"><i class="fas fa-user me-1"></i> ${board.createdBy.fullName}</p>
                                            <p class="text-white-50 small"><i class="fas fa-calendar-alt me-1"></i> ${board.createdAt}</p>
                                        </div>
                                        <div class="card-footer d-flex justify-content-between align-items-center bg-transparent border-0 p-2">
                                            <a href="/board/${board.id}" class="btn btn-outline-light btn-sm px-2 py-1"> <i class="fas fa-external-link-alt"></i> View </a>
                                            <a href="#" class="text-white small" data-bs-toggle="modal" data-bs-target="#addMemberModal-${board.id}">
                                                <i class="fas fa-user-plus"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal delete board -->
                                <div class="modal fade" id="deleteBoardModal-${board.id}" tabindex="-1" aria-labelledby="deleteBoardModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="deleteBoardModalLabel">Confirm</h5>
                                            </div>
                                            <div class="modal-body">Are you sure you want to delete this board?</div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                                                <a type="button" class="btn btn-danger btn-sm" id="confirmDeleteBtn" href="/deleteBoard/${board.id}">Delete</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal update board -->
                                <div class="modal fade" id="updateBoardModal-${board.id}" tabindex="-1" aria-labelledby="updateBoardModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="updateBoardModalLabel">Edit Board</h5>
                                            </div>
                                            <form:form id="updateBoardForm" modelAttribute="updateBoard" method="post" action="/updateBoard">
                                                <form:hidden path="id" value="${board.id}" />
                                                <div class="modal-body">
                                                    <div class="mb-3">
                                                        <label for="title" class="form-label">Title</label>
                                                        <form:input path="name" id="title" class="form-control" required="true" value="${board.name}" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="description" class="form-label">Description</label>
                                                        <form:textarea path="description" id="description-${board.id}" class="form-control"></form:textarea>
                                                    </div>
                                                    <script>
                                                        document.getElementById('description-${board.id}').value = '${board.description}';
                                                    </script>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-success btn-sm">Update</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal add member -->
                                <div class="modal fade" id="addMemberModal-${board.id}" tabindex="-1" aria-labelledby="addMemberModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="addMemberModalLabel">Add Member - ${board.name}</h5>
                                            </div>
                                            <div class="modal-body">
                                                <form:form id="addMemberForm" action="/addMember" method="post" modelAttribute="newMember">
                                                    <form:hidden path="boardId" value="${board.id}" />
                                                    <div class="mb-3">
                                                        <label for="email" class="form-label">Email</label>
                                                        <form:input type="email" class="form-control" id="email" path="email" required="true" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="role" class="form-label">Role</label>
                                                        <form:input type="text" class="form-control" id="role" path="role" required="true" />
                                                    </div>
                                                    <c:if test="${not empty errorMessage}">
                                                        <div class="alert alert-danger" id="error-message">${errorMessage}</div>
                                                    </c:if>
                                                    <c:if test="${not empty successMessage}">
                                                        <div class="alert alert-success" id="success-message">${successMessage}</div>
                                                    </c:if>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal" aria-label="Close" onclick="closeModal('${board.id}')">Close</button>
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
                </main>
                <jsp:include page="./layout/footer.jsp" />
            </div>
        </div>

        <!-- Modal add board -->
        <div class="modal fade" id="addBoardModal" tabindex="-1" aria-labelledby="addBoardModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addBoardModalLabel">New Board</h5>
                    </div>
                    <div class="modal-body">
                        <form:form id="addBoardForm" modelAttribute="newBoard" method="post" action="/addBoard">
                            <div class="mb-3">
                                <label for="title" class="form-label">Title</label>
                                <form:input path="name" id="title" class="form-control" required="true" />
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <form:textarea path="description" id="description" class="form-control" />
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
