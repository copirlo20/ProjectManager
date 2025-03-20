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
        <script src="/js/scripts.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body class="sb-nav-fixed">
        <jsp:include page="./layout/header.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="./layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main style="padding-bottom: 60px">
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Workspace</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Bảng</li>
                        </ol>
                        <c:set var="colors" value="bg-primary,bg-success,bg-danger,bg-dark" />
                        <c:set var="index" value="0" />
                        <div class="row">
                            <c:forEach var="board" items="${boards}" varStatus="loop">
                                <c:set var="color" value="${fn:split(colors, ',')[loop.index % 4]}" />
                                <div class="col-xl-3 col-md-6 mb-3">
                                    <div class="card shadow-sm border-0 rounded-3 ${color} text-white position-relative">
                                        <div class="card-header bg-opacity-25 border-0 d-flex justify-content-between align-items-center p-2">
                                            <h6 class="fw-bold m-0 text-truncate">${board.name}</h6>
                                            <div>
                                                <a href="#" class="text-white small me-2" data-bs-toggle="modal" data-bs-target="#updateBoardModal-${board.id}">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="#" class="text-white small" data-bs-toggle="modal" data-bs-target="#deleteBoardModal">
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
                                            <a href="/board/${board.id}" class="btn btn-outline-light btn-sm px-2 py-1"> <i class="fas fa-external-link-alt"></i> Xem </a>
                                            <a href="#" class="text-white small" data-bs-toggle="modal" data-bs-target="#addMemberModal-${board.id}">
                                                <i class="fas fa-user-plus"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Modal update riêng cho từng board -->
                                <div class="modal fade" id="updateBoardModal-${board.id}" tabindex="-1" aria-labelledby="updateBoardModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="updateBoardModalLabel">Chỉnh sửa bảng</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form:form id="updateBoardForm" modelAttribute="updateBoard" method="post" action="/updateBoard">
                                                <form:hidden path="id" value="${board.id}" />
                                                <div class="modal-body">
                                                    <div class="mb-3">
                                                        <label for="title" class="form-label">Tiêu đề</label>
                                                        <form:input path="name" id="title-${board.id}" class="form-control" required="true" value="${board.name}" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="description" class="form-label">Mô tả</label>
                                                        <form:textarea path="description" id="description-${board.id}" class="form-control"></form:textarea>
                                                        <script>
                                                            document.getElementById('description-${board.id}').value = '${board.description}';
                                                        </script>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-success">Cập nhật</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                                <!-- Modal add member riêng cho từng board -->
                                <div class="modal fade" id="addMemberModal-${board.id}" tabindex="-1" aria-labelledby="addMemberModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="addMemberModalLabel">Thêm thành viên vào ${board.name}</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form:form id="addMemberForm" action="/addMember" method="post" modelAttribute="newMember">
                                                    <form:hidden path="boardId" value="${board.id}" />
                                                    <div class="mb-3">
                                                        <label for="email" class="form-label">Email</label>
                                                        <form:input type="email" class="form-control" id="email-${board.id}" path="email" required="true" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="role" class="form-label">Role</label>
                                                        <form:input type="text" class="form-control" id="role-${board.id}" path="role" required="true" />
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                        <button type="submit" class="btn btn-primary">Thêm</button>
                                                    </div>
                                                </form:form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Modal Xác nhận Xóa -->
                                <div class="modal fade" id="deleteBoardModal" tabindex="-1" aria-labelledby="deleteBoardModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="deleteBoardModalLabel">Xác nhận</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">Bạn chắc chắn muốn xóa bảng này?</div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                <a type="button" class="btn btn-danger" id="confirmDeleteBtn" href="/deleteBoard/${board.id}">xóa</a>
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
                        <h5 class="modal-title" id="addBoardModalLabel">Tạo bảng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form:form id="addBoardForm" modelAttribute="newBoard" method="post" action="/addBoard">
                            <div class="mb-3">
                                <label for="title" class="form-label">Tiêu đề</label>
                                <form:input path="name" id="title" class="form-control" required="true" />
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <form:textarea path="description" id="description" class="form-control" />
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
