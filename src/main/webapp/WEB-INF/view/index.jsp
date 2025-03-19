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
                        <c:set var="colors" value="bg-primary,bg-success,bg-danger,bg-warning,bg-info,bg-dark" />
                        <c:set var="index" value="0" />
                        <div class="row">
                            <c:forEach var="board" items="${boards}" varStatus="loop">
                                <c:set var="color" value="${fn:split(colors, ',')[loop.index % 6]}" />
                                <div class="col-xl-2 col-md-6">
                                    <div class="card ${color} text-white mb-4 position-relative">
                                        <a href="#" class="position-absolute top-0 end-0 m-2 text-white" data-bs-toggle="modal" data-bs-target="#updateBoardModal-${board.id}">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <div class="card-body">
                                            <p class="text-decoration-underline m-0 fw-bold">${board.name}</p>
                                        </div>
                                        <div class="card-footer d-flex align-items-center justify-content-between">
                                            <a class="small text-white text-decoration-none fw-normal" href="/board/${board.id}">${board.description}</a>
                                            <div class="small text-white">
                                                <i class="fas fa-angle-right"></i>
                                            </div>
                                        </div>
                                        <div class="card-footer text-center">
                                            <a href="#" class="text-white text-decoration-none" data-bs-toggle="modal" data-bs-target="#addMemberModal-${board.id}">
                                                <i class="fas fa-user-plus"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Modal update riêng cho từng board -->
                                <div class="modal fade" id="updateBoardModal-${board.id}" tabindex="-1" aria-labelledby="updateBoardModalLabel-${board.id}" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="updateBoardModalLabel-${board.id}">Chỉnh sửa bảng</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form:form id="updateBoardForm-${board.id}" modelAttribute="updateBoard" method="post" action="/updateBoard">
                                                <form:hidden path="id" value="${board.id}" />
                                                <div class="modal-body">
                                                    <div class="mb-3">
                                                        <label for="title-${board.id}" class="form-label">Tiêu đề</label>
                                                        <form:input path="name" id="title-${board.id}" class="form-control" required="true" value="${board.name}" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="description-${board.id}" class="form-label">Mô tả</label>
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
                                <div class="modal fade" id="addMemberModal-${board.id}" tabindex="-1" aria-labelledby="addMemberModalLabel-${board.id}" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="addMemberModalLabel-${board.id}">Thêm thành viên vào ${board.name}</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form:form id="addMemberForm-${board.id}" action="/addMember" method="post" modelAttribute="newMember">
                                                    <form:hidden path="boardId" value="${board.id}" />
                                                    <div class="mb-3">
                                                        <label for="email-${board.id}" class="form-label">Email</label>
                                                        <form:input type="email" class="form-control" id="email-${board.id}" path="email" required="true" />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="role-${board.id}" class="form-label">Role</label>
                                                        <form:input type="text" class="form-control" id="role-${board.id}" path="role" required="true" />
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                        <button type="submit" form="addMemberForm-${board.id}" class="btn btn-primary">Thêm</button>
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
