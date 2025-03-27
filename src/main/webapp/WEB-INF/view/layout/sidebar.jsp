<!-- prettier-ignore -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- prettier-ignore -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- prettier-ignore -->
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!-- prettier-ignore -->
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <div class="sb-sidenav-menu-heading">Menu</div>
                <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#addBoardModal">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Create Board
                </a>
                <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#addTaskListModal">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Create List
                </a>
            </div>
        </div>
        <div class="sb-sidenav-footer">
            <div class="small">Design: CNTT-13</div>
        </div>
    </nav>
</div>
